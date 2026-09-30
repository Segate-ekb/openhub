# Стенд наблюдаемости

Конвейер, который принимает телеметрию хаба и показывает её одним окном. Поднимается
тестовым стендом [`../compose.yaml`](../compose.yaml). Хаб знает один адрес — коллектор;
по хранилищам сигналы разводит коллектор.

```text
хаб ──OTLP──> otel-collector ──┬── трассы ──> Tempo ──спан-метрики──> Prometheus
                               ├── метрики ─> Prometheus
                               └── логи ────> Loki
                                                   └── всё вместе ──> Grafana
```

| Сервис | Конфигурация | Адрес с хоста | Что делает |
| --- | --- | --- | --- |
| коллектор | [`otel-collector.yaml`](otel-collector.yaml) | `localhost:4318` (http), `:4317` (grpc), `:13133` (проба) | приём OTLP |
| Tempo | [`tempo.yaml`](tempo.yaml) | `localhost:3200` | трассы, RED-метрики и карта сервисов из них |
| Loki | [`loki.yaml`](loki.yaml) | `localhost:3100` | логи |
| Prometheus | [`prometheus.yaml`](prometheus.yaml) | `localhost:9090` | метрики; приёмник remote-write и экземпляры включены |
| Grafana | [`grafana/`](grafana) | <http://localhost:3000> | окно; вход анонимный, правами администратора |

Порты опубликованы только на `127.0.0.1`: ни коллектор, ни Grafana никого не аутентифицируют.
Трассы и логи хранятся сутки, метрики — 15 суток: переход из точки графика в трассу старше
суток ведёт в пустоту.

## Запуск

```bash
docker compose -f docker/compose.yaml up -d                                 # весь стенд
docker compose -f docker/compose.yaml up -d otel-collector tempo loki prometheus grafana   # без хаба
```

Grafana открывается на дашборде **«OpenHub — наблюдаемость»**: маршруты, методы контроллеров,
база данных, бизнес-числа хаба, журнал и карта сервисов. Источники данных и дашборд приезжают
провижнингом из [`grafana/`](grafana).

## Хаб на хосте

Сервису `openhub` стенда переменные уже заданы. Хаб, запущенный из исходников на хосте, шлёт
в тот же коллектор:

```bash
OTEL_ENABLED=true \
OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318 \
OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf \
OTEL_SERVICE_NAME=openhub \
OTEL_METRIC_EXPORT_INTERVAL=10000 \
OTEL_BSP_SCHEDULE_DELAY=2000 \
OSHUB_PORT=3385 \
oscript src/main.os
```

Два интервала укорочены для стенда: с умолчаниями (60 с и 5 с) первая метрика появляется
через минуту после запроса.

## Что шлёт хаб

**Трассы.** Серверный спан — `{метод} {шаблон_маршрута}`, например `GET /api/v1/pools`. Под ним —
спан метода контроллера (`КонтроллерВыдачиAPI.ФайлПула`), под ним — спаны служб хаба
(`ИмяЖелудя.ИмяМетода`, например `СервисПулов.НайтиПул`), ниже — обращения к хранилищам
сущностей и запросы к СУБД. Атрибуты `oshub.pool`, `oshub.package`, `oshub.channel` висят
на спане той службы, которую о них спросили. Методы, которые только считают по своим
аргументам, спанов не получают.

**Метрики точек маршрута.** Гистограмма `*.duration` (секунды) и счётчик `*.counted`.
В Prometheus имя транслитерируется в snake_case с единицей:
`КонтроллерПуловAPI.Пулы` → `kontroller_pulov_api_puly_duration_seconds_bucket`
и `kontroller_pulov_api_puly_counted_total`; метки — `code_namespace`, `code_function_name`,
`result`, `service_name`. Задержку по ним считают средним,
`rate(…_seconds_sum) / rate(…_seconds_count)`: границы корзин у этих гистограмм
миллисекундные, квантиль по ним не информативен.

**Метрики базы.** Обращения к СУБД инструментирует entity: `db.client.operation.duration`,
`entity.operation.duration`, `entity.repository.invocation.duration`, счётчики
`entity.entities`, `entity.transactions`, датчики пула `db.client.connection.*`. В Prometheus —
`db_client_operation_duration_seconds_bucket` и т. д.; метки `db_operation_name`,
`entity_operation`, `entity_type`, `entity_repository`, `code_function_name`.

**Метрики хаба.** Скачивания, публикации, реестр, занятое место, очереди фона — приборы
`oshub.*` (`oshub.downloads`, `oshub.publications`, `oshub.storage.used_bytes` и другие);
панели «Бизнес хаба» дашборда.

**RED-метрики маршрутов** считает генератор метрик Tempo: `traces_spanmetrics_calls_total`,
`traces_spanmetrics_latency_bucket`, `traces_service_graph_request_total`. Службу они метят
меткой `service`, метрики хаба — `service_name`.

**Логи.** Журнал хаба мостом logos → OTel; у строки внутри запроса есть `trace_id`.

## Как найти трассу, лог и метрику

```bash
# трассы службы и маршрута; трасса целиком
curl -s -G http://localhost:3200/api/search \
  --data-urlencode 'q={ resource.service.name = "openhub" }' --data-urlencode 'limit=3'
curl -s -G http://localhost:3200/api/search --data-urlencode 'q={ name = "GET /api/v1/pools" }'
curl -s http://localhost:3200/api/traces/<trace_id>

# метрики
curl -s -G http://localhost:9090/api/v1/label/__name__/values \
  --data-urlencode 'match[]={__name__=~".+_duration_seconds_bucket"}'
curl -s -G http://localhost:9090/api/v1/query \
  --data-urlencode 'query=sum by (db_operation_name) (rate(db_client_operation_duration_seconds_count[5m]))'

# строки журнала одной трассы
curl -s -G http://localhost:3100/loki/api/v1/query_range \
  --data-urlencode 'query={service_name=~".+"} | trace_id="<trace_id>"'
```

- `trace_id` лежит в structured metadata строки: ищут фильтром `| trace_id="…"`, а не меткой
  `{trace_id="…"}` и не подстрокой `|= "…"`. Индексная метка у логов одна — `service_name`.
- `/api/search` Tempo печатает `traceID` без ведущих нулей; для запроса его дополняют нулями
  слева до 32 знаков. Grafana берёт полный идентификатор из спана.
- Экземпляры (exemplars) на графиках задержки ведут в трассу; метка в них — `traceID`.

## Готовность

```bash
curl -s http://localhost:13133/          # коллектор: {"status":"Server available"}
curl -s http://localhost:3200/ready      # Tempo
curl -s http://localhost:3100/ready      # Loki
curl -s http://localhost:9090/-/ready    # Prometheus
curl -s http://localhost:3000/api/health # Grafana
```

Tempo и Loki первые секунды после старта отвечают `503 Ingester not ready`.
