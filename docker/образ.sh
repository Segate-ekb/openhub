#!/usr/bin/env bash
# Сборка образа хаба: пакет из packagedef -> .ospx -> образ linux/amd64.
#
# Версия берётся из packagedef и больше нигде не пишется: ею помечаются .ospx, теги
# образа и метки OCI.
#
# Зависимости едут внутри .ospx: хук ПриСборке в packagedef кладёт в пакет рантайм-закрытие
# .ЗависитОт из oscript_modules без dev-зависимостей, посторонних библиотек и частей, которых
# хаб не грузит (tools/ПоставкаЗависимостей.os). oscript_modules сборка только читает.
#
#   docker/образ.sh                          # segateekb/openhub:<версия> локально
#   docker/образ.sh --push                   # собрать и отправить в реестр
#   docker/образ.sh --push harbor.example/openhub   # другой репозиторий
#
# Публикация — только по явному --push.
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

# Версия сборки в пакете — та, что установлена в oscript_modules. oint — сборка форка из пула segate-ekb, autumn-cache —
# библиотека владельца: их версия в opm-metadata.xml обязана совпасть с .ЗависитОт в packagedef. Расхождение
# --push отказывает, проверочная сборка идёт дальше с предупреждением.
fork_builds="autumn-cache oint"

wanted_version() {
	sed -n "s/^[[:space:]]*\.ЗависитОт(\"$1\",[[:space:]]*\"\([^\"]*\)\").*/\1/p" packagedef | head -n1
}

installed_version() {
	sed -n 's/.*<version>\([^<]*\)<\/version>.*/\1/p' "oscript_modules/$1/opm-metadata.xml" 2>/dev/null | head -n1 || true
}

mismatched=""
for lib in $fork_builds; do
	wanted="$(wanted_version "$lib")"
	installed="$(installed_version "$lib")"
	if [ "$wanted" != "$installed" ]; then
		mismatched="${mismatched}  ${lib}: в oscript_modules ${installed:-нет сборки}, packagedef требует ${wanted:-—}"$'\n'
	fi
done

builds_explain() {
	printf '%s' "$mismatched" >&2
	cat >&2 <<-MSG
	Поставить зависимости версий packagedef — opm install -l в корне репозитория (пулы — в opm.cfg),
	шаг «Собрать и запустить» в docs/разработка.md.
	MSG
}

if [ -z "$mismatched" ]; then
	echo "== Сборки форков на месте: $fork_builds — версии как в packagedef"
elif [ "$push" = "1" ]; then
	echo "Публикация остановлена: сборки форков в oscript_modules не совпадают с packagedef:" >&2
	builds_explain
	echo "Затем запустить docker/образ.sh --push заново." >&2
	exit 1
else
	echo "!! ВНИМАНИЕ: сборки форков в oscript_modules не совпадают с packagedef — этот образ НЕЛЬЗЯ публиковать:" >&2
	builds_explain
	echo "!! Проверочная сборка продолжается; docker/образ.sh --push с этими модулями откажет." >&2
fi

echo "== Сборка пакета (opm build .)"
opm build .

ospx="openhub-${version}.ospx"
if [ ! -f "$ospx" ]; then
	echo "После сборки нет файла $ospx" >&2
	exit 1
fi
echo "== Пакет: $ospx ($(du -h "$ospx" | cut -f1))"

# Пакеты других версий попали бы под маску openhub-*.ospx, по которой Dockerfile ставит пакет.
stale="$(ls openhub-*.ospx | grep -v "^${ospx}$" || true)"
if [ -n "$stale" ]; then
	echo "В корне лежат пакеты других версий — уберите их перед сборкой образа:" >&2
	echo "$stale" >&2
	exit 1
fi

# Кросс-сборка с Apple Silicon: qemu ломает JIT .NET, и opm при распаковке пакета падает
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
