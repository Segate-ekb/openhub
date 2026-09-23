#!/usr/bin/env bash
# Сводка одного разделяющего опыта: что было с памятью, потоками и фоном, сколько
# запросов хаб успел обслужить и во что это обошлось на запрос.
# Запускается НА СЕРВЕРЕ СТЕНДА после того, как нагрузка кончилась.
#
#   ./итог-опыта.sh 2-только-трассы            # интервал самплера взят по умолчанию (5 с)
#   EVERY=2 ./итог-опыта.sh 2-только-трассы    # если самплер гонялся с другим интервалом
#   ROUTE=/ready ./итог-опыта.sh проба         # если нагрузка шла не по /health
#
# «КБ на запрос» — главное число круга: оно делится не на время, а на работу, и потому
# сравнимо между прогонами с разной пропускной способностью.
set -eu

NAME="${1:?нужно имя сценария}"
DIR="${DIR:-$(cd "$(dirname "$0")" && pwd)}"
HUB="${HUB:-openhub-load-openhub-1}"
EVERY="${EVERY:-5}"
ROUTE="${ROUTE:-/health}"
COLLECTOR="${COLLECTOR:-http://127.0.0.1:8889/metrics}"
FILE="$DIR/замеры/$NAME.csv"

[ -f "$FILE" ] || { echo "нет $FILE"; exit 1; }

# Запросы считаются по журналу самого хаба: генератор считает и те, что не доехали.
# Шаблон не привязан к адресу стенда — хост в строке журнала произвольный.
SERVED=$(docker logs "$HUB" 2>&1 \
	| grep -c "Request finished HTTP/1.1 GET [^ ]*${ROUTE} " || true)

awk -F';' -v name="$NAME" -v served="$SERVED" -v every="$EVERY" -v route="$ROUTE" '
	NR == 2 { rss0 = $2; kot0 = $9 }
	NR > 1 {
		n++
		if ($2 + 0 > rssmax) rssmax = $2 + 0
		if ($5 + 0 > thrmax) thrmax = $5 + 0
		rss = $2; kot = $9; thr = $5; fds = $6
		if ($7 + 0 < 0) nomolch++
	}
	END {
		printf "опыт             : %s\n", name
		printf "замеров          : %d (по %s с = %d с)\n", n, every, n * every
		printf "RSS старт→конец  : %s → %s МБ   (пик %d МБ)\n", rss0, rss, rssmax
		printf "котёл старт→кон  : %s → %s МБ\n", kot0, kot
		printf "потоки конец/пик : %s / %d\n", thr, thrmax
		printf "дескрипторы      : %s%s\n", fds, (fds + 0 < 0 ? "  (прочитать не дали, нужен sudo)" : "")
		printf "обслужено %-7s: %d\n", route, served
		if (served > 0) printf "КБ на запрос     : %.1f\n", (rss - rss0) * 1024 / served
		printf "проб /ready без ответа: %d\n", nomolch + 0
	}
' "$FILE"

# Результат берём в переменную, а не глушим `|| echo`: у конвейера код возврата нулевой
# даже когда grep ничего не нашёл, и сообщение так никогда бы не напечаталось.
JOBS=$(curl -s -m 10 "$COLLECTOR" 2>/dev/null | grep '^oshub_background_jobs' | awk '{print $NF}' | head -1 || true)
if [ -n "$JOBS" ]; then
	echo "oshub.background_jobs : $JOBS"
else
	echo "oshub.background_jobs : нет данных (коллектор молчит либо метрики выключены)"
fi
