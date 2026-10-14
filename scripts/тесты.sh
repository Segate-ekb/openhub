#!/usr/bin/env bash
#
# Тесты OpenHub по модулям: наборы модуля лежат в tests/<модуль>/, живые — в tests/e2e/<модуль>/.
#
#   scripts/тесты.sh <модуль>                     # наборы модуля tests/<модуль>/ — перед коммитом шага
#   scripts/тесты.sh <модуль> --сквозные          # плюс линты tests/сквозные/ — один раз в конце шага
#   scripts/тесты.sh <модуль> --с-потребителями   # плюс чужие наборы, грузящие код модуля
#   scripts/тесты.sh <модуль> --e2e               # плюс живые наборы tests/e2e/<модуль>/
#   scripts/тесты.sh --e2e                        # все живые наборы tests/e2e/
#   scripts/тесты.sh --всё                        # регрессия: всё дерево без тега «внешние»
#   scripts/тесты.sh --внешние                    # наборы tests/внешние/ — с поднятыми системами
#   scripts/тесты.sh --инфраструктура             # самотесты обвязки tests/инфраструктура/
#   scripts/тесты.sh --плавающие                  # только карантин *_Плавающие_Тесты.os, без корзин
#   scripts/тесты.sh <модуль> --параллельно 4     # отобранное — в 4 одновременных oneunit
#   scripts/тесты.sh <модуль> --время             # наборы по одному: таблица «набор — секунды»
#   scripts/тесты.sh <модуль> --список            # напечатать отобранные наборы (и почему) и выйти
#   scripts/тесты.sh <модуль> -- --mode summary   # всё после «--» уходит в oneunit execute
#
# Ключи модуля сочетаются: `scripts/тесты.sh вход --сквозные --с-потребителями --e2e`.
#
# Наборы карантина (*_Плавающие_Тесты.os) — тесты, которые плавают под нагрузкой: их не берёт ни один
# режим, кроме --плавающие.
#
# --параллельно N (без ключа прогон один) делит отобранные наборы на N корзин, выравнивая суммарный
# размер файлов, и гоняет каждую своим oneunit execute в своём временном воркспейсе git с копией
# oscript_modules: процессы одного чекаута мешают друг другу читать общие файлы. Воркспейсы стоят
# на снимке рабочего дерева — корзины гоняют ровно то, что в дереве, с правками и новыми файлами.
# Снимок — висячий коммит, его объекты убирает обычный gc.
# Корзина — своя группа процессов: прерванный прогон гасит её целиком и только потом снимает
# воркспейсы. Вывод первой корзины идёт по ходу прогона, остальных — по её окончании, строками
# «корзина K │ …»; за ними — СВОДКА: суммы строк статистики oneunit и «Тестирование завершилось
# удачно», только если так закончилась каждая корзина; код выхода — ненулевой, если ненулевой
# у любой корзины. Ключи файлов отчёта oneunit после «--» (--junit, --cobertura и другие) корзины
# не принимают — код 2: все корзины писали бы в один файл; отчёт снимают прогоном в один поток.
# --время и --плавающие корзин не делят.
#
# Вывод открывает шапка прогона (коммит, состояние дерева, команда, время начала) и закрывает
# итог с кодом выхода, во всех режимах; формат — в scripts/шапка-прогона.sh.
#
# Наборы отбираются файлами (`-f`), а не тегами: фильтр тегов не доходит до наборов
# с &Изолированный(Уровень = "Процесс"), см. scripts/смоук.sh. Регрессия тег всё же ставит:
# изолированные внешние наборы без своего окружения пропускают тесты сами.
#
# Потребитель модуля — набор из каталога другого модуля или tests/инфраструктура, чей текст либо
# текст названных в нём фикстур (транзитивно) грузит код модуля: «"<модуль>", "Классы"» или путь
# «<модуль>/Классы», имя класса модуля литералом или в перечне через запятую, модуль в строке-перечне
# слоёв и таблиц, контракт ПодключитьРеализации с реализацией в модуле, либо сборщик всего дерева,
# которому модуль отдаёт своё: таблицы (ВсеМодули), ключи настроек всех предметов (сторож полноты
# реестра настроек), объявления по префиксу (ОбъявленияПредметов), контроллеры (МаршрутыХаба);
# ПодключитьОснову грузит основу и наблюдаемость. Ключи настроек модуля едут за его классами.
# Вызовы ищутся в коде без комментариев и строковых литералов, литералы — в тексте без комментариев:
# литерал с текстом вызова потребителем не делает.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

