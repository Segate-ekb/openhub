// Тексты района «Аккаунт»: вход, регистрация, восстановление пароля, подтверждение адреса
// и настройки аккаунта.

// Кладёт тексты в словарь интерфейса.
//
// Параметры:
//  Словарь - СловарьТекстов - словарь, который собирается из частей.
//
Процедура Наполнить(Знач Словарь) Экспорт

	КлючиДомаАккаунта(Словарь);
	КлючиАдресаПосетителя(Словарь);
	КлючиВосстановленияИПодтверждения(Словарь);
	КлючиПривязокOIDC(Словарь);
	КлючиВыхода(Словарь);

КонецПроцедуры

// Дом «Аккаунт»: разделы настроек аккаунта.
Процедура КлючиДомаАккаунта(Словарь)

	Словарь.Добавить("office.tokens.key-cannot-manage-keys",
		"Управление токенами доступно только из кабинета по обычному входу:"
		+ " ключ доступа не выпускает и не отзывает ключи.");

	Словарь.Добавить("settings.account.title", "Настройки аккаунта");
	Словарь.Добавить("settings.account.lead", "Профиль, доступ, токены и внешний вид.");
	Словарь.Добавить("settings.account.heading", "Аккаунт · %1");
	Словарь.Добавить("settings.account.group.account", "Аккаунт");
	Словарь.Добавить("settings.account.group.access", "Доступ");
	Словарь.Добавить("settings.account.nav.office", "Кабинет");
	Словарь.Добавить("settings.account.nav.profile", "Профиль");
	Словарь.Добавить("settings.account.nav.security", "Безопасность");
	Словарь.Добавить("settings.account.nav.tokens", "Токены доступа");
	Словарь.Добавить("settings.account.nav.oidc", "Привязки OIDC");
	Словарь.Добавить("settings.account.nav.permissions", "Мои права");
	Словарь.Добавить("settings.account.nav.appearance", "Вид и язык");

	Словарь.Добавить("settings.account.error.section", "Раздел настроек не найден");
	Словарь.Добавить("settings.account.error.save", "Не удалось сохранить: %1");
	Словарь.Добавить("settings.account.error.password.current", "Текущий пароль неверен");
	Словарь.Добавить("settings.account.error.password.policy", "Новый пароль не соответствует требованиям: %1");
	Словарь.Добавить("settings.account.error.password.repeat", "Новый пароль и повтор не совпадают");
	Словарь.Добавить("settings.account.error.email.taken", "Этот адрес электронной почты уже принадлежит"
		+ " другой учётной записи. Укажите другой адрес.");
	Словарь.Добавить("settings.account.error.form", "Форма раздела «Профиль» не распознана — ничего"
		+ " не изменено. Обновите страницу и повторите.");

	Словарь.Добавить("settings.account.security.forced", "Для продолжения работы необходимо сменить пароль.");
	Словарь.Добавить("settings.account.security.passwordlogin.off", "Вход по логину и паролю на этом"
		+ " хабе выключен: этим паролем сейчас не войти. Сменить его можно — он пригодится,"
		+ " если администратор вернёт парольный вход.");

	Словарь.Добавить("settings.account.profile.title", "Профиль");
	Словарь.Добавить("settings.account.profile.lead", "Учётные данные аккаунта.");
	Словарь.Добавить("settings.account.profile.login.label", "Логин");
	Словарь.Добавить("settings.account.profile.login.hint", "Логин не меняется: он входит в адреса пакетов");
	Словарь.Добавить("settings.account.profile.email.label", "Email");
	Словарь.Добавить("settings.account.profile.email.empty", "Email не задан");
	Словарь.Добавить("settings.account.profile.email.confirmed", "Email подтверждён");
	Словарь.Добавить("settings.account.profile.email.unconfirmed", "Email не подтверждён");
	Словарь.Добавить("settings.account.confirm.lead",
		"Адрес %1 не подтверждён: его подтверждает ссылка из письма.");

	Словарь.Добавить("settings.account.password.title", "Пароль");
	Словарь.Добавить("settings.account.password.lead", "Требования к паролю задаются политикой хаба.");
	Словарь.Добавить("settings.account.password.current.label", "Текущий пароль");
	Словарь.Добавить("settings.account.password.new.label", "Новый пароль");
	Словарь.Добавить("settings.account.password.repeat.label", "Повтор нового пароля");
	Словарь.Добавить("settings.account.password.button", "Сменить пароль");

	Словарь.Добавить("settings.account.permissions.title", "Мои права");
	Словарь.Добавить("settings.account.permissions.lead",
		"Витрина только для чтения: права доступа выдаются и отзываются на самих объектах.");
	Словарь.Добавить("settings.account.permissions.col.pool", "Пул");
	Словарь.Добавить("settings.account.permissions.col.role", "Роль");
	Словарь.Добавить("settings.account.permissions.col.admin", "Управление");
	Словарь.Добавить("settings.account.permissions.col.where", "Где править");
	Словарь.Добавить("settings.account.permissions.role.grant", "по праву доступа");
	Словарь.Добавить("settings.account.permissions.admin.yes", "да");
	Словарь.Добавить("settings.account.permissions.admin.no", "нет");
	Словарь.Добавить("settings.account.permissions.link", "настройки пула");
	Словарь.Добавить("settings.account.permissions.empty", "У вас пока нет ролей на пулах.");

	Словарь.Добавить("settings.account.groups.title", "Мои группы");
	Словарь.Добавить("settings.account.groups.lead",
		"Группа — субъект прав: её права доступа действуют на всех участников.");
	Словарь.Добавить("settings.account.groups.col.group", "Группа");
	Словарь.Добавить("settings.account.groups.col.description", "Описание");
	Словарь.Добавить("settings.account.groups.empty", "Вы не состоите в группах.");

	Словарь.Добавить("settings.account.appearance.title", "Вид и язык");
	Словарь.Добавить("settings.account.appearance.lead",
		"Хранится в этом браузере. Тема, плотность и скругления сохраняются сразу.");
	Словарь.Добавить("settings.account.appearance.save", "Сохранить");
	Словарь.Добавить("settings.account.appearance.theme.label", "Тема");
	Словарь.Добавить("settings.account.appearance.theme.light", "светлая");
	Словарь.Добавить("settings.account.appearance.theme.dark", "тёмная");
	Словарь.Добавить("settings.account.appearance.accent.label", "Акцент");
	Словарь.Добавить("settings.account.appearance.accent.hint",
		"Контрастный цвет текста на кнопках хаб выводит сам");
	Словарь.Добавить("settings.account.appearance.density.label", "Плотность");
	Словарь.Добавить("settings.account.appearance.density.compact", "компактно");
	Словарь.Добавить("settings.account.appearance.density.normal", "обычно");
	Словарь.Добавить("settings.account.appearance.density.roomy", "просторно");
	Словарь.Добавить("settings.account.appearance.radius.label", "Скругления");
	Словарь.Добавить("settings.account.appearance.radius.less", "меньше");
	Словарь.Добавить("settings.account.appearance.radius.normal", "обычно");
	Словарь.Добавить("settings.account.appearance.radius.more", "больше");

	КлючиТокенов(Словарь);

