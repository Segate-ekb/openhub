#!/usr/bin/env bash
# Доводит поднятый стенд до состояния «есть что нагружать»: администратор, токен,
# пул, зеркало на публичный хаб. Идемпотентен — повторный запуск ничего не ломает.
#
# ⚠ Заводит администратора с ЗАРАНЕЕ ИЗВЕСТНЫМ паролем и кладёт живой токен доступа
# в стенд.env рядом с собой. Это годится только для одноразового стенда в закрытой сети.
#
#   ./настроить.sh                       # всё разом
#   ./настроить.sh зеркало               # только завести зеркало
#   ./настроить.sh синк                  # запустить обход зеркала
#   ./настроить.sh состояние             # карточка зеркала: прогон, счётчики, происшествия
#   ./настроить.sh пакеты                # сколько имён уже в пуле
#
# Имена переменных оболочки — латиницей: кириллицу в идентификаторах bash не допускает.
set -eu

DIR="${DIR:-$(cd "$(dirname "$0")" && pwd)}"
HUB_URL="${HUB_URL:-http://127.0.0.1:3333}"
ADMIN="${ADMIN:-root}"
PASS="${PASS:-LoadStand2026}"
POOL="${POOL:-public}"
UPSTREAM="${UPSTREAM:-https://hub.oscript.io/download/}"
MIRROR_INTERVAL="${MIRROR_INTERVAL:-86400}"
ENVFILE="$DIR/стенд.env"

mkdir -p "$DIR/логи"

к() { curl -s -m "${TIMEOUT:-60}" "$@"; }

завести_админа() {
	SETUPOUT="$DIR/логи/setup.out"
	CODE=$(к -o "$SETUPOUT" -w '%{http_code}' -X POST "$HUB_URL/setup" \
		-H 'Content-Type: application/json' -H 'Accept: application/json' \
		-d "{\"логин\":\"$ADMIN\",\"пароль\":\"$PASS\"}")
	case "$CODE" in
		201) echo "администратор $ADMIN заведён (пароль $PASS)";;
		409) echo "администратор уже есть — мастер закрыт";;
		*)   echo "ОШИБКА /setup: $CODE $(cat "$SETUPOUT")"; exit 1;;
	esac
}

выпустить_токен() {
	COOKIE=$(к -i -X POST "$HUB_URL/api/v1/login" -H 'Content-Type: application/json' \
		-d "{\"логин\":\"$ADMIN\",\"пароль\":\"$PASS\"}" \
		| tr -d '\r' | sed -n 's/^[Ss]et-[Cc]ookie: oshub_session=\([^;]*\).*/\1/p' | head -1)
	if [ -z "$COOKIE" ]; then
		echo "ОШИБКА: вход не дал куку сессии"; exit 1
	fi
	OUT=$(к -X POST "$HUB_URL/api/v1/tokens" -H 'Content-Type: application/json' \
		-H "Cookie: oshub_session=$COOKIE" -d '{"права":"read,write","пул":0,"имя":"нагрузка"}')
	TOKEN=$(printf '%s' "$OUT" | sed -n 's/.*"token"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
	if [ -z "$TOKEN" ]; then
		echo "ОШИБКА: токен не выпущен: $OUT"; exit 1
	fi
	{
		echo "HUB_URL=$HUB_URL"
		echo "TOKEN=$TOKEN"
		echo "POOL=$POOL"
		echo "ADMIN=$ADMIN"
	} > "$ENVFILE"
	chmod 600 "$ENVFILE"
	echo "токен выпущен, записан в $ENVFILE (права 600)"
}

среда() {
	[ -f "$ENVFILE" ] || { echo "нет $ENVFILE — запусти ./настроить.sh без аргументов"; exit 1; }
	# shellcheck disable=SC1090
	. "$ENVFILE"
}

апи() {
	M="$1"; P="$2"; B="${3:-}"
	if [ -n "$B" ]; then
		к -X "$M" "$HUB_URL$P" -H "Authorization: Bearer $TOKEN" \
			-H 'Content-Type: application/json' -d "$B"
	else
		к -X "$M" "$HUB_URL$P" -H "Authorization: Bearer $TOKEN"
	fi
}

завести_пул() {
	среда
	OUT=$(апи POST /api/v1/pools "{\"имя\":\"$POOL\",\"видимость\":\"public\"}")
	echo "пул: $(printf '%s' "$OUT" | head -c 400)"
}

# Ид зеркала ищется ПО АДРЕСУ ИСТОЧНИКА, а не как первый "id" в списке: у пула зеркал
# может быть несколько, и «первое» уехало бы на чужое.
ид_зеркала() {
	# Список режется по '{' на записи; берём ту, в которой стоит наш адрес, и её "id".
	# Пробелы вокруг двоеточия в ответе не фиксированы, поэтому ищем сам адрес.
	апи GET "/api/v1/pools/$POOL/mirrors?pageSize=100" \
		| tr -d '\n' | tr '{' '\n' \
		| grep -F "$UPSTREAM" \
		| sed -n 's/.*"id"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*/\1/p' \
		| head -1
}

завести_зеркало() {
	среда
	if [ -n "$(ид_зеркала)" ]; then
		echo "зеркало на $UPSTREAM уже заведено"
	else
		OUT=$(апи POST "/api/v1/pools/$POOL/mirrors" \
			"{\"url\":\"$UPSTREAM\",\"интервал\":$MIRROR_INTERVAL}")
		echo "зеркало: $(printf '%s' "$OUT" | head -c 600)"
	fi
	ID=$(ид_зеркала)
	if [ -n "$ID" ]; then
		grep -v '^MIRROR=' "$ENVFILE" > "$ENVFILE.tmp" && mv "$ENVFILE.tmp" "$ENVFILE"
		chmod 600 "$ENVFILE"
		echo "MIRROR=$ID" >> "$ENVFILE"
		echo "ид зеркала: $ID"
	else
		echo "ВНИМАНИЕ: зеркало на $UPSTREAM в списке не нашлось"
	fi
}

синк() {
	среда
	апи POST "/api/v1/pools/$POOL/mirrors/${MIRROR:?нет ид зеркала}/sync" '{}'
	echo
}

состояние() {
	среда
	апи GET "/api/v1/pools/$POOL/mirrors/${MIRROR:?нет ид зеркала}"
	echo
}

пакеты() {
	среда
	апи GET "/api/v1/pools/$POOL/packages?pageSize=1" | head -c 300
	echo
}

case "${1:-всё}" in
	всё)        завести_админа; выпустить_токен; завести_пул; завести_зеркало;;
	админ)      завести_админа;;
	токен)      выпустить_токен;;
	пул)        завести_пул;;
	зеркало)    завести_зеркало;;
	синк)       синк;;
	состояние)  состояние;;
	пакеты)     пакеты;;
	*) echo "не знаю шага: $1"; exit 2;;
esac