. "$ROOT_DIR/scripts/шапка-прогона.sh"
run_header "$ROOT_DIR" "$0" "$@"
WORK=""
BUCKETS=1
# BUCKET_PIDS — PID корзин по номерам; дождавшаяся корзина оставляет пустую строку, чтобы сигнал
# не ушёл группе, чей номер система уже отдала другому процессу.
BUCKET_PIDS=()
BUCKET_TREES=()
on_exit() {
	local code=$?
	if [ "${#BUCKET_PIDS[@]}" -gt 0 ]; then
		stop_buckets
		print_bucket_tails
	fi
	remove_bucket_trees
	if [ -n "$WORK" ]; then rm -rf "$WORK"; fi
	run_footer "$code"
}
trap on_exit EXIT

# Корзины, не дождавшиеся конца, гасятся группой процессов целиком — с хабами и изолированными
# наборами: фоновые группы сигнал терминала не получают. Упрямой группе через пять секунд — KILL.
stop_buckets() {
	local pid tick=0
	for pid in "${BUCKET_PIDS[@]}"; do
		if [ -n "$pid" ]; then kill -TERM -- "-$pid" 2>/dev/null || true; fi
	done
	while [ "$tick" -lt 50 ] && buckets_alive; do sleep 0.1; tick=$((tick + 1)); done
	for pid in "${BUCKET_PIDS[@]}"; do
		if [ -n "$pid" ]; then kill -KILL -- "-$pid" 2>/dev/null || true; fi
	done
	for pid in "${BUCKET_PIDS[@]}"; do
		if [ -n "$pid" ]; then wait "$pid" 2>/dev/null || true; fi
	done
}

buckets_alive() {
	local pid
	for pid in "${BUCKET_PIDS[@]}"; do
		if [ -n "$pid" ] && kill -0 -- "-$pid" 2>/dev/null; then return 0; fi
	done
	return 1
}

# Хвосты журналов прерванных корзин — до того, как каталог с журналами уйдёт.
print_bucket_tails() {
	local b=1
	while [ "$b" -le "${#BUCKET_PIDS[@]}" ]; do
		if [ -n "${BUCKET_PIDS[$((b - 1))]}" ] && [ -s "$WORK/bucket-$b.log" ]; then
			echo "== корзина $b/$BUCKETS: прервана, последние 30 строк журнала"
			tail -n 30 "$WORK/bucket-$b.log" | sed "s/^/корзина $b │ /"
		fi
		b=$((b + 1))
	done
}

# Временные воркспейсы корзин снимаются после того, как их процессы дождались конца.
remove_bucket_trees() {
	local tree failure
	for tree in ${BUCKET_TREES[@]+"${BUCKET_TREES[@]}"}; do
		if ! failure="$(git -C "$ROOT_DIR" worktree remove --force "$tree" 2>&1)"; then
			echo "Воркспейс корзины не снят: $tree — $failure" >&2
		fi
	done
	BUCKET_TREES=()
}

# Границы слов у grep -w — по буквам кириллицы только в UTF-8; прогону возвращается своя локаль.
ORIGINAL_LC_ALL="${LC_ALL-}"
export LC_ALL=C.UTF-8

# Имена переменных латиницей — bash 3.2 кириллических не принимает; mapfile в нём тоже нет.
MODULE=""
WITH_CONSUMERS=0
WITH_CROSS=0
WITH_E2E=0
EVERYTHING=0
EXTERNAL=0
INFRASTRUCTURE=0
FLAKY=0
TIMING=0
LIST_ONLY=0
JOBS=""
PASS=()

while [ $# -gt 0 ]; do
	case "$1" in
		--с-потребителями) WITH_CONSUMERS=1 ;;
		--сквозные) WITH_CROSS=1 ;;
		--e2e) WITH_E2E=1 ;;
		--всё) EVERYTHING=1 ;;
		--внешние) EXTERNAL=1 ;;
		--инфраструктура) INFRASTRUCTURE=1 ;;
		--плавающие) FLAKY=1 ;;
		--время) TIMING=1 ;;
		--параллельно)
			if [ $# -lt 2 ]; then echo "--параллельно ждёт число корзин." >&2; exit 2; fi
			JOBS="$2"; shift ;;
		--список) LIST_ONLY=1 ;;
		--) shift; PASS=("$@"); break ;;
		-*) echo "Неизвестный ключ: $1" >&2; exit 2 ;;
		*)
			if [ -n "$MODULE" ]; then
				echo "Модуль назван дважды: $MODULE и $1" >&2
				exit 2
			fi
			MODULE="$1"
			;;
	esac
	shift
