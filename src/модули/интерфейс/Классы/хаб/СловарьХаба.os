// Тексты района «Хаб»: разделы настроек хаба, метки ключей настроек, провайдеры входа и почта.

// Кладёт тексты в словарь интерфейса.
//
// Параметры:
//  Словарь - СловарьТекстов - словарь, который собирается из частей.
//
Процедура Наполнить(Знач Словарь) Экспорт

	КлючиПулов(Словарь);
	КлючиДомаХаба(Словарь);
	КлючиЗначенийНастроек(Словарь);
	КлючиНастроекРеестра(Словарь);
	КлючиНастроекПодсистем(Словарь);
	КлючиПровайдеровВхода(Словарь);
	КлючиПочты(Словарь);
	КлючиЖурналаАудита(Словарь);

КонецПроцедуры

// Раздел «Пулы»: таблица пулов, отбор, окно нового пула, «Сделать основным» и удаление.
Процедура КлючиПулов(Словарь)

	Словарь.Добавить("settings.hub.pools.list.title", "Пулы хаба");
	Словарь.Добавить("settings.hub.pools.list.lead", "Пулы инсталляции; остальное о пуле —"
		+ " в его настройках.");
	Словарь.Добавить("settings.hub.pools.add", "Добавить пул");
	Словарь.Добавить("settings.hub.pools.filter.search", "Поиск");
	Словарь.Добавить("settings.hub.pools.filter.search.example", "Имя пула");
	Словарь.Добавить("settings.hub.pools.filter.visibility", "Видимость");
	Словарь.Добавить("settings.hub.pools.filter.visibility.any", "любая");
	Словарь.Добавить("settings.hub.pools.filter.button", "Найти");
	Словарь.Добавить("settings.hub.pools.col.name", "Пул");
	Словарь.Добавить("settings.hub.pools.col.kind", "Тип");
	Словарь.Добавить("settings.hub.pools.col.visibility", "Видимость");
	Словарь.Добавить("settings.hub.pools.col.owner", "Владелец");
	Словарь.Добавить("settings.hub.pools.col.packages", "Пакетов");
	Словарь.Добавить("settings.hub.pools.col.space", "Место");
	Словарь.Добавить("settings.hub.pools.kind.primary", "Основной");
	Словарь.Добавить("settings.hub.pools.kind.pool", "Пул");
	Словарь.Добавить("settings.hub.pools.visibility.public", "Публичный");
	Словарь.Добавить("settings.hub.pools.visibility.private", "Приватный");
	Словарь.Добавить("settings.hub.pools.space.label", "Место пула «%1»");
	Словарь.Добавить("settings.hub.pools.space.inherited", "%1 · квота хаба");
	Словарь.Добавить("settings.hub.pools.empty", "Пулов пока нет — добавьте первый.");
	Словарь.Добавить("settings.hub.pools.empty.filter", "По этому отбору ничего не найдено:"
		+ " измените поиск или видимость.");
	Словарь.Добавить("settings.hub.pools.menu", "Действия с пулом «%1»");
	Словарь.Добавить("settings.hub.pools.personal.list.title", "Личные пространства — %1");
	Словарь.Добавить("settings.hub.pools.personal.list.lead", "Пул каждой учётки: заводится вместе с ней"
		+ " и уходит вместе с ней; настраивается из ⚙.");
	Словарь.Добавить("settings.hub.pools.personal.list.toggle", "Показать личные пространства");
	Словарь.Добавить("settings.hub.pools.personal.search.example", "Логин или его часть");
	Словарь.Добавить("settings.hub.pools.personal.empty.filter",
		"Ни одно личное пространство не подходит под поиск.");
	Словарь.Добавить("settings.hub.pools.action.settings", "Настройки пула");
	Словарь.Добавить("settings.hub.pools.action.primary", "Сделать основным");
	Словарь.Добавить("settings.hub.pools.action.delete", "Удалить");

	Словарь.Добавить("settings.hub.pools.new.title", "Новый пул");
	Словарь.Добавить("settings.hub.pools.new.lead", "Пул заводится пустым. Владельцем станете вы;"
		+ " права раздаются в настройках пула.");
	Словарь.Добавить("settings.hub.pools.new.name", "Имя пула");
	Словарь.Добавить("settings.hub.pools.new.name.hint", "Латиница, цифры, «-», «_» и «.»;"
		+ " пул откроется по адресу /pools/имя.");
	Словарь.Добавить("settings.hub.pools.new.name.required", "Назовите пул.");
	Словарь.Добавить("settings.hub.pools.new.visibility", "Видимость");
	Словарь.Добавить("settings.hub.pools.new.visibility.unknown",
		"Видимость не распознана: выберите «Публичный» или «Приватный».");
	Словарь.Добавить("settings.hub.pools.new.quota.number",
		"Квота не принята: ожидается целое число мегабайт (−1 — как в хабе, 0 — без ограничения).");
	Словарь.Добавить("settings.hub.pools.new.quota.cap", "Квота не принята: не больше %1 МБ.");
	Словарь.Добавить("settings.hub.pools.new.button", "Добавить");
	Словарь.Добавить("settings.hub.pools.new.failed", "Пул не создан: %1");

	Словарь.Добавить("settings.hub.pools.primary.title", "Сделать «%1» основным пулом?");
	Словарь.Добавить("settings.hub.pools.primary.consequence", "Короткие адреса /download,"
		+ " /dev-channel и /push поведут в «%1», и удалить его станет нельзя. «%2» станет обычным пулом.");
	Словарь.Добавить("settings.hub.pools.primary.consequence.first", "Короткие адреса /download,"
		+ " /dev-channel и /push поведут в «%1», и удалить его станет нельзя.");
	Словарь.Добавить("settings.hub.pools.primary.failed", "Основной пул не изменён: %1");

	Словарь.Добавить("settings.hub.pools.delete.title", "Удалить пул «%1»?");
	Словарь.Добавить("settings.hub.pools.delete.consequence", "Пул удаляется со всем содержимым:"
		+ " пакетов — %1, из них скрытых — %2 (со всеми версиями и файлами), апстримов — %3, зеркал — %4, а также права"
		+ " доступа, подписки и незакрытые заявки. Вернуть его нельзя.");
	Словарь.Добавить("settings.hub.pools.delete.echo", "Введите имя пула");
	Словарь.Добавить("settings.hub.pools.delete.echo.mismatch", "Пул не удалён: введите его имя — %1.");
	Словарь.Добавить("settings.hub.pools.delete.failed", "Пул не удалён: %1");
	Словарь.Добавить("settings.hub.pools.delete.personal", "Пул не удалён: «%1» — личное пространство,"
		+ " оно удаляется вместе с учётной записью.");

	Словарь.Добавить("settings.hub.pools.error.stale", "Страница устарела: ничего не изменено."
		+ " Обновите её и повторите действие.");
	Словарь.Добавить("settings.hub.pools.error.missing", "Пула «%1» нет: его уже удалили. Обновите страницу.");

КонецПроцедуры

