#!/usr/bin/env bash
# Самплер стенда: раз в N секунд пишет строку CSV в замеры/<сценарий>.csv.
# Запускается НА СЕРВЕРЕ СТЕНДА, в фоне, на всё время сценария. Обычно его включает
# перезапустить.sh; вручную — так:
#
#   setsid nohup ./самплер.sh A-холостой 5 </dev/null > логи/самплер-A.log 2>&1 &
#
# Свой pid самплер записывает сам — в логи/самплер-<сценарий>.pid, чтобы его потом
# гасили по номеру, а не шаблоном по всем самплерам машины.
#
# Колонки:
#   время           — ISO, UTC
#   rss_хаб         — VmRSS процесса oscript, МБ
#   rss_pg          — память cgroup контейнера postgres, МБ (процессов у него много)
#   cpu_хаб         — процент одного ядра за интервал (200 = два ядра насыщены)
#   threads_oscript — /proc/<pid>/status Threads
#   fds_oscript     — открытых дескрипторов; -1 = прочитать не дали (см. ниже про sudo)
#   ready_ms        — время ответа /ready; -1 = не ответил за таймаут
#   pg_connections  — «всего/активных» бэкендов базы openhub БЕЗ учёта самого самплера:
#                     10/0 значит «пул выбран, а база простаивает» — слоты держит хаб
#   котёл_мб        — memory.current всего слайса: хаб и база вместе
#   котёл_пик_мб    — memory.peak слайса
#   отказов_котла   — memory.events max: сколько раз котёл упёрся в потолок
#   oom_котла       — memory.events oom_kill: сколько раз котёл кого-то убил
#   хаб_статус      — State.Status контейнера хаба
#
# ⚠ Колонка fds_oscript требует прав на /proc/<pid>/fd чужого процесса: контейнер
# работает под своим uid, поэтому читать каталог может только root. Если passwordless
# sudo недоступен, в колонке будет -1 — честное «не знаю», а не молчаливый ноль.
#
# Имена переменных оболочки — латиницей: кириллицу в идентификаторах bash не допускает.
set -eu

NAME="${1:?нужно имя сценария}"
EVERY="${2:-5}"
DIR="${DIR:-$(cd "$(dirname "$0")" && pwd)}"
PORT="${PORT:-3333}"
# systemd вкладывает слайс по дефису в имени: openhub-load.slice живёт внутри openhub.slice
SLICE="${SLICE:-/sys/fs/cgroup/openhub.slice/openhub-load.slice}"
HUB="${HUB:-openhub-load-openhub-1}"
PG="${PG:-openhub-load-postgres-1}"

FILE="$DIR/замеры/$NAME.csv"
mkdir -p "$DIR/замеры" "$DIR/логи"

# Свой pid пишет сам самплер, а не тот, кто его запустил: `setsid nohup … &` форкается,
# и `$!` в родителе — это pid короткоживущего посредника, а не самплера.
echo $$ > "$DIR/логи/самплер-$NAME.pid"

if [ ! -f "$FILE" ]; then
	echo "время;rss_хаб;rss_pg;cpu_хаб;threads_oscript;fds_oscript;ready_ms;pg_connections;котёл_мб;котёл_пик_мб;отказов_котла;oom_котла;хаб_статус" > "$FILE"
fi

# Число из файла cgroup; нет файла или "max" — ноль.
цифра() {
	if [ -r "$1" ]; then
		V=$(cat "$1" 2>/dev/null || echo 0)
		case "$V" in (max|'') echo 0;; (*) echo "$V";; esac
	else
		echo 0
	fi
}

событие_котла() {
	if [ -r "$SLICE/memory.events" ]; then
		awk -v k="$1" '$1==k {print $2}' "$SLICE/memory.events" 2>/dev/null | head -1
	else
		echo 0
	fi
}