done

usage() {
	sed -n '3,17p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//' >&2
	exit 2
}

if [ $((EVERYTHING + EXTERNAL + INFRASTRUCTURE + FLAKY)) -gt 0 ] \
	&& { [ -n "$MODULE" ] || [ $((EVERYTHING + EXTERNAL + INFRASTRUCTURE + FLAKY + WITH_E2E + WITH_CONSUMERS + WITH_CROSS)) -gt 1 ]; }; then
	echo "--всё, --внешние, --инфраструктура и --плавающие не сочетаются с модулем и другими ключами." >&2
	exit 2
fi
if [ -n "$JOBS" ] && [ $((FLAKY + TIMING)) -gt 0 ]; then
	echo "--плавающие и --время корзин не делят: --параллельно с ними не сочетается." >&2
	exit 2
fi
case "$JOBS" in
	"") JOBS=1 ;;
	*[!0-9]* | 0*) echo "Число корзин — целое больше нуля, а не «${JOBS}»." >&2; exit 2 ;;
esac
if [ -z "$MODULE" ] && [ "$WITH_CONSUMERS" -eq 1 ]; then
	echo "--с-потребителями требует модуля." >&2
	exit 2
fi
if [ -z "$MODULE" ] && [ "$WITH_CROSS" -eq 1 ]; then
	echo "--сквозные требует модуля." >&2
	exit 2
fi
if [ -z "$MODULE" ] && [ $((EVERYTHING + EXTERNAL + INFRASTRUCTURE + FLAKY + WITH_E2E)) -eq 0 ]; then
	usage
fi
if [ -n "$MODULE" ] && [ ! -d "src/модули/$MODULE" ]; then
	echo "Модуля «${MODULE}» нет в src/модули. Есть:" >&2
	ls src/модули >&2
	exit 2
fi

WORK="$(mktemp -d)"

# Наборы — *_Тесты.os вне каталогов фикстур и вне карантина; каталог модуля без вложенных каталогов.
QUARANTINE='*_Плавающие_Тесты.os'
all_suites() {
	find tests -name '*_Тесты.os' -not -name "$QUARANTINE" -not -path '*/фикстуры/*'
}
suites_in() {
	if [ -d "tests/$1" ]; then
		find "tests/$1" -maxdepth 1 -name '*_Тесты.os' -not -name "$QUARANTINE"
	fi
}
quarantined_suites() {
	find tests -name "$QUARANTINE" -not -path '*/фикстуры/*'
}

# ---------------------------------------------------------------- потребители модуля

# Фикстуры-механизмы грузят то, что им назовёт набор, — их собственный текст не в счёт.
MECHANISMS="КлассыСлоя СлоиКонтейнера ОбъявленияПредметов МаршрутыХаба РеестрФикстур КаталогиПроекта
ИсходникиПроекта ИсходникБезКомментариев УникальныеИмена ПомощникиСтендов ЭкземплярХаба КлиентХаба
ВыдачаПортов ЭкземплярФейковогоIdP ЭкземплярФейковогоКоллектора РеестрНастроекХаба"

module_facts() {
	local dir="src/модули/$MODULE"
	find "$dir" -name '*.os' | sed 's#.*/##; s#\.os$##' | sort -u > "$WORK/classes"
	# имя сущности («Пул», «Пакет») — частое слово данных; таблицы опознаются перечнем модулей
	grep -rlE '^&Сущность\(' "$dir" | sed 's#.*/##; s#\.os$##' | sort -u > "$WORK/entities" || true
	grep -vxF -f "$WORK/entities" "$WORK/classes" > "$WORK/plain_classes" || true
	sed 's/.*/(^|[^"])"&(\.os)?"([^"]|$)/' "$WORK/plain_classes" > "$WORK/class_literals"
	ls src/модули > "$WORK/modules"
	grep -rhoE '^&Прозвище\("[^"]+"' "$dir" | sed 's/^&Прозвище("//' | sort -u > "$WORK/aliases" || true
	HAS_TABLES=0; HAS_KEYS=0; HAS_CONTROLLERS=0
	if grep -rqE '^&(Сущность|ХранилищеСущностей)\(' "$dir"; then HAS_TABLES=1; fi
	if grep -q '^КлючиНастроек' "$WORK/classes"; then HAS_KEYS=1; fi
	if grep -rqE '^&Контроллер' "$dir"; then HAS_CONTROLLERS=1; fi
}