// Дом «Хаб»: разделы настроек хаба.
Процедура КлючиДомаХаба(Словарь)

	Словарь.Добавить("settings.hub.title", "Настройки хаба");
	Словарь.Добавить("settings.hub.lead", "Вход, люди, пулы, внешний вид и интеграции.");
	Словарь.Добавить("settings.hub.group.hub", "Хаб");
	Словарь.Добавить("settings.hub.group.login", "Вход");
	Словарь.Добавить("settings.hub.group.people", "Люди и пулы");
	Словарь.Добавить("settings.hub.group.packages", "Пакеты");
	Словарь.Добавить("settings.hub.group.notify", "Оповещения");
	Словарь.Добавить("settings.hub.group.service", "Служба");
	Словарь.Добавить("settings.hub.nav.identity", "Основное");
	Словарь.Добавить("settings.hub.nav.branding", "Брендирование");
	Словарь.Добавить("settings.hub.nav.login", "Вход и регистрация");
	Словарь.Добавить("settings.hub.nav.people", "Люди");
	Словарь.Добавить("settings.hub.nav.groups", "Группы");
	Словарь.Добавить("settings.hub.nav.pools", "Пулы");
	Словарь.Добавить("settings.hub.nav.storage", "Хранилище");
	Словарь.Добавить("settings.hub.nav.trusted", "Доверенная публикация");
	Словарь.Добавить("settings.hub.nav.mail", "Почта");
	Словарь.Добавить("settings.hub.nav.mirrors", "Зеркалирование");
	Словарь.Добавить("settings.hub.nav.webhooks", "Подписки на события");
	Словарь.Добавить("settings.hub.nav.password", "Политика пароля");
	Словарь.Добавить("settings.hub.nav.providers", "Провайдеры входа");
	Словарь.Добавить("settings.hub.nav.legacy", "Легаси-флоу");
	Словарь.Добавить("settings.hub.block.delivery", "Доставка уведомлений");
	Словарь.Добавить("settings.hub.nav.proxy", "Прокси апстрима");
	Словарь.Добавить("settings.hub.nav.audit", "Аудит");
	Словарь.Добавить("settings.hub.nav.maintenance", "Обслуживание");
	Словарь.Добавить("settings.hub.fine.title", "Тонкие настройки");
	Словарь.Добавить("settings.hub.fine.lead",
		"Рабочие умолчания: их меняют, когда об этом просит нагрузка или регламент.");
	Словарь.Добавить("settings.hub.fine.toggle", "Показать тонкие настройки");
	Словарь.Добавить("settings.hub.pools.lead", "Правила пулов на этом хабе.");
	Словарь.Добавить("settings.hub.pools.main.title", "Основной пул хаба");
	Словарь.Добавить("settings.hub.pools.main.lead", "Пул, в который ведут короткие адреса"
		+ " /download, /dev-channel и /push.");
	Словарь.Добавить("settings.hub.pools.main.label", "Основной пул");
	Словарь.Добавить("settings.hub.pools.main.hint", "Переключается в списке ниже:"
		+ " меню строки пула, «Сделать основным»");
	Словарь.Добавить("settings.hub.pools.main.none", "не назначен — короткие адреса отвечают отказом");

	Словарь.Добавить("settings.hub.pools.personal.confirm.title", "Выключить личные пространства");
	Словарь.Добавить("settings.hub.pools.personal.confirm.lead", "Выключение сносит все личные"
		+ " пространства хаба вместе с содержимым. Восстановить их будет нечем.");
	Словарь.Добавить("settings.hub.pools.personal.confirm.counts", "Будет удалено безвозвратно:"
		+ " личных пространств — %1, из них с пакетами — %2; пакетов — %3, версий — %4.");
	Словарь.Добавить("settings.hub.pools.personal.confirm.echo.label", "Число удаляемых пространств");
	Словарь.Добавить("settings.hub.pools.personal.confirm.echo.hint", "Введите %1 — ровно столько"
		+ " личных пространств будет снесено.");
	Словарь.Добавить("settings.hub.pools.personal.confirm.button", "Снести личные пространства");
	Словарь.Добавить("settings.hub.pools.personal.confirm.cancel", "Отмена");
	Словарь.Добавить("settings.hub.pools.personal.error.echo", "Ничего не удалено: введено не то"
		+ " число. Чтобы снести личные пространства, повторите ровно %1.");
	Словарь.Добавить("settings.hub.pools.personal.error.apply",
		"Настройка «Личные пространства» не сохранена: %1");
	Словарь.Добавить("settings.hub.pools.personal.error.off", "Личные пространства уже выключены:"
		+ " сносить нечего. Обновите страницу.");
	Словарь.Добавить("settings.hub.pools.personal.error.wipe", "Снос личных пространств не выполнен:"
		+ " %1. Настройка осталась включённой, операцию можно повторить.");
	Словарь.Добавить("settings.hub.pools.personal.error.grant", "Раздача личных пространств"
		+ " не выполнена: %1");
	Словарь.Добавить("settings.hub.pools.personal.off.done", "Личные пространства выключены:"
		+ " снесено пространств — %1, пакетов — %2, версий — %3.");
	Словарь.Добавить("settings.hub.pools.personal.off.partial", "Снесено пространств — %1,"
		+ " но %2 снести не удалось: причина в журнале хаба. Настройка осталась включённой —"
		+ " повторите операцию, когда причина устранена.");
	Словарь.Добавить("settings.hub.pools.personal.on.done", "Личные пространства включены:"
		+ " создано — %1, уже было — %2, пропущено отключённых учёток — %3,"
		+ " осталось без пространства — %4.");
	Словарь.Добавить("settings.hub.passwordlogin.title", "Вход по паролю");

	Словарь.Добавить("settings.hub.passwordlogin.confirm.title", "Выключить вход по логину и паролю?");
	Словарь.Добавить("settings.hub.passwordlogin.confirm.lead",
		"Со страницы входа уйдут поля логина и пароля; войти можно будет только через провайдера.");
	Словарь.Добавить("settings.hub.passwordlogin.confirm.counts", "Администраторов, готовых войти"
		+ " через провайдера, — %1; включённых провайдеров входа — %2.");
	Словарь.Добавить("settings.hub.passwordlogin.confirm.stays",
		"Выданное не гаснет: открытые сессии и токены доступа продолжают работать, смена своего "
		+ "пароля в кабинете остаётся, вход CLI и мастер первого запуска пароля не спрашивают. "
		+ "Если пароль утёк — завершите сессии и отзовите токены отдельно.");
	Словарь.Добавить("settings.hub.passwordlogin.confirm.rescue",
		"Аварийный возврат — переменная OSHUB_AUTH_PASSWORD_ENABLED=true: пока она задана, "
		+ "тумблер не правится. Штатный возврат — войти провайдером, включить тумблер и убрать "
		+ "переменную.");
	Словарь.Добавить("settings.hub.passwordlogin.confirm.echo.sample", "выключить");
	Словарь.Добавить("settings.hub.passwordlogin.confirm.button", "Выключить парольный вход");
	Словарь.Добавить("settings.hub.passwordlogin.error.echo", "Ничего не изменилось: введено не то"
		+ " слово. Чтобы выключить парольный вход, повторите ровно «%1».");
	Словарь.Добавить("settings.hub.passwordlogin.error.apply",
		"Настройка «Вход по логину и паролю» не сохранена: %1");
	Словарь.Добавить("settings.hub.passwordlogin.error.off", "Вход по логину и паролю уже выключен:"
		+ " выключать нечего. Обновите страницу.");
	Словарь.Добавить("settings.hub.passwordlogin.error.lockout",
		"Вход по логину и паролю оставлен включённым: %1");
	Словарь.Добавить("settings.hub.passwordlogin.lockout.providers",
		"на хабе нет ни одного включённого провайдера входа, и после выключения формы"
		+ " войти будет нечем. Заведите провайдера в разделе «Провайдеры входа»"
		+ " (/hub/settings/providers) и войдите через него хотя бы одним администратором.");
	Словарь.Добавить("settings.hub.passwordlogin.lockout.identities",
		"ни у одного администратора хаба нет привязанной личности включённого провайдера,"
		+ " и после выключения формы войти будет некому. Привяжите провайдера в кабинете"
		+ " (/me/settings/oidc) хотя бы одному администратору.");
	Словарь.Добавить("settings.hub.passwordlogin.off.done", "Вход по логину и паролю выключен:"
		+ " на странице входа остались только провайдеры.");
	Словарь.Добавить("settings.hub.passwordlogin.on.done", "Вход по логину и паролю включён:"
		+ " форма логина и пароля снова на странице входа.");

	Словарь.Добавить("settings.hub.error.section", "Раздел настроек не найден");
	Словарь.Добавить("settings.hub.error.operation", "Неизвестная операция раздела:"
		+ " обновите страницу и повторите действие");
	Словарь.Добавить("settings.hub.error.key", "Эта настройка не редактируется в текущем разделе");
	Словарь.Добавить("settings.hub.error.field", "Настройка «%1» не сохранена: %2.");
	Словарь.Добавить("settings.hub.error.applied",
		"Остальная форма уже применена: %1 — эти значения действуют.");
	Словарь.Добавить("settings.hub.error.applied.none", "Ничего из формы не применено.");

	// пояснения разделов дома; заголовок раздела приходит из nav.*
	Словарь.Добавить("settings.hub.identity.lead", "Как хаб представляется клиентам opm и браузеру.");
	Словарь.Добавить("settings.hub.branding.lead",
		"Название, подпись и цвета хаба. Тему и акцент посетитель может сменить у себя.");
	Словарь.Добавить("settings.hub.login.lead", "Кто заводит учётную запись и чем можно войти.");
	Словарь.Добавить("settings.hub.mail.lead",
		"Письма хаба: приглашения, сброс пароля и подтверждение адреса.");
	Словарь.Добавить("settings.hub.trusted.lead", "На каком внешнем доказательстве хаб пускает"
		+ " публиковать без своей роли.");
	Словарь.Добавить("settings.hub.mirrors.lead",
		"Синхронизация зеркал с источниками; числа репликации задаёт конфигурация инсталляции.");
	Словарь.Добавить("settings.hub.mirrors.overview.title", "Зеркала всех пулов");
	Словарь.Добавить("settings.hub.mirrors.overview.lead",
		"Состояние и последняя синхронизация зеркал всех ваших пулов на одной странице.");
	Словарь.Добавить("settings.hub.mirrors.overview.button", "Открыть обзор зеркал");
	Словарь.Добавить("settings.hub.password.section.lead",
		"Требования к новым паролям; заведённые пароли ужесточение не ломает.");
	Словарь.Добавить("settings.hub.delivery.lead", "Слать ли уведомления и пускать ли их по http.");
	Словарь.Добавить("settings.hub.legacy.lead",
		"Публикация по токену GitHub для пакетов, переехавших из oscript-library.");
	Словарь.Добавить("settings.hub.proxy.lead",
		"Как хаб ходит в чужие хабы за пакетами, которых у него нет.");

	Словарь.Добавить("settings.hub.storage.state.title", "Хранилище");
	Словарь.Добавить("settings.hub.storage.state.lead",
		"Куда хаб складывает пакеты и сколько там места; задаётся при развёртывании.");
	Словарь.Добавить("settings.hub.storage.meter.label", "Занято места в хранилище");
	Словарь.Добавить("settings.hub.storage.meter.caption", "%1 из %2");
	Словарь.Добавить("settings.hub.storage.meter.counted",
		"По учёту хаба: счётчики пулов сверяются с хранилищем раз в час.");
	Словарь.Добавить("settings.hub.storage.health.alive", "Отвечает");
	Словарь.Добавить("settings.hub.storage.health.down", "Не отвечает");
	Словарь.Добавить("settings.hub.storage.health.denied", "Ответило, но не пустило");
	Словарь.Добавить("settings.hub.storage.health.unknown", "Ещё не проверялось");
	Словарь.Добавить("settings.hub.storage.health.never",
		"Первая проверка ещё не проходила — состояние появится после неё.");
	Словарь.Добавить("settings.hub.storage.health.lead", "Хаб проверяет хранилище сам, каждые %1 с.");
	Словарь.Добавить("settings.hub.storage.health.checked", "Последний ответ — %1.");
	Словарь.Добавить("settings.hub.storage.health.since.down",
		"Не отвечает с %1: %2. Поднявшееся хранилище вернётся в работу само,"
		+ " не позже следующей проверки.");
	Словарь.Добавить("settings.hub.storage.health.since.denied",
		"Не пускает хаб с %1: %2. Чинить надо доступ, а не адрес: хранилище на месте"
		+ " и отвечает.");
	Словарь.Добавить("settings.hub.storage.row.occupied", "Занято места");
	Словарь.Добавить("settings.hub.storage.row.health", "Состояние");
	Словарь.Добавить("settings.hub.storage.occupied.unknown", "неизвестно");
	Словарь.Добавить("settings.hub.storage.row.backend", "На чём хранится");
	Словарь.Добавить("settings.hub.storage.row.where", "Где лежат артефакты");
	Словарь.Добавить("settings.hub.storage.row.quota", "Потолок объёма");
	Словарь.Добавить("settings.hub.storage.row.upload", "Предельный размер одной публикации");
	Словарь.Добавить("settings.hub.storage.backend.file", "Файловая система сервера");
	Словарь.Добавить("settings.hub.storage.backend.s3", "Объектное хранилище S3");
	Словарь.Добавить("settings.hub.storage.where.s3", "корзина «%1» на %2");
	Словарь.Добавить("settings.hub.storage.where.prefix", "под префиксом «%1»");
	Словарь.Добавить("settings.hub.storage.quota.none", "не ограничен");
	Словарь.Добавить("settings.hub.storage.env.note", "Меняется переменными окружения");

	// брендирование: образец шапки, логотип и иконка
	Словарь.Добавить("settings.hub.branding.preview.title", "Так увидят посетители");
	Словарь.Добавить("settings.hub.branding.preset.accent", "+ свой акцент");
	Словарь.Добавить("settings.hub.branding.preview.button", "Кнопка акцента");
	Словарь.Добавить("settings.hub.branding.preview.link", "ссылка");
	Словарь.Добавить("settings.hub.branding.preview.badge", "плашка");
	Словарь.Добавить("settings.hub.branding.preview.text", "обычный текст");
	Словарь.Добавить("settings.hub.branding.assets.title", "Логотип и иконка");
	Словарь.Добавить("settings.hub.branding.assets.lead",
		"Загружаются отдельно, без «Сохранить». До %1; SVG, PNG, JPEG, GIF, WebP, AVIF или ICO.");
	Словарь.Добавить("settings.hub.branding.assets.megabytes", "%1 МБ");
	Словарь.Добавить("settings.hub.branding.assets.note",
		"Логотип рисуется высотой 28 px и держит свои пропорции; своя иконка заменяет весь фирменный"
		+ " набор значков.");
	Словарь.Добавить("settings.hub.branding.assets.logo.label", "Логотип в шапке");
	Словарь.Добавить("settings.hub.branding.assets.logo.default", "фирменный из поставки · рисуется высотой 28 px");
	Словарь.Добавить("settings.hub.branding.assets.logo.uploaded", "%1 · %2 · загружен %3");
	Словарь.Добавить("settings.hub.branding.assets.favicon.label", "Иконка сайта");
	Словарь.Добавить("settings.hub.branding.assets.favicon.default", "фирменная из поставки");
	Словарь.Добавить("settings.hub.branding.assets.favicon.uploaded", "%1 · %2 · загружена %3");
	Словарь.Добавить("settings.hub.branding.assets.warning",
		"SVG отдаётся посетителям как есть, скрипт внутри него выполнится в их браузере —"
		+ " загружайте только своё.");
	Словарь.Добавить("settings.hub.branding.error.empty", "Файл не выбран: выберите картинку.");
	Словарь.Добавить("settings.hub.branding.error.large",
		"%1: файл весит %2 при допустимых %3.");
	Словарь.Добавить("settings.hub.branding.error.type",
		"%1: это не картинка известного хабу формата. Допустимы SVG, PNG, JPEG, GIF,"
		+ " WebP, AVIF и ICO.");
	Словарь.Добавить("settings.hub.branding.error.key", "Такой картинки оформления в хабе нет.");
	Словарь.Добавить("settings.hub.branding.error.upload", "%1: хаб не принял картинку, она не изменена.");
	Словарь.Добавить("settings.hub.branding.error.stale",
		"Страница устарела: ничего не изменено. Обновите её и повторите.");

	Словарь.Добавить("settings.hub.version.title", "Сборка");
	Словарь.Добавить("settings.hub.version.hub", "версия хаба");
	Словарь.Добавить("settings.hub.version.autumn", "ОСень");
	Словарь.Добавить("settings.hub.version.winow", "winow");
	Словарь.Добавить("settings.hub.version.kit", "ui-кит");

	Словарь.Добавить("settings.hub.release.title", "Новая версия хаба");
	Словарь.Добавить("settings.hub.release.available", "Доступна версия %1, у вас %2.");
	Словарь.Добавить("settings.hub.release.open", "Страница пакета");

	Словарь.Добавить("settings.key.oshub-updates-check.label", "Проверять новую версию хаба");
	Словарь.Добавить("settings.key.oshub-updates-check.hint",
		"Раз в сутки хаб спрашивает источник выпусков, не вышла ли версия новее.");
	Словарь.Добавить("settings.key.oshub-updates-check.help",
		"Раз в сутки хаб спрашивает источник выпусков, какая версия OpenHub последняя. О версии новее"
		+ " установленной говорит плашка в разделе «Основное», а подписки хаба на событие «Вышла новая"
		+ " версия хаба» получают уведомление — один раз о каждой версии. Выключайте, если инсталляции"
		+ " ходить наружу нечем.");
	Словарь.Добавить("settings.key.oshub-updates-source.label", "Источник выпусков");
	Словарь.Добавить("settings.key.oshub-updates-source.hint",
		"Карточка пакета OpenHub в API хаба пакетов: хаб берёт из неё последнюю версию.");

	Словарь.Добавить("settings.hub.password.title", "Сейчас действует");
	Словарь.Добавить("settings.hub.password.lead", "Так хаб проверит следующий новый пароль.");

	Словарь.Добавить("settings.hub.audit.title", "Журнал аудита");
	Словарь.Добавить("settings.hub.audit.lead", "Мутирующие операции хаба: кто, что и с чем сделал.");
	Словарь.Добавить("settings.hub.audit.col.when", "Когда (UTC)");
	Словарь.Добавить("settings.hub.audit.col.who", "Кто");
	Словарь.Добавить("settings.hub.audit.col.action", "Действие");
	Словарь.Добавить("settings.hub.audit.col.object", "Объект");
	Словарь.Добавить("settings.hub.audit.col.subject", "Кому");
	Словарь.Добавить("settings.hub.audit.col.ip", "Адрес");
	Словарь.Добавить("settings.hub.audit.empty",
		"В прочитанном хвосте журнала записей по этому отбору нет.");
	Словарь.Добавить("settings.hub.audit.tail.note", "Экран читает хвост файла журнала: отбор и страницы действуют в его пределах, более ранние записи остаются в файле. Время — UTC.");
	Словарь.Добавить("settings.hub.audit.tail.truncated", "Журнал прочитан НЕ ЦЕЛИКОМ: файл длиннее читаемого хвоста, показан только его конец. Записи за пределами прочитанного остались в файле, но в отбор и страницы не попали — пустая страница здесь не значит «событий не было». Время — UTC.");
	Словарь.Добавить("settings.hub.audit.source.missing",
		"Источник журнала недоступен: файл журнала не читается. Записи есть, но показать их нечем.");
	Словарь.Добавить("settings.hub.audit.page.first", "В начало журнала");
	Словарь.Добавить("settings.hub.audit.cell.empty", "—");
	Словарь.Добавить("settings.hub.audit.details.summary", "Подробнее");
	Словарь.Добавить("settings.hub.audit.details.about", "Подробнее: %1");
	Словарь.Добавить("settings.hub.audit.details.raw", "детали");
	Словарь.Добавить("settings.hub.audit.filter.type", "Событие");
	Словарь.Добавить("settings.hub.audit.filter.type.all", "Все события");
	Словарь.Добавить("settings.hub.audit.filter.who", "Кто");
	Словарь.Добавить("settings.hub.audit.filter.who.placeholder", "Логин или префикс токена");
	Словарь.Добавить("settings.hub.audit.filter.from", "С даты (UTC)");
	Словарь.Добавить("settings.hub.audit.filter.to", "По дату (UTC)");
	Словарь.Добавить("settings.hub.audit.filter.ip", "Адрес");
	Словарь.Добавить("settings.hub.audit.filter.ip.placeholder", "Адрес или сеть, например 10.0.0.0/8");
	Словарь.Добавить("settings.hub.audit.filter.ip.unread",
		"Адрес «%1» не прочитан: это не IP-адрес и не сеть в записи CIDR. Отбор по адресу не применён — журнал ниже показан без него.");

	// раздел «Пользователи»: таблица с отбором и страницами, меню ⚙ строки, окна и подтверждения
	Словарь.Добавить("settings.hub.users.title", "Пользователи");
	Словарь.Добавить("settings.hub.users.lead", "Учётные записи инсталляции. Себя заблокировать нельзя.");
	Словарь.Добавить("settings.hub.users.add", "Добавить пользователя");
	Словарь.Добавить("settings.hub.users.filter.search", "Поиск");
	Словарь.Добавить("settings.hub.users.filter.search.example", "Логин или email");
	Словарь.Добавить("settings.hub.users.filter.role", "Роль");
	Словарь.Добавить("settings.hub.users.filter.role.any", "любая");
	Словарь.Добавить("settings.hub.users.filter.status", "Статус");
	Словарь.Добавить("settings.hub.users.filter.status.any", "любой");
	Словарь.Добавить("settings.hub.users.filter.button", "Найти");
	Словарь.Добавить("settings.hub.users.col.login", "Логин");
	Словарь.Добавить("settings.hub.users.col.email", "Email");
	Словарь.Добавить("settings.hub.users.col.role", "Роль");
	Словарь.Добавить("settings.hub.users.col.status", "Статус");
	Словарь.Добавить("settings.hub.users.col.actions", "Действия");
	Словарь.Добавить("settings.hub.users.status.active", "активен");
	Словарь.Добавить("settings.hub.users.status.blocked", "заблокирован");
	Словарь.Добавить("settings.hub.users.status.nologin", "нечем войти");
	Словарь.Добавить("settings.hub.users.status.password", "смена пароля");
	Словарь.Добавить("settings.hub.users.empty", "Учётных записей нет.");
	Словарь.Добавить("settings.hub.users.empty.filter", "По этому отбору ничего не найдено.");
	Словарь.Добавить("settings.hub.users.menu", "Действия над «%1»");
	Словарь.Добавить("settings.hub.users.action.block", "Заблокировать");
	Словарь.Добавить("settings.hub.users.action.unblock", "Разблокировать");
	Словарь.Добавить("settings.hub.users.action.grant", "Сделать администратором");
	Словарь.Добавить("settings.hub.users.action.revoke", "Снять администратора");
	Словарь.Добавить("settings.hub.users.action.reset", "Сбросить пароль");
	Словарь.Добавить("settings.hub.users.action.delete", "Удалить");
	Словарь.Добавить("settings.hub.users.new.title", "Новый пользователь");
	Словарь.Добавить("settings.hub.users.new.lead", "Учётка заводится без пароля: хаб выпустит ссылку,"
		+ " по которой человек задаст пароль.");
	Словарь.Добавить("settings.hub.users.new.login", "Логин");
	Словарь.Добавить("settings.hub.users.new.login.hint", "Имя личного пространства, изменить его потом нельзя");
	Словарь.Добавить("settings.hub.users.new.email", "Email");
	Словарь.Добавить("settings.hub.users.new.email.hint", "Необязателен: хаб писем не шлёт");
	Словарь.Добавить("settings.hub.users.new.role", "Роль на хабе");
	Словарь.Добавить("settings.hub.users.role.user", "Пользователь");
	Словарь.Добавить("settings.hub.users.role.admin", "Администратор хаба");
	Словарь.Добавить("settings.hub.users.new.button", "Создать");
	Словарь.Добавить("settings.hub.users.new.login.required", "Укажите логин");
	Словарь.Добавить("settings.hub.users.grant.title", "Сделать «%1» администратором?");
	Словарь.Добавить("settings.hub.users.grant.consequence", "Роль администратора даёт полные права"
		+ " на всю инсталляцию: все пулы, все пакеты и все учётные записи.");
	Словарь.Добавить("settings.hub.users.revoke.title", "Снять с «%1» роль администратора?");
	Словарь.Добавить("settings.hub.users.revoke.consequence", "Выданное на пулах и пакетах останется:"
		+ " снимается только роль хаба.");
	Словарь.Добавить("settings.hub.users.reset.title", "Сбросить пароль «%1»?");
	Словарь.Добавить("settings.hub.users.reset.consequence", "Хаб выпустит новую ссылку установки пароля"
		+ " и покажет её один раз. Прежняя ссылка перестанет работать.");
	Словарь.Добавить("settings.hub.users.delete.title", "Удалить «%1»?");
	Словарь.Добавить("settings.hub.users.delete.consequence", "Действие необратимо: личное пространство,"
		+ " токены и привязки входа пользователя будут удалены. Опубликованное в общих пулах останется без автора.");
	Словарь.Добавить("settings.hub.users.delete.echo", "Введите логин для подтверждения");
	Словарь.Добавить("settings.hub.users.delete.echo.mismatch", "Логин не совпал: наберите «%1» точно так,"
		+ " как он написан.");
	Словарь.Добавить("settings.hub.users.link.title", "Ссылка для «%1»");
	Словарь.Добавить("settings.hub.users.link.lead", "Передайте её человеку любым способом: почты хаб"
		+ " не отправляет. Второй раз ссылка не покажется — потерянную заменит «Сбросить пароль».");
	Словарь.Добавить("settings.hub.users.link.label", "Ссылка установки пароля");

	// отказы раздела «Пользователи»: причина домена словами, без служебного кода
	Словарь.Добавить("settings.hub.users.error.role", "Роль НЕ изменена: %1.");
	Словарь.Добавить("settings.hub.users.error.activity.block", "Учётная запись НЕ заблокирована: %1.");
	Словарь.Добавить("settings.hub.users.error.activity.unblock", "Учётная запись НЕ разблокирована: %1.");
	Словарь.Добавить("settings.hub.users.error.link", "Ссылка НЕ выпущена: %1.");
	Словарь.Добавить("settings.hub.users.error.delete", "Учётная запись НЕ удалена: %1.");
	Словарь.Добавить("settings.hub.users.error.delete.failed", "Учётная запись НЕ удалена: операция"
		+ " сорвалась, и ничего не тронуто. Чаще всего отказывает файловое хранилище пула. Подробность: %1");
	Словарь.Добавить("settings.hub.users.reason.missing", "учётная запись не найдена, возможно, её уже удалили");
	Словарь.Добавить("settings.hub.users.reason.retry", "операция не выполнена, попробуйте ещё раз");
	Словарь.Добавить("settings.hub.users.reason.role.self", "свою роль изменить нельзя — это мгновенный само-локаут");
	Словарь.Добавить("settings.hub.users.reason.role.unknown", "такой роли на хабе нет");
	Словарь.Добавить("settings.hub.users.reason.role.admin", "роль хаба меняет только администратор");
	Словарь.Добавить("settings.hub.users.reason.activity.self", "себя заблокировать нельзя — это мгновенный само-локаут");
	Словарь.Добавить("settings.hub.users.reason.activity.nologin", "в эту учётку нечем войти: ни пароля,"
		+ " ни привязанного провайдера. Выпустите ссылку установки пароля");
	Словарь.Добавить("settings.hub.users.reason.activity.admin", "активность учёток меняет только администратор");
	Словарь.Добавить("settings.hub.users.reason.link.admin", "учётки заводит и ссылки выпускает только"
		+ " администратор хаба");
	Словарь.Добавить("settings.hub.users.reason.link.key", "ключом доступа учётки не заводят — только"
		+ " из браузера по сессии");
	Словарь.Добавить("settings.hub.users.reason.link.onboarding", "хаб ещё не настроен: сначала мастер"
		+ " первого запуска");
	Словарь.Добавить("settings.hub.users.reason.link.password", "вход по логину и паролю на хабе выключен,"
		+ " и заданный по ссылке пароль никого не пустит. Заводите людей через провайдера входа либо"
		+ " включите парольный вход");
	Словарь.Добавить("settings.hub.users.reason.delete.self", "себя удалить нельзя — вернуть учётку будет нечем");
	Словарь.Добавить("settings.hub.users.reason.delete.last", "это последний администратор хаба: сначала"
		+ " назначьте другого");
	Словарь.Добавить("settings.hub.users.reason.delete.admin", "учётные записи удаляет только администратор");

	// раздел «Группы»: таблица с отбором и страницами, меню ⚙ строки, окно и подтверждение
	Словарь.Добавить("settings.hub.groups.title", "Группы");
	Словарь.Добавить("settings.hub.groups.lead", "Группа — субъект прав: право группы действует"
		+ " для всех её участников.");
	Словарь.Добавить("settings.hub.groups.add", "Добавить группу");
	Словарь.Добавить("settings.hub.groups.filter.search", "Поиск");
	Словарь.Добавить("settings.hub.groups.filter.search.example", "Имя или описание группы");
	Словарь.Добавить("settings.hub.groups.col.name", "Группа");
	Словарь.Добавить("settings.hub.groups.col.description", "Описание");
	Словарь.Добавить("settings.hub.groups.col.members", "Участников");
	Словарь.Добавить("settings.hub.groups.col.actions", "Действия");
	Словарь.Добавить("settings.hub.groups.empty", "Групп пока нет.");
	Словарь.Добавить("settings.hub.groups.empty.filter", "По запросу «%1» ничего не найдено.");
	Словарь.Добавить("settings.hub.groups.menu", "Действия над группой «%1»");
	Словарь.Добавить("settings.hub.groups.action.settings", "Настройки группы");
	Словарь.Добавить("settings.hub.groups.action.delete", "Удалить");
	Словарь.Добавить("settings.hub.groups.new.title", "Новая группа");
	Словарь.Добавить("settings.hub.groups.new.lead", "Имя уникально и попадает в адрес настроек группы.");
	Словарь.Добавить("settings.hub.groups.new.name", "Имя группы");
	Словарь.Добавить("settings.hub.groups.new.name.hint", "Регистр не важен: имя приводится к строчному");
	Словарь.Добавить("settings.hub.groups.new.name.required", "Укажите имя группы");
	Словарь.Добавить("settings.hub.groups.new.description", "Описание");
	Словарь.Добавить("settings.hub.groups.new.button", "Создать");
	Словарь.Добавить("settings.hub.groups.delete.title", "Удалить группу «%1»?");
	Словарь.Добавить("settings.hub.groups.delete.consequence", "Снимутся её права доступа, роли на пулах"
		+ " и связки с провайдером входа. %1");
	Словарь.Добавить("settings.hub.groups.delete.members.none", "Участников у группы нет.");
	Словарь.Добавить("settings.hub.groups.delete.members.one", "%1 участник останется в хабе.");
	Словарь.Добавить("settings.hub.groups.delete.members.few", "%1 участника останутся в хабе.");
	Словарь.Добавить("settings.hub.groups.delete.members.many", "%1 участников останутся в хабе.");
	Словарь.Добавить("settings.hub.groups.delete.echo", "Введите имя группы");
	Словарь.Добавить("settings.hub.groups.delete.echo.mismatch", "Имя не совпало: наберите «%1» точно так,"
		+ " как оно написано.");
	Словарь.Добавить("settings.hub.groups.error.exists", "Группа «%1» уже существует");
	Словарь.Добавить("settings.hub.groups.error.missing", "Группы «%1» нет: возможно, её уже удалили.");

	Словарь.Добавить("settings.hub.maintenance.lead", "Витрины инсталляции и фоновые механизмы.");
	Словарь.Добавить("settings.hub.metrics.title", "Счётчики инсталляции");
	Словарь.Добавить("settings.hub.maintenance.row.users", "Пользователей");
	Словарь.Добавить("settings.hub.maintenance.row.pools", "Пулов");

	Словарь.Добавить("settings.guard.hub.forbidden",
		"Раздел настроек хаба доступен только администратору хаба");

	Словарь.Добавить("subscriptions.hub.lead",
		"Подписка хаба получает события ВСЕХ пулов инсталляции, включая приватные. Поток"
		+ " прекращается, как только заведший подписку перестаёт быть администратором хаба.");

