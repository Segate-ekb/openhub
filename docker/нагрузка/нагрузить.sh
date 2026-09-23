#!/usr/bin/env bash
# Генератор нагрузки. Запускается НЕ на сервере стенда — иначе два ядра испытуемого
# делятся с генератором и замер испорчен. На машине генератора нужны docker (тянет образ
# oha) и zip (сборка .ospx для публикаций).
#
#   ./нагрузить.sh маршруты                      # собрать цели из живого хаба -> маршруты.txt
#   ./нагрузить.sh смесь 50 300 C-50             # смесь маршрутов: 50 соединений, 300 с, метка C-50
#   ./нагрузить.sh один /ready 25 120 проба      # одна ручка
#   ./нагрузить.sh пакеты 1 20 100               # собрать .ospx весом 1, 20 и 100 МБ
#   ./нагрузить.sh публикации 5 20 F-5x20        # 5 параллельных публикаций по 20 МБ
#
# Адрес стенда обязателен и нигде не зашит. Задать один раз файлом рядом со скриптом:
#
#   echo 'HUB=http://<адрес-стенда>:3333' > цель.env
#
# либо переменной на вызов: `HUB=http://… ./нагрузить.sh …`. Токен для публикаций лежит
# на СЕРВЕРЕ СТЕНДА в ~/openhub-load/стенд.env — оттуда его и берут.
#
# Функции названы по-русски, переменные — латиницей: кириллицу в именах переменных
# bash не допускает, в именах функций — вполне.
set -eu

DIR="${DIR:-$(cd "$(dirname "$0")" && pwd)}"

# Файл цели читается ДО проверки: он и есть штатный способ задать адрес.
# shellcheck disable=SC1091
[ -f "$DIR/цель.env" ] && . "$DIR/цель.env"

HUB="${HUB:?укажи адрес стенда: HUB=http://<адрес>:3333 — или положи строку HUB=… в цель.env рядом со скриптом}"
POOL="${POOL:-public}"
TOKEN="${TOKEN:-}"
OHA="${OHA:-ghcr.io/hatoo/oha:v1.4.5}"
OUT="$DIR/итоги"
ROUTES="$DIR/маршруты.txt"
PKGDIR="$DIR/пакеты"

mkdir -p "$OUT"