# Разбор исходника тот же, что у фикстуры ИсходникБезКомментариев: в text_file — строки без
# комментариев «//», в code_file — ещё и без строковых литералов. Литерал тянется через переводы
# строк до следующей кавычки; число строк сохраняется.
SOURCE_PARSER='
{
	rest = $0; text = ""; code = ""
	while (rest != "") {
		quote = index(rest, "\"")
		if (in_literal) {
			if (quote == 0) { text = text rest; break }
			text = text substr(rest, 1, quote); rest = substr(rest, quote + 1); in_literal = 0
			continue
		}
		comment = index(rest, "//")
		if (comment > 0 && (quote == 0 || comment < quote)) {
			text = text substr(rest, 1, comment - 1); code = code substr(rest, 1, comment - 1)
			break
		}
		if (quote == 0) { text = text rest; code = code rest; break }
		text = text substr(rest, 1, quote); code = code substr(rest, 1, quote - 1)
		rest = substr(rest, quote + 1); in_literal = 1
	}
	print text > text_file
	print code > code_file
}'

# Разбирает файл один раз за прогон; пути разбора — в TEXT и CODE.
parse_source() {
	TEXT="$WORK/parsed/$1.text"
	CODE="$WORK/parsed/$1.code"
	if [ -e "$TEXT" ]; then return 0; fi
	mkdir -p "$(dirname "$TEXT")"
	# пустой файл awk не открывает вовсе
	: > "$TEXT"; : > "$CODE"
	# байтами: кавычка и «//» — ASCII, в многобайтных буквах UTF-8 таких байтов нет
	LC_ALL=C awk -v text_file="$TEXT" -v code_file="$CODE" "$SOURCE_PARSER" "$1"
}

# Строковые литералы файла, похожие на перечень модулей, где есть названный модуль.
list_mentions() {
	local file="$1" name="$2" literal items
	grep -oE '"[^"]*"' "$file" \
		| grep -E "^\"([^\",]*,)*[[:space:]]*$name(/[^\",]*)?[[:space:]]*(,[^\"]*)?\"$" \
		| sort -u > "$WORK/candidates" || true
	while IFS= read -r literal; do
		items="$(printf '%s' "$literal" | sed 's/^"//; s/"$//' | tr ',' '\n' \
			| sed 's/^[[:space:]]*//; s/[[:space:]]*$//; s#/.*##')"
		if ! printf '%s\n' "$items" | grep -qvxF -f "$WORK/modules"; then
			return 0
		fi
	done < "$WORK/candidates"
	return 1
}

# Первый класс модуля, названный в литерале-перечне через запятую («ЗадачаА,ЗадачаБ,»).
class_in_list() {
	grep -oE '"[^"]*"' "$1" | grep ',' | tr -d '"' | tr ',' '\n' \
		| sed 's/^[[:space:]]*//; s/[[:space:]]*$//' | grep -xF -f "$WORK/plain_classes" | head -1 || true
}

