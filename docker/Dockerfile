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
# ни opm, ни hub.oscript.io при сборке образа не нужны. Сеть при сборке всё же нужна, но
# в две стороны и только: `github.com` — за архивом релиза OneScript, `deb.debian.org` —
# за curl и unzip для стадии скачивания.
#
# РАНТАЙМ ОБРАЗ СТАВИТ СЕБЕ САМ — из официального релиза OneScript, а не берёт готовым
# образом чужого тега. Тег обещает меньше, чем кажется: под номером выпуска у публикатора
# встречалась предрелизная сборка без функций, на которые хаб опирается через свои
# библиотеки, и собранный так контейнер падал «Неизвестный символ» на первом обращении
# к БД — уже у оператора. Здесь версия названа явно (ONESCRIPT_VERSION), архив сверяется
# по SHA-256, а стадия распаковки вдобавок спрашивает версию у самого `oscript` и падает
# на предрелизной сборке или на выпуске старее .ВерсияСреды из packagedef. Тот же рубеж
# со стороны объявления стережёт tests/ОбразХаба_Тесты.os.
#
# База — runtime-deps .NET: сборка OneScript самодостаточна (несёт свой .NET), базе остаётся
# дать ей нативные зависимости — ICU, OpenSSL, корневые сертификаты.
#
# ⚠ Проверка образа на Apple Silicon: эмуляция amd64 через qemu ломает JIT .NET, и ЛЮБАЯ
# библиотека падает NullReferenceException на инициализации модуля (а иногда segfault-ом).
# Запускать локально только с -e DOTNET_EnableWriteXorExecute=0. В образ эта переменная НЕ
# зашита: на настоящем amd64 она не нужна, а W^X — защита рантайма.

ARG BASE_IMAGE=mcr.microsoft.com/dotnet/runtime-deps:8.0
ARG DOWNLOADER_IMAGE=debian:bookworm-slim
ARG ONESCRIPT_VERSION=2.2.0
ARG ONESCRIPT_SHA256=3b3b0a96e141d6758b74cbf492d5e5c11823bfd92318caff1aaa19bd500f1df7

# ---------------------------------------------------------------------------
# Стадия 1: рантайм OneScript из официального релиза
# ---------------------------------------------------------------------------
FROM ${DOWNLOADER_IMAGE} AS onescript

ARG ONESCRIPT_VERSION
ARG ONESCRIPT_SHA256

# Скачивание отделено от рантайма намеренно: curl и unzip нужны только здесь и в готовый
# образ не едут. Несовпадение контрольной суммы роняет сборку — подменённый или битый
# архив до образа не доходит.
RUN set -eu; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl unzip; \
    rm -rf /var/lib/apt/lists/*; \
    curl -fsSL -o /tmp/onescript.zip \
        "https://github.com/EvilBeaver/OneScript/releases/download/v${ONESCRIPT_VERSION}/OneScript-${ONESCRIPT_VERSION}-linux-x64.zip"; \
    printf '%s  %s\n' "${ONESCRIPT_SHA256}" /tmp/onescript.zip | sha256sum -c -; \
    mkdir -p /opt/onescript; \
    unzip -q /tmp/onescript.zip -d /opt/onescript; \
    chmod +x /opt/onescript/bin/oscript /opt/onescript/bin/opm; \
    rm -f /tmp/onescript.zip

# ---------------------------------------------------------------------------
# Стадия 2: распаковка пакета и сверка версий
# ---------------------------------------------------------------------------
FROM ${BASE_IMAGE} AS unpack

# Тот же обход эмуляции, что и при запуске: под qemu распаковщик на oscript падает
# segfault-ом ещё на сборке. docker/образ.sh подставляет 0 только на хосте arm64;
# на настоящем amd64 аргумент пустой и W^X остаётся включённым.
ARG DOTNET_EnableWriteXorExecute

COPY --from=onescript /opt/onescript /opt/onescript
ENV PATH=/opt/onescript/bin:$PATH

COPY openhub-*.ospx /build/
COPY packagedef /build/packagedef
COPY scripts/РаспаковатьПакет.os /build/РаспаковатьПакет.os

RUN set -eu; \
    version_engine="$(sed -n 's/^[[:space:]]*\.ВерсияСреды("\([^"]*\)").*/\1/p' /build/packagedef | head -n1)"; \
    test -n "$version_engine" || { echo "packagedef: не найдена строка .ВерсияСреды(\"…\")"; exit 1; }; \
    version_runtime="$(oscript -version | tr -d '\r' | head -n1)"; \
    case "$version_runtime" in *-*) \
        echo "Распакованный архив несёт предрелизную сборку OneScript ($version_runtime): в ней нет того, что есть в выпуске, и хаб упадёт на первом обращении к БД. Укажите в ARG ONESCRIPT_VERSION номер выпуска"; exit 1;; \
    esac; \
    test "$(printf '%s\n%s\n' "$version_engine" "$version_runtime" | sort -V | head -n1)" = "$version_engine" || { \
        echo "Установленный рантайм ($version_runtime) старее .ВерсияСреды из packagedef ($version_engine): зависимости хаба его не поддерживают. Поднимите ARG ONESCRIPT_VERSION и ARG ONESCRIPT_SHA256"; exit 1; }; \
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
# Стадия 3: рантайм
# ---------------------------------------------------------------------------
FROM ${BASE_IMAGE}

# Рантайм OneScript и сам хаб — оба только на чтение (владелец root): хаб туда не пишет.
COPY --from=onescript /opt/onescript /opt/onescript
COPY --from=unpack /opt/openhub /opt/openhub

ENV PATH=/opt/onescript/bin:$PATH

# База .NET рассчитана на приложение ASP.NET, которое слушает 8080 под пользователем 1654;
# у нас ни того, ни другого. Пока ASPNETCORE_HTTP_PORTS оставался унаследованным, Kestrel
# на КАЖДОМ старте писал `warn: Overriding address(es) 'http://*:8080'` — порт хабу задаёт
# winow. Гасим обе: пустое значение ничего не задаёт, но и не даёт чужому умолчанию
# дожить до рантайма.
ENV ASPNETCORE_HTTP_PORTS= \
    APP_UID=

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