КонецПроцедуры

// Раздел «Токены доступа»: реестр личных токенов, окно выпуска шагами и отзыв.
Процедура КлючиТокенов(Словарь)

	Словарь.Добавить("settings.account.tokens.title", "Токены доступа");
	Словарь.Добавить("settings.account.tokens.lead", "Для opm и CI. Секрет показывается один раз — при выпуске.");
	Словарь.Добавить("settings.account.tokens.add", "Выпустить токен");
	Словарь.Добавить("settings.account.tokens.empty", "Токенов пока нет.");
	Словарь.Добавить("settings.account.tokens.unnamed", "(без имени)");

	Словарь.Добавить("settings.account.tokens.scope.read", "чтение");
	Словарь.Добавить("settings.account.tokens.scope.write", "запись");
	Словарь.Добавить("settings.account.tokens.scope.none", "нет областей");
	Словарь.Добавить("settings.account.tokens.where.hub", "весь хаб");
	Словарь.Добавить("settings.account.tokens.where.pools", "пулы %1");
	Словарь.Добавить("settings.account.tokens.where.pool", "пул %1");
	Словарь.Добавить("settings.account.tokens.term.until", "до %1");
	Словарь.Добавить("settings.account.tokens.term.expired", "истёк %1");
	Словарь.Добавить("settings.account.tokens.term.never", "бессрочно — выпущен до запрета, отзовите");

	Словарь.Добавить("settings.account.tokens.prop.prefix", "префикс");
	Словарь.Добавить("settings.account.tokens.prop.scopes", "области");
	Словарь.Добавить("settings.account.tokens.prop.where", "где действует");
	Словарь.Добавить("settings.account.tokens.prop.created", "создан");
	Словарь.Добавить("settings.account.tokens.prop.expires", "истекает");

	Словарь.Добавить("settings.account.tokens.revoke", "Отозвать");
	Словарь.Добавить("settings.account.tokens.revoke.title", "Отозвать токен «%1»?");
	Словарь.Добавить("settings.account.tokens.revoke.consequence",
		"Программы, которые входят с этим токеном, перестанут попадать в хаб. Вернуть токен нельзя.");
	Словарь.Добавить("settings.account.tokens.revoke.missing", "Токен не найден");

	Словарь.Добавить("settings.account.tokens.window.new", "Новый токен");
	Словарь.Добавить("settings.account.tokens.step.name", "Имя и права");
	Словарь.Добавить("settings.account.tokens.step.where", "Где действует");
	Словарь.Добавить("settings.account.tokens.step.term", "Срок");
	Словарь.Добавить("settings.account.tokens.field.name", "Имя");
	Словарь.Добавить("settings.account.tokens.field.name.example", "например, ноутбук");
	Словарь.Добавить("settings.account.tokens.field.name.hint", "Зачем этот токен — чтобы потом отозвать нужный");
	Словарь.Добавить("settings.account.tokens.field.rights", "Права");
	Словарь.Добавить("settings.account.tokens.field.read", "чтение — скачивать пакеты и читать метаданные");
	Словарь.Добавить("settings.account.tokens.field.write", "запись — публиковать версии и менять настройки");
	Словарь.Добавить("settings.account.tokens.field.where", "Где действует");
	Словарь.Добавить("settings.account.tokens.field.where.hub", "весь хаб");
	Словарь.Добавить("settings.account.tokens.field.where.pools", "выбранные пулы");
	Словарь.Добавить("settings.account.tokens.field.pools", "Пулы");
	Словарь.Добавить("settings.account.tokens.field.pools.cut",
		"Показаны %1 пулов из %2 — остальные найдёт поиск.");
	Словарь.Добавить("settings.account.tokens.field.pools.marked", "Уже отмечены: %1");
	Словарь.Добавить("settings.account.tokens.field.where.nopools",
		"Доступных пулов нет — токен будет действовать на весь хаб.");
	Словарь.Добавить("settings.account.tokens.field.term", "Срок, дней");
	Словарь.Добавить("settings.account.tokens.field.term.hint",
		"От 1 до %1 дней. Бессрочных токенов хаб не выпускает.");
	Словарь.Добавить("settings.account.tokens.issue", "Выпустить");

	Словарь.Добавить("settings.account.tokens.error.scopes",
		"Отметьте хотя бы одно право: токен без прав ничего не может.");
	Словарь.Добавить("settings.account.tokens.error.term",
		"Срок действия — целое число от 1 до %1 дней: бессрочных токенов хаб не выпускает.");
	Словарь.Добавить("settings.account.tokens.error.pools", "Отметьте хотя бы один пул или выберите «весь хаб».");
	Словарь.Добавить("settings.account.tokens.error.pool", "Пул %1 не найден.");
	Словарь.Добавить("settings.account.tokens.error.issue", "Не удалось выпустить токен: %1");

	Словарь.Добавить("settings.account.tokens.issued.title", "Токен выпущен");
	Словарь.Добавить("settings.account.tokens.issued.lead", "Скопируйте его сейчас — больше он показан не будет.");
	Словарь.Добавить("settings.account.tokens.issued.token", "токен");