КонецПроцедуры

// Значения настроек: класс настройки и источник значения.
Процедура КлючиЗначенийНастроек(Словарь)

	Словарь.Добавить("settings.values.editable.note", "Изменения записываются в журнал аудита.");
	Словарь.Добавить("settings.values.occupied.lead",
		"Значения этого раздела сейчас задаёт конфигурация инсталляции.");

	Словарь.Добавить("settings.source.config", "из конфигурации");
	Словарь.Добавить("settings.source.db", "изменено");
	Словарь.Добавить("settings.source.default", "по умолчанию");
	Словарь.Добавить("settings.source.title", "%1 · %2");
	Словарь.Добавить("settings.source.reset", "Сбросить «%1»");
	Словарь.Добавить("settings.source.reset.title", "Сбросить к значению по умолчанию");

	Словарь.Добавить("settings.value.locked.forced",
		"Задано конфигурацией: уберите ключ %1 или переменную %2 — поле снова станет "
		+ "редактируемым, рестарт не нужен.");
	Словарь.Добавить("settings.value.yes", "Да");
	Словарь.Добавить("settings.value.no", "Нет");
	Словарь.Добавить("settings.value.on", "включено");
	Словарь.Добавить("settings.value.off", "выключено");
	Словарь.Добавить("settings.value.empty", "не задано");
	Словарь.Добавить("settings.value.secret.set",
		"Значение задано; пустое поле оставит его как есть, стирает сброс.");
	Словарь.Добавить("settings.value.secret.empty",
		"Значение не задано. Введённое сохранится в базе хаба; не хотите держать секрет в базе "
		+ "— задайте переменную окружения.");

