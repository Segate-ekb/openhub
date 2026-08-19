# Образ хаба OpenHub. Контекст сборки — корень репозитория: `docker buildx build -f docker/Dockerfile .`
#
# По умолчанию контейнер самодостаточен: файловое хранилище артефактов и SQLite на томе
# /var/lib/openhub. `docker run -p 3333:3333 openhub` работает без единой внешней системы;
# S3 включается по требованию (см. docker/README.md и docker/compose.yaml).
#
# ВЕРСИЯ ХАБА В ЭТОМ ФАЙЛЕ НЕ ПИШЕТСЯ. Она вычитывается на стадии сборки из packagedef и
# сверяется с двумя её носителями — именем файла .ospx и тем packagedef, что уехал внутрь
# пакета: из него хаб читает версию в рантайме и отдаёт её в GET /health. Разъехались —
# сборка падает здесь же. Тот же инвариант держит сторож tests/ОбразХаба_Тесты.os.
#
# Собирать только через docker/образ.sh: он собирает .ospx из packagedef, ставит тег и
# метки OCI по той же единственной версии и включает кросс-платформу linux/amd64.
#
# Пакет самодостаточен: .ospx несёт src, autumn-properties.json и oscript_modules, поэтому
# ни opm, ни hub.oscript.io при сборке образа не нужны.
#
# ⚠ Проверка образа на Apple Silicon: эмуляция amd64 через qemu ломает JIT .NET, и ЛЮБАЯ
# библиотека падает NullReferenceException на инициализации модуля (а иногда segfault-ом).
# Запускать локально только с -e DOTNET_EnableWriteXorExecute=0. В образ эта переменная НЕ
# зашита: на настоящем amd64 она не нужна, а W^X — защита рантайма.

ARG BASE_IMAGE=evilbeaver/onescript:2.1.0

# ---------------------------------------------------------------------------
# Стадия 1: распаковка пакета и сверка версий
# ---------------------------------------------------------------------------
FROM ${BASE_IMAGE} AS unpack

# Тот же обход эмуляции, что и при запуске: под qemu распаковщик на oscript падает
# segfault-ом ещё на сборке. docker/образ.sh подставляет 0 только на хосте arm64;
# на настоящем amd64 аргумент пустой и W^X остаётся включённым.
ARG DOTNET_EnableWriteXorExecute

COPY openhub-*.ospx /build/
COPY packagedef /build/packagedef
COPY scripts/РаспаковатьПакет.os /build/РаспаковатьПакет.os

RUN set -eu; \
    ospx="$(ls /build/openhub-*.ospx)"; \
    version_pkgdef="$(sed -n 's/^[[:space:]]*\.Версия("\([^"]*\)").*/\1/p' /build/packagedef | head -n1)"; \
    test -n "$version_pkgdef" || { echo "packagedef: не найдена строка .Версия(\"…\")"; exit 1; }; \
    version_ospx="$(basename "$ospx" .ospx | sed 's/^openhub-//')"; \
    test "$version_ospx" = "$version_pkgdef" || { \
        echo "Версия .ospx ($version_ospx) не равна версии packagedef ($version_pkgdef): пересоберите пакет через docker/образ.sh"; exit 1; }; \
    oscript /build/РаспаковатьПакет.os "$ospx" /opt/openhub; \
    test -f /opt/openhub/packagedef || { \
        echo "В пакете нет packagedef: хабу нечем ответить о своей версии — верните .ВключитьФайл(\"packagedef\")"; exit 1; }; \
    version_app="$(sed -n 's/^[[:space:]]*\.Версия("\([^"]*\)").*/\1/p' /opt/openhub/packagedef | head -n1)"; \
    test "$version_app" = "$version_pkgdef" || { \
        echo "packagedef внутри пакета ($version_app) не равен собранному ($version_pkgdef): пересоберите пакет через docker/образ.sh"; exit 1; }; \
    printf '%s\n' "$version_pkgdef" > /opt/openhub/ВЕРСИЯ; \
    rm -rf /build

# ---------------------------------------------------------------------------
# Стадия 2: рантайм
# ---------------------------------------------------------------------------
FROM ${BASE_IMAGE}

# /opt/openhub — только чтение (владелец root): хаб туда не пишет.
COPY --from=unpack /opt/openhub /opt/openhub

# Данные инсталляции: файл SQLite, артефакты пакетов и журнал аудита
# (<oshub.storage.root>/аудит.log). Всё лежит в одном каталоге и обязано быть на томе —
# в слое образа оно не переживёт ни рестарт пода, ни обновление образа.
RUN set -eu; \
    groupadd --gid 10001 openhub; \
    useradd --uid 10001 --gid 10001 --no-create-home --home-dir /opt/openhub \
        --shell /usr/sbin/nologin openhub; \
    mkdir -p /var/lib/openhub; \
    chown 10001:10001 /var/lib/openhub

VOLUME ["/var/lib/openhub"]

# Приоритет источников конфигурации (сверху вниз):
#   1. переменные OSHUB_* при запуске контейнера;
#   2. autumn-properties.json в /opt/openhub — приезжает в пакете, монтируется поверх своим:
#      `-v ./autumn-properties.json:/opt/openhub/autumn-properties.json:ro`;
#   3. значения по умолчанию в коде.
#
# Здесь зашит только тот минимум, который является фактом контейнера, а не выбором
# оператора: расположение данных на томе. Всё остальное — включая oshub.storage.backend
# (по умолчанию "fs", то есть самодостаточный запуск) — берётся из файла и перебивается
# переменными.
ENV OSHUB_STORAGE_ROOT=/var/lib/openhub \
    OSHUB_DB_CONNECTOR=КоннекторSQLite \
    OSHUB_DB_CONNECTION="Data Source=/var/lib/openhub/openhub.db"

# Задаются при развёртывании, дефолта в образе нет и быть не должно:
#   OSHUB_STORAGE_BACKEND=s3 и к нему OSHUB_STORAGE_S3_ENDPOINT, OSHUB_STORAGE_S3_BUCKET,
#   OSHUB_STORAGE_S3_REGION, OSHUB_STORAGE_S3_ACCESS_KEY(_FILE),
#   OSHUB_STORAGE_S3_SECRET_KEY(_FILE),
#   OSHUB_STORAGE_S3_FORCE__PATH__STYLE (двойное подчёркивание — конвенция configor);
#   OSHUB_INSTANCE_URL, OSHUB_OIDC_*;
#   телеметрия — стандартными именами OpenTelemetry: OTEL_ENABLED, OTEL_SERVICE_NAME,
#   OTEL_EXPORTER_OTLP_ENDPOINT и OTEL_EXPORTER_OTLP_HEADERS (секрет коллектора — только сюда).
# АДМИН ПРИ СТАРТЕ НЕ СОЗДАЁТСЯ: OSHUB_ADMIN_LOGIN/OSHUB_ADMIN_PASSWORD намеренно пусты,
# первого администратора заводит мастер онбординга на /setup.

# Рабочий каталог задаёт корень поиска autumn-properties.json; библиотеки хаб находит
# по src/oscript.cfg (lib.additional=../oscript_modules), приехавшему в пакете.
WORKDIR /opt/openhub

USER 10001:10001

EXPOSE 3333

# Пробы оркестратора: GET /health — живость, GET /ready — готовность (503 до конца старта).
ENTRYPOINT ["oscript", "/opt/openhub/src/main.os"]
