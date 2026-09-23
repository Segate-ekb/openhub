# Образ хаба OpenHub. Контекст сборки — корень репозитория; собирать через docker/образ.sh.

ARG ONESCRIPT_IMAGE=evilbeaver/onescript:2.2.0

FROM ${ONESCRIPT_IMAGE}

# Под qemu (сборка amd64 на arm64) opm падает без отключения W^X; docker/образ.sh подставляет 0.
ARG DOTNET_EnableWriteXorExecute

# Пакет примонтирован на время установки и в слой образа не попадает.
RUN --mount=type=bind,target=/build set -eu; \
    opm update opm; \
    opm install -f /build/openhub-*.ospx -s -d /opt --skip-create-app; \
    rm -f /opt/openhub/autumn-properties.json

# Унаследованные от базы ASP.NET порт и пользователь гасятся: порт задаёт winow, пользователь — ниже.
ENV ASPNETCORE_HTTP_PORTS= \
    APP_UID=

# База живёт по Москве; драйвер SQLite переводит даты в пояс процесса, хабу нужен UTC.
ENV TZ=UTC

RUN set -eu; \
    ln -snf /usr/share/zoneinfo/UTC /etc/localtime; \
    echo UTC > /etc/timezone; \
    apt-get update; \
    apt-get install -y --no-install-recommends curl; \
    rm -rf /var/lib/apt/lists/*

RUN set -eu; \
    groupadd --gid 10001 openhub; \
    useradd --uid 10001 --gid 10001 --no-create-home --home-dir /opt/openhub \
        --shell /usr/sbin/nologin openhub; \
    mkdir -p /var/lib/openhub; \
    chown 10001:10001 /var/lib/openhub

VOLUME ["/var/lib/openhub"]

ENV OSHUB_STORAGE_ROOT=/var/lib/openhub \
    OSHUB_DB_CONNECTOR=КоннекторSQLite \
    OSHUB_DB_CONNECTION="Data Source=/var/lib/openhub/openhub.db"

WORKDIR /opt/openhub

USER 10001:10001

EXPOSE 3333

HEALTHCHECK --interval=30s --timeout=5s --start-period=120s --retries=3 \
    CMD curl -fsS "http://localhost:${OSHUB_PORT:-3333}/ready" || exit 1

ENTRYPOINT ["oscript", "/opt/openhub/src/main.os"]
