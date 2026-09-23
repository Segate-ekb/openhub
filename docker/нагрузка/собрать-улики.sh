#!/usr/bin/env bash
# Снимает улики падения. Запускается НА СЕРВЕРЕ СТЕНДА, ДО рестарта — после рестарта
# половины этого уже нет: журнал мёртвого контейнера, код выхода, признак OOMKilled.
#
#   ./собрать-улики.sh C-200-смерть
#
# ⚠ Нужен passwordless sudo: строки ядра про OOM-killer лежат только в journalctl -k,
# и без sudo файл улик ядро-oom.txt останется пустым (сам скрипт не упадёт).
#
# Кладёт всё в улики/<метка>/ и печатает главное: что говорит docker о смерти,
# убивал ли кто-нибудь кого-нибудь, и была ли в журнале трасса исключения.
set -eu

LABEL="${1:?нужна метка}"
DIR="${DIR:-$(cd "$(dirname "$0")" && pwd)}"
HUB="${HUB:-openhub-load-openhub-1}"
PG="${PG:-openhub-load-postgres-1}"
COL="${COL:-openhub-load-otel-collector-1}"
# systemd вкладывает слайс по дефису в имени: openhub-load.slice живёт внутри openhub.slice
SLICE="${SLICE:-/sys/fs/cgroup/openhub.slice/openhub-load.slice}"
E="$DIR/улики/$LABEL"

mkdir -p "$E"

echo "== состояние контейнеров ==" | tee "$E/состояние.txt"
for C in "$HUB" "$PG" "$COL"; do
	docker inspect "$C" --format \
		"$C: status={{.State.Status}} exit={{.State.ExitCode}} oomkilled={{.State.OOMKilled}} started={{.State.StartedAt}} finished={{.State.FinishedAt}} restarts={{.RestartCount}} health={{if .State.Health}}{{.State.Health.Status}}{{else}}нет{{end}}" \
		2>/dev/null | tee -a "$E/состояние.txt" || echo "$C: контейнера нет" | tee -a "$E/состояние.txt"
done

# История проб: «жив, но не отвечает» виден именно здесь, а не в логе.
docker inspect "$HUB" --format '{{if .State.Health}}{{range .State.Health.Log}}{{.Start}} код={{.ExitCode}} {{.Output}}
{{end}}{{end}}' > "$E/пробы-хаба.txt" 2>/dev/null || true

docker logs --tail 600 "$HUB" > "$E/журнал-хаба.txt" 2>&1 || true
docker logs --tail 300 "$PG" > "$E/журнал-базы.txt" 2>&1 || true
docker logs --tail 200 "$COL" > "$E/журнал-коллектора.txt" 2>&1 || true

# Котёл: упирался ли, убивал ли.
{
	echo "memory.max=$(cat "$SLICE/memory.max" 2>/dev/null || echo нет)"
	echo "memory.peak=$(cat "$SLICE/memory.peak" 2>/dev/null || echo нет)"
	echo "memory.current=$(cat "$SLICE/memory.current" 2>/dev/null || echo нет)"
	echo "--- memory.events ---"
	cat "$SLICE/memory.events" 2>/dev/null || echo нет
	echo "--- memory.stat (выжимка) ---"
	grep -E '^(anon|file|slab|sock|pgfault|pgmajfault) ' "$SLICE/memory.stat" 2>/dev/null || true
} > "$E/котёл.txt"

# Ядро: OOM-killer пишет только сюда, и только root это прочитает.
if sudo -n true 2>/dev/null; then
	sudo -n journalctl -k --since '-40min' 2>/dev/null \
		| grep -i -e oom -e 'killed process' -e 'Out of memory' > "$E/ядро-oom.txt" || true
else
	echo "sudo без пароля недоступен — строки ядра не сняты" > "$E/ядро-oom.txt"
fi

docker stats --no-stream > "$E/docker-stats.txt" 2>&1 || true
free -m > "$E/память-сервера.txt" 2>&1 || true

# Трасса необработанного исключения — самое ценное. Ищем по словам, которыми она
# себя называет, и по именам модулей OneScript.
grep -n -i -e 'Необработанн' -e 'Unhandled' -e 'Exception' -e 'NullReference' \
	-e 'InvalidOperation' -e 'Collection was modified' -e 'Npgsql' -e 'IOException' \
	-e 'OutOfMemory' -e 'ОШИБКА' -e '\.os:' -e '\.os(' \
	"$E/журнал-хаба.txt" > "$E/исключения.txt" 2>/dev/null || true

echo
echo "== главное =="
cat "$E/состояние.txt"
echo "--- котёл ---"
head -12 "$E/котёл.txt"
echo "--- ядро про OOM (строк: $(wc -l < "$E/ядро-oom.txt")) ---"
tail -5 "$E/ядро-oom.txt" || true
echo "--- исключения в журнале хаба (строк: $(wc -l < "$E/исключения.txt")) ---"
tail -20 "$E/исключения.txt" || true
echo
echo "улики сложены в $E"