КонецПроцедуры

// Метки и подсказки ключей настроек; ключ словаря выводится из ключа настройки.
Процедура КлючиНастроекРеестра(Словарь)

	Словарь.Добавить("settings.key.oshub-port.label", "Порт");
	Словарь.Добавить("settings.key.oshub-port.hint", "Порт HTTP-сервера хаба.");
	Словарь.Добавить("settings.key.oshub-instance-trusted-proxies.label", "Доверенные прокси");
	Словарь.Добавить("settings.key.oshub-instance-trusted-proxies.hint",
		"Сети обратных прокси этой инсталляции в записи CIDR через запятую"
		+ " (10.0.0.0/8, 2001:db8::/32). Только с этих адресов хаб читает заголовки"
		+ " пересылки и считает клиентом адрес человека, а не адрес прокси."
		+ " Пусто — заголовки не читаются вовсе: написать в них чужой адрес может кто угодно.");
	Словарь.Добавить("settings.key.oshub-instance-url.label", "Адрес хаба");
	Словарь.Добавить("settings.key.oshub-instance-url.hint",
		"Схема, хост и порт. Из него выводится адрес возврата для провайдеров входа.");
	Словарь.Добавить("settings.key.oshub-instance-url.help",
		"Внешний адрес хаба вида https://hub.example.com — только схема, хост и порт,"
		+ " без пути. Из него хаб выводит адрес возврата (redirect_uri) провайдеров входа."
		+ " Пусто — адрес возврата придётся вносить руками у каждого провайдера.");
	Словарь.Добавить("settings.key.oshub-instance-opm-default-hub.label", "opm знает этот хаб по умолчанию");
	Словарь.Добавить("settings.key.oshub-instance-opm-default-hub.hint",
		"Для hub.oscript.io: пакеты основного пула не просят прописать хаб в opm.cfg.");
	Словарь.Добавить("settings.key.oshub-instance-opm-default-hub.help",
		"Включите на хабе, которым opm пользуется без настройки (hub.oscript.io): для пакетов"
		+ " основного публичного пула хаб перестанет предлагать прописать себя в opm.cfg.");

	Словарь.Добавить("settings.key.oshub-ui-theme.label", "Тема по умолчанию");
	Словарь.Добавить("settings.key.oshub-ui-theme.hint",
		"Тема инсталляции: тёмная (по умолчанию) или светлая. Посетитель может выбрать свою.");
	Словарь.Добавить("settings.key.oshub-ui-preset.label", "Пресет темы");
	Словарь.Добавить("settings.key.oshub-ui-preset.hint",
		"Цвета сайта для всех посетителей: «Как было», «Новая» или «oscript». Свой акцент ложится поверх.");
	Словарь.Добавить("settings.key.oshub-ui-accent.label", "Акцент по умолчанию");
	Словарь.Добавить("settings.key.oshub-ui-accent.hint",
		"Цвет акцента в формате #rrggbb; пусто — акцент пресета.");
	Словарь.Добавить("settings.key.oshub-ui-brand.label", "Название хаба");
	Словарь.Добавить("settings.key.oshub-ui-brand.hint",
		"В шапке, во вкладке и в подвале; пусто — название по умолчанию.");
	Словарь.Добавить("settings.key.oshub-ui-brand.help",
		"Знак инсталляции: печатается в шапке, в заголовке вкладки и в подвале."
		+ " Пустое поле вернёт название по умолчанию.");
	Словарь.Добавить("settings.key.oshub-ui-tagline.label", "Подпись в подвале");
	Словарь.Добавить("settings.key.oshub-ui-tagline.hint",
		"Одно предложение в подвале; пусто — подпись по умолчанию.");
	Словарь.Добавить("settings.key.oshub-ui-tagline.help",
		"Одно предложение о том, что это за хаб; печатается в подвале каждой страницы."
		+ " Пустое поле вернёт подпись по умолчанию.");
	Словарь.Добавить("settings.key.oshub-ui-show-name.label", "Название рядом с логотипом");
	Словарь.Добавить("settings.key.oshub-ui-show-name.hint",
		"Выключите, если название уже нарисовано на логотипе.");
	Словарь.Добавить("settings.key.oshub-ui-show-name.help",
		"Печатать ли название хаба текстом справа от логотипа. Выключите, если на"
		+ " загруженном логотипе название уже нарисовано.");
	Словарь.Добавить("settings.key.oshub-ui-asset-max-bytes.label", "Потолок картинки, байт");
	Словарь.Добавить("settings.key.oshub-ui-asset-max-bytes.hint",
		"Сколько байт разрешено загружать в логотип и иконку. Картинки лежат в базе"
		+ " хаба, поэтому потолок бережёт и базу, и время отклика страниц.");

	Словарь.Добавить("settings.key.oshub-auth-registration-mode.label", "Режим регистрации");
	Словарь.Добавить("settings.key.oshub-auth-registration-mode.hint",
		"open — открытая, invite — по приглашению, disabled — выключена.");
	Словарь.Добавить("settings.key.oshub-auth-session-ttlseconds.label", "TTL сессии, секунд");
	Словарь.Добавить("settings.key.oshub-auth-session-ttlseconds.hint",
		"Через сколько сессия браузера перестаёт действовать.");
	Словарь.Добавить("settings.key.oshub-auth-login-maxattempts.label", "Попыток входа до блокировки");
	Словарь.Добавить("settings.key.oshub-auth-login-maxattempts.hint",
		"Сколько неудачных попыток пароля подряд допускается.");
	Словарь.Добавить("settings.key.oshub-auth-login-lockoutseconds.label", "Блокировка входа, секунд");
	Словарь.Добавить("settings.key.oshub-auth-login-lockoutseconds.hint",
		"На сколько блокируется вход после исчерпания попыток.");
	Словарь.Добавить("settings.key.oshub-auth-invite-ttl-days.label", "Срок ссылки на пароль, дней");
	Словарь.Добавить("settings.key.oshub-auth-invite-ttl-days.hint",
		"Сколько живёт одноразовая ссылка, которой администратор приглашает нового"
		+ " пользователя или сбрасывает пароль существующему. По истечении срока ссылка"
		+ " перестаёт работать, и её выпускают заново.");
	Словарь.Добавить("settings.key.oshub-auth-token-cli-days.label", "Срок токена opm login, дней");
	Словарь.Добавить("settings.key.oshub-auth-token-cli-days.hint",
		"Сколько живёт ключ, который забирает opm login. Больше потолка не выдаётся.");
	Словарь.Добавить("settings.key.oshub-auth-token-max-days.label", "Потолок срока токена, дней");
	Словарь.Добавить("settings.key.oshub-auth-token-max-days.hint",
		"Наибольший срок ручного выпуска токена. Бессрочных токенов хаб не выпускает.");

	Словарь.Добавить("settings.key.oshub-auth-password-enabled.label", "Вход по логину и паролю");
	Словарь.Добавить("settings.key.oshub-auth-password-enabled.hint",
		"Выключение оставит вход только через провайдеров.");
	Словарь.Добавить("settings.key.oshub-auth-password-enabled.help",
		"Работает ли на хабе форма логина и пароля. Выключение убирает поля со страницы"
		+ " входа и закрывает POST входа, вход в API и регистрацию с паролем; остаются"
		+ " только провайдеры. Выключить нельзя, пока некому будет войти. Аварийный"
		+ " возврат — OSHUB_AUTH_PASSWORD_ENABLED=true: значение конфигурации перебивает базу.");

	Словарь.Добавить("settings.key.oshub-admin-login.label", "Логин администратора");
	Словарь.Добавить("settings.key.oshub-admin-login.hint",
		"Учётная запись администратора, создаваемая при первом запуске.");
	Словарь.Добавить("settings.key.oshub-admin-password.label", "Пароль администратора");
	Словарь.Добавить("settings.key.oshub-admin-password.hint",
		"Задаётся только конфигурацией; в интерфейсе не показывается никогда.");
	Словарь.Добавить("settings.key.oshub-admin-password-file.label", "Файл с паролем администратора");
	Словарь.Добавить("settings.key.oshub-admin-password-file.hint",
		"Путь к файлу с паролем (docker secret) — альтернатива паролю в конфигурации.");

	Словарь.Добавить("settings.key.oshub-storage-backend.label", "Бэкенд хранилища");
	Словарь.Добавить("settings.key.oshub-storage-backend.hint",
		"file — файловая система, s3 — объектное хранилище.");
	Словарь.Добавить("settings.key.oshub-storage-root.label", "Каталог хранилища");
	Словарь.Добавить("settings.key.oshub-storage-root.hint", "Корень артефактов при бэкенде file.");
	Словарь.Добавить("settings.key.oshub-storage-quota-bytes.label", "Общая квота хранилища, байт");
	Словарь.Добавить("settings.key.oshub-storage-quota-bytes.hint",
		"Сколько места суммарно занимают артефакты хаба; 0 означает «без общего лимита».");
	Словарь.Добавить("settings.key.oshub-storage-health-ttl-sec.label", "Свежесть пробы хранилища, секунд");
	Словарь.Добавить("settings.key.oshub-storage-health-ttl-sec.hint",
		"Сколько хаб считает результат проверки доступности хранилища свежим, прежде чем"
		+ " спросить хранилище снова.");

	Словарь.Добавить("settings.key.oshub-publish-max-upload-bytes.label",
		"Максимальный размер загрузки, байт");
	Словарь.Добавить("settings.key.oshub-publish-max-upload-bytes.hint",
		"Предельный размер архива, принимаемого при публикации.");
	Словарь.Добавить("settings.key.oshub-publish-max-unpacked-bytes.label",
		"Максимальный размер распаковки, байт");
	Словарь.Добавить("settings.key.oshub-publish-max-unpacked-bytes.hint",
		"Предельный объём содержимого архива после распаковки (защита от zip-бомбы).");
	Словарь.Добавить("settings.key.oshub-publish-max-files.label", "Максимум файлов в пакете");
	Словарь.Добавить("settings.key.oshub-publish-max-files.hint",
		"Сколько файлов допускается внутри одного архива.");
	Словарь.Добавить("settings.key.oshub-publish-max-manifest-bytes.label",
		"Максимальный размер packagedef, байт");
	Словарь.Добавить("settings.key.oshub-publish-max-manifest-bytes.hint",
		"Предельный размер манифеста пакета.");
	Словарь.Добавить("settings.key.oshub-mirror-sync-enabled.label", "Фоновая синхронизация зеркал");
	Словарь.Добавить("settings.key.oshub-mirror-sync-enabled.hint",
		"Выключенная — зеркала стоят: ни расписание, ни кнопка их не запускают.");
	Словарь.Добавить("settings.key.oshub-mirror-sync-enabled.help",
		"Выключенная синхронизация не принимает заявок ни от расписания, ни от кнопки:"
		+ " зеркала стоят, пока её не включат обратно.");
	Словарь.Добавить("settings.key.oshub-mirror-max-per-pool.label", "Зеркал на один пул");
	Словарь.Добавить("settings.key.oshub-mirror-max-per-pool.hint",
		"Сколько зеркал разрешено завести в одном пуле.");
	Словарь.Добавить("settings.key.oshub-mirror-default-interval-sec.label",
		"Интервал синхронизации по умолчанию, сек");
	Словарь.Добавить("settings.key.oshub-mirror-default-interval-sec.hint",
		"Период, с которым синхронизируется зеркало, не задавшее свой.");
	Словарь.Добавить("settings.key.oshub-mirror-min-interval-sec.label",
		"Наименьший интервал синхронизации, сек");
	Словарь.Добавить("settings.key.oshub-mirror-min-interval-sec.hint",
		"Ниже этой границы зеркало не опустится, даже если попросит: защита апстрима"
		+ " и хаба от слишком частого пула.");
	Словарь.Добавить("settings.key.oshub-mirror-run-stale-sec.label",
		"Прогон считается брошенным после, сек");
	Словарь.Добавить("settings.key.oshub-mirror-run-stale-sec.hint",
		"Срок молчания, после которого прогон признаётся брошенным и зеркало снова"
		+ " принимает заявки. Живой обход отмечается на каждом перечисленном имени"
		+ " и на каждой перенесённой версии, поэтому единицы минут ему не мешают.");
	Словарь.Добавить("settings.key.oshub-mirror-max-packages-per-cycle.label",
		"Пакетов за цикл обхода");
	Словарь.Добавить("settings.key.oshub-mirror-max-packages-per-cycle.hint",
		"Сколько ИМЁН апстрима перечисляется за один цикл; версии отобранного имени"
		+ " переносятся целиком.");
	Словарь.Добавить("settings.key.oshub-mirror-max-cycles-per-run.label", "Циклов за плановый прогон");
	Словарь.Добавить("settings.key.oshub-mirror-max-cycles-per-run.hint",
		"Сколько циклов подряд делает один плановый прогон, прежде чем уступить очередь.");
	Словарь.Добавить("settings.key.oshub-mirror-queue-max.label", "Потолок очереди синхронизации");
	Словарь.Добавить("settings.key.oshub-mirror-queue-max.hint",
		"Сколько заявок на синхронизацию ждёт разбора; при переполнении отбрасываются"
		+ " старейшие.");
	Словарь.Добавить("settings.key.oshub-mirror-cycles-per-turn.label", "Циклов за заход рабочего");
	Словарь.Добавить("settings.key.oshub-mirror-cycles-per-turn.hint",
		"Сколько циклов рабочий отдаёт одному зеркалу за раз; недобранное зеркало"
		+ " возвращается в хвост очереди.");
	Словарь.Добавить("settings.key.oshub-mirror-queue-poll-sec.label", "Опрос очереди, сек");
	Словарь.Добавить("settings.key.oshub-mirror-queue-poll-sec.hint",
		"Как часто рабочий заглядывает в пустую очередь заявок.");

	Словарь.Добавить("settings.key.oshub-publish-github-legacy.label",
		"Публикация по токену GitHub (легаси)");
	Словарь.Добавить("settings.key.oshub-publish-github-legacy.hint",
		"Публикация в основной пул по токену GitHub — путь совместимости со старым хабом.");
	Словарь.Добавить("settings.key.oshub-publish-github-legacy.help",
		"Разрешает публиковать в ДЕФОЛТНЫЙ пул по токену GitHub с правом записи в"
		+ " репозиторий организации-зеркала (какой — задаёт oshub.publish.github.org) —"
		+ " путь совместимости со старым хабом. В остальных пулах не действует никогда."
		+ " Тот же переключатель раздаёт права, когда GitHub-личность ЗАВОДИТСЯ: при"
		+ " регистрации через GitHub и при привязке GitHub в кабинете. Человек получает роль"
		+ " мейнтейнера на пакетах дефолтного пула, чьи имена совпали с его ПУБЛИЧНЫМИ"
		+ " репозиториями организации-зеркала (приватные не учитываются)."
		+ " Включайте ДО того, как люди начнут входить: у того, кто уже входил через GitHub,"
		+ " личность заведена, и повторные входы прав ему не добавят — ему придётся отвязать"
		+ " и заново привязать GitHub в кабинете. Права выдаются НАВСЕГДА: ни выключение"
		+ " настройки, ни утрата доступа в GitHub их не отзывают, снимать роли придётся"
		+ " руками.");
	Словарь.Добавить("settings.key.oshub-publish-inbox-max-pending-per-pool.label",
		"Заявок во «входящих» на пул");
	Словарь.Добавить("settings.key.oshub-publish-inbox-max-pending-per-pool.hint",
		"Сколько заявок на публикацию пул держит на рассмотрении одновременно."
		+ " Ноль отключает приём заявок во всех пулах.");
	Словарь.Добавить("settings.key.oshub-publish-inbox-max-pending-per-user.label",
		"Заявок во «входящих» на автора");
	Словарь.Добавить("settings.key.oshub-publish-inbox-max-pending-per-user.hint",
		"Сколько заявок один пользователь держит на рассмотрении во всём хабе."
		+ " Ноль отключает приём заявок.");
	Словарь.Добавить("settings.key.oshub-publish-ci-audience.label",
		"Аудитория id-token доверенных конвейеров");
	Словарь.Добавить("settings.key.oshub-publish-ci-audience.hint",
		"Что конвейер запрашивает в audience id-token; пусто — адрес хаба.");
	Словарь.Добавить("settings.key.oshub-publish-ci-audience.help",
		"Значение, которое конвейер обязан запросить в audience при выпуске id-token, и"
		+ " которое хаб сверяет с клеймом aud. Пусто — берётся «Адрес хаба»; пока пусты"
		+ " оба, доверенные конвейеры не публикуют.");
	Словарь.Добавить("settings.key.oshub-publish-ci-issuers.label",
		"Дополнительные издатели доверенных конвейеров");
	Словарь.Добавить("settings.key.oshub-publish-ci-issuers.hint",
		"Издатели (iss) сверх GitHub Actions и GitLab.com через запятую; только https.");
	Словарь.Добавить("settings.key.oshub-publish-ci-issuers.help",
		"Адреса издателей (iss) через запятую СВЕРХ встроенных GitHub Actions и GitLab.com —"
		+ " нужны для self-hosted GitLab. Только https и только маршрутизируемые адреса:"
		+ " по этому адресу хаб ходит за ключами сам.");
	Словарь.Добавить("settings.key.oshub-pools-personal-enabled.label", "Личные пространства");
	Словарь.Добавить("settings.key.oshub-pools-personal-enabled.hint",
		"Личные пространства /{логин}; выключение сносит их вместе с пакетами.");
	Словарь.Добавить("settings.key.oshub-pools-personal-enabled.help",
		"Есть ли на хабе личные пространства /{логин}. Включение заводит пространство каждому"
		+ " существующему пользователю, выключение — сносит все личные пространства вместе"
		+ " с пакетами; выключение спрашивает подтверждение.");
	Словарь.Добавить("settings.key.oshub-pools-default-quota-mb.label", "Квота пула по умолчанию, МБ");
	Словарь.Добавить("settings.key.oshub-pools-default-quota-mb.hint",
		"Для пулов без своей квоты; 0 — без ограничения.");
	Словарь.Добавить("settings.key.oshub-pools-default-quota-mb.help",
		"Сколько места отводится пулу, не выставившему свою квоту. Ноль — хаб пулы"
		+ " не ограничивает. Пул с собственной квотой это значение не смотрит;"
		+ " квоту пула выставляет администратор хаба.");

	Словарь.Добавить("settings.key.oshub-jobs-enabled.label", "Фоновые задачи");
	Словарь.Добавить("settings.key.oshub-jobs-enabled.hint", "Планировщик обслуживания хаба.");
	Словарь.Добавить("settings.key.otel-enabled.label", "Телеметрия");
	Словарь.Добавить("settings.key.otel-enabled.hint", "Экспорт метрик и трасс OpenTelemetry.");
	Словарь.Добавить("settings.key.otel-exporter-otlp-endpoint.label", "Адрес коллектора");
	Словарь.Добавить("settings.key.otel-exporter-otlp-endpoint.hint",
		"Куда хаб отправляет телеметрию (OTLP over HTTP).");

