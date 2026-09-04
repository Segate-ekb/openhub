# Образ OpenHub

Здесь лежит всё, чем хаб собирается и запускается в контейнере.

| Файл | Что делает |
| --- | --- |
| [`Dockerfile`](Dockerfile) | описание образа; контекст сборки — корень репозитория |
| [`Dockerfile.dockerignore`](Dockerfile.dockerignore) | что попадает в контекст: `.ospx`, `packagedef` и распаковщик |
| [`образ.sh`](образ.sh) | собирает пакет и образ, по `--push` публикует |
| [`compose.yaml`](compose.yaml) | стенд: хаб, MinIO и конвейер наблюдаемости |
| [`наблюдаемость/`](наблюдаемость) | конфигурация коллектора, Tempo, Loki, Prometheus и Grafana |

## Собрать

```bash
docker/образ.sh                    # segateekb/openhub:<версия> локально
docker/образ.sh --push             # собрать и опубликовать
docker/образ.sh --push my/openhub  # другой репозиторий
```

Версия берётся только из `packagedef`: ею помечаются файл `.ospx`, тег образа и метки OCI,
её же хаб отдаёт в `GET /health`. Сборка сверяет все носители версии между собой и падает,
если они разошлись, — руками версия не пишется нигде. Образ собирается под `linux/amd64`:
базовый `evilbeaver/onescript` других платформ не публикует.

## Запустить

Контейнер самодостаточен: ни S3, ни внешней базы данных не нужно.

```bash
docker run --rm -p 3333:3333 -v openhub-data:/var/lib/openhub segateekb/openhub
```

Хаб отвечает на <http://localhost:3333>, первого администратора заводит мастер на `/setup`.
Артефакты, база SQLite и журнал аудита лежат в `/var/lib/openhub`; том обязателен — без него
данные не переживут пересоздание контейнера.

![Мастер первого запуска](../docs/screenshots/setup.png)

*Так выглядит свежий хаб сразу после `docker run`.*

Стенд с MinIO целиком — `docker compose -f docker/compose.yaml up`.

> **На Apple Silicon нужны два флага.** Без `--platform linux/amd64` образ не скачается
> (`no matching manifest for linux/arm64/v8`), без `-e DOTNET_EnableWriteXorExecute=0`
> эмуляция ломает JIT .NET и любая библиотека падает с `NullReferenceException`.
> В образ вторая переменная не зашита: на настоящем amd64 она только вредит.
> В `compose.yaml` стоят обе.

## Настроить

Три источника значений, по убыванию приоритета: переменные окружения `OSHUB_*`, затем файл
`autumn-properties.json`, затем умолчания в коде. Файл приезжает внутри пакета и монтируется
поверх своим — `-v ./autumn-properties.json:/opt/openhub/autumn-properties.json:ro`, — причём
заменяет приехавший целиком, а не дополняет. Берите за основу
[`../autumn-properties.json`](../autumn-properties.json): там перечислены все настройки,
а имя переменной окружения выводится из имени настройки.

В образе зашиты только три переменные — те, что являются фактом контейнера, а не выбором
оператора:

| Переменная | Значение |
| --- | --- |
| `OSHUB_STORAGE_ROOT` | `/var/lib/openhub` |
| `OSHUB_DB_CONNECTOR` | `КоннекторSQLite` |
| `OSHUB_DB_CONNECTION` | `Data Source=/var/lib/openhub/openhub.db` |

Хранилище по умолчанию файловое, S3 включается переменными:

```bash
docker run --rm -p 3333:3333 -v openhub-data:/var/lib/openhub \
  -e OSHUB_STORAGE_BACKEND=s3 \
  -e OSHUB_STORAGE_S3_ENDPOINT=https://s3.example.com \
  -e OSHUB_STORAGE_S3_BUCKET=openhub \
  -e OSHUB_STORAGE_S3_ACCESS_KEY_FILE=/run/secrets/s3_access \
  -e OSHUB_STORAGE_S3_SECRET_KEY_FILE=/run/secrets/s3_secret \
  segateekb/openhub
```

> Ключи доступа читаются только из окружения — значением или через `*_FILE` — и в
> `autumn-properties.json` не кладутся.
>
> Эндпоинт S3 обязан слушать стандартный порт, 80 или 443: библиотека `oint` подписывает
> заголовок `Host` без порта, и на `:9000` сервер ответит `403 SignatureDoesNotMatch`.
> Поэтому у MinIO в `compose.yaml` стоит `--address ":80"`.

## Наблюдаемость

Стенд поднимает конвейер, который принимает телеметрию хаба и показывает её одним окном.
Хаб знает про него ровно один адрес — коллектор; всё остальное разводит коллектор.