# Грузит ли сам файл (без своих фикстур) код модуля; причина — в REASON.
loads_module() {
	local contract literal
	REASON=""
	parse_source "$1"
	if grep -qE "\"$MODULE\"[[:space:]]*,[[:space:]]*\"Классы\"|[\"/]$MODULE/Классы" "$TEXT"; then
		REASON="каталог модуля"; return 0
	fi
	# строки аннотаций не в счёт: &Прозвище("<класс>") у фейка подменяет класс, а не грузит его
	grep -v '^[[:space:]]*&' "$TEXT" > "$WORK/unannotated" || true
	if [ -s "$WORK/class_literals" ] && grep -qE -f "$WORK/class_literals" "$WORK/unannotated"; then
		REASON="класс $(grep -ohE -f "$WORK/class_literals" "$WORK/unannotated" | head -1 | tr -d '(),"[:space:]')"; return 0
	fi
	literal="$(class_in_list "$WORK/unannotated")"
	if [ -n "$literal" ]; then REASON="класс $literal в перечне"; return 0; fi
	if list_mentions "$TEXT" "$MODULE"; then REASON="перечень слоёв или таблиц"; return 0; fi
	if { [ "$MODULE" = "основа" ] || [ "$MODULE" = "наблюдаемость" ]; } \
		&& { grep -qE 'ПодключитьОснову\(|РеестрНастроекХаба' "$CODE" || list_mentions "$TEXT" "основа" \
			|| { grep -qw 'СлоиКонтейнера' "$CODE" && list_mentions "$TEXT" "настройки"; }; }; then
		REASON="основа"; return 0
	fi
	if [ "$HAS_TABLES" -eq 1 ] && grep -q 'ВсеМодули(' "$CODE"; then REASON="таблицы всех модулей"; return 0; fi
	# ключи настроек едут за классами своего модуля; все сразу — только по просьбе сторожа полноты
	if [ "$HAS_KEYS" -eq 1 ] \
		&& grep -qE 'ПодключитьКлючиВсехПредметов\(|РеестрНастроекХаба\.(Реестр|Предметы)\(' "$CODE"; then
		REASON="ключи настроек всех предметов"; return 0
	fi
	if [ "$MODULE" = "настройки" ] && grep -qw 'РеестрНастроекХаба' "$CODE"; then
		REASON="реестр настроек"; return 0
	fi
	if [ "$HAS_CONTROLLERS" -eq 1 ] && grep -qw 'МаршрутыХаба' "$CODE"; then
		REASON="контроллеры всех модулей"; return 0
	fi
	if [ -s "$WORK/aliases" ] && grep -q 'ПодключитьРеализации(' "$CODE"; then
		for contract in $(grep -oE 'ПодключитьРеализации\([^)]*"[^"]*"' "$TEXT" | sed -E 's/.*"([^"]*)"$/\1/' | tr ',' ' '); do
			if grep -qxF "$contract" "$WORK/aliases"; then REASON="реализация $contract"; return 0; fi
		done
	fi
	if grep -qw 'ОбъявленияПредметов' "$CODE"; then
		for literal in $(grep -oE '"[А-Яа-яЁёA-Za-z0-9_]+"' "$TEXT" | tr -d '"' | sort -u); do
			if grep -q "^$literal" "$WORK/classes"; then REASON="объявления $literal"; return 0; fi
		done
	fi
	return 1
}

# Имена фикстур, которые называет файл (кроме механизмов).
named_fixtures() {
	parse_source "$1"
	grep -owF -f "$WORK/fixture_names" "$TEXT" | sort -u || true
}

