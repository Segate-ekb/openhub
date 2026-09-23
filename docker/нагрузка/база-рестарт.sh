#!/usr/bin/env bash
# Проверяет, чинится ли хаб сам после того, как база пропала и вернулась.
# Запускается НА СЕРВЕРЕ СТЕНДА. Продуктовый код не трогает: перезапускается только
# контейнер PostgreSQL этого стенда, по имени.
#
#   ./база-рестарт.sh            # наблюдение 3 минуты
#   MINUTES=10 ./база-рестарт.sh # дольше
#
# Что делает: снимает опорные ответы, перезапускает базу, и дальше MINUTES минут каждые
# 10 с спрашивает у хаба четыре адреса — два без базы (`/health`, `/ready`) и два с ней
# (`/api/v1/pools`, главная). Улика — расхождение: «здоров» при пятисотках на данных.
set -eu

DIR="${DIR:-$(cd "$(dirname "$0")" && pwd)}"
HUB_URL="${HUB_URL:-http://127.0.0.1:3333}"
HUB="${HUB:-openhub-load-openhub-1}"
PG="${PG:-openhub-load-postgres-1}"
MINUTES="${MINUTES:-3}"
FILE="$DIR/замеры/база-рестарт.csv"

mkdir -p "$DIR/замеры"

проба() {
	curl -s -o /dev/null -w '%{http_code}:%{time_total}' -m 30 "$HUB_URL$1" 2>/dev/null || echo "нет"
}

строка() {
	printf '%s;%s;%s;%s;%s\n' "$(date -u +%H:%M:%SZ)" \
		"$(проба /health)" "$(проба /ready)" "$(проба /api/v1/pools)" "$(проба /)"
}

echo "время;health;ready;api_pools;главная" | tee "$FILE"
echo "--- до перезапуска базы ---"
строка | tee -a "$FILE"
строка | tee -a "$FILE"

echo "--- перезапускаю $PG ---"
docker restart "$PG" > /dev/null
echo "перезапущен в $(date -u +%H:%M:%SZ), наблюдаю $MINUTES мин"

END=$(( $(date +%s) + MINUTES * 60 ))
while [ "$(date +%s)" -lt "$END" ]; do
	строка | tee -a "$FILE"
	sleep 10
done

echo
echo "--- ошибки хаба за время опыта ---"
docker logs --since "${MINUTES}m" "$HUB" 2>&1 \
	| grep -oE 'Внешнее исключение \([A-Za-z.]+\)[^}]*' | sort | uniq -c | sort -rn | head -5
echo "замеры: $FILE"
