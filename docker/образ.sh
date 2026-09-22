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

# oscript_modules едет в .ospx и дальше в образ как есть. Хабовая сборка oint неверно
# подписывает слеш в ?prefix= — а хаб листает хранилище префиксом pools/<пул>/, и с ней
# на S3 отказывает любой листинг. Исправленная авторская сборка вышла под тем же номером,
# отличить её можно только по коду: маркер — вызов ПолучитьКодированнуюСтроку.
# Опасна публикация, а не сборка: без маркера --push отказывает, проверочная сборка
# идёт дальше с предупреждением.
oint_http="oscript_modules/oint/tools/http/Modules/internal/Classes/OPI_HTTPКлиент.os"
oint_fixed=1
grep -q "ПолучитьКодированнуюСтроку" "$oint_http" 2>/dev/null || oint_fixed=0

oint_explain() {
	cat >&2 <<-MSG
	В $oint_http
	нет исправления подписи S3 (маркер ПолучитьКодированнуюСтроку).

	Это oint из hub.oscript.io — с ней образ не ходит в S3: листинг pools/<пул>/ получает
	403 SignatureDoesNotMatch, отказывают опись обхода зеркала, вытеснение кэша прокси,
	объёмы пулов и удаление пула.

	Что сделать — одно из двух:
	  1) положить в oscript_modules/oint авторскую сборку oint с исправлением — она вышла
	     под тем же номером, что в packagedef (скопировать каталог с машины, где она стоит);
	     после этого не запускать «opm install -l» без имени пакета — он вернёт хабовую
	     сборку поверх;
	  2) когда автор выпустит следующую версию oint с исправлением: поднять
	     .ЗависитОт("oint", …) в packagedef и выполнить «opm install -l oint».
	MSG
}

if [ "$oint_fixed" = "1" ]; then
	echo "== oint: исправление подписи S3 на месте"
elif [ "$push" = "1" ]; then
	echo "Публикация остановлена: образ с этой oint не работает с S3." >&2
	oint_explain
	echo "Затем запустить docker/образ.sh --push заново." >&2
	exit 1
else
	echo "!! ВНИМАНИЕ: oint без исправления подписи S3 — этот образ НЕЛЬЗЯ публиковать." >&2
	oint_explain
	echo "!! Проверочная сборка продолжается; docker/образ.sh --push с этой oint откажет." >&2
fi

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