consumers() {
	module_facts

	# фикстура -> файл; одноимённые фикстуры отказывает реестр, здесь берётся первая
	: > "$WORK/fixture_index"
	while IFS= read -r path; do
		printf '%s\t%s\n' "$(basename "$path" .os)" "$path" >> "$WORK/fixture_index"
	done < <(find tests -path '*/фикстуры/*.os' -not -path '*/фикстуры/*/*' | sort)
	cut -f1 "$WORK/fixture_index" | grep -vxF -f <(printf '%s\n' $MECHANISMS) > "$WORK/fixture_names" || true

	# прямые признаки и связи фикстур, затем замыкание по связям до неподвижной точки
	mkdir -p "$WORK/children" "$WORK/loads"
	while IFS=$'\t' read -r name path; do
		if ! grep -qxF "$name" "$WORK/fixture_names"; then continue; fi
		named_fixtures "$path" | grep -vxF "$name" > "$WORK/children/$name" || true
		if loads_module "$path"; then echo "$REASON" > "$WORK/loads/$name"; fi
	done < "$WORK/fixture_index"
	local changed=1 name child
	while [ "$changed" -eq 1 ]; do
		changed=0
		while IFS= read -r name; do
			[ -e "$WORK/loads/$name" ] && continue
			while IFS= read -r child; do
				if [ -e "$WORK/loads/$child" ]; then
					echo "фикстура $child: $(cat "$WORK/loads/$child")" > "$WORK/loads/$name"
					changed=1
					break
				fi
			done < "$WORK/children/$name"
		done < "$WORK/fixture_names"
	done

	local suite dir fixture
	while IFS= read -r suite; do
		dir="$(dirname "$suite")"
		case "$dir" in
			"tests/$MODULE" | tests/сквозные | tests/внешние | tests/e2e | tests/e2e/*) continue ;;
		esac
		if loads_module "$suite"; then
			echo "$suite"
			printf '%s\t%s\n' "$suite" "$REASON" >> "$WORK/reasons"
			continue
		fi
		for fixture in $(named_fixtures "$suite"); do
			if [ -e "$WORK/loads/$fixture" ]; then
				echo "$suite"
				printf '%s\tфикстура %s: %s\n' "$suite" "$fixture" "$(cat "$WORK/loads/$fixture")" >> "$WORK/reasons"
				break
			fi
		done
	done < <(all_suites | sort)
}

# ---------------------------------------------------------------- состав прогона

EXTRA=()
if [ "$EVERYTHING" -eq 1 ]; then
	# неизолированный набор с тегом «внешние» фильтр -T снимет сам — в список он не идёт
	all_suites | while IFS= read -r suite; do
		if grep -q '^&Тег("внешние")' "$suite" && ! grep -q '^&Изолированный' "$suite"; then
			continue
		fi
		echo "$suite"
	done > "$WORK/selected"
	EXTRA=(-T внешние)
	TITLE="регрессия: всё дерево без тега «внешние»"
elif [ "$EXTERNAL" -eq 1 ]; then
	suites_in внешние > "$WORK/selected"
	TITLE="внешние наборы"
elif [ "$INFRASTRUCTURE" -eq 1 ]; then
	suites_in инфраструктура > "$WORK/selected"
	TITLE="самотесты обвязки tests/инфраструктура"
elif [ "$FLAKY" -eq 1 ]; then
	quarantined_suites > "$WORK/selected"
	TITLE="карантин: наборы, плавающие под нагрузкой"
elif [ -z "$MODULE" ]; then
	find tests/e2e -name '*_Тесты.os' -not -name "$QUARANTINE" > "$WORK/selected"
	TITLE="все живые наборы"
else
	suites_in "$MODULE" > "$WORK/selected"
	if [ "$WITH_CROSS" -eq 1 ]; then
		suites_in сквозные | while IFS= read -r suite; do
			echo "$suite"
			printf '%s\tключ --сквозные\n' "$suite" >> "$WORK/reasons"
		done >> "$WORK/selected"
		TITLE="модуль $MODULE и сквозные наборы (ключ --сквозные)"
	else
		TITLE="модуль $MODULE без сквозных наборов (их добавляет --сквозные)"
	fi
	if [ "$WITH_CONSUMERS" -eq 1 ]; then
		consumers >> "$WORK/selected"
		TITLE="$TITLE, потребители модуля"
	fi
	if [ "$WITH_E2E" -eq 1 ]; then
		suites_in "e2e/$MODULE" >> "$WORK/selected"
		TITLE="$TITLE, живые наборы модуля"
	fi
fi

SUITES=()
while IFS= read -r suite; do
	SUITES+=("$suite")
done < <(sort -u "$WORK/selected")

if [ "${#SUITES[@]}" -eq 0 ]; then
	echo "Наборов не отобрано ($TITLE) — прогонять нечего." >&2
	exit 1
fi

# Корзины: наборы по убыванию размера файла, каждый — в корзину с наименьшей суммой размеров;
# корзин не больше, чем наборов. Строки «<номер корзины>\t<набор>» — в $WORK/buckets.
split_into_buckets() {
	local suite
	for suite in "${SUITES[@]}"; do
		printf '%s\t%s\n' "$(wc -c < "$suite" | tr -d ' ')" "$suite"
	done | sort -t "$(printf '\t')" -k1,1nr -k2,2 | awk -F '\t' -v jobs="$JOBS" '
		{ sizes[NR] = $1; paths[NR] = $2 }
		END {
			buckets = (NR < jobs) ? NR : jobs
			for (b = 1; b <= buckets; b++) load[b] = 0
			for (i = 1; i <= NR; i++) {
				best = 1
				for (b = 2; b <= buckets; b++) if (load[b] < load[best]) best = b
				load[best] += sizes[i]
				print best "\t" paths[i]
			}
		}' > "$WORK/buckets"
	BUCKETS="$(cut -f1 "$WORK/buckets" | sort -un | tail -1)"
}

if [ "$JOBS" -gt 1 ]; then
	split_into_buckets
fi

if [ "$BUCKETS" -gt 1 ] && [ "$LIST_ONLY" -eq 0 ]; then
	if [ "$RUN_IN_GIT" -ne 1 ]; then
		echo "Параллельный режим гоняет корзины во временных воркспейсах git, а каталог вне git." >&2
		exit 2
	fi
	for argument in ${PASS[@]+"${PASS[@]}"}; do
		case "$argument" in
			--junit | --junit=* | --genericExecution | --genericExecution=* | --openTestReport \
				| --openTestReport=* | --genericCoverage | --genericCoverage=* | --cobertura | --cobertura=*)
				echo "В параллельном режиме отчёты oneunit не поддерживаются: уберите ${argument%%=*} или гоняйте в один поток." >&2
				exit 2 ;;
		esac
	done
fi

heading="== Тесты: $TITLE — ${#SUITES[@]} наборов"
if [ "$BUCKETS" -gt 1 ]; then heading="$heading, корзин $BUCKETS"; fi
echo "$heading"
for suite in "${SUITES[@]}"; do
	reason=""
	if [ "$LIST_ONLY" -eq 1 ] && [ -s "$WORK/reasons" ]; then
		reason="$(grep -F "$suite"$'\t' "$WORK/reasons" | head -1 | cut -f2 || true)"
	fi
	echo "   $suite${reason:+  ← $reason}"
done
if [ "$BUCKETS" -gt 1 ]; then
	sort -t "$(printf '\t')" -k1,1n -k2,2 "$WORK/buckets" \
		| awk -F '\t' -v buckets="$BUCKETS" '{ printf "== корзина %s/%s: %s\n", $1, buckets, $2 }'
fi
echo

if [ "$LIST_ONLY" -eq 1 ]; then
	exit 0
fi

# Сводка прогонов oneunit: суммы строк статистики и вердикт. Строки «<имя>\t<код>\t<лог>» —
# в файле-аргументе; «удачно» — только если каждый прогон вышел с кодом 0 и так и написал.
summarize() {
	local name status log verdict="удачно"
	echo "== СВОДКА: прогонов oneunit $(grep -c '' "$1")"
	cut -f3 "$1" | while IFS= read -r log; do cat "$log"; done | awk '
		/^\[ *[0-9]+ (Наборов|Тестов) .*\]$/ {
			line = $0
			sub(/^\[ */, "", line); sub(/ *\]$/, "", line)
			count = line; sub(/ .*/, "", count)
			label = line; sub(/^[0-9]+ /, "", label)
			if (!(label in sums)) order[++labels] = label
			sums[label] += count
		}
		END {
			for (i = 1; i <= labels; i++) {
				group = order[i]; sub(/ .*/, "", group)
				if (i > 1 && group != previous) print ""
				printf "[ %9d %s ]\n", sums[order[i]], order[i]
				previous = group
			}
		}'
	echo
	while IFS=$'\t' read -r name status log; do
		if [ "$status" -ne 0 ]; then
			echo "== $name: код $status"
			verdict="неудачно"
		elif ! grep -q '^Тестирование завершилось удачно' "$log"; then
			echo "== $name: oneunit не написал «Тестирование завершилось удачно»"
			verdict="неудачно"
		fi
	done < "$1"
	echo "Тестирование завершилось $verdict"
	[ "$verdict" = "удачно" ]
}

