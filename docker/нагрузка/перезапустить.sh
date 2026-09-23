#!/usr/bin/env bash
# Поднимает хаб после падения или под новый режим и включает самплер на новый сценарий.
# Запускается НА СЕРВЕРЕ СТЕНДА. Улики снимает ДО рестарта скрипт собрать-улики.sh —
# этот их не ждёт и не сохраняет.
#
#   ./перезапустить.sh <сценарий> [ПЕРЕМЕННАЯ=значение ...]
#
# Переменные окружения хаба, отличные от compose.yaml, задаются позиционно и уезжают
# в файл режима режим-ступени.yaml, который подставляется вторым -f. Имена — ровно те,
# что читает продукт:
#
#   ./перезапустить.sh без-телеметрии OTEL_OFF=1
#   ./перезапустить.sh сэмплинг OTEL_TRACES_SAMPLER=traceidratio OTEL_TRACES_SAMPLER_ARG=0.01
#   ./перезапустить.sh чёрная-дыра OTEL_EXPORTER_OTLP_ENDPOINT=http://10.255.255.1:4318
#   ./перезапустить.sh предел-кучи DOTNET_GCHeapHardLimit=40000000
#
# OTEL_OFF — единственное сокращение комплекта (разворачивается в OTEL_ENABLED=false);
# всё прочее уходит в контейнер под тем именем, под которым написано.
set -eu

NAME="${1:?нужно имя сценария}"
shift || true
DIR="${DIR:-$(cd "$(dirname "$0")" && pwd)}"
PORT="${PORT:-3333}"
WAIT="${WAIT:-300}"
EVERY="${EVERY:-5}"
OVERRIDE="$DIR/режим-ступени.yaml"
PIDFILE="$DIR/логи/самплер-$NAME.pid"

cd "$DIR"
mkdir -p "$DIR/логи" "$DIR/замеры"

# Гасим САМПЛЕР ЭТОГО СЦЕНАРИЯ по записанному pid, а не `pkill -f самплер.sh`:
# шаблон снёс бы и чужой самплер, запущенный соседом на той же машине.
остановить_прежний_самплер() {
	for PF in "$DIR"/логи/самплер-*.pid; do
		[ -f "$PF" ] || continue
		SPID=$(cat "$PF" 2>/dev/null || echo "")
		if [ -n "$SPID" ] && kill -0 "$SPID" 2>/dev/null; then
			kill "$SPID" 2>/dev/null || true
		fi
		rm -f "$PF"
	done
}

# Опечатка в имени переменной превратила бы опыт в контроль незаметно: неизвестный
# префикс — повод громко сказать, а не молча протащить ключ в контейнер.
проверить_имя() {
	case "$1" in
		OTEL_*|OSHUB_*|DOTNET_*|TZ|LOG_LEVEL) ;;
		*) echo "ВНИМАНИЕ: '$1' не похоже на переменную хаба (ждём OTEL_*, OSHUB_*, DOTNET_*, TZ)" >&2;;
	esac
}

собрать_файл_режима() {
	rm -f "$OVERRIDE"
	[ "$#" -gt 0 ] || return 0
	printf 'services:\n  openhub:\n    environment:\n' > "$OVERRIDE"
	for KV in "$@"; do
		KEY="${KV%%=*}"; VAL="${KV#*=}"
		if [ "$KEY" = "OTEL_OFF" ]; then
			printf '      OTEL_ENABLED: "false"\n' >> "$OVERRIDE"
		else
			проверить_имя "$KEY"
			printf '      %s: "%s"\n' "$KEY" "$VAL" >> "$OVERRIDE"
		fi
	done
	echo "режим ступени:"; cat "$OVERRIDE"
}

остановить_прежний_самплер
собрать_файл_режима "$@"

if [ -f "$OVERRIDE" ]; then
	docker compose -f "$DIR/compose.yaml" -f "$OVERRIDE" up -d --force-recreate openhub
else
	docker compose -f "$DIR/compose.yaml" up -d --force-recreate openhub
fi

T0=$(date +%s)
until [ "$(curl -s -o /dev/null -w '%{http_code}' -m 5 "http://127.0.0.1:$PORT/ready" || true)" = "200" ]; do
	sleep 3
	if [ $(( $(date +%s) - T0 )) -gt "$WAIT" ]; then
		echo "хаб не поднялся за $WAIT с"
		docker compose -f "$DIR/compose.yaml" ps
		exit 1
	fi
done
echo "хаб поднят за $(( $(date +%s) - T0 )) с"

rm -f "$PIDFILE"
setsid nohup "$DIR/самплер.sh" "$NAME" "$EVERY" </dev/null > "$DIR/логи/самплер-$NAME.log" 2>&1 &

# Файл с pid пишет сам самплер: `setsid` форкается, и `$!` здесь — pid посредника,
# а не самплера. Поэтому не записываем номер, а ждём, пока его запишут.
T0=$(date +%s)
until [ -s "$PIDFILE" ]; do
	sleep 1
	if [ $(( $(date +%s) - T0 )) -gt 20 ]; then
		echo "самплер не записал pid за 20 с — смотри $DIR/логи/самплер-$NAME.log" >&2
		break
	fi
done

sleep 6
tail -1 "$DIR/замеры/$NAME.csv"