КонецПроцедуры

// Метки и подсказки ключей подсистем: пароль, подписки, прокси, счётчики, задачи, OTel, S3.
Процедура КлючиНастроекПодсистем(Словарь)

	Словарь.Добавить("settings.key.oshub-auth-password-min-length.label", "Минимальная длина");
	Словарь.Добавить("settings.key.oshub-auth-password-min-length.hint",
		"Короче пароль не принимается; не больше максимальной длины.");
	Словарь.Добавить("settings.key.oshub-auth-password-min-length.help",
		"Короче этого пароль не принимается. Значение выше максимальной длины запирает"
		+ " вход, поэтому такое не сохраняется.");
	Словарь.Добавить("settings.key.oshub-auth-password-max-length.label", "Максимальная длина");
	Словарь.Добавить("settings.key.oshub-auth-password-max-length.hint",
		"Длиннее этого пароль отвергается сразу и не хешируется вовсе — это и защита"
		+ " от нагрузки гигантским вводом.");
	Словарь.Добавить("settings.key.oshub-auth-password-require-lowercase.label", "Требовать строчную букву");
	Словарь.Добавить("settings.key.oshub-auth-password-require-lowercase.hint",
		"Пароль обязан содержать хотя бы одну строчную букву.");
	Словарь.Добавить("settings.key.oshub-auth-password-require-uppercase.label", "Требовать заглавную букву");
	Словарь.Добавить("settings.key.oshub-auth-password-require-uppercase.hint",
		"Пароль обязан содержать хотя бы одну заглавную букву.");
	Словарь.Добавить("settings.key.oshub-auth-password-require-digit.label", "Требовать цифру");
	Словарь.Добавить("settings.key.oshub-auth-password-require-digit.hint",
		"Пароль обязан содержать хотя бы одну цифру.");
	Словарь.Добавить("settings.key.oshub-auth-password-require-special.label", "Требовать спецсимвол");
	Словарь.Добавить("settings.key.oshub-auth-password-require-special.hint",
		"Пароль обязан содержать хотя бы один символ, не являющийся буквой или цифрой.");

	Словарь.Добавить("settings.key.oshub-webhooks-delivery-enabled.label", "Доставка уведомлений");
	Словарь.Добавить("settings.key.oshub-webhooks-delivery-enabled.hint",
		"Общий рубильник доставки: выключенный хаб копит события, но никуда их не шлёт.");
	Словарь.Добавить("settings.key.oshub-webhooks-allow-insecure.label", "Разрешать http и непроверенный TLS");
	Словарь.Добавить("settings.key.oshub-webhooks-allow-insecure.hint",
		"Разрешает http и узлы с непроверяемым сертификатом.");
	Словарь.Добавить("settings.key.oshub-webhooks-allow-insecure.help",
		"Позволяет слать уведомления по http и на узлы с непроверяемым сертификатом."
		+ " Содержимое уведомления в этом случае идёт открытым текстом.");
	Словарь.Добавить("settings.key.oshub-webhooks-max-queue.label", "Потолок очереди доставки");
	Словарь.Добавить("settings.key.oshub-webhooks-max-queue.hint",
		"Сколько недоставленных уведомлений хаб хранит, прежде чем перестать принимать новые.");
	Словарь.Добавить("settings.key.oshub-webhooks-max-attempts.label", "Попыток доставки");
	Словарь.Добавить("settings.key.oshub-webhooks-max-attempts.hint",
		"Сколько раз хаб повторяет недоставленное уведомление, прежде чем сдаться.");
	Словарь.Добавить("settings.key.oshub-webhooks-backoff-base-sec.label", "Основание паузы повтора, секунд");
	Словарь.Добавить("settings.key.oshub-webhooks-backoff-base-sec.hint",
		"От этого числа растёт пауза между повторами: каждая следующая длиннее предыдущей.");
	Словарь.Добавить("settings.key.oshub-webhooks-delivery-interval-sec.label", "Разбор очереди, секунд");
	Словарь.Добавить("settings.key.oshub-webhooks-delivery-interval-sec.hint",
		"Как часто хаб заглядывает в очередь недоставленного.");
	Словарь.Добавить("settings.key.oshub-webhooks-delivery-timeout-sec.label", "Таймаут доставки вебхука, секунд");
	Словарь.Добавить("settings.key.oshub-webhooks-delivery-timeout-sec.hint",
		"Сколько хаб ждёт ответа адреса вебхука, прежде чем счесть попытку неудачной. Telegram ждёт"
		+ " срок oshub.storage.s3.timeout.sec.");
	Словарь.Добавить("settings.key.oshub-webhooks-test-max-per-hour.label", "Пробных отправок в час на подписку");
	Словарь.Добавить("settings.key.oshub-webhooks-test-max-per-hour.hint",
		"Потолок кнопки «Проверить»: сколько раз в час одну подписку разрешено дёргать"
		+ " вручную. Считается в памяти процесса, перезапуск потолок отпускает.");

	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-host.label", "Прокси Telegram: сервер");
	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-host.hint",
		"HTTP-прокси с CONNECT для api.telegram.org; пусто — напрямую.");
	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-host.help",
		"Имя или адрес HTTP-прокси, через который хаб обращается к api.telegram.org."
		+ " Пусто — хаб ходит в Bot API напрямую. Прокси действует только на уведомления"
		+ " Telegram: вебхуки, зеркала, почта и хранилище ходят как ходили. SOCKS платформа"
		+ " не поддерживает — нужен именно HTTP-прокси с методом CONNECT.");
	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-port.label", "Прокси Telegram: порт");
	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-port.hint",
		"Порт прокси-сервера. Пока сервер не задан, значение ни на что не влияет.");
	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-user.label", "Прокси Telegram: пользователь");
	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-user.hint",
		"Имя пользователя для входа на прокси. Пусто — прокси без аутентификации.");
	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-password.label", "Прокси Telegram: пароль");
	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-password.hint",
		"Пустое поле оставляет сохранённый пароль как есть.");
	Словарь.Добавить("settings.key.oshub-webhooks-telegram-proxy-password.help",
		"Секрет: поле открывается пустым, значение не показывается ни здесь, ни в API,"
		+ " ни в журнале, ни в тексте отказа доставки. Пустое поле оставляет сохранённый"
		+ " пароль как есть, стирает его кнопка сброса.");

	Словарь.Добавить("settings.key.oshub-proxy-offline.label", "Офлайн");
	Словарь.Добавить("settings.key.oshub-proxy-offline.hint",
		"Только из кэша, наружу не ходит: чего нет в кэше, то не найдётся.");
	Словарь.Добавить("settings.key.oshub-proxy-offline.help",
		"Хаб обслуживает запросы только из своего кэша и наружу не ходит вовсе. Пакет,"
		+ " которого в кэше нет, при включённом офлайне не найдётся.");
	Словарь.Добавить("settings.key.oshub-proxy-timeout-sec.label", "Таймаут похода в апстрим, секунд");
	Словарь.Добавить("settings.key.oshub-proxy-timeout-sec.hint",
		"Сколько хаб ждёт ответа чужого хаба, прежде чем счесть его недоступным.");
	Словарь.Добавить("settings.key.oshub-proxy-negative-ttl-sec.label", "Срок отрицательного ответа, секунд");
	Словарь.Добавить("settings.key.oshub-proxy-negative-ttl-sec.hint",
		"Сколько хаб помнит, что у источника такого пакета нет, не переспрашивая заново.");
	Словарь.Добавить("settings.key.oshub-proxy-upstream-recheck-ttl-sec.label",
		"Перепроверка живости источника, секунд");
	Словарь.Добавить("settings.key.oshub-proxy-upstream-recheck-ttl-sec.hint",
		"Как часто хаб заново выясняет, отвечает ли источник.");
	Словарь.Добавить("settings.key.oshub-upstream-probe-enabled.label", "Пробовать подключение к источнику");
	Словарь.Добавить("settings.key.oshub-upstream-probe-enabled.hint",
		"Перед сохранением источника хаб пробует к нему подключиться.");
	Словарь.Добавить("settings.key.oshub-upstream-probe-enabled.help",
		"Перед сохранением источника хаб пробует к нему подключиться и не сохраняет адрес,"
		+ " по которому не дозвонился. Выключайте, если инсталляции ходить наружу нечем.");
	Словарь.Добавить("settings.key.oshub-readme-repository-enabled.label", "README из репозитория пакета");
	Словарь.Добавить("settings.key.oshub-readme-repository-enabled.hint",
		"Без README в пакете хаб ищет его в репозитории на GitHub.");
	Словарь.Добавить("settings.key.oshub-readme-repository-enabled.help",
		"Если в пакете нет README, хаб ищет его в репозитории пакета на GitHub — на теге версии,"
		+ " затем в ветке по умолчанию. Выключайте, если инсталляции ходить наружу нечем.");
	Словарь.Добавить("settings.key.oshub-readme-repository-raw-url.label", "Адрес содержимого GitHub");
	Словарь.Добавить("settings.key.oshub-readme-repository-raw-url.hint",
		"Откуда хаб берёт файлы репозиториев на GitHub, когда ищет README.");
	Словарь.Добавить("settings.key.oshub-proxy-max-redirects.label", "Потолок перенаправлений");
	Словарь.Добавить("settings.key.oshub-proxy-max-redirects.hint",
		"Сколько переходов по Location хаб делает, прежде чем счесть цепочку бесконечной.");
	Словарь.Добавить("settings.key.oshub-jobs-upstream-health-interval-sec.label",
		"Проверка живости источников, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-upstream-health-interval-sec.hint",
		"Как часто хаб сам обходит источники пулов и зеркал, выясняя, отвечают ли они.");

	Словарь.Добавить("settings.key.oshub-publish-github-org.label", "Организация GitHub");
	Словарь.Добавить("settings.key.oshub-publish-github-org.hint",
		"Чьё членство даёт право публиковать по легаси-токену GitHub. Действует только"
		+ " при включённом легаси-пути.");

	Словарь.Добавить("settings.key.oshub-ui-audit-page-size.label", "Записей на странице журнала");
	Словарь.Добавить("settings.key.oshub-ui-audit-page-size.hint",
		"Сколько записей аудита показывается на одной странице журнала.");
	Словарь.Добавить("settings.key.oshub-cache-guest-pages.label", "Кэш страниц гостя");
	Словарь.Добавить("settings.key.oshub-cache-guest-pages.hint",
		"Гость получает страницы каталога из памяти хаба, не старше минуты. Выключение действует сразу.");
	Словарь.Добавить("settings.key.oshub-api-page-size.label", "Размер страницы API");
	Словарь.Добавить("settings.key.oshub-api-page-size.hint",
		"Сколько элементов отдаёт списковая ручка API, когда клиент не назвал размер"
		+ " страницы сам.");
	Словарь.Добавить("settings.key.oshub-api-page-max.label", "Потолок страницы API");
	Словарь.Добавить("settings.key.oshub-api-page-max.hint",
		"Сколько элементов списковая ручка API отдаёт в одном ответе максимум, каким бы"
		+ " большим ни был запрошенный размер страницы.");
	Словарь.Добавить("settings.key.oshub-stats-flush-interval-sec.label", "Сброс счётчиков, секунд");
	Словарь.Добавить("settings.key.oshub-stats-flush-interval-sec.hint",
		"Как часто накопленные счётчики скачиваний уезжают в базу.");
	Словарь.Добавить("settings.key.oshub-stats-flush-threshold.label", "Досрочный сброс счётчиков, событий");
	Словарь.Добавить("settings.key.oshub-stats-flush-threshold.hint",
		"Сколько накопленных событий сбрасывают счётчики, не дожидаясь срока.");

	Словарь.Добавить("settings.key.oshub-jobs-tick-interval-ms.label", "Период тика планировщика, мс");
	Словарь.Добавить("settings.key.oshub-jobs-tick-interval-ms.hint",
		"Как часто планировщик проверяет, не пора ли запускать задачу.");
	Словарь.Добавить("settings.key.oshub-jobs-readme-reindex-hour.label", "Час актуализации описаний");
	Словарь.Добавить("settings.key.oshub-jobs-readme-reindex-hour.hint",
		"В какой час суток (0–23) хаб обходит пакеты и обновляет на диске README тех версий,"
		+ " которые отдаёт установка без версии.");
	Словарь.Добавить("settings.key.oshub-jobs-mirror-sync-interval-sec.label",
		"Побудка синхронизации зеркал, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-mirror-sync-interval-sec.hint",
		"Как часто планировщик будит синхронизацию зеркал. Свой период каждого зеркала"
		+ " задаётся отдельно и чаще этой побудки не сработает.");
	Словарь.Добавить("settings.key.oshub-jobs-proxy-gc-interval-sec.label", "Уборка кэша прокси, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-proxy-gc-interval-sec.hint",
		"Как часто хаб выбрасывает из кэша апстрима устаревшее.");
	Словарь.Добавить("settings.key.oshub-jobs-cli-device-gc-interval-sec.label",
		"Уборка кодов входа CLI, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-cli-device-gc-interval-sec.hint",
		"Как часто хаб удаляет протухшие коды входа opm login.");
	Словарь.Добавить("settings.key.oshub-jobs-invite-gc-interval-sec.label",
		"Уборка приглашений, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-invite-gc-interval-sec.hint",
		"Как часто хаб удаляет протухшие приглашения и ссылки установки пароля.");
	Словарь.Добавить("settings.key.oshub-jobs-pool-volume-audit-interval-sec.label",
		"Пересчёт объёма пулов, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-pool-volume-audit-interval-sec.hint",
		"Как часто хаб сверяет учтённый объём пулов с фактическим.");
	Словарь.Добавить("settings.key.oshub-jobs-incidents-gc-interval-sec.label",
		"Уборка происшествий, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-incidents-gc-interval-sec.hint",
		"Как часто хаб удаляет записи о неудачах, у которых вышел срок жизни.");
	Словарь.Добавить("settings.key.oshub-jobs-storage-health-interval-sec.label",
		"Проверка доступности хранилища, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-storage-health-interval-sec.hint",
		"Как часто хаб сам спрашивает хранилище артефактов, отвечает ли оно.");
	Словарь.Добавить("settings.key.oshub-jobs-registry-gc-interval-sec.label",
		"Уборка реестра фоновых заданий, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-registry-gc-interval-sec.hint",
		"Как часто хаб снимает записи отработавших фоновых заданий: сами они реестр"
		+ " не покидают и занимают память процесса до перезапуска.");

	Словарь.Добавить("settings.key.oshub-incidents-max-per-object.label", "Причин на один объект");
	Словарь.Добавить("settings.key.oshub-incidents-max-per-object.hint",
		"Сколько разных причин неудач хаб помнит по одному объекту; всё сверх этого"
		+ " сводится в одну строку «прочее» со счётчиком.");
	Словарь.Добавить("settings.key.oshub-incidents-ttl-sec.label", "Срок жизни причины, секунд");
	Словарь.Добавить("settings.key.oshub-incidents-ttl-sec.hint",
		"Сколько живёт запись о неудаче с момента последнего повтора.");

	Словарь.Добавить("settings.key.oshub-jobs-geo-update-interval-sec.label",
		"Заход за базой стран, секунд");
	Словарь.Добавить("settings.key.oshub-jobs-geo-update-interval-sec.hint",
		"Как часто хаб проверяет базу стран посетителей: замечает положенный руками файл"
		+ " и, если обновление разрешено, идёт за новым выпуском.");
	Словарь.Добавить("settings.key.oshub-geo-db-path.label", "Файл базы стран");
	Словарь.Добавить("settings.key.oshub-geo-db-path.hint",
		"Где лежит база диапазонов адресов по странам. Пусто — каталог «гео» в корне данных"
		+ " инсталляции.");
	Словарь.Добавить("settings.key.oshub-geo-header.label", "Заголовок страны от прокси");
	Словарь.Добавить("settings.key.oshub-geo-header.hint",
		"Каким заголовком обратный прокси называет страну посетителя. Заголовку верят только"
		+ " с доверенных сетей; пусто — не читать его вовсе.");
	Словарь.Добавить("settings.key.oshub-geo-source-order.label", "Порядок источников страны");
	Словарь.Добавить("settings.key.oshub-geo-source-order.hint",
		"Кого хаб спрашивает первым: «база-прокси» — сначала встроенную базу,"
		+ " «прокси-база» — сначала заголовок доверенного прокси.");
	Словарь.Добавить("settings.key.oshub-geo-update-enabled.label", "Обновлять базу стран из сети");
	Словарь.Добавить("settings.key.oshub-geo-update-enabled.hint",
		"Разрешает хабу ходить за новым выпуском базы. Выключено — базу кладут файлом,"
		+ " и хаб подхватывает её сам.");
	Словарь.Добавить("settings.key.oshub-geo-update-url.label", "Адрес выпуска базы стран");
	Словарь.Добавить("settings.key.oshub-geo-update-url.hint",
		"Шаблон адреса, откуда берётся выпуск: {ГОД} и {МЕСЯЦ} подставляет хаб.");

	Словарь.Добавить("settings.key.otel-exporter-otlp-protocol.label", "Протокол выгрузки");
	Словарь.Добавить("settings.key.otel-exporter-otlp-protocol.hint",
		"Каким протоколом хаб отдаёт телеметрию сборщику: http/protobuf, http/json или grpc.");
	Словарь.Добавить("settings.key.otel-service-name.label", "Имя службы в трассах");
	Словарь.Добавить("settings.key.otel-service-name.hint",
		"Под этим именем инсталляция видна в трассах сборщика.");
	Словарь.Добавить("settings.key.otel-traces-sampler.label", "Правило отбора трасс");
	Словарь.Добавить("settings.key.otel-traces-sampler.hint",
		"Чем хаб решает, какие трассы оставить. Долю ниже учитывают только"
		+ " traceidratio и parentbased_traceidratio.");
	Словарь.Добавить("settings.key.otel-traces-sampler-arg.label", "Доля отбираемых трасс");
	Словарь.Добавить("settings.key.otel-traces-sampler-arg.hint",
		"Какая доля запросов попадает в трассы: 1.0 — все, 0.1 — каждый десятый."
		+ " Работает при правиле отбора traceidratio или parentbased_traceidratio.");
	Словарь.Добавить("settings.key.otel-bsp-schedule-delay.label", "Период выгрузки, миллисекунд");
	Словарь.Добавить("settings.key.otel-bsp-schedule-delay.hint",
		"Как часто накопленные спаны уезжают сборщику.");
	Словарь.Добавить("settings.key.otel-bsp-max-queue-size.label", "Потолок буфера спанов");
	Словарь.Добавить("settings.key.otel-bsp-max-queue-size.hint",
		"Сколько спанов хаб держит в памяти до выгрузки; лишние отбрасываются.");
	Словарь.Добавить("settings.key.otel-exporter-otlp-timeout.label", "Таймаут выгрузки, миллисекунд");
	Словарь.Добавить("settings.key.otel-exporter-otlp-timeout.hint",
		"Сколько хаб ждёт ответа сборщика телеметрии.");
	Словарь.Добавить("settings.key.otel-exporter-otlp-insecure.label", "Не проверять сертификат сборщика");
	Словарь.Добавить("settings.key.otel-exporter-otlp-insecure.hint",
		"Ослабление безопасности: телеметрия уедет и на узел с неподтверждённым сертификатом.");
	Словарь.Добавить("settings.key.otel-traces-exporter.label", "Выгрузка трасс");
	Словарь.Добавить("settings.key.otel-traces-exporter.hint",
		"otlp — трассы уезжают сборщику, none — не уезжают. Остальные два сигнала"
		+ " продолжают работать.");
	Словарь.Добавить("settings.key.otel-metrics-exporter.label", "Выгрузка метрик");
	Словарь.Добавить("settings.key.otel-metrics-exporter.hint",
		"otlp — метрики уезжают сборщику, none — не уезжают. Остальные два сигнала"
		+ " продолжают работать.");
	Словарь.Добавить("settings.key.otel-logs-exporter.label", "Выгрузка журнала");
	Словарь.Добавить("settings.key.otel-logs-exporter.hint",
		"otlp — строки журнала уезжают сборщику, none — не уезжают. В консоль инсталляции"
		+ " журнал пишется в любом случае.");
	Словарь.Добавить("settings.key.otel-metric-export-interval.label", "Период среза метрик, миллисекунд");
	Словарь.Добавить("settings.key.otel-metric-export-interval.hint",
		"Как часто снимаются и уезжают показания приборов: метрики уходят срезом"
		+ " по расписанию, а не партией по событию.");

	Словарь.Добавить("settings.key.otel-entity-enabled.label", "Телеметрия базы данных");
	Словарь.Добавить("settings.key.otel-entity-enabled.hint",
		"Спаны и метрики обращений к базе. Пусто — как телеметрия целиком;"
		+ " false выключает их, оставив остальные сигналы.");
	Словарь.Добавить("settings.key.otel-entity-repository-enabled.label", "Замер вызовов хранилищ");
	Словарь.Добавить("settings.key.otel-entity-repository-enabled.hint",
		"Длительность вызовов хранилищ сущностей отдельной гистограммой."
		+ " Пусто — как телеметрия целиком.");
	Словарь.Добавить("settings.key.otel-entity-query-text.label", "Текст запроса в спане");
	Словарь.Добавить("settings.key.otel-entity-query-text.hint",
		"Класть SQL запроса в атрибут спана. По умолчанию выключено: произвольный"
		+ " текст запроса может нести значения полей. Текст дают только SQL-бэкенды"
		+ " (SQLite, PostgreSQL); на файловой базе спан текста не несёт.");

	Словарь.Добавить("settings.key.oshub-storage-s3-endpoint.label", "Адрес хранилища S3");
	Словарь.Добавить("settings.key.oshub-storage-s3-endpoint.hint",
		"Куда хаб кладёт артефакты при бэкенде s3.");
	Словарь.Добавить("settings.key.oshub-storage-s3-bucket.label", "Корзина S3");
	Словарь.Добавить("settings.key.oshub-storage-s3-bucket.hint", "Имя корзины, в которой лежат артефакты.");
	Словарь.Добавить("settings.key.oshub-storage-s3-region.label", "Регион S3");
	Словарь.Добавить("settings.key.oshub-storage-s3-region.hint", "Регион корзины.");
	Словарь.Добавить("settings.key.oshub-storage-s3-prefix.label", "Префикс ключей S3");
	Словарь.Добавить("settings.key.oshub-storage-s3-prefix.hint",
		"Под каким префиксом внутри корзины лежат ключи артефактов.");
	Словарь.Добавить("settings.key.oshub-storage-s3-force-path-style.label", "Адресация путём");
	Словарь.Добавить("settings.key.oshub-storage-s3-force-path-style.hint",
		"Обращаться к корзине путём, а не поддоменом. Нужно хранилищам вроде MinIO.");
	Словарь.Добавить("settings.key.oshub-storage-s3-timeout-sec.label", "Срок ответа S3, секунд");
	Словарь.Добавить("settings.key.oshub-storage-s3-timeout-sec.hint",
		"Сколько хаб ждёт ответа корзины на каждый запрос — и на пробе доступности, — прежде чем"
		+ " счесть её недоступной; столько же ждёт и Telegram. В срок должна уложиться отправка каждой"
		+ " части загрузки (5 МиБ); скачивание, начавшееся в срок, он не обрывает.");
	Словарь.Добавить("settings.key.oshub-storage-s3-access-key.label", "Ключ доступа S3");
	Словарь.Добавить("settings.key.oshub-storage-s3-access-key.hint",
		"Задаётся только конфигурацией; в интерфейсе не показывается никогда.");
	Словарь.Добавить("settings.key.oshub-storage-s3-access-key-file.label", "Файл с ключом доступа S3");
	Словарь.Добавить("settings.key.oshub-storage-s3-access-key-file.hint",
		"Путь к файлу с ключом (docker secret) — альтернатива ключу в конфигурации.");
	Словарь.Добавить("settings.key.oshub-storage-s3-secret-key.label", "Секретный ключ S3");
	Словарь.Добавить("settings.key.oshub-storage-s3-secret-key.hint",
		"Задаётся только конфигурацией; в интерфейсе не показывается никогда.");
	Словарь.Добавить("settings.key.oshub-storage-s3-secret-key-file.label", "Файл с секретным ключом S3");
	Словарь.Добавить("settings.key.oshub-storage-s3-secret-key-file.hint",
		"Путь к файлу с ключом (docker secret) — альтернатива ключу в конфигурации.");