```text
хаб ──OTLP──> otel-collector ──┬── трассы ──> Tempo ──спан-метрики──> Prometheus
                               ├── метрики ─> Prometheus
                               └── логи ────> Loki
                                                   └── всё вместе ──> Grafana
```

| Сервис | Образ | Адрес с хоста | Зачем |
| --- | --- | --- | --- |
| коллектор | `otel/opentelemetry-collector-contrib:0.115.1` | `localhost:4318` (http), `:4317` (grpc), `:13133` (проба) | единственная дверь для телеметрии |
| Tempo | `grafana/tempo:2.7.1` | `localhost:3200` | трассы + RED-метрики и карта сервисов из них |
| Loki | `grafana/loki:3.4.2` | `localhost:3100` | логи |
| Prometheus | `prom/prometheus:v3.1.0` | `localhost:9090` | метрики; приёмник remote-write и хранилище экземпляров включены |
| Grafana | `grafana/grafana:11.6.0` | **<http://localhost:3000>** | окно; вход анонимный, правами администратора |

Порты опубликованы только на `127.0.0.1`: ни коллектор, ни Grafana никого не аутентифицируют.

```bash
docker compose -f docker/compose.yaml up -d        # весь стенд
docker compose -f docker/compose.yaml up -d \
  otel-collector tempo loki prometheus grafana     # только наблюдаемость, без хаба
docker compose -f docker/compose.yaml up -d \
  --no-deps minio minio-init openhub               # прежний лёгкий стенд: хаб и S3
```

Третья строка поднимает то, чем стенд был до наблюдаемости. `--no-deps` обязателен:
без него `openhub` потянет за собой коллектор, а тот — остальные четыре сервиса.
Хаб при этом будет писать телеметрию в никуда и на старте пожалуется на недоступный
коллектор — это не поломка, работать он не перестанет.

Сроки хранения: трассы и логи живут **сутки**, метрики — **15 суток** (умолчание
Prometheus). Из этого следует одно неочевидное: переход из точки графика в трассу
после суток ведёт в пустоту — экземпляр в метрике ещё есть, а трассы по нему уже нет.

Grafana открывается сразу на дашборде **«OpenHub — наблюдаемость»**: темп запросов,
квантили задержки, ответы по маршрутам и кодам, задержка и темп методов контроллеров,
журнал и карта сервисов. Датасорсы и дашборд приезжают провижнингом, руками их не заводят.

### Хаб в стенде

Сервису `openhub` переменные уже проставлены — он шлёт в `http://otel-collector:4318`.
Отдельная настройка нужна, только если хаб запускается **нативно на хосте**: на Apple
Silicon образ идёт под qemu и заводится не везде, а конвейер работает и без него.

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

Два последних интервала — вкус стенда, а не требование: с умолчаниями (60 с и 5 с)
первая метрика появится через минуту после запроса, и кажется, что конвейер не работает.

### Посмотреть трассу, лог и метрику

Всё, что ниже, Grafana делает кликом; те же адреса отвечают и на `curl` — так конвейер
проверяется без браузера.

**Трасса.** Explore → Tempo → Search, либо:

```bash
curl -s -G http://localhost:3200/api/search \
  --data-urlencode 'q={ resource.service.name = "openhub" }' --data-urlencode 'limit=3'
curl -s -G http://localhost:3200/api/search \
  --data-urlencode 'q={ name = "GET /api/v1/pools" }'
curl -s http://localhost:3200/api/traces/<trace_id>
```

Имя серверного спана — `{метод} {шаблон_маршрута}`, поэтому по маршруту ищется и трасса,
и метрика. Внутри спана есть переходы: **Logs for this span** (в Loki) и **Related metrics**
(в Prometheus).

**Метрика.** На каждую точку маршрута хаб пишет гистограмму `*.duration` и счётчик
`*.counted`. В Prometheus имя приезжает транслитерированным и в snake_case:
`КонтроллерПуловAPI.Пулы` → `kontroller_pulov_api_puly_duration_bucket` и
`…_counted_total`. Метки — `code_namespace`, `code_function_name`, `result`, `service_name`.

```bash
curl -s -G http://localhost:9090/api/v1/label/__name__/values \
  --data-urlencode 'match[]={__name__=~".+_duration_bucket"}'
curl -s -G http://localhost:9090/api/v1/query \
  --data-urlencode 'query=kontroller_pulov_api_puly_counted_total'
```

RED-метрики маршрутов считает не хаб, а генератор метрик Tempo:
`traces_spanmetrics_calls_total`, `traces_spanmetrics_latency_bucket`,
`traces_service_graph_request_total`.

> ⚠ Службу они метят меткой **`service`**, а метрики самого хаба — меткой
> **`service_name`**. Одно и то же значение, два разных имени: запрос по `service_name`
> к `traces_spanmetrics_*` молча вернёт пусто.