# Снимок рабочего дерева коммитом поверх HEAD — то, что гоняют корзины. Индекс временный:
# основной индекс чекаута не трогается, игнорируемое (oscript_modules) в снимок не идёт.
snapshot_tree() {
	local index="$WORK/снимок.index" tree parent=()
	if [ -n "$(tree_head)" ]; then
		parent=(-p HEAD)
		GIT_INDEX_FILE="$index" git read-tree HEAD
	fi
	GIT_INDEX_FILE="$index" git add -A
	tree="$(GIT_INDEX_FILE="$index" git write-tree)"
	GIT_AUTHOR_NAME="scripts/тесты.sh" GIT_AUTHOR_EMAIL="tests@localhost" \
		GIT_COMMITTER_NAME="scripts/тесты.sh" GIT_COMMITTER_EMAIL="tests@localhost" \
		git commit-tree --no-gpg-sign ${parent[@]+"${parent[@]}"} -m "снимок для параллельного прогона" "$tree"
}

# Корзина в своём воркспейсе со своей копией зависимостей; на macOS копия — клон файлов.
run_bucket() {
	local tree="$1"
	shift
	if [ -e oscript_modules ]; then
		cp -c -a oscript_modules/. "$tree/oscript_modules" 2> /dev/null \
			|| cp -a oscript_modules/. "$tree/oscript_modules" || exit 1
	fi
	cd "$tree" || exit 1
	exec oneunit execute ${EXTRA[@]+"${EXTRA[@]}"} "$@" ${PASS[@]+"${PASS[@]}"}
}