КонецПроцедуры

// Страница «как хаб видит ваш запрос»: её читает посетитель, а не оператор.
Процедура КлючиАдресаПосетителя(Словарь)

	Словарь.Добавить("whoami.page.title", "Как хаб видит ваш запрос");
	Словарь.Добавить("whoami.page.address", "Ваш адрес");
	Словарь.Добавить("whoami.page.country", "Страна");
	Словарь.Добавить("whoami.page.hint",
		"По этому адресу и стране хаб решает, какие способы входа вам показать."
		+ " Если страна не та, откуда вы подключаетесь, проверьте сетевые настройки: запросы"
		+ " к этому хабу могут идти другим маршрутом, чем к остальным сайтам.");

	Словарь.Добавить("whoami.country.unwatched", "не из стран, которые хаб различает: %1");
	Словарь.Добавить("whoami.country.unknown", "не определена");
	Словарь.Добавить("whoami.country.off",
		"не определяется: правил по стране на этом хабе нет, способы входа от неё не зависят");

КонецПроцедуры

// Восстановление пароля и подтверждение адреса: страницы.
Процедура КлючиВосстановленияИПодтверждения(Словарь)

	Словарь.Добавить("password.requirements.title", "Требования к паролю:");

	Словарь.Добавить("access.page.login", "Страница входа");
	Словарь.Добавить("access.page.signin", "Вход");
	Словарь.Добавить("access.page.signin.hub", "Вход в %1");
	Словарь.Добавить("access.page.or", "или");
	Словарь.Добавить("access.page.signup.prompt", "Нет аккаунта? %1");
	Словарь.Добавить("access.page.signup.link", "Зарегистрироваться");

	Словарь.Добавить("recover.page.title", "Восстановление пароля");
	Словарь.Добавить("recover.page.lead", "Назовите логин или адрес электронной почты своей"
		+ " учётной записи. Если такая учётная запись есть и её адрес подтверждён,"
		+ " хаб пришлёт письмо со ссылкой установки нового пароля.");
	Словарь.Добавить("recover.page.field", "Логин или email");
	Словарь.Добавить("recover.page.button", "Выслать ссылку");
	Словарь.Добавить("recover.page.link", "Забыли пароль?");
	Словарь.Добавить("recover.page.done", "Если такая учётная запись есть и её адрес подтверждён,"
		+ " письмо со ссылкой уже отправлено. Проверьте почту — включая папку со спамом.");
	Словарь.Добавить("recover.page.unavailable", "Восстановление пароля на этом хабе не работает:"
		+ " отправка почты не настроена, и письмо со ссылкой слать нечем."
		+ " Обратитесь к администратору хаба — он выдаст ссылку установки пароля.");
	Словарь.Добавить("recover.page.throttled", "Слишком много запросов восстановления."
		+ " Попробуйте позже.");
	Словарь.Добавить("recover.page.method", "Разрешены методы GET и POST.");

	Словарь.Добавить("confirm.page.title", "Подтверждение адреса");
	Словарь.Добавить("confirm.page.lead",
		"Учётная запись «%1», адрес %2. Нажмите кнопку — и адрес будет подтверждён.");
	Словарь.Добавить("confirm.page.button", "Подтвердить адрес");
	Словарь.Добавить("confirm.page.done", "Адрес %1 подтверждён.");
	Словарь.Добавить("confirm.page.request.lead",
		"Письмо со ссылкой не пришло или ссылка устарела? Назовите логин или адрес"
		+ " электронной почты — вышлем новое.");
	Словарь.Добавить("confirm.page.request.field", "Логин или email");
	Словарь.Добавить("confirm.page.request.button", "Выслать письмо");
	Словарь.Добавить("confirm.page.request.done",
		"Если такая учётная запись есть и её адрес не подтверждён, письмо со ссылкой"
		+ " отправлено. Проверьте почту.");
	Словарь.Добавить("confirm.page.state.noemail",
		"В учётной записи не указан адрес электронной почты — подтверждать нечего."
		+ " Укажите адрес в кабинете.");
	Словарь.Добавить("confirm.page.state.confirmed", "Адрес %1 уже подтверждён.");
	Словарь.Добавить("confirm.page.resend.lead",
		"Адрес %1 не подтверждён. Хаб вышлет на него письмо со ссылкой.");
	Словарь.Добавить("confirm.page.resend.button", "Выслать письмо ещё раз");
	Словарь.Добавить("confirm.page.resend.done", "Письмо отправлено на %1. Проверьте почту.");
	Словарь.Добавить("confirm.page.error.method", "Разрешены методы GET и POST.");
	Словарь.Добавить("confirm.page.error.form", "Форма устарела. Обновите страницу и повторите.");
	Словарь.Добавить("confirm.page.error.unknown",
		"Такой ссылки нет. Проверьте адрес целиком — он длинный и легко теряет хвост.");
	Словарь.Добавить("confirm.page.error.expired",
		"Срок этой ссылки вышел. Войдите в учётную запись и запросите письмо заново.");
	Словарь.Добавить("confirm.page.error.used",
		"Этой ссылкой уже воспользовались либо её отменило письмо, отправленное позже.");
	Словарь.Добавить("confirm.page.error.nouser", "Учётной записи этой ссылки больше нет.");
	Словарь.Добавить("confirm.page.error.changed",
		"Адрес учётной записи изменился после отправки письма — про новый адрес эта ссылка"
		+ " ничего не говорит. Запросите письмо заново.");
	Словарь.Добавить("confirm.page.error.already", "Адрес учётной записи уже подтверждён.");
	Словарь.Добавить("confirm.page.error.off",
		"Подтверждение адреса письмом на этом хабе выключено.");
	Словарь.Добавить("confirm.page.error.mail",
		"Отправка почты на этом хабе не настроена — письмо выслать некуда."
		+ " Обратитесь к администратору хаба.");
	Словарь.Добавить("confirm.page.error.send",
		"Письмо отправить не удалось: почтовый сервер хаба его не принял."
		+ " Сообщите администратору хаба — причина записана в журнал.");
	Словарь.Добавить("confirm.page.error.address",
		"Адрес учётной записи не годится для отправки письма: исправьте его в кабинете.");
	Словарь.Добавить("confirm.page.error.url",
		"У хаба не задан внешний адрес — ссылке в письме некуда вести, и письмо не отправлено."
		+ " Обратитесь к администратору хаба.");
	Словарь.Добавить("confirm.page.error.failed",
		"Письмо выслать не удалось — причина записана в журнал хаба. Попробуйте позже.");

