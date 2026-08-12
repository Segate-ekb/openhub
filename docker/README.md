# Сборка и запуск образа OpenHub

| Файл | Назначение |
|---|---|
| [`Dockerfile`](Dockerfile) | образ хаба; контекст сборки — **корень репозитория** |
| [`Dockerfile.dockerignore`](Dockerfile.dockerignore) | контекст сборки: только `.ospx`, `packagedef` и распаковщик |
| [`образ.sh`](образ.sh) | сборка пакета и образа по единственной версии из `packagedef`; `--push` публикует |
| [`compose.yaml`](compose.yaml) | тестовый стенд с S3 (MinIO) |

## Собрать

```bash
docker/образ.sh                    # segateekb/openhub:<версия> локально
docker/образ.sh --push             # собрать и опубликовать
docker/образ.sh --push my/openhub  # другой репозиторий
```

Версия живёт **только** в `packagedef`: ею помечается `.ospx`, ею помечаются тег и метки
OCI, её же читает сам хаб — `packagedef` едет внутрь пакета, и `ОписаниеПриложения.Версия()`
берёт версию оттуда через `packageinfo`. Сборка сверяет уехавший в пакет манифест
с собранным; разъехались — падает. Руками в `Dockerfile` и `образ.sh` версия не пишется
никогда.

Образ собирается под `linux/amd64`: базовый `evilbeaver/onescript` других платформ не
публикует.

## Запустить

Самодостаточно — ни S3, ни внешней БД:

```bash
docker run --rm -p 3333:3333 -v openhub-data:/var/lib/openhub segateekb/openhub
```

Хаб на <http://localhost:3333>; первого администратора заводит мастер на `/setup`.
Артефакты, SQLite и журнал аудита — в `/var/lib/openhub`, том обязателен: без него данные
инсталляции не переживут пересоздание контейнера.

С S3 (MinIO), стенд целиком:

```bash
cd build && docker compose up
```

> **На Apple Silicon нужны два флага.** `--platform linux/amd64` — иначе `docker pull`
> отказывает: `no matching manifest for linux/arm64/v8`. `-e DOTNET_EnableWriteXorExecute=0` —
> иначе qemu ломает JIT .NET и любая библиотека падает `NullReferenceException`. В образ
> переменная не зашита: на настоящем amd64 W^X нужен. В `compose.yaml` стоят оба.
>
> ```bash
> docker run --rm --platform linux/amd64 -e DOTNET_EnableWriteXorExecute=0 \
>   -p 3333:3333 -v openhub-data:/var/lib/openhub segateekb/openhub
> ```

### Канал до хаба не зашифрован, и хаб этого не умеет

Веб-сервер принимает соединения по открытому протоколу; настройки шифрования у хаба нет
и не будет — ключ, который ничего не меняет, обещал бы контроль, которого нет. Наружу хаб
выставляют **только** за обратным прокси, который терминирует TLS и заодно снимает
кэшируемый трафик; сам порт хаба слушает локальный адрес или сеть контейнеров.
Ограничение темпа обращений и сжатие — там же, на прокси: хаб их не обещает и не заменяет.

## Настроить

Три источника, по убыванию приоритета:

1. **переменные окружения `OSHUB_*`** — перебивают всё;
2. **`autumn-properties.json`** — приезжает в пакете, монтируется поверх своим:
   `-v ./autumn-properties.json:/opt/openhub/autumn-properties.json:ro`;
3. значения по умолчанию в коде.

Монтируемый файл **заменяет** приехавший в пакете целиком, а не дополняет его: за основу
берите [`../autumn-properties.json`](../autumn-properties.json) и правьте: в нём
перечислены все детальки, а имя переменной окружения выводится из имени детальки.

В образе зашиты только три переменные — те, что являются фактом контейнера, а не выбором
оператора:

| Переменная | Значение | Почему в образе |
|---|---|---|
| `OSHUB_STORAGE_ROOT` | `/var/lib/openhub` | каталог тома |
| `OSHUB_DB_CONNECTOR` | `КоннекторSQLite` | БД инсталляции на том же томе |
| `OSHUB_DB_CONNECTION` | `Data Source=/var/lib/openhub/openhub.db` | там же |

Всё остальное — из файла или из окружения. В частности, `oshub.storage.backend` в образе
**не задан**: по умолчанию работает файловое хранилище, а S3 включается по требованию —

```bash
docker run --rm -p 3333:3333 -v openhub-data:/var/lib/openhub \
  -e OSHUB_STORAGE_BACKEND=s3 \
  -e OSHUB_STORAGE_S3_ENDPOINT=https://s3.example.com \
  -e OSHUB_STORAGE_S3_BUCKET=openhub \
  -e OSHUB_STORAGE_S3_ACCESS_KEY_FILE=/run/secrets/s3_access \
  -e OSHUB_STORAGE_S3_SECRET_KEY_FILE=/run/secrets/s3_secret \
  segateekb/openhub
```

> Ключи доступа читаются **только** из окружения (значением или `*_FILE`) и в
> `autumn-properties.json` не кладутся никогда.
>
> Эндпоинт S3 обязан слушать стандартный порт (80/443): `oint` 2.3.0 подписывает `Host`
> без порта, и на `:9000` сервер вернёт `403 SignatureDoesNotMatch`. Отсюда `--address ":80"`
> у MinIO в `compose.yaml`.

## Пробы оркестратора

| Адрес | Что значит |
|---|---|
| `GET /health` | живость; отдаёт версию хаба |
| `GET /ready` | готовность; 503 до конца старта |