# Корзины одновременно, каждая своим oneunit в своём воркспейсе на снимке дерева, своей группой
# процессов и в свой лог. Первая печатается по ходу прогона, остальные — по окончании, по порядку.
# Пути наборов — относительно корня, в воркспейсе они те же.
run_parallel() {
	local b=1 args bucket suite status snapshot
	snapshot="$(snapshot_tree)"
	: > "$WORK/runs"
	while [ "$b" -le "$BUCKETS" ]; do
		git worktree add --quiet --detach "$WORK/корзина-$b" "$snapshot"
		BUCKET_TREES+=("$WORK/корзина-$b")
		b=$((b + 1))
	done

	# Своя группа процессов (set -m) — только у корзин: иначе её получил бы и каждый sed или git.
	set -m
	b=1
	while [ "$b" -le "$BUCKETS" ]; do
		args=()
		while IFS=$'\t' read -r bucket suite; do
			if [ "$bucket" = "$b" ]; then args+=(-f "$suite"); fi
		done < "$WORK/buckets"
		if [ "$b" -eq 1 ]; then
			( run_bucket "$WORK/корзина-1" "${args[@]}" 2>&1 | tee "$WORK/bucket-1.log" \
				| awk '{ print "корзина 1 │ " $0; fflush() }' ) < /dev/null &
		else
			run_bucket "$WORK/корзина-$b" "${args[@]}" > "$WORK/bucket-$b.log" 2>&1 < /dev/null &
		fi
		BUCKET_PIDS+=("$!")
		b=$((b + 1))
	done
	set +m

	b=1
	while [ "$b" -le "$BUCKETS" ]; do
		status=0
		wait "${BUCKET_PIDS[$((b - 1))]}" || status=$?
		BUCKET_PIDS[$((b - 1))]=""
		echo "== корзина $b/$BUCKETS: код $status"
		if [ "$b" -gt 1 ]; then sed "s/^/корзина $b │ /" "$WORK/bucket-$b.log"; fi
		echo
		printf 'корзина %s\t%s\t%s\n' "$b" "$status" "$WORK/bucket-$b.log" >> "$WORK/runs"
		b=$((b + 1))
	done
	BUCKET_PIDS=()
	remove_bucket_trees
	summarize "$WORK/runs"
}

# Наборы по одному со временем каждого; в конце — таблица по убыванию и сводка.
run_timed() {
	local i=0 suite started seconds status log
	: > "$WORK/runs"
	: > "$WORK/timing"
	for suite in "${SUITES[@]}"; do
		i=$((i + 1))
		log="$WORK/suite-$i.log"
		started="$(date +%s)"
		status=0
		oneunit execute ${EXTRA[@]+"${EXTRA[@]}"} -f "$suite" ${PASS[@]+"${PASS[@]}"} > "$log" 2>&1 || status=$?
		seconds=$(($(date +%s) - started))
		echo "== набор $i/${#SUITES[@]}: $suite — $seconds с, код $status"
		if [ "$status" -ne 0 ]; then sed 's/^/   │ /' "$log"; fi
		printf '%s\t%s\t%s\n' "$seconds" "$status" "$suite" >> "$WORK/timing"
		printf '%s\t%s\t%s\n' "$suite" "$status" "$log" >> "$WORK/runs"
	done
	echo
	echo "== Время наборов по убыванию: секунды, итог набора, набор"
	sort -t "$(printf '\t')" -k1,1nr -k3,3 "$WORK/timing" \
		| awk -F '\t' '{ total += $1; printf "%7d  %s  %s\n", $1, ($2 == 0 ? "✔" : "✘"), $3 } END { printf "%7d  всего\n", total }'
	echo
	summarize "$WORK/runs"
}

if [ -n "$ORIGINAL_LC_ALL" ]; then export LC_ALL="$ORIGINAL_LC_ALL"; else unset LC_ALL; fi
code=0
if [ "$TIMING" -eq 1 ]; then
	run_timed || code=$?
elif [ "$BUCKETS" -gt 1 ]; then
	run_parallel || code=$?
else
	FILE_ARGS=()
	for suite in "${SUITES[@]}"; do FILE_ARGS+=(-f "$suite"); done
	oneunit execute ${EXTRA[@]+"${EXTRA[@]}"} "${FILE_ARGS[@]}" ${PASS[@]+"${PASS[@]}"} || code=$?
fi
exit "$code"