**Лог.** Grafana ходит в Loki фильтром по метаданным строки:

```bash
curl -s -G http://localhost:3100/loki/api/v1/query_range \
  --data-urlencode 'query={service_name=~".+"} | trace_id="<trace_id>"'
```

> ⚠ `trace_id` лежит в **structured metadata**, а не в теле строки и не в индексных метках.
> Индексная метка у OTLP-логов ровно одна — `service_name`. Поэтому ни `{trace_id="…"}`,
> ни поиск подстроки `|= "<trace_id>"` не находят ничего: оба варианта встречаются
> в туториалах и оба здесь неверны. По той же причине обратный переход «строка → трасса»
> собран производным полем с `matcherType: label`, а не регуляркой по тексту.
>
> ⚠ Идентификатор для запроса берут из самой трассы, а не из выдачи поиска: `/api/search`
> печатает `traceID` с **обрезанными ведущими нулями** (31 знак вместо 32), и по такому
> огрызку не найдётся ни строка лога, ни сама трасса. Клик в Grafana берёт полный
> идентификатор из спана; руками его дополняют нулями слева до 32 знаков.

**Экземпляры (exemplars).** Точка на графике задержки ведёт в конкретную трассу.
Их шлёт генератор метрик Tempo, и метка в них называется `traceID` — не `trace_id`,
как в логах.

```bash
# macOS
curl -s -G http://localhost:9090/api/v1/query_exemplars \
  --data-urlencode 'query=traces_spanmetrics_latency_bucket' \
  --data-urlencode "start=$(date -v-1H +%s)" --data-urlencode "end=$(date +%s)"
# Linux
curl -s -G http://localhost:9090/api/v1/query_exemplars \
  --data-urlencode 'query=traces_spanmetrics_latency_bucket' \
  --data-urlencode "start=$(date -d '1 hour ago' +%s)" --data-urlencode "end=$(date +%s)"
```

### Готовность стенда

```bash
curl -s http://localhost:13133/          # коллектор: {"status":"Server available"}
curl -s http://localhost:3200/ready      # Tempo: ready
curl -s http://localhost:3100/ready      # Loki: ready
curl -s http://localhost:9090/-/ready    # Prometheus
curl -s http://localhost:3000/api/health # Grafana
```

Tempo и Loki первые пятнадцать секунд после старта отвечают `503 Ingester not ready` —
это норма, а не поломка.

## Наружу — только за обратным прокси

Хаб принимает соединения по открытому HTTP; настроек шифрования у него нет. TLS терминирует
обратный прокси, там же настраиваются сжатие и ограничение темпа запросов. Порт самого хаба
слушает локальный адрес или сеть контейнеров.

За прокси каждое соединение приходит с адреса прокси, и всё, что хаб считает по адресу
клиента, собирается в одно ведро на всех: ограничитель попыток входа запирает вход всем
разом, а в журнале аудита в поле «откуда» стоит адрес прокси. Поэтому назовите хабу сети
своих прокси — только с них он читает заголовки пересылки:

```yaml
services:
  openhub:
    environment:
      # сети обратных прокси через запятую, IPv4 и IPv6 вперемешку;
      # пусто (по умолчанию) — заголовки X-Forwarded-For и Forwarded не читаются вовсе
      OSHUB_INSTANCE_TRUSTED_PROXIES: "10.0.0.0/8, 2001:db8::/32"
```

Прокси обязан дописывать в `X-Forwarded-For` адрес, с которого получил запрос
(`proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;` у nginx). **Других заголовков
пересылки хаб не читает** — ни `Forwarded`, ни `X-Real-IP`: у прокси, заполняющего только
свой заголовок, клиентский `X-Forwarded-For` остаётся нетронутым, и выбор адреса достался бы
самому клиенту. Адресом клиента хаб считает первую справа запись цепочки, не принадлежащую
названным сетям: записи своих прокси в хвосте пропускаются, всё левее найденной не читается —
её пишет сам клиент. Сеть в списке можно записать от знакомого адреса: `10.1.2.3/8` — это
`10.0.0.0/8`. **`0.0.0.0/0` в списке делает своей всю цепочку**: доверенным окажется
каждый её адрес, клиента в ней не найдётся — и заголовок перестанет читаться вовсе.
Негодная запись отвергается при чтении конфигурации с названной записью и причиной;
нечитаемая запись в цепочке оставляет адресом клиента адрес соединения и объясняется
на уровне ОТЛАДКА.

## Пробы оркестратора

| Адрес | Что значит |
| --- | --- |
| `GET /health` | живость; отдаёт версию хаба |
| `GET /ready` | готовность; до конца старта отвечает 503 |