# Читаем сами, если пустили; иначе через sudo без пароля; иначе честное -1.
дескрипторы() {
	TPID="$1"
	if ls "/proc/$TPID/fd" > /dev/null 2>&1; then
		ls "/proc/$TPID/fd" 2>/dev/null | wc -l
	elif sudo -n true 2>/dev/null; then
		sudo -n ls "/proc/$TPID/fd" 2>/dev/null | wc -l
	else
		echo -1
	fi
}

PREV_TICKS=""
PREV_TIME=""
HZ=$(getconf CLK_TCK)

while :; do
	TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)

	HPID=$(docker inspect -f '{{.State.Pid}}' "$HUB" 2>/dev/null || echo 0)
	HSTATE=$(docker inspect -f '{{.State.Status}}' "$HUB" 2>/dev/null || echo "нет")

	RSS_HUB=0; THREADS=0; FDS=0; CPU=0
	if [ "$HPID" != "0" ] && [ -r "/proc/$HPID/status" ]; then
		RSS_HUB=$(awk '/^VmRSS:/ {printf "%.0f", $2/1024}' "/proc/$HPID/status" 2>/dev/null || echo 0)
		THREADS=$(awk '/^Threads:/ {print $2}' "/proc/$HPID/status" 2>/dev/null || echo 0)
		FDS=$(дескрипторы "$HPID")
		TICKS=$(awk '{print $14+$15}' "/proc/$HPID/stat" 2>/dev/null || echo 0)
		NOW=$(date +%s)
		if [ -n "$PREV_TICKS" ] && [ -n "$PREV_TIME" ] && [ "$NOW" -gt "$PREV_TIME" ]; then
			CPU=$(awk -v a="$PREV_TICKS" -v b="$TICKS" -v dt="$((NOW - PREV_TIME))" -v hz="$HZ" \
				'BEGIN {v=(b-a)*100/hz/dt; if (v<0) v=0; printf "%.1f", v}')
		fi
		PREV_TICKS="$TICKS"; PREV_TIME="$NOW"
	fi

	PGPID=$(docker inspect -f '{{.State.Pid}}' "$PG" 2>/dev/null || echo 0)
	RSS_PG=0
	if [ "$PGPID" != "0" ]; then
		CG=$(head -1 "/proc/$PGPID/cgroup" 2>/dev/null | cut -d: -f3 || echo "")
		if [ -n "$CG" ] && [ -r "/sys/fs/cgroup$CG/memory.current" ]; then
			RSS_PG=$(( $(цифра "/sys/fs/cgroup$CG/memory.current") / 1048576 ))
		fi
	fi

	T0=$(date +%s%3N)
	CODE=$(curl -s -o /dev/null -w '%{http_code}' -m 10 "http://127.0.0.1:$PORT/ready" 2>/dev/null || echo 000)
	READY=$(( $(date +%s%3N) - T0 ))
	[ "$CODE" = "200" ] || READY=-1

	# pid <> pg_backend_pid(): собственный бэкенд самплера в счёт не идёт, иначе
	# «10 из 10 занято» никогда бы не наблюдалось — одиннадцатым всегда был бы он сам.
	CONNS=$(docker exec "$PG" psql -U openhub -d openhub -tAc \
		"select count(*) || '/' || count(*) filter (where state='active') from pg_stat_activity where datname='openhub' and pid <> pg_backend_pid()" \
		2>/dev/null | tr -d ' \r' || echo 0)
	[ -n "$CONNS" ] || CONNS=0

	KOTEL=$(( $(цифра "$SLICE/memory.current") / 1048576 ))
	PEAK=$(( $(цифра "$SLICE/memory.peak") / 1048576 ))
	MAXEV=$(событие_котла max); [ -n "$MAXEV" ] || MAXEV=0
	OOMEV=$(событие_котла oom_kill); [ -n "$OOMEV" ] || OOMEV=0

	echo "$TS;$RSS_HUB;$RSS_PG;$CPU;$THREADS;$FDS;$READY;$CONNS;$KOTEL;$PEAK;$MAXEV;$OOMEV;$HSTATE" >> "$FILE"

	sleep "$EVERY"
done
