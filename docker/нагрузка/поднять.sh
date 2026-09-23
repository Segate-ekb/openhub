#!/usr/bin/env bash
# Поднимает нагрузочный стенд: общий котёл памяти (systemd-слайс), коллектор, PostgreSQL, хаб.
# Запускается НА СЕРВЕРЕ СТЕНДА, из каталога стенда. Идемпотентен.
#
#   ./поднять.sh            # поднять
#   ./поднять.sh --снести   # снести стенд вместе с данными, слайсом и файлом режима
#
# Переменные окружения: DIR, LIMIT, PORT, WAIT — здесь; HUB_IMAGE, DB_PASS, HUB_URL,
# LOG_LEVEL, METRIC_INTERVAL читает compose.yaml.
#
# Имена переменных оболочки — латиницей: кириллицу в идентификаторах bash не допускает.
# Имён функций это не касается, они по-русски.
set -eu

DIR="${DIR:-$(cd "$(dirname "$0")" && pwd)}"
LIMIT="${LIMIT:-2G}"
WAIT="${WAIT:-420}"
PORT="${PORT:-3333}"
# systemd вкладывает слайс по дефису в имени: openhub-load.slice живёт внутри openhub.slice.
SLICE="${SLICE:-/sys/fs/cgroup/openhub.slice/openhub-load.slice}"
OVERRIDE="$DIR/режим-ступени.yaml"

cd "$DIR"

# Файлы compose: основной всегда, файл режима — если его положил перезапустить.sh.
# Автоподхвата у docker compose тут нет: он работает только для файла с именем
# docker-compose.override.yml рядом с основным, а мы зовём compose по явному -f.
#
# Аргументы держим массивом и передаём "${COMPOSE_ARGS[@]}": подстановка через $(…)
# разошлась бы по IFS и развалила вызов на пути с пробелом.
COMPOSE_ARGS=(-f "$DIR/compose.yaml")
if [ -f "$OVERRIDE" ]; then
	COMPOSE_ARGS+=(-f "$OVERRIDE")
fi

# --- котёл ---------------------------------------------------------------------
# Общий лимит на хаб и базу вместе. Без него mem_limit дал бы два отдельных лимита,
# и «2 ГиБ на всё про всё» превратилось бы в «2 ГиБ каждому по-своему».
завести_котёл() {
	sudo install -m 0644 "$DIR/openhub-load.slice" /etc/systemd/system/openhub-load.slice
	sudo mkdir -p /etc/systemd/system/openhub-load.slice.d
	printf '[Slice]\nMemoryMax=%s\nMemorySwapMax=0\n' "$LIMIT" \
		| sudo tee /etc/systemd/system/openhub-load.slice.d/лимит.conf > /dev/null
	sudo systemctl daemon-reload
	sudo systemctl start openhub-load.slice
	echo "котёл: memory.max=$(cat "$SLICE/memory.max" 2>/dev/null || echo '?')," \
		"swap.max=$(cat "$SLICE/memory.swap.max" 2>/dev/null || echo '?')"
}

снести_котёл() {
	sudo systemctl stop openhub-load.slice 2>/dev/null || true
	sudo rm -f /etc/systemd/system/openhub-load.slice /etc/systemd/system/openhub-load.slice.d/лимит.conf
	sudo rmdir /etc/systemd/system/openhub-load.slice.d 2>/dev/null || true
	sudo systemctl daemon-reload
}

if [ "${1:-}" = "--снести" ]; then
	docker compose "${COMPOSE_ARGS[@]}" down -v
	rm -f "$OVERRIDE"
	снести_котёл
	echo "стенд снесён"
	exit 0
fi

mkdir -p "$DIR/замеры" "$DIR/логи" "$DIR/улики"

завести_котёл

docker compose "${COMPOSE_ARGS[@]}" up -d

# --- ждём готовности -----------------------------------------------------------
echo -n "жду /ready"
T0=$(date +%s)
while :; do
	CODE=$(curl -s -o /dev/null -w '%{http_code}' -m 5 "http://127.0.0.1:$PORT/ready" || true)
	if [ "$CODE" = "200" ]; then
		echo " — 200 за $(( $(date +%s) - T0 )) с от запуска compose"
		break
	fi
	if [ $(( $(date +%s) - T0 )) -gt "$WAIT" ]; then
		echo " — НЕ ДОЖДАЛСЯ за ${WAIT} с (последний код $CODE)"
		docker compose "${COMPOSE_ARGS[@]}" ps
		exit 1
	fi
	echo -n "."
	sleep 3
done

# Холодный старт по журналу: строка, которой хаб объявляет, что открыл порт.
docker logs openhub-load-openhub-1 2>&1 | grep -F 'Стартовые задачи завершены' | tail -1 || true
docker compose "${COMPOSE_ARGS[@]}" ps