# --- цели ----------------------------------------------------------------------
# Маршруты собираются из живого хаба, а не прибиты гвоздями: после зеркалирования
# имена пакетов заранее неизвестны, а бить в несуществующее имя — мерить 404.
маршруты() {
	NAMES=$(curl -s -m 30 "$HUB/api/v1/pools/$POOL/packages?pageSize=40" \
		| tr ',' '\n' | sed -n 's/.*"name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -20)
	if [ -z "$NAMES" ]; then
		echo "в пуле $POOL нет пакетов — сначала зеркалирование"; exit 1
	fi

	: > "$ROUTES"
	{
		echo "3	$HUB/"
		echo "1	$HUB/ready"
		echo "1	$HUB/api/v1/metrics"
		echo "3	$HUB/api/v1/pools/$POOL/packages?pageSize=20"
	} >> "$ROUTES"

	# Карточка пакета живёт по адресу «/{пул}/{имя}», а не «/package/{имя}»: короткая
	# форма отвечает перенаправлением. Веб-поиск параметра q не знает — списковый поиск
	# спрашивается у API.
	N=0
	for PKG in $NAMES; do
		N=$((N + 1))
		[ "$N" -le 6 ] || break
		echo "1	$HUB/$POOL/$PKG" >> "$ROUTES"
		echo "1	$HUB/api/v1/pools/$POOL/packages/$PKG/versions" >> "$ROUTES"
		echo "1	$HUB/api/v1/search?q=$(printf '%s' "$PKG" | cut -c1-3)" >> "$ROUTES"
	done

	# Артефакт по короткому адресу выдачи основного пула — именно им ходит opm.
	# Крупный артефакт добавляется переменной BIG_PKG вида «имя/имя-версия.ospx».
	for PKG in $NAMES; do
		VER=$(curl -s -m 30 "$HUB/api/v1/pools/$POOL/packages/$PKG/versions" \
			| tr ',' '\n' | sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
		[ -n "$VER" ] || continue
		echo "2	$HUB/download/$PKG/$PKG-$VER.ospx" >> "$ROUTES"
		break
	done
	if [ -n "${BIG_PKG:-}" ]; then
		echo "1	$HUB/download/$BIG_PKG" >> "$ROUTES"
	fi

	echo "маршрутов: $(wc -l < "$ROUTES")"
	cat "$ROUTES"
}

# --- нагрузка ------------------------------------------------------------------
# oha на каждую группу маршрутов отдельным процессом: один oha бьёт в один адрес,
# а нужна смесь. Соединения делятся между группами по весам из маршруты.txt.
смесь() {
	CONC="${1:?параллелизм}"; SECS="${2:?секунды}"; LABEL="${3:?метка}"
	[ -f "$ROUTES" ] || { echo "нет $ROUTES — сначала ./нагрузить.sh маршруты"; exit 1; }

	TOTALW=$(awk -F'\t' '{s+=$1} END {print s}' "$ROUTES")
	RUNDIR="$OUT/$LABEL"
	rm -rf "$RUNDIR"; mkdir -p "$RUNDIR"

	echo "ступень $LABEL: $CONC соединений на $SECS с, весов $TOTALW, групп $(wc -l < "$ROUTES")"
	echo "начало: $(date -u +%Y-%m-%dT%H:%M:%SZ)" > "$RUNDIR/окно.txt"

	N=0
	while IFS="$(printf '\t')" read -r W URL; do
		[ -n "${URL:-}" ] || continue
		N=$((N + 1))
		C=$(awk -v c="$CONC" -v w="$W" -v t="$TOTALW" 'BEGIN {v=int(c*w/t); if (v<1) v=1; print v}')
		docker run --rm --network host "$OHA" \
			-c "$C" -z "${SECS}s" --no-tui --output-format json --insecure \
			-H 'Accept-Encoding: gzip' -t 30s "$URL" \
			> "$RUNDIR/$N.json" 2> "$RUNDIR/$N.err" &
	done < "$ROUTES"

	wait
	echo "конец: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RUNDIR/окно.txt"
	итоги "$LABEL"
}

один() {
	RPATH="${1:?путь}"; CONC="${2:?параллелизм}"; SECS="${3:?секунды}"; LABEL="${4:?метка}"
	RUNDIR="$OUT/$LABEL"; rm -rf "$RUNDIR"; mkdir -p "$RUNDIR"
	echo "начало: $(date -u +%Y-%m-%dT%H:%M:%SZ)" > "$RUNDIR/окно.txt"
	docker run --rm --network host "$OHA" -c "$CONC" -z "${SECS}s" --no-tui --output-format json -t 30s \
		"$HUB$RPATH" > "$RUNDIR/1.json" 2> "$RUNDIR/1.err" || true
	echo "конец: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RUNDIR/окно.txt"
	итоги "$LABEL"
}

# Сводка по ступени: RPS, задержки, коды. Числа берутся из JSON oha без внешних
# инструментов — на генераторе может не быть ни jq, ни питона.
итоги() {
	LABEL="${1:?метка}"
	RUNDIR="$OUT/$LABEL"
	echo "--- ступень $LABEL ---"
	for F in "$RUNDIR"/*.json; do
		[ -f "$F" ] || continue
		printf '%s ' "$(basename "$F" .json)"
		tr ',' '\n' < "$F" | sed -n \
			-e 's/.*"requestsPerSec"[[:space:]]*:[[:space:]]*\([0-9.]*\).*/rps=\1/p' \
			-e 's/.*"p50"[[:space:]]*:[[:space:]]*\([0-9.]*\).*/p50=\1/p' \
			-e 's/.*"p95"[[:space:]]*:[[:space:]]*\([0-9.]*\).*/p95=\1/p' \
			-e 's/.*"p99"[[:space:]]*:[[:space:]]*\([0-9.]*\).*/p99=\1/p' \
			| tr '\n' ' '
		printf 'коды: '
		tr ',{' '\n\n' < "$F" | sed -n 's/.*"\([0-9][0-9][0-9]\)"[[:space:]]*:[[:space:]]*\([0-9]*\).*/\1=\2/p' | tr '\n' ' '
		echo
	done
	cat "$RUNDIR/окно.txt"
}

# --- публикации ----------------------------------------------------------------
# .ospx — это zip с opm-metadata.xml и content.zip внутри. Вес набирается содержимым:
# случайные байты, чтобы zip не сжимал их в ничто и по проводу шло ровно столько,
# сколько объявлено. Имя пакета — только латиницей: кириллицу хаб не принимает.
собрать_ospx() {
	PKG="$1"; MB="$2"; DEST="$3"
	WORK="$(dirname "$DEST")/сборка-$PKG"
	rm -rf "$WORK"; mkdir -p "$WORK/содержимое"
	cat > "$WORK/opm-metadata.xml" <<XML
<?xml version="1.0" encoding="UTF-8"?>
<opm-metadata xmlns="http://oscript.io/schemas/opm-metadata/1.0"><name>$PKG</name><version>1.0.0</version><description>Пакет нагрузочного стенда</description></opm-metadata>
XML
	printf '# %s\n\nПакет нагрузочного стенда.\n' "$PKG" > "$WORK/содержимое/README.md"
	dd if=/dev/urandom of="$WORK/содержимое/данные.bin" bs=1M count="$MB" status=none
	( cd "$WORK/содержимое" && zip -q -0 -r ../content.zip . )
	( cd "$WORK" && zip -q -0 "$DEST" opm-metadata.xml content.zip )
	rm -rf "$WORK"
}

# Отдельная команда — посмотреть на вес .ospx до того, как его публиковать.
пакеты() {
	mkdir -p "$PKGDIR"
	for MB in "$@"; do
		PKG="loadpkg${MB}m"
		rm -f "$PKGDIR/$PKG.ospx"
		собрать_ospx "$PKG" "$MB" "$PKGDIR/$PKG.ospx"
		echo "$PKGDIR/$PKG.ospx — $(du -m "$PKGDIR/$PKG.ospx" | cut -f1) МБ"
	done
}

# Каждая публикация — своё имя: иммутабельность не даст положить одну версию дважды,
# и повтор мерил бы отказ, а не приём. Поэтому архив собирается на месте, а не берётся
# из каталога пакеты/ — та команда нужна только чтобы посмотреть на вес.
публикации() {
	COUNT="${1:?сколько параллельно}"; MB="${2:?вес в МБ}"; LABEL="${3:?метка}"
	[ -n "$TOKEN" ] || { echo "нужен TOKEN=<pat> — он лежит на сервере стенда в ~/openhub-load/стенд.env"; exit 1; }
	RUNDIR="$OUT/$LABEL"; rm -rf "$RUNDIR"; mkdir -p "$RUNDIR"
	STAMP=$(date +%s)

	echo "начало: $(date -u +%Y-%m-%dT%H:%M:%SZ)" > "$RUNDIR/окно.txt"
	N=0
	while [ "$N" -lt "$COUNT" ]; do
		N=$((N + 1))
		PKG="loadpkg${MB}m-${STAMP}-${N}"
		TMPF="$RUNDIR/$PKG.ospx"
		собрать_ospx "$PKG" "$MB" "$TMPF"
		(
			curl -s -o "$RUNDIR/$PKG.ответ" -w "$PKG %{http_code} %{time_total} %{size_upload}\n" \
				-m 900 -X POST "$HUB/api/v1/pools/$POOL/push" \
				-H "Authorization: Bearer $TOKEN" \
				-H 'Content-Type: application/octet-stream' \
				-H "FILE-NAME: $PKG-1.0.0.ospx" \
				--data-binary "@$TMPF" >> "$RUNDIR/коды.txt" 2>&1
			rm -f "$TMPF"
		) &
	done
	wait
	echo "конец: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$RUNDIR/окно.txt"
	cat "$RUNDIR/коды.txt"
	cat "$RUNDIR/окно.txt"
}

case "${1:-}" in
	маршруты)    маршруты;;
	смесь)       shift; смесь "$@";;
	один)        shift; один "$@";;
	пакеты)      shift; пакеты "$@";;
	публикации)  shift; публикации "$@";;
	итоги)       shift; итоги "$@";;
	*) sed -n '2,20p' "$0"; exit 2;;
esac
