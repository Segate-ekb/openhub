# Шапка и итог прогона: на каком коммите, в каком дереве и какой командой шёл прогон.
# Подключается scripts/тесты.sh и scripts/смоук.sh; все строки начинаются с «== прогон.».
#
#   == прогон.коммит: <полный хэш HEAD>
#   == прогон.дерево: чисто | с правками, путей <N> (дальше пути строками, первые 20)
#   == прогон.команда: <командная строка запуска>
#   == прогон.каталог: <корень дерева>
#   == прогон.начало: <время UTC>
#   ...
#   == прогон.итог: код <код выхода>, коммит <хэш>, <состояние дерева>, конец <время UTC>
#
# Итог сверяет коммит и содержимое дерева с началом: правка, коммит или новый файл по ходу
# прогона дают в итоге «дерево менялось по ходу прогона». Пути, которые git игнорирует
# (oscript_modules и прочее из .gitignore), в сверку не входят.

RUN_DIRTY_SHOWN=20

# git дерева прогона: без необязательной блокировки индекса — соседний коммит в том же
# чекауте не наткнётся на index.lock.
tree_git() {
	git --no-optional-locks -C "$RUN_ROOT" -c core.quotePath=false "$@" 2>/dev/null
}

tree_head() {
	tree_git rev-parse --verify -q HEAD || true
}

tree_status() {
	tree_git status --porcelain --untracked-files=all || true
}

# Отпечаток содержимого дерева: коммит, состояние путей, правки отслеживаемых файлов
# и содержимое неотслеживаемых.
tree_fingerprint() {
	{
		tree_head
		tree_status
		tree_git diff --no-ext-diff --no-textconv --binary HEAD || true
		tree_git ls-files --others --exclude-standard | tree_git hash-object --stdin-paths || true
	} | git hash-object --stdin 2>/dev/null
}

# Аргумент как в командной строке: в кавычках, только если без них оболочка прочла бы иначе.
shell_quoted() {
	case "$1" in
		"" | *[[:space:]\"\'\\\$\`\;\&\|\<\>\(\)\*\?\[\]\#\~\!\{\}]*)
			printf "'%s'" "$(printf '%s' "$1" | sed "s/'/'\\\\''/g")" ;;
		*) printf '%s' "$1" ;;
	esac
}

utc_now() {
	date -u '+%Y-%m-%dT%H:%M:%SZ'
}

# Печатает шапку, запоминает, с чем сверять итог, и превращает сигналы остановки в выход
# с кодом сигнала — иначе ловушка EXIT увидела бы код 0: run_header <корень> <$0> <аргументы…>
run_header() {
	RUN_ROOT="$1"
	shift
	trap 'exit 129' HUP
	trap 'exit 130' INT
	trap 'exit 143' TERM

	RUN_IN_GIT=0
	if command -v git >/dev/null 2>&1 && [ "$(tree_git rev-parse --is-inside-work-tree)" = "true" ]; then
		RUN_IN_GIT=1
	fi

	local line="" argument
	for argument in "$@"; do
		line="$line${line:+ }$(shell_quoted "$argument")"
	done

	if [ "$RUN_IN_GIT" -eq 1 ]; then
		RUN_START_HEAD="$(tree_head)"
		RUN_START_FINGERPRINT="$(tree_fingerprint)"
		echo "== прогон.коммит: ${RUN_START_HEAD:-нет — в репозитории ни одного коммита}"
		local status dirty
		status="$(tree_status)"
		dirty="$(printf '%s' "$status" | grep -c '' || true)"
		if [ "$dirty" -eq 0 ]; then
			echo "== прогон.дерево: чисто"
		else
			echo "== прогон.дерево: с правками, путей $dirty"
			# sed, а не head: head закрыл бы канал раньше времени, и pipefail уронил бы скрипт
			printf '%s\n' "$status" | sed -n "1,${RUN_DIRTY_SHOWN}s/^/== прогон.дерево: /p"
			if [ "$dirty" -gt "$RUN_DIRTY_SHOWN" ]; then
				echo "== прогон.дерево: … и ещё $((dirty - RUN_DIRTY_SHOWN))"
			fi
		fi
	else
		echo "== прогон.коммит: нет — каталог вне git"
		echo "== прогон.дерево: неизвестно — каталог вне git"
	fi
	echo "== прогон.команда: $line"
	echo "== прогон.каталог: $RUN_ROOT"
	echo "== прогон.начало: $(utc_now)"
}

# Печатает итог прогона: run_footer <код выхода>
run_footer() {
	local code="$1" head tree
	if [ "$RUN_IN_GIT" -eq 0 ]; then
		echo "== прогон.итог: код $code, коммита нет — каталог вне git, конец $(utc_now)"
		return 0
	fi
	head="$(tree_head)"
	if [ "$head" != "$RUN_START_HEAD" ]; then
		head="$RUN_START_HEAD → $head"
		tree="дерево менялось по ходу прогона"
	elif [ "$(tree_fingerprint)" != "$RUN_START_FINGERPRINT" ]; then
		tree="дерево менялось по ходу прогона"
	elif [ -z "$(tree_status)" ]; then
		tree="дерево чистое и не менялось"
	else
		tree="дерево с правками и не менялось"
	fi
	echo "== прогон.итог: код $code, коммит ${head:-нет}, $tree, конец $(utc_now)"
}