КонецПроцедуры

// Раздел «Провайдеры входа»: реестр провайдеров, окна провайдера, правило по странам, удаление.
Процедура КлючиПровайдеровВхода(Словарь)

	Словарь.Добавить("providers.section.title", "Провайдеры входа");
	Словарь.Добавить("providers.section.lead", "Кнопки на странице входа и привязки учётных записей.");
	Словарь.Добавить("providers.section.add", "Добавить провайдера");
	Словарь.Добавить("providers.list.empty", "Провайдеров входа пока нет.");

	// запись реестра
	Словарь.Добавить("providers.badge.kind", "%1 · %2");
	Словарь.Добавить("providers.badge.oauth2", "OAuth2");
	Словарь.Добавить("providers.badge.oidc", "OIDC");
	Словарь.Добавить("providers.badge.config", "из конфигурации");
	Словарь.Добавить("providers.badge.closed.one", "закрыт в %1 стране");
	Словарь.Добавить("providers.badge.closed.many", "закрыт в %1 странах");
	Словарь.Добавить("providers.badge.closed.all", "закрыт всем");
	Словарь.Добавить("providers.state.on", "включён");
	Словарь.Добавить("providers.state.off", "выключен");
	Словарь.Добавить("providers.entry.button", "Кнопка «%1»");
	Словарь.Добавить("providers.toggle.label", "Провайдер %1 включён");
	Словарь.Добавить("providers.prop.kind", "провайдер");
	Словарь.Добавить("providers.prop.client", "client_id");
	Словарь.Добавить("providers.prop.redirect", "redirect_uri");
	Словарь.Добавить("providers.prop.issuer", "издатель");
	Словарь.Добавить("providers.prop.scope", "области");
	Словарь.Добавить("providers.prop.accounts", "учётки");
	Словарь.Добавить("providers.prop.countries", "страны");
	Словарь.Добавить("providers.policy.autoprovision", "создавать при первом входе");
	Словарь.Добавить("providers.policy.linked", "только привязанные учётки");
	Словарь.Добавить("providers.policy.groups", "группы из клейма %1");
	Словарь.Добавить("providers.policy.link", "клейм %1 связывается с группами по имени");
	Словарь.Добавить("providers.policy.prefix", "префикс групп %1");
	Словарь.Добавить("providers.redirect.unset.short", "не определён — задайте адрес хаба");

	Словарь.Добавить("providers.button.edit", "Изменить");
	Словарь.Добавить("providers.button.view", "Подробнее");
	Словарь.Добавить("providers.button.create", "Добавить");
	Словарь.Добавить("providers.button.save", "Сохранить");
	Словарь.Добавить("providers.button.delete", "Удалить");

	// окна провайдера: «Новый провайдер» шагами, «Изменить» вкладками, просмотр из конфигурации
	Словарь.Добавить("providers.window.new", "Новый провайдер");
	Словарь.Добавить("providers.window.edit", "Провайдер %1");
	Словарь.Добавить("providers.window.view", "Провайдер %1");
	Словарь.Добавить("providers.locked.lead",
		"Задан конфигурацией инсталляции (переменные OSHUB_OIDC_*): меняется там, а не здесь.");
	Словарь.Добавить("providers.step.provider", "Провайдер");
	Словарь.Добавить("providers.step.accounts", "Учётки и группы");
	Словарь.Добавить("providers.field.preset", "Пресет");
	Словарь.Добавить("providers.preset.own", "свой");
	Словарь.Добавить("providers.field.name", "Имя");
	Словарь.Добавить("providers.field.name.hint", "Латиницей; попадёт в адрес входа");
	Словарь.Добавить("providers.field.client.help",
		"Идентификатор приложения, которое вы зарегистрировали у провайдера (OAuth App у GitHub,"
		+ " Application у GitLab, OAuth client у Google).");
	Словарь.Добавить("providers.field.secret", "client_secret");
	Словарь.Добавить("providers.field.secret.help",
		"Секрет того же приложения. Хаб хранит его и никогда не показывает: чтобы сменить,"
		+ " введите новый.");
	Словарь.Добавить("providers.field.secret.keep", "Пусто — оставить прежний секрет");
	Словарь.Добавить("providers.redirect.note", "Адрес возврата — укажите его в приложении у провайдера");
	Словарь.Добавить("providers.redirect.unset",
		"Адрес возврата не определён: задайте адрес хаба в разделе «Основное»"
		+ " или впишите адрес под «Свой адрес возврата».");
	Словарь.Добавить("providers.redirect.own", "Свой адрес возврата");
	Словарь.Добавить("providers.window.more", "Дополнительно: подпись и значок");
	Словарь.Добавить("providers.field.label", "Подпись кнопки");
	Словарь.Добавить("providers.field.label.own", "Текст кнопки на странице входа; пусто — имя провайдера");
	Словарь.Добавить("providers.field.label.hint", "Текст кнопки на странице входа");
	Словарь.Добавить("providers.field.icon", "Значок");
	Словарь.Добавить("providers.icon.default", "По издателю");
	Словарь.Добавить("providers.field.scope", "Области (scope)");
	Словарь.Добавить("providers.field.scope.example", "пусто — прежние области");
	Словарь.Добавить("providers.field.scope.help",
		"Что хаб просит у провайдера при входе. Пусто — умолчание пресета, у правки — прежние"
		+ " области. Каждая лишняя область — разрешение, которое провайдер покажет на экране"
		+ " согласия каждому входящему.");
	Словарь.Добавить("providers.connection.fixed",
		"Протокол и точки меняются только заведением провайдера заново.");
	Словарь.Добавить("providers.field.protocol", "Протокол своего провайдера");
	Словарь.Добавить("providers.segment.own", "Свой");
	Словарь.Добавить("providers.segment.oidc", "OpenID Connect");
	Словарь.Добавить("providers.segment.oauth2", "OAuth 2.0");
	Словарь.Добавить("providers.field.issuer", "Издатель (issuer)");
	Словарь.Добавить("providers.field.issuer.help",
		"Точки хаб прочитает у издателя сам, по адресу /.well-known/openid-configuration.");
	Словарь.Добавить("providers.field.authorize", "Точка авторизации");
	Словарь.Добавить("providers.field.token", "Точка токена");
	Словарь.Добавить("providers.field.profile", "Точка профиля");
	Словарь.Добавить("providers.field.emails", "Точка адресов почты");
	Словарь.Добавить("providers.field.base", "Адрес своей инсталляции GitLab");
	Словарь.Добавить("providers.field.base.hint", "Пусто — gitlab.com");
	Словарь.Добавить("providers.field.redirect", "Адрес возврата (redirect_uri)");
	Словарь.Добавить("providers.field.redirect.hint",
		"Пусто — адрес из адреса хаба; свой — только если хаб стоит за прокси с другим адресом");
	Словарь.Добавить("providers.field.autoprovision", "Создавать учётную запись при первом входе");
	Словарь.Добавить("providers.field.groups.jit", "Создавать группы из клейма");
	Словарь.Добавить("providers.field.groups.link", "Связывать клейм с существующей группой по имени");
	Словарь.Добавить("providers.field.groups.claim", "Имя клейма групп");
	Словарь.Добавить("providers.field.groups.prefix", "Префикс имён групп");
	Словарь.Добавить("providers.field.groups.prefix.help",
		"Группы из клейма получают этот префикс и не смешиваются с локальными группами с правами.");
	Словарь.Добавить("providers.field.enabled", "Показывать кнопку на странице входа");

	// удаление: подтверждение с именем провайдера
	Словарь.Добавить("providers.delete.title", "Удалить провайдера %1?");
	Словарь.Добавить("providers.delete.consequence.none",
		"Кнопка «%1» пропадёт со страницы входа. Учёток, которым станет нечем войти, нет.");
	Словарь.Добавить("providers.delete.consequence.some",
		"Кнопка «%1» пропадёт со страницы входа; учёток, которым станет нечем войти: %2.");
	Словарь.Добавить("providers.delete.echo", "Введите имя провайдера");
	Словарь.Добавить("providers.delete.echo.mismatch", "Имя не совпало — провайдер %1 не удалён");

	// правило «закрыт в странах»: окно «Страны и доступ»
	Словарь.Добавить("providers.geo.link", "Страны и доступ");
	Словарь.Добавить("providers.geo.title", "Страны и доступ: %1");
	Словарь.Добавить("providers.geo.field", "Закрыт в странах");
	Словарь.Добавить("providers.geo.field.example", "код страны");
	Словарь.Добавить("providers.geo.field.hint",
		"Коды ISO 3166-1; посетитель с неопределённой страной считается пришедшим из закрытой");
	Словарь.Добавить("providers.geo.closed", "закрыт: %1");
	Словарь.Добавить("providers.geo.open", "открыт всем");
	Словарь.Добавить("providers.geo.closes.all",
		"Пока базы стран нет, правило закрывает провайдера всем: страна посетителя не определяется.");
	Словарь.Добавить("providers.geo.lockout",
		"каждый включённый провайдер закрыт правилом по стране, и после выключения формы"
		+ " посетителю из закрытой страны войти будет нечем. Снимите правило хотя бы"
		+ " с одного провайдера в разделе «Провайдеры входа» (/hub/settings/providers).");
	Словарь.Добавить("providers.geo.prop.db", "база стран");
	Словарь.Добавить("providers.geo.prop.request", "ваша страна сейчас");
	Словарь.Добавить("providers.geo.whoami", "проверить на /whoami");

	// встроенная база стран там, где администратор правит правило
	Словарь.Добавить("providers.geo.db.closes.everyone",
		"Пока хаб не может назвать страну ни одного посетителя, правило закрывает провайдера"
		+ " всем: посетитель с неопределённой страной считается пришедшим из закрытой.");
	Словарь.Добавить("providers.geo.db.release", "DB-IP, выпуск %1 · %2");
	Словарь.Добавить("providers.geo.db.index", "индекс собран: %1");
	Словарь.Добавить("providers.geo.db.empty", "индекс пуст");
	Словарь.Добавить("providers.geo.db.none", "файла базы нет");
	Словарь.Добавить("providers.geo.db.stale",
		"Выпуск устарел: DB-IP обновляет базу раз в месяц. Положите свежий файл либо"
		+ " включите обновление из сети.");
	Словарь.Добавить("providers.geo.db.missing",
		"Ожидается %1 — CSV-выпуск DB-IP Lite Country (статья «Развёртывание», раздел"
		+ " «База стран посетителей») либо обновление из сети настройкой «Обновлять базу стран"
		+ " из сети».");
	Словарь.Добавить("providers.geo.db.building",
		"Индекс перестраивается под %1: правило вступит в силу, когда сборка закончится.");
	Словарь.Добавить("providers.geo.db.failed", "Прошлая сборка индекса не удалась: %1");
	Словарь.Добавить("providers.geo.db.unknown", "состояние не прочитать");

	// какой страной хаб видит этот запрос: хаб видит посетителя, а не обратный прокси
	Словарь.Добавить("providers.geo.request.closed", "%1 — кнопку вы тоже не увидите");
	Словарь.Добавить("providers.geo.request.unwatched", "не из наблюдаемых стран — правило вас не касается");
	Словарь.Добавить("providers.geo.request.unknown.short", "не определена");
	Словарь.Добавить("providers.geo.request.unknown",
		"Причина: %1. Если хаб стоит за обратным прокси, назовите его сети в oshub.instance.trusted_proxies —"
		+ " иначе хаб видит адрес прокси, а не посетителя, и правило закроет провайдера всем.");

