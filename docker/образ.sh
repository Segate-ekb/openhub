#!/usr/bin/env bash
# Сборка образа хаба: пакет из packagedef -> .ospx -> образ linux/amd64.
#
# Версия берётся ИЗ packagedef и больше нигде не пишется: ею помечается .ospx, ею
# помечается тег образа и метки OCI, её же сверяет с образом сама сборка (см. Dockerfile).
#
#   docker/образ.sh                          # segateekb/openhub:<версия> локально
#   docker/образ.sh --push                   # собрать и отправить в реестр
#   docker/образ.sh --push harbor.example/openhub   # другой репозиторий
#
# Публикация — только по явному --push: реестр и права на него решение владельца,
# а не побочный эффект сборки.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

push=0
if [ "${1:-}" = "--push" ]; then
	push=1
	shift
fi

image_repo="${1:-segateekb/openhub}"

version="$(sed -n 's/^[[:space:]]*\.Версия("\([^"]*\)").*/\1/p' packagedef | head -n1)"
if [ -z "$version" ]; then
	echo "packagedef: не найдена строка .Версия(\"…\")" >&2
	exit 1
fi

echo "== Версия из packagedef: $version"

echo "== Сборка пакета (opm build .)"
opm build .

ospx="openhub-${version}.ospx"
if [ ! -f "$ospx" ]; then
	echo "После сборки нет файла $ospx" >&2
	exit 1
fi
echo "== Пакет: $ospx ($(du -h "$ospx" | cut -f1))"

# Лишние сборки прошлых версий сбили бы glob COPY openhub-*.ospx в Dockerfile.
stale="$(ls openhub-*.ospx | grep -v "^${ospx}$" || true)"
if [ -n "$stale" ]; then
	echo "В корне лежат пакеты других версий — уберите их перед сборкой образа:" >&2
	echo "$stale" >&2
	exit 1
fi

# Кросс-сборка с Apple Silicon: qemu ломает JIT .NET, и распаковщик на oscript падает
# прямо на стадии сборки. На настоящем amd64 аргумент не передаётся.
build_args=()
if [ "$(uname -m)" != "x86_64" ]; then
	echo "== Хост $(uname -m): сборка amd64 идёт через эмуляцию, отключаю W^X .NET"
	build_args+=(--build-arg "DOTNET_EnableWriteXorExecute=0")
fi

if [ "$push" = "1" ]; then
	echo "== Сборка и публикация образа ${image_repo}:${version} (linux/amd64)"
	output=(--push)
else
	echo "== Сборка образа ${image_repo}:${version} (linux/amd64)"
	output=(--load)
fi

docker buildx build \
	--file docker/Dockerfile \
	--platform linux/amd64 \
	"${build_args[@]}" \
	--tag "${image_repo}:${version}" \
	--tag "${image_repo}:latest" \
	--label "org.opencontainers.image.title=OpenHub" \
	--label "org.opencontainers.image.version=${version}" \
	--label "org.opencontainers.image.description=Открытый хаб пакетов OneScript" \
	"${output[@]}" \
	.

echo
if [ "$push" = "1" ]; then
	echo "Опубликовано: ${image_repo}:${version} и ${image_repo}:latest"
else
	echo "Готово: ${image_repo}:${version} (локально, без публикации)"
fi
echo "Локальный запуск на Apple Silicon требует -e DOTNET_EnableWriteXorExecute=0:"
echo "  эмуляция amd64 через qemu ломает JIT .NET; на настоящем amd64 переменная не нужна."
