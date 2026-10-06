#!/usr/bin/env bash
#
# Тесты OpenHub по модулям: наборы модуля лежат в tests/<модуль>/, живые — в tests/e2e/<модуль>/.
#
#   scripts/тесты.sh <модуль>                     # tests/<модуль>/ и tests/сквозные/
#   scripts/тесты.sh <модуль> --с-потребителями   # плюс чужие наборы, грузящие код модуля
#   scripts/тесты.sh <модуль> --e2e               # плюс живые наборы tests/e2e/<модуль>/
#   scripts/тесты.sh --e2e                        # все живые наборы tests/e2e/
#   scripts/тесты.sh --всё                        # регрессия: всё дерево без тега «внешние»
#   scripts/тесты.sh --внешние                    # наборы tests/внешние/ — с поднятыми системами
#   scripts/тесты.sh --инфраструктура             # самотесты обвязки tests/инфраструктура/
#   scripts/тесты.sh <модуль> --список            # напечатать отобранные наборы (и почему) и выйти
#   scripts/тесты.sh <модуль> -- --mode summary   # всё после «--» уходит в oneunit execute
#
# Ключи модуля сочетаются: `scripts/тесты.sh вход --с-потребителями --e2e`.
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
on_exit() {
	local code=$?
	if [ -n "$WORK" ]; then rm -rf "$WORK"; fi
	run_footer "$code"
}
trap on_exit EXIT

# Границы слов у grep -w — по буквам кириллицы только в UTF-8; прогону возвращается своя локаль.
ORIGINAL_LC_ALL="${LC_ALL-}"
export LC_ALL=C.UTF-8

# Имена переменных латиницей — bash 3.2 кириллических не принимает; mapfile в нём тоже нет.
MODULE=""
WITH_CONSUMERS=0
WITH_E2E=0
EVERYTHING=0
EXTERNAL=0
INFRASTRUCTURE=0
LIST_ONLY=0
PASS=()

while [ $# -gt 0 ]; do
	case "$1" in
		--с-потребителями) WITH_CONSUMERS=1 ;;
		--e2e) WITH_E2E=1 ;;
		--всё) EVERYTHING=1 ;;
		--внешние) EXTERNAL=1 ;;
		--инфраструктура) INFRASTRUCTURE=1 ;;
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
	sed -n '3,13p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//' >&2
	exit 2
}

if [ $((EVERYTHING + EXTERNAL + INFRASTRUCTURE)) -gt 0 ] \
	&& { [ -n "$MODULE" ] || [ $((EVERYTHING + EXTERNAL + INFRASTRUCTURE + WITH_E2E + WITH_CONSUMERS)) -gt 1 ]; }; then
	echo "--всё, --внешние и --инфраструктура не сочетаются с модулем и другими ключами." >&2
	exit 2
fi
if [ -z "$MODULE" ] && [ "$WITH_CONSUMERS" -eq 1 ]; then
	echo "--с-потребителями требует модуля." >&2
	exit 2
fi
if [ -z "$MODULE" ] && [ $((EVERYTHING + EXTERNAL + INFRASTRUCTURE + WITH_E2E)) -eq 0 ]; then
	usage
fi
if [ -n "$MODULE" ] && [ ! -d "src/модули/$MODULE" ]; then
	echo "Модуля «${MODULE}» нет в src/модули. Есть:" >&2
	ls src/модули >&2
	exit 2
fi

WORK="$(mktemp -d)"

# Наборы — *_Тесты.os вне каталогов фикстур; каталог модуля без вложенных каталогов.
all_suites() {
	find tests -name '*_Тесты.os' -not -path '*/фикстуры/*'
}
suites_in() {
	if [ -d "tests/$1" ]; then
		find "tests/$1" -maxdepth 1 -name '*_Тесты.os'
	fi
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
elif [ -z "$MODULE" ]; then
	find tests/e2e -name '*_Тесты.os' > "$WORK/selected"
	TITLE="все живые наборы"
else
	{ suites_in "$MODULE"; suites_in сквозные; } > "$WORK/selected"
	TITLE="модуль $MODULE и сквозные наборы"
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
FILE_ARGS=()
while IFS= read -r suite; do
	SUITES+=("$suite")
	FILE_ARGS+=(-f "$suite")
done < <(sort -u "$WORK/selected")

if [ "${#SUITES[@]}" -eq 0 ]; then
	echo "Наборов не отобрано ($TITLE) — прогонять нечего." >&2
	exit 1
fi

echo "== Тесты: $TITLE — ${#SUITES[@]} наборов"
for suite in "${SUITES[@]}"; do
	reason=""
	if [ "$LIST_ONLY" -eq 1 ] && [ -s "$WORK/reasons" ]; then
		reason="$(grep -F "$suite"$'\t' "$WORK/reasons" | head -1 | cut -f2 || true)"
	fi
	echo "   $suite${reason:+  ← $reason}"
done
echo

if [ "$LIST_ONLY" -eq 1 ]; then
	exit 0
fi

if [ -n "$ORIGINAL_LC_ALL" ]; then export LC_ALL="$ORIGINAL_LC_ALL"; else unset LC_ALL; fi
code=0
oneunit execute ${EXTRA[@]+"${EXTRA[@]}"} "${FILE_ARGS[@]}" ${PASS[@]+"${PASS[@]}"} || code=$?
exit "$code"