КонецПроцедуры

// Раздел «Почта»: проверка отправки и метки ключей почты.
Процедура КлючиПочты(Словарь)

	Словарь.Добавить("settings.hub.mail.test.title", "Проверка отправки");
	Словарь.Добавить("settings.hub.mail.test.lead",
		"Проверочное письмо покажет, работает ли отправка.");
	Словарь.Добавить("settings.hub.mail.test.note", "Письмо уйдёт на адрес вашей учётной записи: %1.");
	Словарь.Добавить("settings.hub.mail.test.button", "Отправить проверочное письмо");
	Словарь.Добавить("settings.hub.mail.test.subject", "Проверка почты хаба");
	Словарь.Добавить("settings.hub.mail.test.body",
		"Это проверочное письмо. Если вы его читаете, отправка почты с хаба %1 настроена верно.");
	Словарь.Добавить("settings.hub.mail.test.done", "Письмо отправлено на %1. Проверьте почту.");
	Словарь.Добавить("settings.hub.mail.test.error.off",
		"Отправка почты не настроена: включите её, укажите сервер и адрес отправителя.");
	Словарь.Добавить("settings.hub.mail.test.error.noemail",
		"В вашей учётной записи не указан адрес — проверочное письмо слать некуда.");
	Словарь.Добавить("settings.hub.mail.test.error.address",
		"Адрес вашей учётной записи не годится для отправки: исправьте его в кабинете.");
	Словарь.Добавить("settings.hub.mail.test.error.send",
		"Письмо не отправлено: почтовый сервер не принял его. Причина — в журнале хаба.");

	Словарь.Добавить("settings.key.oshub-mail-enabled.label", "Отправка почты");
	Словарь.Добавить("settings.key.oshub-mail-enabled.hint",
		"Разрешает хабу слать письма. Выключено — хаб работает как обычно, просто без писем.");
	Словарь.Добавить("settings.key.oshub-mail-smtp-host.label", "Сервер SMTP");
	Словарь.Добавить("settings.key.oshub-mail-smtp-host.hint",
		"Имя или адрес почтового сервера, через который хаб отправляет письма.");
	Словарь.Добавить("settings.key.oshub-mail-smtp-port.label", "Порт SMTP");
	Словарь.Добавить("settings.key.oshub-mail-smtp-port.hint",
		"465 — TLS с первого байта, остальные — переход на TLS, если сервер предложит.");
	Словарь.Добавить("settings.key.oshub-mail-smtp-port.help",
		"Порт решает и режим шифрования: 465 — TLS с первого байта, остальные порты —"
		+ " открытое соединение с переходом на TLS, только если сервер его предложит."
		+ " Отдельной настройки шифрования у хаба нет: библиотека отправки выбирает режим"
		+ " сама, и повлиять на выбор нечем.");
	Словарь.Добавить("settings.key.oshub-mail-smtp-user.label", "Пользователь SMTP");
	Словарь.Добавить("settings.key.oshub-mail-smtp-user.hint",
		"Имя пользователя для входа на почтовый сервер. Пусто — сервер без аутентификации.");
	Словарь.Добавить("settings.key.oshub-mail-smtp-password.label", "Пароль SMTP");
	Словарь.Добавить("settings.key.oshub-mail-smtp-password.hint",
		"Сертификат сервера не проверяется: без TLS пароль уходит открытым текстом.");
	Словарь.Добавить("settings.key.oshub-mail-smtp-password.help",
		"Секрет: задаётся только конфигурацией или переменной окружения, в базе не хранится"
		+ " и на экране не показывается. ВНИМАНИЕ: библиотека отправки не проверяет"
		+ " подлинность сертификата сервера и не требует шифрования — на порту без TLS"
		+ " этот пароль уходит по проводу открытым текстом. Указывайте только свой сервер"
		+ " или сервер за доверенным каналом.");
	Словарь.Добавить("settings.key.oshub-mail-from.label", "Адрес отправителя");
	Словарь.Добавить("settings.key.oshub-mail-from.hint",
		"Без годного адреса отправителя хаб писем не шлёт.");
	Словарь.Добавить("settings.key.oshub-mail-from.help",
		"Адрес, от имени которого хаб шлёт письма. Пока он не задан или не похож на адрес,"
		+ " писем не будет вовсе — хаб считает почту ненастроенной.");

	Словарь.Добавить("settings.key.oshub-auth-email-confirm-enabled.label", "Подтверждение адреса письмом");
	Словарь.Добавить("settings.key.oshub-auth-email-confirm-enabled.hint",
		"Письмо со ссылкой на адрес новой учётки; прав подтверждение не раздаёт.");
	Словарь.Добавить("settings.key.oshub-auth-email-confirm-enabled.help",
		"Хаб шлёт письмо со ссылкой на адрес новой учётной записи. Права подтверждение"
		+ " не раздаёт: неподтверждённый адрес отличается только тем, что о нём сказано,"
		+ " и на него хаб не шлёт ничего, кроме самого письма подтверждения.");
	Словарь.Добавить("settings.key.oshub-auth-email-confirm-ttl-hours.label", "Срок ссылки подтверждения, ч");
	Словарь.Добавить("settings.key.oshub-auth-email-confirm-ttl-hours.hint",
		"Сколько часов живёт ссылка из письма. Сработает она один раз.");

КонецПроцедуры

// Поток «кабинет» (Х4а): журнал аудита — многопольный отбор с кнопкой «Найти».
Процедура КлючиЖурналаАудита(Словарь)

	Словарь.Добавить("settings.hub.audit.filter.find", "Найти");

КонецПроцедуры

&Прозвище("ЧастьСловаряТекстов")
&Порядок(40)
&Желудь
Процедура ПриСозданииОбъекта() Экспорт
КонецПроцедуры