КонецПроцедуры

// Поток «кабинет» (Х4а): раздел «Привязки OIDC» — таблица личностей, отвязка окном, привязка провайдеров.
Процедура КлючиПривязокOIDC(Словарь)

	Словарь.Добавить("settings.account.oidc.title", "Привязки OIDC");
	Словарь.Добавить("settings.account.oidc.lead", "Входы через внешних провайдеров, связанные с учётной записью.");
	Словарь.Добавить("settings.account.oidc.empty", "Пока нет привязанных личностей.");
	Словарь.Добавить("settings.account.oidc.col.issuer", "Провайдер (issuer)");
	Словарь.Добавить("settings.account.oidc.col.account", "Аккаунт у провайдера");
	Словарь.Добавить("settings.account.oidc.col.email", "Email");
	Словарь.Добавить("settings.account.oidc.menu", "Действия с привязкой %1");
	Словарь.Добавить("settings.account.oidc.unlink", "Отвязать");
	Словарь.Добавить("settings.account.oidc.unlink.title", "Отвязать %1?");
	Словарь.Добавить("settings.account.oidc.unlink.consequence", "Вход через этого провайдера перестанет"
		+ " вести в вашу учётку. Учётка и роли останутся; привязать можно снова.");
	Словарь.Добавить("settings.account.oidc.last", "Это последний способ входа: без него в учётку"
		+ " не войти. Сначала задайте пароль или привяжите другого провайдера.");
	Словарь.Добавить("settings.account.oidc.password", "Задать пароль");
	Словарь.Добавить("settings.account.oidc.link.title", "Привязать провайдера");
	Словарь.Добавить("settings.account.oidc.link.lead", "Вход провайдером поведёт в эту учётку.");
	Словарь.Добавить("settings.account.oidc.link.button", "Привязать %1");
	Словарь.Добавить("settings.account.oidc.link.none", "Провайдеры OIDC не настроены.");
	Словарь.Добавить("settings.account.oidc.error.provider", "Неизвестный провайдер входа.");
	Словарь.Добавить("settings.account.oidc.error.start", "Не удалось начать привязку через провайдера.");

КонецПроцедуры

// Выход: отказ двери выхода без токена сессии.
Процедура КлючиВыхода(Словарь)
	Словарь.Добавить("access.logout.title", "Выход");
	Словарь.Добавить("access.logout.stale", "Выйти не получилось: страница, с которой нажали «Выйти», устарела."
		+ " Вы по-прежнему в учётной записи — «Выйти» в меню учётки вверху.");
КонецПроцедуры

&Прозвище("ЧастьСловаряТекстов")
&Порядок(10)
&Желудь
Процедура ПриСозданииОбъекта() Экспорт
КонецПроцедуры
