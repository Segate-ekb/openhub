// Словарь текстов интерфейса (русский) — желудь модуля web-ui: единственное место, где
// живут пользовательские строки экранов. Резолвер ключей — ТекстыИнтерфейса кита; этот
// класс перебивает его пустой контракт СловарьИнтерфейса прозвищем.
//
// Формат ключа: <область>.<экран>.<узел>[.<узел>…], строчная латиница, цифры и дефис,
// не меньше трёх сегментов. Хвост ключа — соглашение, а не правило: одиночная роль идёт
// последним сегментом (title, lead, label, hint, empty, note, crumb, tab, link, on/off),
// группа однородных значений — ролью перед именем (col.*, nav.*, option.*, button.*,
// error.*, mode.*, type.*), чтобы сортировка по ключу собирала группу вместе.
//
// Сообщений журнала, текстов исключений и технических диагностик здесь нет: их читает
// разработчик, и ключ вместо текста сделал бы разбор инцидента дороже.

Перем Тексты; // Соответствие: ключ (Строка) -> текст (Строка)

// Текст по ключу. Политику «что делать, когда ключа нет» держит резолвер: словарь —
// это данные, и он не решает, как выглядит дефект.
//
// Параметры:
//  Ключ - Строка - ключ текста.
//
// Возвращаемое значение:
//  Строка, Неопределено - текст либо Неопределено, если ключа нет.
//
Функция НайтиТекст(Знач Ключ) Экспорт
	Возврат Тексты.Получить(Ключ);
КонецФункции

// Все ключи словаря — для теста «мёртвых ключей нет».
//
// Возвращаемое значение:
//  Массив из Строка
//
Функция Ключи() Экспорт

	Результат = Новый Массив();
	Для Каждого КиЗ Из Тексты Цикл
		Результат.Добавить(КиЗ.Ключ);
	КонецЦикла;
	Возврат Результат;

КонецФункции

// Метода «язык словаря» здесь нет: язык определяется тем, какой класс подставлен
// пластилином резолвера, и спрашивать его пока некому.

#Область НаполнениеСловаря

// Каркас домов настроек (РендерерНастроек) — общая обвязка всех пяти домов.
Процедура КлючиКаркаса()

	Добавить("settings.frame.crumbs.label", "Путь");
	Добавить("settings.frame.nav.title", "Разделы настроек");
	Добавить("settings.frame.empty", "В этом разделе пока нечего настраивать.");
	Добавить("settings.frame.save", "Сохранить");
	Добавить("settings.frame.cancel", "Отмена");

	// Отказы объявленной формы (ПроверкаПоля): текст говорит, ЧТО поправить в этом поле.
	Добавить("form.error.required", "Заполните это поле");
	Добавить("form.error.number", "Введите целое число");
	Добавить("form.error.min", "Не меньше %1");
	Добавить("form.error.max", "Не больше %1");
	Добавить("form.error.choice", "Выберите значение из списка");

КонецПроцедуры

// Общие ответы домов (ОтветыНастроек): страницы отказов и уведомления разделов.
Процедура КлючиОтветов()

	Добавить("settings.reply.forbidden.title", "Отказано");
	Добавить("settings.reply.notfound.title", "Не найдено");
	Добавить("settings.reply.method.title", "Метод не разрешён");
	Добавить("settings.reply.method.body", "Разрешено: %1");
	Добавить("settings.reply.error.internal", "внутренняя ошибка");
	Добавить("settings.reply.saved", "Изменения сохранены");
	Добавить("settings.reply.grant.none", "—");
	Добавить("settings.reply.grant.read", "чтение");
	Добавить("settings.reply.grant.create", "создание");
	Добавить("settings.reply.grant.update", "изменение");
	Добавить("settings.reply.grant.delete", "удаление");

	// единая таблица прав (ТаблицаПрав, 6.C п.4) — колонки одни на все экраны прав
	Добавить("access.grants.col.subject-type", "Тип субъекта");
	Добавить("access.grants.col.subject", "Субъект");
	Добавить("access.grants.col.actions", "Действия");
	Добавить("access.grants.col.role", "Роль");
	Добавить("access.grants.col.object", "Объект");

	// Список пулов и выдача ролей на пул. Наружу — роли В-1; гранулярные действия
	// остались машинным представлением и в интерфейсе не звучат.
	Добавить("access.pools.create.title", "Создать пул");
	Добавить("access.pools.create.lead", "Пул заводится сразу и пустым: пакеты в него"
		+ " публикуются обычным opm push.");
	Добавить("access.pools.create.denied", "Создание пулов доступно по праву на уровне хаба"
		+ " (обратитесь к администратору).");
	Добавить("access.pools.create.name", "Имя пула");
	Добавить("access.pools.create.type", "Тип");
	Добавить("access.pools.create.type.hint", "Личное пространство заводится при регистрации,"
		+ " основной пул — один на хаб");
	Добавить("access.pools.create.type.custom", "проектный");
	Добавить("access.pools.create.visibility", "Видимость");
	Добавить("access.pools.create.visibility.on", "публичный");
	Добавить("access.pools.create.visibility.off", "приватный");
	Добавить("access.pools.create.submit", "Создать пул");
	Добавить("access.pools.create.failed", "Не удалось создать пул: %1");
	Добавить("access.pools.filter.label", "Отбор по имени пула");
	Добавить("access.pools.filter.placeholder", "часть имени");
	Добавить("access.pools.filter.submit", "Отобрать");
	Добавить("access.pools.empty.filtered.lead", "Попробуйте другую подстроку имени.");
	Добавить("access.pools.personal", "Личные пространства (%1)");
	Добавить("access.pools.col.pool", "Пул");
	Добавить("access.pools.col.props", "Свойства");
	Добавить("access.pools.action.settings", "Настройки пула");
	Добавить("access.pools.action.access", "Права доступа");
	Добавить("access.pools.table.empty", "Пулов нет");
	Добавить("access.pools.default.action", "Сделать основным");
	Добавить("access.pools.default.failed", "Не удалось назначить основной пул: %1");

	Добавить("access.rights.revoke", "Отозвать");
	Добавить("access.rights.error.operation", "Неизвестная операция раздела «Права доступа»");
	Добавить("access.rights.form.subject-type", "Тип субъекта");
	Добавить("access.rights.form.subject-type.user", "пользователь");
	Добавить("access.rights.form.subject-type.group", "группа пользователей");
	Добавить("access.rights.form.subject", "Субъект (логин или имя группы)");
	Добавить("access.rights.form.role", "Роль");
	Добавить("access.rights.form.role.hint", "Каждая роль включает предыдущую: читатель"
		+ " видит приватный пул, райтер публикует пакеты, мейнтейнер правит настройки"
		+ " и раздаёт роли.");
	Добавить("access.rights.form.submit", "Выдать роль");
	Добавить("access.rights.role.reader", "читатель");
	Добавить("access.rights.role.writer", "райтер");
	Добавить("access.rights.role.maintainer", "мейнтейнер");
	Добавить("access.rights.role.owner", "владелец");
	Добавить("access.rights.role.admin", "админ хаба");

	// Инвариант «ключ не размножается» (В-9): формулировка одна, экранов с ней два.
	Добавить("office.tokens.key-cannot-manage-keys",
		"Управление токенами доступно только из кабинета по обычному входу:"
		+ " ключ доступа не выпускает и не отзывает ключи.");

КонецПроцедуры

// Дом «Аккаунт» — карта разделов (ДомАккаунта).
Процедура КлючиДомаАккаунта()

	Добавить("settings.account.title", "Настройки аккаунта");
	Добавить("settings.account.lead", "Личные настройки: профиль, доступ, токены и внешний вид."
		+ " Права на пулы и пакеты редактируются на самих объектах.");
	Добавить("settings.account.nav.profile", "Профиль");
	Добавить("settings.account.nav.security", "Безопасность");
	Добавить("settings.account.nav.tokens", "Токены доступа");
	Добавить("settings.account.nav.oidc", "Привязки OIDC");
	Добавить("settings.account.nav.permissions", "Мои права");
	Добавить("settings.account.nav.appearance", "Вид и язык");

	Добавить("settings.account.error.section", "Раздел настроек не найден");
	Добавить("settings.account.error.save", "Не удалось сохранить: %1");
	Добавить("settings.account.error.password.current", "Текущий пароль неверен");
	Добавить("settings.account.error.password.policy", "Новый пароль не соответствует требованиям: %1");
	Добавить("settings.account.error.password.repeat", "Новый пароль и повтор не совпадают");
	Добавить("settings.account.error.email.taken", "Этот адрес электронной почты уже принадлежит"
		+ " другой учётной записи. Укажите другой адрес.");

	Добавить("settings.account.security.forced", "Для продолжения работы необходимо сменить пароль.");
	Добавить("settings.account.security.passwordlogin.off", "Вход по логину и паролю на этом"
		+ " хабе выключен: этим паролем сейчас не войти. Сменить его можно — он пригодится,"
		+ " если администратор вернёт парольный вход.");

	Добавить("settings.account.profile.title", "Профиль");
	Добавить("settings.account.profile.lead", "Учётные данные аккаунта.");
	Добавить("settings.account.profile.login.label", "Логин");
	Добавить("settings.account.profile.login.hint", "Логин не меняется: он входит в адреса пакетов");
	Добавить("settings.account.profile.email.label", "Email");
	Добавить("settings.account.profile.email.empty", "Email не задан");
	Добавить("settings.account.profile.email.confirmed", "Email подтверждён");
	Добавить("settings.account.profile.email.unconfirmed", "Email не подтверждён");

	Добавить("settings.account.password.title", "Пароль");
	Добавить("settings.account.password.lead", "Требования к паролю задаются политикой хаба.");
	Добавить("settings.account.password.current.label", "Текущий пароль");
	Добавить("settings.account.password.new.label", "Новый пароль");
	Добавить("settings.account.password.repeat.label", "Повтор нового пароля");
	Добавить("settings.account.password.button", "Сменить пароль");

	Добавить("settings.account.permissions.title", "Мои права");
	Добавить("settings.account.permissions.lead",
		"Витрина только для чтения: права доступа выдаются и отзываются на самих объектах.");
	Добавить("settings.account.permissions.col.pool", "Пул");
	Добавить("settings.account.permissions.col.role", "Роль");
	Добавить("settings.account.permissions.col.admin", "Управление");
	Добавить("settings.account.permissions.col.where", "Где править");
	Добавить("settings.account.permissions.role.grant", "по праву доступа");
	Добавить("settings.account.permissions.admin.yes", "да");
	Добавить("settings.account.permissions.admin.no", "нет");
	Добавить("settings.account.permissions.link", "настройки пула");
	Добавить("settings.account.permissions.empty", "У вас пока нет ролей на пулах.");

	Добавить("settings.account.groups.title", "Мои группы");
	Добавить("settings.account.groups.lead",
		"Группа — субъект прав: её права доступа действуют на всех участников.");
	Добавить("settings.account.groups.col.group", "Группа");
	Добавить("settings.account.groups.col.description", "Описание");
	Добавить("settings.account.groups.empty", "Вы не состоите в группах.");

	Добавить("settings.account.appearance.title", "Вид");
	Добавить("settings.account.appearance.lead",
		"Оформление интерфейса. Хранится в cookie этого браузера.");
	Добавить("settings.account.appearance.theme.label", "Тема");
	Добавить("settings.account.appearance.theme.dark", "Тёмная");
	Добавить("settings.account.appearance.theme.light", "Светлая");
	Добавить("settings.account.appearance.accent.label", "Акцент");
	Добавить("settings.account.appearance.accent.hint", "Цвет в формате #rrggbb. Пусто — акцент темы."
		+ " Контрастный цвет текста на кнопках хаб выводит сам.");
	Добавить("settings.account.appearance.density.label", "Плотность");
	Добавить("settings.account.appearance.density.hint", "Множитель шага сетки, 0.5–2");
	Добавить("settings.account.appearance.radius.label", "Скругления");
	Добавить("settings.account.appearance.radius.hint", "Множитель радиусов, 0.5–2");

КонецПроцедуры

// Дом «Группа» — карта разделов (ДомГруппы).
Процедура КлючиДомаГруппы()

	Добавить("settings.group.title", "Настройки группы");
	Добавить("settings.group.lead", "Группа — субъект прав: её состав и связка с OIDC настраиваются здесь,"
		+ " а права доступа выдаются на самих объектах (пул, пакет).");
	Добавить("settings.group.nav.members", "Участники");
	Добавить("settings.group.nav.oidc", "Связка с OIDC");
	Добавить("settings.group.nav.grants", "Права доступа группы");
	Добавить("settings.group.crumb", "группы");

	Добавить("settings.group.error.section", "Раздел настроек не найден");
	Добавить("settings.group.error.save", "Не удалось сохранить: %1");
	Добавить("settings.group.error.operation", "Неизвестная операция раздела");
	Добавить("settings.group.readonly", "Вы видите группу как участник:"
		+ " изменять её состав и связки может только администратор хаба.");

	Добавить("settings.group.members.title", "Участники");
	Добавить("settings.group.members.lead", "Состав группы и происхождение каждого членства.");
	Добавить("settings.group.members.col.login", "Логин");
	Добавить("settings.group.members.col.source", "Источник");
	Добавить("settings.group.members.empty", "В группе нет участников.");
	Добавить("settings.group.members.note", "Участник с источником %1 синхронизируется из"
		+ " клеймов провайдера: удаление вручную не удержится, если клейм остался.");
	Добавить("settings.group.members.synced", "Сверено с клеймами: %1");
	Добавить("settings.group.members.button.remove", "Исключить");

	Добавить("settings.group.member-new.title", "Добавить участника");
	Добавить("settings.group.member-new.lead", "Учётные записи хаба, которых в группе ещё нет."
		+ " Членство заводится с источником local.");
	Добавить("settings.group.member-new.col.login", "Логин");
	Добавить("settings.group.member-new.col.email", "Email");
	Добавить("settings.group.member-new.filter.label", "Поиск");
	Добавить("settings.group.member-new.filter.placeholder", "Логин или email");
	Добавить("settings.group.member-new.filter.button", "Найти");
	Добавить("settings.group.member-new.empty", "Все учётные записи хаба уже в группе.");
	Добавить("settings.group.member-new.notfound", "По запросу «%1» ничего не найдено.");
	Добавить("settings.group.member-new.truncated",
		"Показаны первые %1 из %2 — уточните запрос.");
	Добавить("settings.group.member-new.duplicate", "Пользователь «%1» уже в группе");
	Добавить("settings.group.member-new.button", "Добавить");
	Добавить("settings.group.member-new.client.partial",
		"Отбор идёт по показанным строкам. Чтобы искать по всем учётным записям хаба,"
		+ " нажмите «Найти».");
	Добавить("settings.group.member-new.client.empty",
		"Среди показанных строк совпадений нет. Нажмите «Найти», чтобы искать по всем"
		+ " учётным записям хаба.");

	Добавить("settings.group.oidc.title", "Связка с OIDC");
	Добавить("settings.group.oidc.lead", "Какие клеймы провайдера означают членство в этой группе.");
	Добавить("settings.group.oidc.col.issuer", "Издатель (issuer)");
	Добавить("settings.group.oidc.col.claim", "Клейм");
	Добавить("settings.group.oidc.col.value", "Значение клейма");
	Добавить("settings.group.oidc.empty", "Группа не связана ни с одним клеймом.");
	Добавить("settings.group.oidc.note", "При входе пользователя клеймы провайдера сопоставляются с"
		+ " этими правилами: совпало — участник добавляется, пропало — исключается.");
	Добавить("settings.group.oidc.button.remove", "Удалить");

	Добавить("settings.group.policy.title", "Политика выпавших из клейма");
	Добавить("settings.group.policy.lead",
		"Что делать с участником, которого IdP перестал возвращать в клейме.");
	Добавить("settings.group.policy.label", "Выпавших из клейма — оставлять в группе");
	Добавить("settings.group.policy.on", "оставлять: участник остаётся, IdP только добавляет");
	Добавить("settings.group.policy.off", "исключать: пропал клейм — снимается членство");
	Добавить("settings.group.policy.hint", "Затрагивает только членства с источником oidc;"
		+ " локальные назначения синхронизация не трогает никогда.");
	Добавить("settings.group.policy.synced", "Состав сверялся с клеймами: %1");
	Добавить("settings.group.policy.never", "ещё не сверялся");

	Добавить("settings.group.mapping-new.title", "Добавить связку");
	Добавить("settings.group.mapping-new.issuer.label", "Издатель (issuer)");
	Добавить("settings.group.mapping-new.issuer.hint", "Значение iss из токена провайдера");
	Добавить("settings.group.mapping-new.claim.label", "Имя клейма");
	Добавить("settings.group.mapping-new.claim.hint", "Обычно groups или roles");
	Добавить("settings.group.mapping-new.value.label", "Значение клейма");
	Добавить("settings.group.mapping-new.button", "Добавить");

	Добавить("settings.group.grants.title", "Права доступа группы");
	Добавить("settings.group.grants.lead", "Куда и в какой роли группа открывает доступ своим участникам.");
	Добавить("settings.group.grants.col.where", "Где править");
	Добавить("settings.group.grants.empty", "Группе не выдано ни одного права доступа.");
	Добавить("settings.group.grants.note", "Витрина только для чтения: роль выдаётся и отзывается"
		+ " на самом объекте — право видно рядом с объектом. Объекты, которых вам не видно,"
		+ " в таблице не показаны.");
	Добавить("settings.group.grants.object.hub", "весь хаб");
	Добавить("settings.group.grants.link.pool", "править на пуле");
	Добавить("settings.group.grants.link.package", "править на пакете");

КонецПроцедуры

// Дом «Пул» — карта разделов (ДомПула).
Процедура КлючиДомаПула()

	Добавить("settings.pool.title", "Настройки пула");
	Добавить("settings.pool.lead", "Настройки пула редактирует его владелец или администратор хаба.");
	Добавить("settings.pool.nav.general", "Общие");
	Добавить("settings.pool.nav.visibility", "Видимость и доступ");
	Добавить("settings.pool.nav.reserved", "Резерв имён");
	Добавить("settings.pool.nav.inbox", "Входящие");
	Добавить("settings.pool.nav.tags", "Теги");
	Добавить("settings.pool.nav.upstreams", "Апстримы");
	Добавить("settings.pool.nav.mirrors", "Зеркала");
	Добавить("settings.pool.nav.webhooks", "Подписки на события");
	Добавить("settings.pool.nav.access", "Права доступа");
	Добавить("settings.pool.nav.quota", "Квота");
	Добавить("settings.pool.nav.danger", "Опасная зона");
	Добавить("settings.pool.crumb", "настройки");

	Добавить("settings.pool.error.section", "Раздел настроек не найден");
	Добавить("settings.pool.error.save", "Не удалось сохранить: %1");
	Добавить("settings.pool.error.visibility",
		"Видимость должна быть «public» или «private». Ничего не изменено.");
	Добавить("settings.pool.error.quota.number", "Квота должна быть целым числом мегабайт"
		+ " (−1 — как в хабе, 0 — без ограничения). Значение не распознано, квота НЕ изменена.");
	Добавить("settings.pool.error.quota.forbidden",
		"Квоту пула назначает администратор хаба — изменить её отсюда нельзя.");
	Добавить("settings.pool.error.quota.limit",
		"Квота слишком велика: максимум %1 МБ (примерно эксабайт). Квота НЕ изменена.");
	Добавить("settings.pool.error.upstream.operation", "Неизвестная операция раздела «Апстримы»."
		+ " Ничего не изменено — обновите страницу и повторите действие.");
	Добавить("settings.pool.error.upstream.url", "Не задан адрес апстрима.");
	Добавить("settings.pool.error.upstream.ttl", "TTL кэша должен быть целым числом секунд.");
	Добавить("settings.pool.error.upstream.target", "Не указано, какой апстрим менять.");

	Добавить("settings.pool.general.title", "Общие");
	Добавить("settings.pool.general.lead", "Базовые свойства пула.");
	Добавить("settings.pool.general.name.label", "Имя пула");
	Добавить("settings.pool.general.name.hint", "Имя пула входит в адреса пакетов и не переименовывается");
	Добавить("settings.pool.general.default.label", "Основной пул хаба");
	Добавить("settings.pool.general.default.hint", "Короткие адреса /download, /dev-channel"
		+ " и /push ведут в основной пул; он публичен и неудаляем."
		+ " Основной пул назначается в настройках хаба (/hub/settings/pools)");
	Добавить("settings.pool.general.default.yes", "да");
	Добавить("settings.pool.general.default.no", "нет");
	Добавить("settings.pool.general.visibility.label", "Видимость");
	Добавить("settings.pool.general.visibility.hint", "Меняется в разделе «Видимость и доступ»");

	Добавить("settings.pool.visibility.title", "Видимость");
	Добавить("settings.pool.visibility.lead", "Кто может читать пакеты пула.");
	Добавить("settings.pool.visibility.label", "Видимость");
	Добавить("settings.pool.visibility.hint",
		"Приватный пул означает, что ВСЕ его пакеты приватны: доступ строго по правам");
	Добавить("settings.pool.visibility.option.public", "Публичный — виден всем");
	Добавить("settings.pool.visibility.option.private", "Приватный — только по правам");

	Добавить("settings.pool.access.title", "Права доступа");
	Добавить("settings.pool.access.lead", "Кто и в какой роли допущен к пулу помимо владельца.");
	Добавить("settings.pool.access.empty", "Ролей на пуле никому не выдано.");
	Добавить("settings.pool.access.col.action", "Действие");
	Добавить("settings.pool.access.note", "Администратор хаба распоряжается пулом"
		+ " независимо от этого списка.");
	Добавить("settings.pool.access.readonly", "Роли на пуле раздаёт его мейнтейнер"
		+ " или администратор хаба — у вас только просмотр.");
	Добавить("settings.pool.access.error.subject",
		"Субъект не найден (проверьте логин пользователя или имя группы)");
	Добавить("settings.pool.access.error.object",
		"Раздел управляет правами только на свой пул");
	Добавить("settings.pool.access-new.title", "Выдать роль на пул");
	Добавить("settings.pool.access-new.lead", "Роль выдаётся пользователю или группе"
		+ " целиком на пул и наследуется всеми его пакетами.");

	Добавить("settings.pool.reserved.title", "Зарезервированные имена");
	Добавить("settings.pool.reserved.lead", "Имена, занятые заранее: пакет заведён, версий ещё нет.");
	Добавить("settings.pool.reserved.col.name", "Имя пакета");
	Добавить("settings.pool.reserved.col.rights", "Права на имя");
	Добавить("settings.pool.reserved.col.action", "Действие");
	Добавить("settings.pool.reserved.grant", "выдать права");
	Добавить("settings.pool.reserved.empty", "Занятых заранее имён в пуле нет.");
	Добавить("settings.pool.reserved.note", "Здесь же оказывается имя, пакет которого завели,"
		+ " но ни одной версии так и не опубликовали. Снятие освобождает имя для всех.");
	Добавить("settings.pool.reserved.button.release", "Снять резерв");
	Добавить("settings.pool.reserved.release.title", "Снять резерв имени");
	Добавить("settings.pool.reserved.release.lead", "Имя освободится, выданные на него роли исчезнут.");
	Добавить("settings.pool.reserved.release.note", "Снять резерв имени %1?"
		+ " Вместе с ним пропадут и роли, выданные на это имя: следующий, кто его займёт,"
		+ " ничего не унаследует.");
	Добавить("settings.pool.reserved.release.button", "Снять резерв");
	Добавить("settings.pool.reserved.release.confirm", "Снять резерв имени «%1»?"
		+ " Вместе с ним пропадут и роли, выданные на это имя.");
	Добавить("settings.pool.reserved.error.operation", "Неизвестная операция раздела «Резерв имён»."
		+ " Ничего не изменено — обновите страницу и повторите действие.");
	Добавить("settings.pool.reserved.error.name", "Не задано имя пакета.");
	Добавить("settings.pool.reserved.error.reserve", "Имя не занято: %1");
	Добавить("settings.pool.reserved.error.release", "Резерв не снят: %1");

	Добавить("settings.pool.reserve-new.title", "Занять имя");
	Добавить("settings.pool.reserve-new.lead", "Пакет появится пустым, и первая публикация"
		+ " придёт уже в него, а не заведёт имя заново.");
	Добавить("settings.pool.reserve-new.name.label", "Имя пакета");
	Добавить("settings.pool.reserve-new.name.hint", "Латинские буквы, цифры, «-», «_», «.»;"
		+ " права на занятое имя выдаются в его настройках");
	Добавить("settings.pool.reserve-new.button", "Занять имя");
	Добавить("settings.pool.reserve-new.blocked",
		"Публикация в пул выключена, поэтому занимать имена нельзя: имя осталось бы"
		+ " занятым навсегда — опубликовать в него не смог бы никто. Включите публикацию"
		+ " в разделе «Публикация».");

	Добавить("settings.pool.tags.title", "Теги");
	Добавить("settings.pool.tags.lead", "Как пул раздаёт подвижные метки версий.");
	Добавить("settings.pool.tags.auto.label", "Каналы «по умолчанию» новым пакетам");
	Добавить("settings.pool.tags.auto.on", "заводятся автоматически");
	Добавить("settings.pool.tags.auto.off", "заводит мейнтейнер");
	Добавить("settings.pool.tags.auto.hint", "Включено — пакет этого пула получает stable,"
		+ " prerelease и develop на первой же версии, своей или привезённой с апстрима,"
		+ " ровно те же, что предлагает визард в настройках пакета. Выключено — каналов"
		+ " у нового пакета нет, и «пакет@stable» отвечает «нет такого», пока их"
		+ " не заведут. Пакета, у которого канал уже есть, настройка не касается.");
	Добавить("settings.pool.tags.note", "Теги указывают на конкретные версии пакетов, поэтому"
		+ " настраиваются на пакете: раздел «Теги» в настройках пакета. Теги уровня пула"
		+ " (релиз-бандл) в этой версии не поддерживаются.");

	Добавить("settings.pool.publication.title", "Публикация");
	Добавить("settings.pool.publication.lead", "Принимает ли пул собственные пакеты.");
	Добавить("settings.pool.publication.label", "Публикация разрешена");
	Добавить("settings.pool.publication.on", "принимает opm push");
	Добавить("settings.pool.publication.off", "чистый прокси-кэш");
	Добавить("settings.pool.publication.hint", "Выключите, чтобы получился чистый прокси-кэш:"
		+ " пул только раздаёт то, что взял с апстримов, и не принимает opm push");

	Добавить("settings.pool.upstreams.title", "Апстримы");
	Добавить("settings.pool.upstreams.lead", "Порядок обхода внешних хабов при промахе в пуле.");
	Добавить("settings.pool.upstreams.col.position", "№");
	Добавить("settings.pool.upstreams.col.url", "Апстрим");
	Добавить("settings.pool.upstreams.col.ttl", "TTL, сек");
	Добавить("settings.pool.upstreams.col.state", "Состояние");
	Добавить("settings.pool.upstreams.col.order", "Порядок");
	Добавить("settings.pool.upstreams.empty", "Апстримов нет: пул раздаёт только свои пакеты.");
	Добавить("settings.pool.upstreams.note", "Свои пакеты всегда проверяются РАНЬШЕ апстримов —"
		+ " одноимённый пакет снаружи не может подменить ваш.");
	Добавить("settings.pool.upstreams.button.up", "Выше");
	Добавить("settings.pool.upstreams.button.down", "Ниже");
	Добавить("settings.pool.upstreams.button.on", "Включить");
	Добавить("settings.pool.upstreams.button.off", "Выключить");
	Добавить("settings.pool.upstreams.button.remove", "Удалить");
	Добавить("settings.pool.upstreams.state.off", "выключен вручную — не опрашивается");
	Добавить("settings.pool.upstreams.state.unknown", "ещё не проверялся");
	Добавить("settings.pool.upstreams.state.alive", "жив, проверен %1");
	Добавить("settings.pool.upstreams.state.down", "лежит с %1: %2");
	Добавить("settings.pool.upstreams.col.access", "Доступ");
	Добавить("settings.pool.upstreams.access.token", "по токену");
	Добавить("settings.pool.upstreams.access.anonymous", "анонимно");
	Добавить("settings.pool.upstreams.button.token-off", "Снять токен");
	Добавить("settings.pool.upstreams.state.denied", "не пустил, проверен %1: %2");

	Добавить("settings.pool.upstream-new.title", "Добавить апстрим");
	Добавить("settings.pool.upstream-new.lead",
		"Апстрим — внешний хаб; пул опрашивает апстримы по порядку после промаха у себя.");
	Добавить("settings.pool.upstream-new.url.label", "Адрес апстрима");
	Добавить("settings.pool.upstream-new.url.hint", "Базовый URL выдачи внешнего хаба (контракт opm)");
	Добавить("settings.pool.upstream-new.ttl.label", "TTL кэша, секунд");
	Добавить("settings.pool.upstream-new.ttl.hint",
		"Как долго жить кэшу изменяемых ресурсов (list.txt, latest)");
	Добавить("settings.pool.upstream-new.probe.note",
		"Адрес принимается любой — хаб в вашей сети, хаб на нестандартном порту, публичный"
		+ " хаб. Перед сохранением хаб пробует к нему подключиться: не подключился —"
		+ " источник не заводится, и на этой же странице будет написано, что именно"
		+ " не получилось.");
	Добавить("settings.pool.upstream-new.probe.note.off",
		"Адрес принимается любой — хаб в вашей сети, хаб на нестандартном порту, публичный"
		+ " хаб. Пробное подключение на этом хабе выключено (настройка"
		+ " oshub.upstream.probe.enabled): адрес сохранится, даже если по нему никто"
		+ " не отвечает, и живость источников хаб не проверяет вовсе.");
	Добавить("settings.pool.upstream-new.button", "Добавить");
	Добавить("settings.pool.upstream-new.token.label", "Токен доступа");
	Добавить("settings.pool.upstream-new.token.hint",
		"Нужен, только если выдача источника закрыта. Токен предъявляется каждому запросу"
		+ " к нему и обратно не показывается: пустое поле у заведённого источника означает"
		+ " «оставить прежний», а вернуть анонимное чтение — кнопкой «Снять токен» в списке.");

	Добавить("settings.pool.mirrors.title", "Зеркала пула");
	Добавить("settings.pool.mirrors.lead",
		"Плановая репликация: хаб по расписанию скачивает пакеты другого хаба и складывает"
		+ " их копию в этот пул.");
	Добавить("settings.pool.mirrors.col.upstream", "Апстрим");
	Добавить("settings.pool.mirrors.col.mode", "Режим");
	Добавить("settings.pool.mirrors.col.interval", "Интервал, сек");
	Добавить("settings.pool.mirrors.col.state", "Состояние");
	Добавить("settings.pool.mirrors.col.run", "Прогон");
	Добавить("settings.pool.mirrors.col.sync", "Последний синк");
	Добавить("settings.pool.mirrors.col.actions", "Действия");
	Добавить("settings.pool.mirrors.sync.never", "ещё не было");
	Добавить("settings.pool.mirrors.empty", "Зеркал пока нет: пул ничего не реплицирует.");
	Добавить("settings.pool.mirrors.note", "Зеркало отличается от апстрима: апстрим отдаёт чужой"
		+ " пакет по запросу, зеркало заранее копирует набор пакетов к себе. Содержимое апстрима"
		+ " недоверенное — каждый .ospx проверяется, а уже существующие версии не перезаписываются.");
	Добавить("settings.pool.mirrors.state.on", "включено");
	Добавить("settings.pool.mirrors.state.off", "выключено");
	Добавить("settings.pool.mirrors.button.sync", "Синхронизировать сейчас");
	Добавить("settings.pool.mirrors.button.enable", "Включить");
	Добавить("settings.pool.mirrors.button.disable", "Выключить");
	Добавить("settings.pool.mirrors.button.delete", "Удалить");
	Добавить("settings.pool.mirrors.error.url", "Не задан адрес апстрима зеркала.");
	Добавить("settings.pool.mirrors.error.interval",
		"Интервал синхронизации должен быть целым числом секунд (пусто — значение по умолчанию).");
	Добавить("settings.pool.mirrors.error.disabled",
		"Фоновая синхронизация зеркал выключена на этом хабе: заявку некому разобрать.");
	Добавить("settings.pool.mirrors.sync.queued",
		"Заявка принята: зеркало поставлено в очередь синхронизации. Прогон начнётся, когда"
		+ " фоновый рабочий освободится: занятое зеркало он дочитывает порциями, и это"
		+ " могут быть минуты и десятки минут.");
	Добавить("settings.pool.mirrors.sync.running",
		"Заявка не нужна: синхронизация этого зеркала уже идёт. Живой обход виден по полю"
		+ " «Обновлён» — пока отметка сдвигается, рабочий работает.");
	Добавить("settings.pool.mirrors.sync.waiting",
		"Заявка не нужна: зеркало уже стоит в очереди и ждёт свободного рабочего.");
	Добавить("settings.pool.mirrors.sync.rejected",
		"Заявка не принята: очередь синхронизации её не взяла.");
	Добавить("settings.pool.mirrors.col.access", "Доступ");
	Добавить("settings.pool.mirrors.access.token", "по токену");
	Добавить("settings.pool.mirrors.access.anonymous", "анонимно");
	Добавить("settings.pool.mirrors.button.token-off", "Снять токен");

	Добавить("settings.pool.mirror-new.title", "Новое зеркало");
	Добавить("settings.pool.mirror-new.lead",
		"Пул назначения обязан принимать публикации: зеркало складывает копию именно в него.");
	Добавить("settings.pool.mirror-new.url.label", "Адрес апстрима");
	Добавить("settings.pool.mirror-new.url.hint", "Базовый URL хаба-источника, только http/https");
	Добавить("settings.pool.mirror-new.mode.label", "Режим");
	Добавить("settings.pool.mirror-new.mode.hint", "Протокол хаба-источника");
	Добавить("settings.pool.mirror-new.filter.label", "Фильтр имён");
	Добавить("settings.pool.mirror-new.filter.hint",
		"JSON-массив масок имён пакетов; пусто — забирать всё");
	Добавить("settings.pool.mirror-new.interval.label", "Интервал синхронизации, секунд");
	Добавить("settings.pool.mirror-new.interval.hint",
		"Пусто — интервал по умолчанию; слишком малые значения поднимаются до минимального");
	Добавить("settings.pool.mirror-new.probe.note",
		"Адрес принимается любой. Перед сохранением хаб пробует к нему подключиться:"
		+ " не подключился — зеркало не заводится, и причина будет написана здесь же.");
	Добавить("settings.pool.mirror-new.probe.note.off",
		"Адрес принимается любой. Пробное подключение на этом хабе выключено (настройка"
		+ " oshub.upstream.probe.enabled): зеркало заведётся, даже если по адресу никто"
		+ " не отвечает, а о недоступности апстрима скажет только первый прогон"
		+ " синхронизации.");
	Добавить("settings.pool.mirror-new.button", "Создать зеркало");
	Добавить("settings.pool.mirror-new.token.label", "Токен доступа");
	Добавить("settings.pool.mirror-new.token.hint",
		"Нужен, только если выдача апстрима закрыта. Токен предъявляется каждому запросу"
		+ " к нему и обратно не показывается; вернуть анонимное чтение — кнопкой"
		+ " «Снять токен» в списке.");

	Добавить("settings.pool.quota.title", "Квота");
	Добавить("settings.pool.quota.lead", "Сколько места пул может занять.");
	Добавить("settings.pool.quota.label", "Квота пула, МБ");
	Добавить("settings.pool.quota.hint",
		"−1 — как в хабе, 0 — без ограничения. Квота меряет ВСЁ место, занятое пулом"
		+ " в хранилище: свои публикации, ВКЛЮЧАЯ отозванные (отзыв места не освобождает,"
		+ " артефакт остаётся на диске), кэш прокси, зеркалированное и артефакты заявок."
		+ " Место освобождают удаление пакета и уборка кэша прокси.");
	Добавить("settings.pool.quota.meter.label", "Заполнение пула");
	Добавить("settings.pool.quota.meter.value", "%1 из %2");
	Добавить("settings.pool.quota.meter.unlimited", "занято %1, квота не задана");
	Добавить("settings.pool.quota.readonly",
		"Квоту пула назначает администратор хаба. Здесь она видна, но не меняется.");
	Добавить("settings.pool.quota.inherited", "Действует квота хаба по умолчанию: %1 МБ.");
	Добавить("settings.pool.quota.own", "Собственная квота пула: %1 МБ.");
	Добавить("settings.pool.quota.none", "Ограничения нет: пул растёт, пока есть место в хранилище.");

	Добавить("settings.pool.danger.title", "Опасная зона");
	Добавить("settings.pool.danger.lead", "Необратимые операции над пулом «%1».");
	Добавить("settings.pool.danger.delete.title", "Удаление пула");
	Добавить("settings.pool.danger.note", "Удаление уносит пул со всем, что на нём висело:"
		+ " пакеты и все их версии, файлы артефактов в хранилище, выданные роли и права,"
		+ " ключи доступа пула, подписки, источники и зеркала, незакрытые заявки."
		+ " Артефакты, на которые ссылаются чужие сборки, после этого не скачаются.");
	Добавить("settings.pool.danger.note.free", "Имя «%1» освободится: пул с тем же именем"
		+ " заводится заново и начинается пустым — старое содержимое в нём не появится.");
	Добавить("settings.pool.danger.note.softer", "Мягче удаления: сделать пул приватным"
		+ " (раздел «Видимость и доступ») и запретить публикацию (раздел «Апстримы»).");
	Добавить("settings.pool.danger.note.yank", "Отзыв отдельных версий — в настройках пакета.");
	Добавить("settings.pool.danger.button", "Удалить пул");
	Добавить("settings.pool.danger.echo.label", "Имя пула");
	Добавить("settings.pool.danger.echo.hint", "Введите «%1» — так подтверждается,"
		+ " что удаляется именно этот пул.");
	// почему пул не удаляется (основной пул хаба, идущее зеркало) — слова домена
	// (СервисПулов.ПричинаЗапретаУдаления): экран и API обязаны говорить одно и то же
	Добавить("settings.pool.danger.readonly", "Пул удаляет администратор хаба:"
		+ " это право уровня хаба, роль администратора пула его не даёт.");
	Добавить("settings.pool.danger.error.forbidden", "Удаление пула — право уровня хаба;"
		+ " роль администратора пула его не даёт.");
	Добавить("settings.pool.danger.error.operation", "Неизвестная операция опасной зоны:"
		+ " пул не тронут.");
	Добавить("settings.pool.danger.error.echo", "Пул не удалён: подтверждение не совпало."
		+ " Повторите имя пула «%1» в точности.");
	Добавить("settings.pool.danger.error.delete", "Пул не удалён: %1");

КонецПроцедуры

// «Входящие» — очередь заявок на публикацию: раздел дома «Пул», сводка кабинета и виджет.
Процедура КлючиВходящих()

	Добавить("settings.inbox.title", "Заявки на публикацию");
	Добавить("settings.inbox.lead", "Артефакты, присланные push от тех, у кого прав на пул нет:"
		+ " версия ещё не опубликована, имя не занято.");
	Добавить("settings.inbox.empty", "Заявок, ждущих решения, нет.");
	Добавить("settings.inbox.note", "Одобрение публикует версию и делает заявителя мейнтейнером"
		+ " пакета. Отклонение стирает артефакт и не выдаёт никаких прав; имя остаётся свободным.");

	Добавить("settings.inbox.col.pool", "Пул");
	Добавить("settings.inbox.col.package", "Пакет и версия");
	Добавить("settings.inbox.col.author", "Кто подал");
	Добавить("settings.inbox.col.filed", "Когда");
	Добавить("settings.inbox.col.artifact", "Артефакт");
	Добавить("settings.inbox.col.action", "Решение");

	Добавить("settings.inbox.filed.value", "%1 (заявка №%2)");
	Добавить("settings.inbox.artifact.value", "%1 байт, канал %2");
	Добавить("settings.inbox.size.value", "%1 байт");
	Добавить("settings.inbox.manifest.author", " (автор манифеста: %1)");
	Добавить("settings.inbox.applicant.gone", "учётка удалена");

	Добавить("settings.inbox.button.approve", "Одобрить");
	Добавить("settings.inbox.button.reject", "Отклонить");

	Добавить("settings.inbox.card.pool", "Пул");
	Добавить("settings.inbox.card.package", "Пакет и версия");
	Добавить("settings.inbox.card.applicant", "Заявитель");
	Добавить("settings.inbox.card.manifest-author", "Автор из манифеста");
	Добавить("settings.inbox.card.filed", "Подана");
	Добавить("settings.inbox.card.size", "Размер артефакта");
	Добавить("settings.inbox.card.channel", "Канал");
	Добавить("settings.inbox.card.file", "Имя файла");
	Добавить("settings.inbox.card.sha256", "sha256");

	Добавить("settings.inbox.approve.title", "Одобрить заявку №%1");
	Добавить("settings.inbox.approve.lead", "Версия будет опубликована от имени заявителя,"
		+ " а он станет мейнтейнером этого пакета.");
	Добавить("settings.inbox.approve.button", "Одобрить и опубликовать");

	Добавить("settings.inbox.reject.title", "Отклонить заявку №%1");
	Добавить("settings.inbox.reject.lead", "Артефакт будет стёрт, права не выдаются,"
		+ " имя останется свободным. Причину увидит заявитель.");
	Добавить("settings.inbox.reject.button", "Отклонить заявку");
	Добавить("settings.inbox.reason.label", "Причина отказа");
	Добавить("settings.inbox.reason.placeholder", "Что не так с заявкой");
	Добавить("settings.inbox.reason.hint", "Текст увидит заявитель — назовите, что исправить.");

	Добавить("settings.inbox.crumb", "Входящие");
	Добавить("settings.inbox.page.title", "Заявки на публикацию");
	Добавить("settings.inbox.page.lead", "Всё, что ждёт вашего решения: заявки из пулов,"
		+ " где вы мейнтейнер и выше.");

	Добавить("settings.inbox.widget.title", "Заявки ждут решения: %1");
	Добавить("settings.inbox.widget.lead", "Push в ваши пулы от тех, у кого прав нет."
		+ " Пока заявка не рассмотрена, версия не опубликована.");
	Добавить("settings.inbox.widget.open", "Разобрать заявки");
	Добавить("settings.inbox.widget.rest", "И ещё %1 — в полном списке.");

	Добавить("settings.inbox.error.operation", "Неизвестная операция раздела «Входящие»."
		+ " Ничего не изменено — обновите страницу и повторите действие.");
	Добавить("settings.inbox.error.id", "Не задан номер заявки.");
	Добавить("settings.inbox.error.foreign", "Заявка относится к другому пулу и в этом разделе"
		+ " не рассматривается.");
	Добавить("settings.inbox.error.decide", "Заявка недоступна: %1");
	Добавить("settings.inbox.error.approve", "Заявка не одобрена: %1");
	Добавить("settings.inbox.error.reject", "Заявка не отклонена: %1");
	Добавить("settings.inbox.error.csrf", "Форма устарела: обновите страницу и повторите решение.");

КонецПроцедуры

// Лента личных уведомлений кабинета (КонтроллерУведомлений, ВитринаУведомлений).
Процедура КлючиУведомлений()

	Добавить("office.notifications.crumb", "Уведомления");
	Добавить("office.notifications.page.title", "Уведомления");
	Добавить("office.notifications.page.lead", "Всё, что хаб адресовал лично вам:"
		+ " исход ваших заявок и события вашей учётной записи.");

	Добавить("office.notifications.title", "Ваши события");
	Добавить("office.notifications.lead", "Свежие сверху. Непрочитанные помечены.");
	Добавить("office.notifications.empty", "Хаб вам пока ничего не сообщал.");

	Добавить("office.notifications.col.state", "");
	Добавить("office.notifications.col.event", "Событие");
	Добавить("office.notifications.col.when", "Когда");

	Добавить("office.notifications.new", "новое");
	Добавить("office.notifications.read.button", "Отметить всё прочитанным");
	Добавить("office.notifications.read.done", "Лента отмечена прочитанной.");

	Добавить("office.notifications.widget.title", "Новые уведомления: %1");
	Добавить("office.notifications.widget.lead", "События, адресованные лично вам.");
	Добавить("office.notifications.widget.open", "Открыть ленту");
	Добавить("office.notifications.widget.rest", "И ещё %1 — в полной ленте.");

	Добавить("office.notifications.error.csrf", "Форма устарела: обновите страницу"
		+ " и повторите действие.");

КонецПроцедуры

// Главная кабинета «/me» — сводка состояния дел (КонтроллерЛичногоПространства и витрины
// его блоков: пакеты, первые шаги, личное пространство, токены, зеркала).
Процедура КлючиГлавнойКабинета()

	Добавить("office.home.title", "Личное пространство");
	Добавить("office.home.lead", "Что происходит с вашими пакетами, пулами и ключами.");

	Добавить("office.home.packages.title", "Мои пакеты");
	Добавить("office.home.packages.lead", "Пакеты, которыми вы управляете как автор,"
		+ " владелец пула или мейнтейнер. Свежие публикации сверху.");
	Добавить("office.home.packages.open", "Открыть каталог");
	Добавить("office.home.packages.rest", "И ещё %1 — в каталоге с отбором «мои».");
	Добавить("office.home.packages.published", "опубликована");
	Добавить("office.home.packages.downloads", "скачиваний");

	Добавить("office.home.space.title", "Место в пуле %1");
	Добавить("office.home.space.lead", "Ваше личное пространство: пакеты, опубликованные"
		+ " под вашим логином.");
	Добавить("office.home.space.open", "Открыть пул");
	Добавить("office.home.space.meter.label", "Занято в личном пространстве");
	Добавить("office.home.space.meter.value", "%1 из %2");
	Добавить("office.home.space.meter.unlimited", "Занято %1, ограничения нет.");
	Добавить("office.home.space.packages", "Пакетов в пространстве: %1");

	Добавить("office.home.keys.title", "Токены на исходе: %1");
	Добавить("office.home.keys.lead", "Истёкшим ключом opm не опубликует и не установит:"
		+ " выпустите новый заранее.");
	Добавить("office.home.keys.open", "Мои токены");
	Добавить("office.home.keys.col.name", "Имя");
	Добавить("office.home.keys.col.prefix", "Префикс");
	Добавить("office.home.keys.col.until", "Действует до");
	Добавить("office.home.keys.col.state", "Состояние");
	Добавить("office.home.keys.noname", "(без имени)");
	Добавить("office.home.keys.state.expired", "истёк");
	Добавить("office.home.keys.state.soon", "скоро истечёт");

	Добавить("office.home.mirrors.title", "Зеркала ваших пулов");
	Добавить("office.home.mirrors.lead", "Плановая репликация с чужих хабов."
		+ " Настраивается в доме пула.");
	Добавить("office.home.mirrors.col.pool", "Пул");
	Добавить("office.home.mirrors.col.upstream", "Апстрим");
	Добавить("office.home.mirrors.col.state", "Прогон");
	Добавить("office.home.mirrors.col.sync", "Последний синк");
	Добавить("office.home.mirrors.never", "ни разу");

КонецПроцедуры

// Путь первой публикации: карточка шагов на проводнике «/tour» и в кабинете новичка
// (ВитринаПервойПубликации).
Процедура КлючиПервойПубликации()

	Добавить("office.start.title", "Первая публикация");
	Добавить("office.start.lead", "Четыре шага от свежей инсталляции до версии в каталоге.");
	Добавить("office.start.open", "Открыть проводник");

КонецПроцедуры

// Дом «Пакет» — карта разделов (ДомПакета).
Процедура КлючиДомаПакета()

	Добавить("settings.package.title", "Настройки пакета");
	Добавить("settings.package.lead", "Карточка, права доступа, теги, версии"
		+ " и подписки на события пакета.");
	Добавить("settings.package.nav.card", "Карточка");
	Добавить("settings.package.nav.access", "Права доступа");
	Добавить("settings.package.nav.tags", "Теги");
	Добавить("settings.package.nav.versions", "Версии и метки");
	Добавить("settings.package.nav.webhooks", "Подписки на события");
	Добавить("settings.package.nav.ci", "Доверенная публикация");
	Добавить("settings.package.nav.danger", "Опасная зона");
	Добавить("settings.package.crumb", "настройки");
	Добавить("settings.package.tab", "Настройки: %1");

	Добавить("settings.package.error.section", "Раздел настроек не найден");
	Добавить("settings.package.error.save", "Не удалось сохранить: %1");

	Добавить("settings.package.card.title", "Карточка пакета");
	Добавить("settings.package.card.lead", "Метаданные, которые видит потребитель.");
	Добавить("settings.package.card.description.label", "Описание");
	Добавить("settings.package.card.keywords.label", "Ключевые слова");
	Добавить("settings.package.card.keywords.hint", "Через запятую");
	Добавить("settings.package.card.license.label", "Лицензия");
	Добавить("settings.package.card.repo.label", "Адрес репозитория");
	Добавить("settings.package.card.repo.hint", "Только http/https");
	Добавить("settings.package.card.deprecated.label", "Устаревший (deprecated)");
	Добавить("settings.package.card.deprecated.hint",
		"Пакет остаётся доступным, но помечается как устаревший");
	Добавить("settings.package.card.hidden.label", "Скрыт из каталога");
	Добавить("settings.package.card.hidden.hint",
		"Пакет не показывается в каталоге и поиске, но остаётся доступным по прямой ссылке");

	Добавить("settings.package.access.title", "Права доступа на пакет");
	Добавить("settings.package.access.lead", "Кто и в какой роли работает с этим пакетом"
		+ " сверх того, что даёт роль на пуле.");
	Добавить("settings.package.access.col.action", "Действие");
	Добавить("settings.package.access.empty", "Отдельных прав на пакет не выдано:"
		+ " доступ приходит с пула.");
	Добавить("settings.package.access.note", "Роль действует только на этот пакет и его версии."
		+ " Права на весь пул выдаются в настройках пула.");
	Добавить("settings.package.access.readonly", "Права показаны только для чтения:"
		+ " выдавать и отзывать их может мейнтейнер пакета и выше.");
	Добавить("settings.package.access.error.object",
		"Раздел правит права только на этот пакет");
	Добавить("settings.package.access.error.subject",
		"Пользователь или группа с таким именем не найдены");

	Добавить("settings.package.access-new.title", "Выдать право на пакет");
	Добавить("settings.package.access-new.lead", "Роль на пакете не даёт прав на остальной пул.");

	Добавить("settings.package.access.inherited.title", "Унаследованный доступ");
	Добавить("settings.package.access.inherited.lead",
		"Кто распоряжается пакетом, не значась в списке выше.");
	Добавить("settings.package.access.inherited.note", "Список выше — только роли на самом пакете."
		+ " Менять пакет вправе ещё и райтер пула и выше (роль на пуле наследуется его пакетами),"
		+ " администратор хаба и автор любой опубликованной версии этого пакета. Выдавать и"
		+ " отзывать роли на пакете может мейнтейнер пакета и выше — в том числе полученный"
		+ " наследованием с пула.");
	Добавить("settings.package.access.inherited.pool",
		"Роли на весь пул выдаются там же, где его видимость: %1.");
	Добавить("settings.package.access.inherited.link", "видимость и доступ пула");

	Добавить("settings.package.tags.title", "Теги пакета");
	Добавить("settings.package.tags.lead", "Тег — канал обновления: он помечает свои версии,"
		+ " а «пакет@тег» отдаёт максимальную из них.");
	Добавить("settings.package.tags.col.tag", "Тег");
	Добавить("settings.package.tags.col.mode", "Режим");
	Добавить("settings.package.tags.col.rule", "Правило");
	Добавить("settings.package.tags.col.version", "Версия");
	Добавить("settings.package.tags.empty", "Тегов нет: сам хаб их не заводит."
		+ " Три обычных канала заводит кнопка «Создать каналы „по умолчанию“» над таблицей,"
		+ " любой другой — конструктор тега ниже.");
	Добавить("settings.package.tags.none", "—");
	Добавить("settings.package.tags.repush.allowed", "переиздание разрешено");
	// правило свёрнуто: видимая строка у всех каналов одна, имя канала звучит в доступном
	// имени раскрывашки. Доступное имя НАЧИНАЕТСЯ видимым словом — иначе голосовое
	// управление командой «нажать Показать» этой строки не найдёт (WCAG 2.5.3)
	Добавить("settings.package.tags.rule.show", "Показать");
	Добавить("settings.package.tags.rule.about", "Показать правило канала «%1»");

	Добавить("settings.package.tags.wizard.button", "Создать каналы «по умолчанию»");
	Добавить("settings.package.tags.wizard.title", "Каналы «по умолчанию»");
	Добавить("settings.package.tags.wizard.lead", "Три канала, которых чаще всего ждут"
		+ " от пакета. Заводятся один раз; дальше каждый правится как обычный тег,"
		+ " и визард уже заведённый канал не переопределяет.");
	Добавить("settings.package.tags.wizard.col.channel", "Канал");
	Добавить("settings.package.tags.wizard.col.content", "Что в нём");
	Добавить("settings.package.tags.wizard.col.rule", "Правило");
	Добавить("settings.package.tags.wizard.stable", "Только стабильные версии."
		+ " Он же станет основным каналом пакета, если основного ещё нет.");
	Добавить("settings.package.tags.wizard.prerelease", "Стабильные версии"
		+ " и предрелизы-кандидаты «-rc».");
	Добавить("settings.package.tags.wizard.develop", "Сборочные и нестабильные: «-alpha»,"
		+ " «-beta», «-dev», версии со сборочным суффиксом и строки вне порядка версий"
		+ " вроде SNAPSHOT.");
	Добавить("settings.package.tags.wizard.submit", "Создать каналы");
	// перечень идёт ПОСЛЕ двоеточия и без числового слова перед ним: фраза обязана
	// читаться и с одним занятым именем, и с тремя
	Добавить("settings.package.tags.wizard.busy", "Ни один канал не заведён — занято"
		+ " номерами версий этого пакета: %1. Заведите каналы под другими именами"
		+ " в конструкторе тега.");
	Добавить("settings.package.tags.wizard.skipped", "Каналы заведены, кроме занятых"
		+ " номерами версий этого пакета: %1.");
	Добавить("settings.package.tags.wizard.skipped.nodefault", "Каналы заведены, кроме"
		+ " занятых номерами версий этого пакета: %1. Основного тега у пакета нет —"
		+ " назначьте его действием «Сделать основным» в меню строки, иначе установка"
		+ " без тега пойдёт за последней версией, а не за каналом.");
	Добавить("settings.package.tags.wizard.nothing", "Заводить нечего: все предлагаемые"
		+ " каналы у пакета уже есть.");
	// плашка тега печатается и в настройках, и на публичных страницах — потому и ключи
	// её пометок без «settings». Пометка основного канала рисуется значком, и этот текст
	// её и озвучивает: подсказка браузера и речь скринридера
	Добавить("package.tags.default", "Канал по умолчанию");
	Добавить("package.tags.more", "ещё %1");
	Добавить("settings.package.tags.menu.title", "Действия с каналом «%1»");
	Добавить("settings.package.tags.button.default", "Сделать основным");
	Добавить("settings.package.tags.button.edit", "Изменить");
	Добавить("settings.package.tags.button.remove", "Удалить");
	Добавить("settings.package.tags.error.operation", "Неизвестная операция раздела «Теги»."
		+ " Нажмите «Сохранить тег» или «Проверить правило».");

	Добавить("settings.package.tag-new.title", "Конструктор тега");
	Добавить("settings.package.tag-new.edit.title", "Изменение тега");
	Добавить("settings.package.tag-new.lead", "Ручной тег заводится пустым — версии вешаются"
		+ " в разделе «Версии и метки», у самой версии. Тег-правило отбирает версии само,"
		+ " по выражению.");
	Добавить("settings.package.tag-new.name.label", "Имя тега");
	Добавить("settings.package.tag-new.name.error", "Имя тега не принято: разрешены латиница,"
		+ " цифры, дефис, подчёркивание и точка, не длиннее 64 символов. Имя участвует"
		+ " в адресе и в записи «пакет@тег».");
	Добавить("settings.package.tag-new.name.version.error", "Имя тега занято версией пакета:"
		+ " запись «пакет@имя» читается сначала как точная версия, и тег с таким именем"
		+ " остался бы недостижим. Назовите тег иначе.");
	Добавить("settings.package.tag-new.mode.label", "Вид тега");
	Добавить("settings.package.tag-new.mode.hint", "Правило отбирает версии само;"
		+ " ручному тегу версии назначает мейнтейнер.");
	Добавить("settings.package.tag-new.mode.manual", "ручной — версии вешает мейнтейнер");
	Добавить("settings.package.tag-new.style.label", "Стиль плашки");
	Добавить("settings.package.tag-new.style.hint", "Стиль говорит, ЧТО за канал, а не какого"
		+ " он цвета: цвет берётся из темы, поэтому плашка читается и в светлой, и в тёмной.");
	Добавить("settings.package.tag-new.style.plain", "Обычный");
	Добавить("settings.package.tag-new.style.stable", "Стабильный");
	Добавить("settings.package.tag-new.style.prerelease", "Предварительный");
	Добавить("settings.package.tag-new.style.deprecated", "Устаревший");
	Добавить("settings.package.tag-new.style.special", "Особый");
	Добавить("settings.package.tag-new.icon.label", "Значок");
	Добавить("settings.package.tag-new.icon.hint",
		"Значок наследует цвет стиля, поэтому меняется вместе с ним и с темой");
	Добавить("settings.package.tag-new.icon.none", "Без значка");
	Добавить("settings.package.tag-new.icon.check", "Галочка");
	Добавить("settings.package.tag-new.icon.verified", "Проверено");
	Добавить("settings.package.tag-new.icon.warning", "Внимание");
	Добавить("settings.package.tag-new.icon.stop", "Стоп");
	Добавить("settings.package.tag-new.icon.lock", "Замок");
	Добавить("settings.package.tag-new.icon.history", "История");
	Добавить("settings.package.tag-new.icon.cube", "Сборка");
	Добавить("settings.package.tag-new.icon.key", "Ключ");
	Добавить("settings.package.tag-new.kind.error", "Вид тега не принят: выберите один из"
		+ " предложенных вариантов списка.");
	Добавить("settings.package.tag-new.look.error", "Оформление не принято: стиль и значок"
		+ " выбираются из списка, и присланного значения в нём нет.");
	Добавить("settings.package.tag-new.default.label", "Тег по умолчанию");
	Добавить("settings.package.tag-new.default.hint", "Им резолвится установка без тега."
		+ " Снять признак нельзя — он всегда ровно у одного тега, назначьте его другому.");
	Добавить("settings.package.tag-new.repush.label", "Запрет повторной публикации");
	Добавить("settings.package.tag-new.repush.hint", "Пока запрет включён, номер, попавший"
		+ " под этот тег, вторым push не заменить: публикатору отвечают конфликтом."
		+ " Заменить номер можно только явно — параметром «?force=1» у адреса push,"
		+ " а в новых версиях клиента «opm push --force». Снимите запрет, если номера этого"
		+ " канала переиздаются постоянно, — тогда любой, кто вправе публиковать, заменит"
		+ " уже установленную у людей версию молча.");
	Добавить("settings.package.tag-new.preview.chip", "Так будет выглядеть плашка");
	Добавить("settings.package.tag-new.preview.sample", "тег");
	Добавить("settings.package.tag-new.type.semver", "semver — диапазон версий");
	Добавить("settings.package.tag-new.type.regex", "regex — по строке версии");
	Добавить("settings.package.tag-new.rule.semver.label", "Диапазон версий");
	Добавить("settings.package.tag-new.rule.semver.hint", "Например «^1.2» или «>=2.0.0»."
		+ " Диапазон «*» пререлизы НЕ пропускает, «>=0.0.0-0» — пропускает");
	Добавить("settings.package.tag-new.rule.regex.label", "Регулярное выражение");
	Добавить("settings.package.tag-new.rule.regex.hint", "regex НЕ якорится автоматически и совпадает"
		+ " с ПОДСТРОКОЙ версии: «1\\.2» поймает и «11.2.0». Пользуйтесь якорями ^…$");
	Добавить("settings.package.tag-new.check.button", "Проверить правило");
	Добавить("settings.package.tag-new.preview.version", "Тег будет отдавать версию %1");
	Добавить("settings.package.tag-new.preview.matches", "Под правило попадут: %1");
	Добавить("settings.package.tag-new.preview.empty", "Ни одна версия пакета под правило не попадает"
		+ " — такой тег не отдаст ничего.");
	Добавить("settings.package.tag-new.preview.error", "Правило не применено: %1");
	Добавить("settings.package.tag-new.button", "Сохранить тег");
	Добавить("settings.package.tag-new.saved.matches", "Под правило тега %1 попали версии: %2");
	Добавить("settings.package.tag-new.saved.matches.yanked", "Под правило тега %1 попали"
		+ " версии: %2. Отозванные тоже попали (%3), но установка их не выбирает.");
	Добавить("settings.package.tag-new.saved.yanked", "Под правило тега %1 попали только"
		+ " отозванные версии (%2) — установка их не выбирает, и тег не отдаст ничего.");
	Добавить("settings.package.tag-new.saved.empty", "Под правило тега %1 не попала ни одна"
		+ " версия пакета — такой тег не отдаст ничего.");
	Добавить("settings.package.tag-new.save.lead", "Сохранение одноимённого тега"
		+ " переопределяет прежний. Ручной тег заводится пустым: версии вешаются в разделе"
		+ " «Версии и метки», в меню нужной версии.");
	Добавить("settings.package.tag-new.save.switch.manual", "Тег %1 сейчас в режиме правила."
		+ " После сохранения правило будет стёрто, а канал станет ПУСТЫМ: версии в него"
		+ " набирают вручную, в меню версии.");
	Добавить("settings.package.tag-new.save.switch.rule", "Тег %1 сейчас ручной. После"
		+ " сохранения его метки будут сняты, а состав канала начнёт считаться правилом.");

	Добавить("settings.package.versions.title", "Версии и метки");
	Добавить("settings.package.versions.lead", "Отзыв, восстановление и теги опубликованных версий.");
	Добавить("settings.package.versions.col.version", "Версия");
	Добавить("settings.package.versions.col.state", "Состояние");
	Добавить("settings.package.versions.col.published", "Опубликована");
	Добавить("settings.package.versions.col.tags", "Теги");
	Добавить("settings.package.versions.col.action", "Действие");
	Добавить("settings.package.versions.empty", "Нет опубликованных версий.");
	Добавить("settings.package.versions.error.operation", "Неизвестная операция раздела");
	Добавить("settings.package.versions.yanked", "отозвана");
	Добавить("settings.package.versions.note", "Отзыв не удаляет артефакт: уже собранные"
		+ " проекты продолжают его получать, но новые установки версию не выбирают.");
	Добавить("settings.package.versions.button.yank", "Отозвать");
	Добавить("settings.package.versions.button.unyank", "Восстановить");
	Добавить("settings.package.versions.menu.title", "Действия с версией %1");
	Добавить("settings.package.versions.menu.tag.label", "Тег");
	Добавить("settings.package.versions.menu.tag.add", "Добавить тег");
	Добавить("settings.package.versions.menu.tag.none", "Ручных тегов у пакета нет —"
		+ " вешать нечего. Заведите тег в конструкторе: %1.");
	Добавить("settings.package.versions.menu.tag.link", "раздел «Теги пакета»");
	Добавить("settings.package.versions.menu.tag.unknown", "Такого ручного тега у пакета нет."
		+ " Выберите тег из списка либо заведите его в разделе «Теги пакета»: тег-правило"
		+ " набирает версии сам, и ручная метка на нём ни на что не влияет.");
	Добавить("settings.package.versions.unset.hint", "Снять тег %1 с версии %2");
	Добавить("settings.package.versions.unset.title", "Снять тег с версии");
	Добавить("settings.package.versions.unset.lead", "Действие обратимо: тег можно повесить"
		+ " обратно тем же меню версии.");
	Добавить("settings.package.versions.unset.note", "Снять тег %1 с версии %2?"
		+ " Сам тег останется, из его канала уйдёт только эта версия.");
	Добавить("settings.package.versions.unset.button", "Снять");
	Добавить("settings.package.versions.unset.confirm", "Снять тег «%1» с версии «%2»?"
		+ " Сам тег останется, из его канала уйдёт только эта версия.");

	Добавить("settings.package.danger.title", "Опасная зона");
	Добавить("settings.package.danger.lead", "Необратимые операции над пакетом.");
	Добавить("settings.package.danger.note", "Удаление пакета не поддерживается: имя пакета — часть"
		+ " публичного контракта хаба, а его артефакты уже могли попасть в чужие сборки."
		+ " Доступные необратимые действия: отзыв версии (раздел «Версии и метки»)"
		+ " и пометка «устаревший» либо «скрыт» (раздел «Карточка»).");
	Добавить("settings.package.danger.public", "Публичная страница: %1");

КонецПроцедуры

// Раздел «Доверенная публикация» дома «Пакет» (ВитринаДоверияCI, ПультДоверияCI).
Процедура КлючиДоверияCI()

	Добавить("settings.package.ci.title", "Доверенные конвейеры");
	Добавить("settings.package.ci.lead", "Конвейеры сборки, которым разрешено публиковать"
		+ " версии этого пакета по короткоживущему id-token — без постоянного ключа"
		+ " в секретах репозитория.");
	Добавить("settings.package.ci.col.repo", "Репозиторий");
	Добавить("settings.package.ci.col.workflow", "Конвейер");
	Добавить("settings.package.ci.col.ref", "Реф");
	Добавить("settings.package.ci.col.author", "Кем и когда");
	Добавить("settings.package.ci.col.action", "Действие");
	Добавить("settings.package.ci.issuer", "издатель %1");
	Добавить("settings.package.ci.any", "любой");
	Добавить("settings.package.ci.ref.wide", "без ограничения");
	Добавить("settings.package.ci.empty", "Доверенных конвейеров у пакета нет:"
		+ " публиковать его сейчас может только человек со своим ключом доступа.");
	Добавить("settings.package.ci.note", "Совпасть должно КАЖДОЕ поле записи; пустым"
		+ " остаётся только конвейер — это «любой конвейер репозитория»."
		+ " Доверие не заводит новых имён: пакет уже существует, а первую публикацию"
		+ " закрывают резерв имени и очередь заявок пула.");
	Добавить("settings.package.ci.button.revoke", "Отозвать");
	Добавить("settings.package.ci.revoke.title", "Отозвать доверие конвейеру");
	Добавить("settings.package.ci.revoke.lead", "Следующая попытка публикации из этого"
		+ " конвейера получит отказ.");
	Добавить("settings.package.ci.revoke.note", "Отозвать доверие конвейеру %1?");
	Добавить("settings.package.ci.revoke.button", "Отозвать доверие");
	Добавить("settings.package.ci.revoke.confirm", "Отозвать доверие конвейеру «%1»?"
		+ " Следующая попытка публикации из него получит отказ.");
	Добавить("settings.package.ci.error.forbidden", "Доверенные конвейеры пакета"
		+ " настраивают его мейнтейнеры и выше.");
	Добавить("settings.package.ci.error.csrf", "Форма устарела: обновите страницу"
		+ " и повторите действие.");
	Добавить("settings.package.ci.error.operation", "Неизвестная операция раздела"
		+ " «Доверенная публикация».");
	Добавить("settings.package.ci.error.id", "Не указана запись доверия.");
	Добавить("settings.package.ci.error.trust", "Конвейер не добавлен: %1");
	Добавить("settings.package.ci.error.revoke", "Доверие не отозвано: %1");
	Добавить("settings.package.ci.error.link", "Ссылка не разобрана. Нужен адрес файла"
		+ " в вебе — GitHub «…/blob/<ветка>/<путь>» либо GitLab «…/-/blob/<ветка>/<путь>»"
		+ " — и инсталляция, которой хаб доверяет выпуск id-token: github.com, gitlab.com"
		+ " либо адрес из настройки хаба oshub.publish.ci.issuers. Ссылку на другую"
		+ " инсталляцию хаб не разбирает: подставить вместо её хоста публичный адрес"
		+ " значило бы направить доверие на чужой репозиторий с тем же именем.");
	Добавить("settings.package.ci.error.link.empty", "Ссылка не введена. Вставьте адрес"
		+ " файла workflow — или заполните поля руками и нажмите «Доверить конвейеру».");

	Добавить("settings.package.ci-link.title", "Есть ссылка на workflow?");
	Добавить("settings.package.ci-link.lead", "Разберём её и заполним поля ниже — запись"
		+ " при этом не создаётся: проверьте поля и нажмите «Доверить конвейеру».");
	Добавить("settings.package.ci-link.label", "Ссылка на файл workflow");
	Добавить("settings.package.ci-link.hint", "Адрес файла в GitHub или GitLab, как он"
		+ " открывается в браузере. Ветку от тега ссылка не отличает: вид рефа хаб предложит"
		+ " по значению — проверьте его после заполнения");
	Добавить("settings.package.ci-link.button", "Разобрать ссылку");

	Добавить("settings.package.ci-new.title", "Доверить конвейеру");
	Добавить("settings.package.ci-new.lead", "Репозиторий и реф обязательны, издателя хаб"
		+ " выводит из типа репозитория. Конвейер необязателен, пустое поле значит «любой»."
		+ " Подсказки полей ведут к готовому конвейеру ниже — он запускается по тегам «v*»;"
		+ " короткие значения хаб достраивает до строк, которые приезжают в клеймах.");
	Добавить("settings.package.ci-new.provider.label", "Тип репозитория");
	Добавить("settings.package.ci-new.provider.hint", "От него зависят и набор полей,"
		+ " и издатель токена");
	Добавить("settings.package.ci-new.provider.github", "GitHub Actions");
	Добавить("settings.package.ci-new.provider.gitlab", "GitLab CI");
	Добавить("settings.package.ci-new.advanced", "Дополнительно");
	Добавить("settings.package.ci-new.issuer.label", "Издатель (клейм iss)");
	Добавить("settings.package.ci-new.issuer.auto", "по типу репозитория");
	Добавить("settings.package.ci-new.issuer.hint", "Заполнять нужно только на инсталляции"
		+ " с несколькими издателями одного типа — например с self-hosted GitLab,"
		+ " добавленным настройкой хаба");
	Добавить("settings.package.ci-new.repo.label", "Репозиторий");
	Добавить("settings.package.ci-new.repo.hint", "owner/repo у GitHub,"
		+ " group/project (можно с подгруппами) у GitLab");
	Добавить("settings.package.ci-new.workflow.label", "Конвейер");
	Добавить("settings.package.ci-new.workflow.hint", "Имя файла workflow: у GitHub Actions"
		+ " они всегда лежат в .github/workflows, и приставку хаб достроит сам."
		+ " Сверяется workflow, ЗАПУСТИВШИЙСЯ в этом репозитории; что он вызывает внутри"
		+ " — reusable из другого репозитория, чужой action — решает его автор."
		+ " Пусто — любой конвейер репозитория");
	Добавить("settings.package.ci-new.workflow.hint.gitlab", "Путь к файлу конфигурации CI"
		+ " от корня репозитория. Почти всегда .gitlab-ci.yml; менять нужно, только если"
		+ " в настройках проекта задан свой путь. Пусто — любой конвейер репозитория");
	Добавить("settings.package.ci-new.ref.label", "Ветка, тег или маска");
	Добавить("settings.package.ci-new.ref.hint", "Короткое имя либо глоб-маска: «v*» (теги"
		+ " релизов — так запускается готовый конвейер ниже), «main», «release/*» (ветки"
		+ " внутри release/), «**» (любой реф). «*» подставляется вместо любых символов,"
		+ " кроме «/», «**» — включая «/». Значение с refs/ принимается как есть");
	Добавить("settings.package.ci-new.ref-kind.label", "Вид рефа");
	Добавить("settings.package.ci-new.ref-kind.hint", "Чем считать короткое имя или маску;"
		+ " значение с refs/ и маску «**» этот выбор не трогает. Стоит на том, чем"
		+ " запускается готовый конвейер: тег, записанный веткой, не совпадёт ни с чем");
	Добавить("settings.package.ci-new.ref-kind.branch", "ветка");
	Добавить("settings.package.ci-new.ref-kind.tag", "тег");
	Добавить("settings.package.ci-new.ref.warning", "Маска, не ограничивающая имя — «**»,"
		+ " «*», «refs/heads/*» — означает публикацию с ЛЮБОЙ ветки доверенного"
		+ " репозитория. Это классическая атака на GitHub Actions: ветка или форк"
		+ " с изменённым workflow получает id-token того же репозитория — и вместе с ним"
		+ " право публиковать ваш пакет. Назовите ветку релизов или маску вида «v*».");
	Добавить("settings.package.ci-new.button", "Доверить конвейеру");

	Добавить("settings.package.ci-snippet.title", "Готовый конвейер");
	Добавить("settings.package.ci-snippet.lead", "Скопируйте в репозиторий пакета"
		+ " и поправьте шаги сборки под свой проект.");
	Добавить("settings.package.ci-snippet.github",
		"GitHub Actions — .github/workflows/publish.yml");
	Добавить("settings.package.ci-snippet.gitlab", "GitLab CI — .gitlab-ci.yml");
	Добавить("settings.package.ci-snippet.unknown-host", "Внешний адрес хаба не задан,"
		+ " поэтому готовый конвейер показать не из чего: он обязан ссылаться на настоящий"
		+ " адрес инсталляции, а не на localhost сервера. Задайте настройку «URL инстанса»"
		+ " в настройках хаба.");
	Добавить("settings.package.ci-snippet.unknown-audience", "Хаб не знает, для кого"
		+ " выпускается его id-token, поэтому доверенные конвейеры сейчас не публикуют"
		+ " вовсе, а готовый конвейер было бы нечем заполнить: аудитория в нём обязана"
		+ " совпасть с той, что сверяет хаб. Задайте настройку «URL инстанса» либо"
		+ " oshub.publish.ci.audience в настройках хаба.");

КонецПроцедуры

// Дом «Хаб» — карта разделов (ДомХаба).
Процедура КлючиДомаХаба()

	Добавить("settings.hub.title", "Настройки хаба");
	Добавить("settings.hub.lead", "То, чем администратор хаба распоряжается: кто входит,"
		+ " как хаб выглядит, кому что позволено и чем он ходит наружу. У каждого значения"
		+ " виден источник — умолчание хаба или введённое здесь. Размеры, таймауты, интервалы"
		+ " и адреса хранилища задаёт тот, кто разворачивает инсталляцию.");
	Добавить("settings.hub.nav.identity", "Базовые настройки");
	Добавить("settings.hub.nav.branding", "Брендирование");
	Добавить("settings.hub.nav.login", "Вход и регистрация");
	Добавить("settings.hub.nav.people", "Люди");
	Добавить("settings.hub.nav.pools", "Пулы");
	Добавить("settings.hub.nav.storage", "Хранилище");
	Добавить("settings.hub.nav.trusted", "Доверенная публикация");
	Добавить("settings.hub.nav.mail", "Почта");
	Добавить("settings.hub.nav.mirrors", "Зеркалирование");
	Добавить("settings.hub.nav.webhooks", "Подписки на события");
	Добавить("settings.hub.nav.password", "Политика пароля");
	Добавить("settings.hub.nav.providers", "Провайдеры входа");
	Добавить("settings.hub.nav.legacy", "Легаси-флоу");
	Добавить("settings.hub.block.delivery", "Доставка уведомлений");
	Добавить("settings.hub.nav.proxy", "Прокси апстрима");
	Добавить("settings.hub.nav.audit", "Аудит");
	Добавить("settings.hub.nav.maintenance", "Обслуживание");
	Добавить("settings.hub.screen.users", "Пользователи");
	Добавить("settings.hub.screen.groups", "Группы");
	Добавить("settings.hub.screens.title", "Отдельные экраны раздела");
	Добавить("settings.hub.screens.lead", "Эти экраны пока живут по своим адресам"
		+ " и переедут в этот раздел позже.");
	Добавить("settings.hub.fine.title", "Тонкие настройки");
	Добавить("settings.hub.fine.lead", "Значения с рабочими умолчаниями: их меняют,"
		+ " когда об этом просит нагрузка, регламент или чужая интеграция.");
	Добавить("settings.hub.pools.lead", "Правила пулов на этом хабе.");
	Добавить("settings.hub.pools.main.title", "Основной пул хаба");
	Добавить("settings.hub.pools.main.lead", "Пул, в который ведут короткие адреса"
		+ " /download, /dev-channel и /push.");
	Добавить("settings.hub.pools.main.label", "Основной пул");
	Добавить("settings.hub.pools.main.hint", "Переключается в списке ниже:"
		+ " меню строки пула, «Сделать основным»");
	Добавить("settings.hub.pools.main.none", "не назначен — короткие адреса отвечают отказом");

	Добавить("settings.hub.pools.list.title", "Пулы хаба");
	Добавить("settings.hub.pools.list.lead", "Все пулы инсталляции: видимость, занятое место,"
		+ " квота и признак основного. Остальные настройки пула живут в его доме.");
	Добавить("settings.hub.pools.col.usage", "Занято и квота");
	Добавить("settings.hub.pools.quota.inherited", "квота хаба");
	Добавить("settings.hub.pools.menu.title", "Действия с пулом «%1»");
	Добавить("settings.hub.pools.action.quota", "Изменить квоту");
	Добавить("settings.hub.pools.quota.title", "Квота и видимость пула «%1»");
	Добавить("settings.hub.pools.quota.lead", "Квоту пула назначает только администратор хаба;"
		+ " владелец пула видит её у себя, но не меняет.");
	Добавить("settings.hub.pools.quota.button", "Применить");
	Добавить("settings.hub.pools.quota.error.pool", "Квота НЕ изменена: пул не указан.");
	Добавить("settings.hub.pools.quota.error.number",
		"Квота НЕ изменена: ожидается целое число мегабайт (0 — без лимита).");
	Добавить("settings.hub.pools.quota.error.cap", "Квота НЕ изменена: не больше %1 МБ.");
	Добавить("settings.hub.pools.quota.error.apply", "Квота НЕ изменена: %1");

	Добавить("settings.hub.pools.personal.confirm.title", "Выключить личные пространства");
	Добавить("settings.hub.pools.personal.confirm.lead", "Выключение сносит все личные пулы"
		+ " хаба вместе с содержимым. Восстановить их будет нечем.");
	Добавить("settings.hub.pools.personal.confirm.counts", "Будет удалено безвозвратно:"
		+ " личных пространств — %1, из них с пакетами — %2; пакетов — %3, версий — %4.");
	Добавить("settings.hub.pools.personal.confirm.echo.label", "Число удаляемых пространств");
	Добавить("settings.hub.pools.personal.confirm.echo.hint", "Введите %1 — ровно столько"
		+ " личных пространств будет снесено.");
	Добавить("settings.hub.pools.personal.confirm.button", "Снести личные пространства");
	Добавить("settings.hub.pools.personal.error.echo", "Ничего не удалено: введено не то"
		+ " число. Чтобы снести личные пространства, повторите ровно %1.");
	Добавить("settings.hub.pools.personal.error.apply",
		"Настройка «Личные пространства» не сохранена: %1");
	Добавить("settings.hub.pools.personal.error.off", "Личные пространства уже выключены:"
		+ " сносить нечего. Обновите страницу.");
	Добавить("settings.hub.pools.personal.error.wipe", "Снос личных пространств не выполнен:"
		+ " %1. Настройка осталась включённой, операцию можно повторить.");
	Добавить("settings.hub.pools.personal.error.grant", "Раздача личных пространств"
		+ " не выполнена: %1");
	Добавить("settings.hub.pools.personal.off.done", "Личные пространства выключены:"
		+ " снесено пространств — %1, пакетов — %2, версий — %3.");
	Добавить("settings.hub.pools.personal.off.partial", "Снесено пространств — %1,"
		+ " но %2 снести не удалось: причина в журнале хаба. Настройка осталась включённой —"
		+ " повторите операцию, когда причина устранена.");
	Добавить("settings.hub.pools.personal.on.done", "Личные пространства включены:"
		+ " создано — %1, уже было — %2, пропущено отключённых учёток — %3,"
		+ " осталось без пространства — %4.");

	Добавить("settings.hub.passwordlogin.confirm.title", "Выключить вход по логину и паролю");
	Добавить("settings.hub.passwordlogin.confirm.lead", "После выключения на странице входа"
		+ " не останется полей логина и пароля, а POST входа, вход в API и регистрация"
		+ " с паролем будут отвечать отказом. Войти можно будет только через провайдера.");
	Добавить("settings.hub.passwordlogin.confirm.counts", "Администраторов, готовых войти"
		+ " через провайдера, — %1; включённых провайдеров входа — %2.");
	Добавить("settings.hub.passwordlogin.confirm.stays", "Выключение НЕ гасит уже выданное:"
		+ " открытые сессии браузера продолжают работать, токены доступа (PAT) продолжают"
		+ " действовать, смена собственного пароля в кабинете остаётся доступной, а вход"
		+ " CLI и мастер первого запуска пароля и не спрашивают. Если причина выключения —"
		+ " утёкший пароль, отдельно завершите сессии и отзовите токены.");
	Добавить("settings.hub.passwordlogin.confirm.rescue", "Если провайдер сломается, форму"
		+ " временно возвращает переменная окружения OSHUB_AUTH_PASSWORD_ENABLED=true:"
		+ " пока она задана, значение форсировано конфигурацией и этот тумблер не"
		+ " редактируется. Штатный возврат — войти провайдером и включить тумблер обратно,"
		+ " после чего переменную убрать.");
	Добавить("settings.hub.passwordlogin.confirm.echo.label", "Подтверждение");
	Добавить("settings.hub.passwordlogin.confirm.echo.hint", "Введите «%1» — иначе ничего"
		+ " не изменится.");
	Добавить("settings.hub.passwordlogin.confirm.echo.sample", "выключить");
	Добавить("settings.hub.passwordlogin.confirm.button", "Выключить парольный вход");
	Добавить("settings.hub.passwordlogin.error.echo", "Ничего не изменилось: введено не то"
		+ " слово. Чтобы выключить парольный вход, повторите ровно «%1».");
	Добавить("settings.hub.passwordlogin.error.apply",
		"Настройка «Вход по логину и паролю» не сохранена: %1");
	Добавить("settings.hub.passwordlogin.error.off", "Вход по логину и паролю уже выключен:"
		+ " выключать нечего. Обновите страницу.");
	Добавить("settings.hub.passwordlogin.error.lockout",
		"Вход по логину и паролю оставлен включённым: %1");
	Добавить("settings.hub.passwordlogin.lockout.providers",
		"на хабе нет ни одного включённого провайдера входа, и после выключения формы"
		+ " войти будет нечем. Заведите провайдера в разделе «Провайдеры входа»"
		+ " (/hub/settings/providers) и войдите через него хотя бы одним администратором.");
	Добавить("settings.hub.passwordlogin.lockout.identities",
		"ни у одного администратора хаба нет привязанной личности включённого провайдера,"
		+ " и после выключения формы войти будет некому. Привяжите провайдера в кабинете"
		+ " (/me/settings/oidc) хотя бы одному администратору.");
	Добавить("settings.hub.passwordlogin.off.done", "Вход по логину и паролю выключен:"
		+ " на странице входа остались только провайдеры.");
	Добавить("settings.hub.passwordlogin.on.done", "Вход по логину и паролю включён:"
		+ " форма логина и пароля снова на странице входа.");

	Добавить("settings.hub.error.section", "Раздел настроек не найден");
	Добавить("settings.hub.error.operation", "Неизвестная операция раздела:"
		+ " обновите страницу и повторите действие");
	Добавить("settings.hub.error.key", "Эта настройка не редактируется в текущем разделе");
	Добавить("settings.hub.error.field", "Настройка «%1» не сохранена: %2.");
	Добавить("settings.hub.error.applied",
		"Остальная форма уже применена: %1 — эти значения действуют.");
	Добавить("settings.hub.error.applied.none", "Ничего из формы не применено.");

	// пояснения РАЗДЕЛОВ дома (заголовок раздела приходит из дерева навигации, nav.*)
	Добавить("settings.hub.identity.lead",
		"Как хаб представляется клиентам opm и браузеру: внешний адрес и порт.");
	Добавить("settings.hub.branding.lead",
		"Как хаб называет себя и как выглядит по умолчанию: название, подпись подвала,"
		+ " тема и акцент. Значения применяются сразу; тему и акцент посетитель может"
		+ " переопределить в своём аккаунте.");
	Добавить("settings.hub.login.lead", "Как попадают в этот хаб: кто может завести учётную"
		+ " запись, чем можно войти и сколько живут выданные сессии и приглашения.");
	Добавить("settings.hub.people.lead", "Учётные записи хаба и группы, через которые им"
		+ " выдаются права.");
	Добавить("settings.hub.mail.lead", "Как хаб отправляет письма: приглашения, сброс пароля"
		+ " и подтверждение адреса.");
	Добавить("settings.hub.trusted.lead", "На каком внешнем доказательстве хаб пускает"
		+ " публиковать без своей роли.");
	Добавить("settings.hub.mirrors.lead",
		"Числа плановой репликации с чужих хабов: сколько зеркал разрешено пулу, как часто"
		+ " они ходят к источнику и через сколько молчания прогон считается брошенным."
		+ " Предела на размер привозимого пакета здесь нет — приезжающее судится теми же"
		+ " числами приёма, что и публикация снаружи, в разделе «Хранилище».");
	Добавить("settings.hub.mirrors.overview.title", "Зеркала всех пулов");
	Добавить("settings.hub.mirrors.overview.lead", "Список зеркал по всем пулам, которыми"
		+ " вы распоряжаетесь: состояние прогона и дата последней синхронизации в одном"
		+ " месте — без обхода настроек пулов по одному.");
	Добавить("settings.hub.mirrors.overview.button", "Открыть обзор зеркал");
	Добавить("settings.hub.password.section.lead", "Каким хаб считает годный пароль. Требования"
		+ " применяются к новым паролям — регистрации, смене, приглашению и восстановлению;"
		+ " уже заведённые пароли ужесточение не ломает, вход по ним продолжает работать.");
	Добавить("settings.hub.delivery.lead", "Слать ли уведомления вообще и пускать ли их"
		+ " по http. Темп разбора очереди и повторы задаются конфигурацией инсталляции.");
	Добавить("settings.hub.legacy.lead", "Старый путь публикации по токену GitHub: он"
		+ " остался ради пакетов, переехавших из oscript-library, и к доверенной публикации"
		+ " отношения не имеет.");
	Добавить("settings.hub.proxy.lead", "Как хаб ходит в чужие хабы за пакетами, которых"
		+ " у него нет: таймауты, срок кэша отрицательных ответов и принудительный офлайн.");

	Добавить("settings.hub.storage.state.title", "Хранилище");
	Добавить("settings.hub.storage.state.lead",
		"Куда хаб складывает опубликованные пакеты и сколько там места. Всё это задаёт тот,"
		+ " кто разворачивает инсталляцию; из интерфейса состояние читают, а не меняют.");
	Добавить("settings.hub.storage.meter.label", "Занято места в хранилище");
	Добавить("settings.hub.storage.meter.caption", "%1 из %2");
	Добавить("settings.hub.storage.meter.free",
		"Занято %1. Общего потолка объёма у хаба нет — место ограничивает только диск"
		+ " и квоты отдельных пулов.");
	Добавить("settings.hub.storage.col.what", "Что");
	Добавить("settings.hub.storage.col.how", "Как настроено");
	Добавить("settings.hub.storage.row.backend", "На чём хранится");
	Добавить("settings.hub.storage.row.where", "Где лежат артефакты");
	Добавить("settings.hub.storage.row.quota", "Потолок объёма");
	Добавить("settings.hub.storage.row.upload", "Предельный размер одной публикации");
	Добавить("settings.hub.storage.backend.fs", "Файловая система сервера");
	Добавить("settings.hub.storage.backend.s3", "Объектное хранилище S3");
	Добавить("settings.hub.storage.where.s3", "корзина «%1» на %2");
	Добавить("settings.hub.storage.where.prefix", "под префиксом «%1»");
	Добавить("settings.hub.storage.quota.none", "не ограничен");
	Добавить("settings.hub.storage.env.note",
		"Меняется при развёртывании — переменными окружения %1");

	Добавить("settings.hub.branding.assets.title", "Картинки оформления");
	Добавить("settings.hub.branding.assets.lead",
		"Свой логотип в шапке и своя иконка сайта. Пока ничего не загружено, хаб"
		+ " рисует фирменные картинки из поставки.");
	Добавить("settings.hub.branding.assets.col.asset", "Картинка");
	Добавить("settings.hub.branding.assets.col.current", "Сейчас");
	Добавить("settings.hub.branding.assets.col.action", "Действие");
	Добавить("settings.hub.branding.assets.logo.label", "Логотип в шапке");
	Добавить("settings.hub.branding.assets.logo.hint",
		"Знак рядом с названием хаба. Рисуется высотой 28 пикселей, ширина берётся"
		+ " по пропорциям картинки, поэтому горизонтальный логотип не сплющивается;"
		+ " очень длинный ужимается по ширине. Подойдёт SVG, PNG, JPEG, GIF, WebP или AVIF.");
	Добавить("settings.hub.branding.assets.favicon.label", "Иконка сайта");
	Добавить("settings.hub.branding.assets.favicon.hint",
		"Значок вкладки браузера и ярлыка на домашнем экране. Загруженная иконка"
		+ " заменяет весь фирменный набор значков сразу.");
	Добавить("settings.hub.branding.assets.default", "фирменная из поставки");
	Добавить("settings.hub.branding.assets.uploaded", "загружена: %1, %2");
	Добавить("settings.hub.branding.assets.reset", "Вернуть стандартную");
	Добавить("settings.hub.branding.assets.upload", "Загрузить картинки");
	Добавить("settings.hub.branding.assets.limit", "Размер файла — не больше %1.");
	Добавить("settings.hub.branding.assets.warning",
		"Файл отдаётся посетителям как есть: хаб не проверяет и не обезвреживает его"
		+ " содержимое, поэтому SVG со скриптом выполнится в браузере каждого,"
		+ " кто откроет страницу. Загружайте только то, чему доверяете.");
	Добавить("settings.hub.branding.error.empty",
		"Файл не выбран: укажите картинку в поле логотипа или иконки.");
	Добавить("settings.hub.branding.error.large",
		"%1: файл весит %2 при допустимых %3.");
	Добавить("settings.hub.branding.error.type",
		"%1: это не картинка известного хабу формата. Допустимы SVG, PNG, JPEG, GIF,"
		+ " WebP, AVIF и ICO.");
	Добавить("settings.hub.branding.error.key", "Такой картинки оформления в хабе нет.");

	Добавить("settings.hub.version.title", "Сборка");
	Добавить("settings.hub.version.lead", "Версия хаба, которую вы сейчас видите.");
	Добавить("settings.hub.identity.version.label", "Версия хаба");
	Добавить("settings.hub.identity.version.hint", "Версия сборки openhub");

	Добавить("settings.hub.password.title", "Политика пароля");
	Добавить("settings.hub.password.lead", "Единая для регистрации, смены пароля и онбординга.");
	Добавить("settings.hub.password.note", "Так выглядит действующая политика. Поля выше"
		+ " меняют её сразу — ближайшая же проверка пароля судит по новым требованиям.");

	Добавить("settings.hub.audit.title", "Журнал аудита");
	Добавить("settings.hub.audit.lead", "Мутирующие операции хаба: кто, что и с чем сделал.");
	Добавить("settings.hub.audit.col.when", "Когда (UTC)");
	Добавить("settings.hub.audit.col.who", "Кто");
	Добавить("settings.hub.audit.col.action", "Действие");
	Добавить("settings.hub.audit.col.object", "Объект");
	Добавить("settings.hub.audit.col.subject", "Кому");
	Добавить("settings.hub.audit.col.ip", "Адрес");
	Добавить("settings.hub.audit.empty",
		"В прочитанном хвосте журнала записей по этому отбору нет.");
	Добавить("settings.hub.audit.tail.note", "Экран читает хвост файла журнала: отбор и страницы действуют в его пределах, более ранние записи остаются в файле. Время — UTC.");
	Добавить("settings.hub.audit.tail.truncated", "Журнал прочитан НЕ ЦЕЛИКОМ: файл длиннее читаемого хвоста, показан только его конец. Записи за пределами прочитанного остались в файле, но в отбор и страницы не попали — пустая страница здесь не значит «событий не было». Время — UTC.");
	Добавить("settings.hub.audit.source.missing",
		"Источник журнала недоступен: файл журнала не читается. Записи есть, но показать их нечем.");
	Добавить("settings.hub.audit.page.first", "В начало журнала");
	Добавить("settings.hub.audit.cell.empty", "—");
	Добавить("settings.hub.audit.details.summary", "Подробнее");
	Добавить("settings.hub.audit.details.about", "Подробнее: %1");
	Добавить("settings.hub.audit.details.raw", "детали");
	Добавить("settings.hub.audit.filter.type", "Событие");
	Добавить("settings.hub.audit.filter.type.all", "Все события");
	Добавить("settings.hub.audit.filter.who", "Кто");
	Добавить("settings.hub.audit.filter.who.placeholder", "Логин или префикс токена");
	Добавить("settings.hub.audit.filter.from", "С даты (UTC)");
	Добавить("settings.hub.audit.filter.to", "По дату (UTC)");
	Добавить("settings.hub.audit.filter.button", "Показать");

	Добавить("settings.hub.groups.title", "Группы хаба");
	Добавить("settings.hub.groups.lead", "Группа — субъект прав: выданное группе право"
		+ " действует для всех её участников.");
	Добавить("settings.hub.groups.col.name", "Группа");
	Добавить("settings.hub.groups.col.description", "Описание");
	Добавить("settings.hub.groups.col.members", "Участников");
	Добавить("settings.hub.groups.empty", "Групп пока нет.");
	Добавить("settings.hub.groups.error.operation", "Неизвестная операция раздела");
	Добавить("settings.hub.groups.error.exists", "Группа «%1» уже существует");
	Добавить("settings.hub.groups.error.notfound", "Такой группы нет");
	Добавить("settings.hub.groups.error.confirm",
		"Введённое имя не совпадает с именем выбранной группы");

	Добавить("settings.hub.group-new.title", "Создать группу");
	Добавить("settings.hub.group-new.lead", "Имя уникально и попадает в адрес настроек группы.");
	Добавить("settings.hub.group-new.name.label", "Имя группы");
	Добавить("settings.hub.group-new.name.hint", "Регистр не важен: имя приводится к строчному");
	Добавить("settings.hub.group-new.description.label", "Описание");
	Добавить("settings.hub.group-new.button", "Создать группу");

	Добавить("settings.hub.user-new.title", "Создать пользователя");
	Добавить("settings.hub.user-new.lead", "Учётка заводится закрытой: пароля у неё нет."
		+ " Хаб выпустит одноразовую ссылку — по ней человек задаст пароль, и вход откроется.");
	Добавить("settings.hub.user-new.login.label", "Логин");
	Добавить("settings.hub.user-new.login.hint", "Первый сегмент адреса пространства"
		+ " пользователя, изменить его потом нельзя.");
	Добавить("settings.hub.user-new.email.label", "Email");
	Добавить("settings.hub.user-new.email.hint", "Необязателен: хаб писем не шлёт, адрес нужен"
		+ " для связи и привязки входа.");
	Добавить("settings.hub.user-new.role.label", "Роль на хабе");
	Добавить("settings.hub.user-new.role.user", "Пользователь");
	Добавить("settings.hub.user-new.role.admin", "Администратор хаба");
	Добавить("settings.hub.user-new.button", "Создать и выпустить ссылку");

	Добавить("settings.hub.group-delete.title", "Удаление группы");
	Добавить("settings.hub.group-delete.lead", "Вместе с группой снимаются её права доступа,"
		+ " роли на пулах, связки с провайдером входа и весь состав. Действие необратимо.");
	Добавить("settings.hub.group-delete.select.label", "Какую группу удалить");
	Добавить("settings.hub.group-delete.confirm.label",
		"Введите имя выбранной группы для подтверждения");
	Добавить("settings.hub.group-delete.confirm.hint",
		"Участники останутся в хабе, но потеряют доступ, который давала группа");
	Добавить("settings.hub.group-delete.button", "Удалить группу");

	Добавить("settings.hub.maintenance.lead", "Витрины инсталляции и фоновые механизмы.");
	Добавить("settings.hub.metrics.title", "Счётчики инсталляции");
	Добавить("settings.hub.metrics.lead", "Сколько сейчас учётных записей и пулов.");
	Добавить("settings.hub.maintenance.row.users", "Пользователей");
	Добавить("settings.hub.maintenance.row.pools", "Пулов");
	Добавить("settings.hub.maintenance.col.metric", "Показатель");
	Добавить("settings.hub.maintenance.col.value", "Значение");

КонецПроцедуры

// Общая витрина настроек (ВитринаНастроек): источники значений, причины
// блокировки, уборка введённого руками. Тексты — ОДНИ на все настройки: они говорят про
// КЛАСС настройки и источник значения, а не про конкретный ключ.
Процедура КлючиВитриныНастроек()

	Добавить("settings.values.editable.lead",
		"Эти значения хранятся в базе хаба и применяются сразу, без рестарта.");
	Добавить("settings.values.editable.note", "Изменения записываются в журнал аудита.");
	Добавить("settings.values.occupied.lead",
		"Все значения этой секции сейчас задаёт конфигурация инсталляции. Отсюда они"
		+ " не правятся, пока ключ стоит в конфигурации: у каждого сказано, что убрать,"
		+ " чтобы правка вернулась.");
	Добавить("settings.values.reset.title", "Значения, введённые вручную");
	Добавить("settings.values.reset.lead",
		"Сброс удаляет введённое значение: действующим снова становится конфигурация"
		+ " либо значение по умолчанию.");
	Добавить("settings.values.reset.button", "Сбросить");
	Добавить("settings.values.reset.col.setting", "Настройка");
	Добавить("settings.values.reset.col.value", "Значение");
	Добавить("settings.values.reset.col.action", "Действие");

	Добавить("settings.source.config", "из конфигурации");
	Добавить("settings.source.db", "из базы");
	Добавить("settings.source.default", "по умолчанию");

	Добавить("settings.value.locked.forced",
		"Ключ %1 задан в конфигурации, и она побеждает. Уберите ключ из файла"
		+ " конфигурации (или переменную %2) — поле снова станет редактируемым,"
		+ " рестарт для этого не нужен.");
	Добавить("settings.value.yes", "Да");
	Добавить("settings.value.no", "Нет");
	Добавить("settings.value.empty", "не задано");
	Добавить("settings.value.secret.set",
		"Значение задано. Поле всегда открывается пустым и обратно значения не показывает:"
		+ " оставьте его пустым, чтобы ничего не менять, или введите новое. Чтобы стереть"
		+ " значение, воспользуйтесь сбросом.");
	Добавить("settings.value.secret.empty",
		"Значение не задано. Введённое сюда сохраняется в базе хаба и обратно не показывается;"
		+ " если держать секрет в базе нельзя — задайте его переменной окружения.");

КонецПроцедуры

// Метки и подсказки КОНКРЕТНЫХ настроек реестра. Ключ словаря вычисляется из
// ключа настройки (ВитринаНастроек.КлючТекста), поэтому список настроек в коде экрана не
// повторяется. Полноту этого блока стережёт тест «у каждого ключа реестра есть метка и
// подсказка» (tests/НастройкиUI_Тесты.os) — он читает НАСТОЯЩИЙ реестр, а не список
// отсюда: новая настройка без метки краснит CI, а метка без настройки — тоже.
Процедура КлючиНастроекРеестра()

	Добавить("settings.key.oshub-port.label", "Порт");
	Добавить("settings.key.oshub-port.hint", "Порт HTTP-сервера хаба.");
	Добавить("settings.key.oshub-instance-url.label", "URL инстанса");
	Добавить("settings.key.oshub-instance-url.hint",
		"Внешний адрес хаба вида https://hub.example.com — только схема, хост и порт,"
		+ " без пути. Из него хаб выводит адрес возврата (redirect_uri) провайдеров входа."
		+ " Пусто — адрес возврата придётся вносить руками у каждого провайдера.");

	Добавить("settings.key.oshub-ui-theme.label", "Тема по умолчанию");
	Добавить("settings.key.oshub-ui-theme.hint",
		"Тема инсталляции: тёмная (по умолчанию) или светлая. Посетитель может выбрать свою.");
	Добавить("settings.key.oshub-ui-accent.label", "Акцент по умолчанию");
	Добавить("settings.key.oshub-ui-accent.hint",
		"Цвет акцента в формате #rrggbb; пусто — акцент дизайн-системы.");
	Добавить("settings.key.oshub-ui-brand.label", "Название хаба");
	Добавить("settings.key.oshub-ui-brand.hint",
		"Знак инсталляции: печатается в шапке, в заголовке вкладки и в подвале."
		+ " Пустое поле вернёт название по умолчанию.");
	Добавить("settings.key.oshub-ui-tagline.label", "Подпись в подвале");
	Добавить("settings.key.oshub-ui-tagline.hint",
		"Одно предложение о том, что это за хаб; печатается в подвале каждой страницы."
		+ " Пустое поле вернёт подпись по умолчанию.");
	Добавить("settings.key.oshub-ui-show-name.label", "Название рядом с логотипом");
	Добавить("settings.key.oshub-ui-show-name.hint",
		"Печатать ли название хаба текстом справа от логотипа. Выключите, если на"
		+ " загруженном логотипе название уже нарисовано.");
	Добавить("settings.key.oshub-ui-asset-max-bytes.label", "Потолок картинки, байт");
	Добавить("settings.key.oshub-ui-asset-max-bytes.hint",
		"Сколько байт разрешено загружать в логотип и иконку. Картинки лежат в базе"
		+ " хаба, поэтому потолок бережёт и базу, и время отклика страниц.");

	Добавить("settings.key.oshub-auth-registration-mode.label", "Режим регистрации");
	Добавить("settings.key.oshub-auth-registration-mode.hint",
		"open — открытая, invite — по приглашению, disabled — выключена.");
	Добавить("settings.key.oshub-auth-session-ttlseconds.label", "TTL сессии, секунд");
	Добавить("settings.key.oshub-auth-session-ttlseconds.hint",
		"Через сколько сессия браузера перестаёт действовать.");
	Добавить("settings.key.oshub-auth-login-maxattempts.label", "Попыток входа до блокировки");
	Добавить("settings.key.oshub-auth-login-maxattempts.hint",
		"Сколько неудачных попыток пароля подряд допускается.");
	Добавить("settings.key.oshub-auth-login-lockoutseconds.label", "Блокировка входа, секунд");
	Добавить("settings.key.oshub-auth-login-lockoutseconds.hint",
		"На сколько блокируется вход после исчерпания попыток.");
	Добавить("settings.key.oshub-auth-invite-ttl-days.label", "Срок ссылки на пароль, дней");
	Добавить("settings.key.oshub-auth-invite-ttl-days.hint",
		"Сколько живёт одноразовая ссылка, которой администратор приглашает нового"
		+ " пользователя или сбрасывает пароль существующему. По истечении срока ссылка"
		+ " перестаёт работать, и её выпускают заново.");
	Добавить("settings.key.oshub-auth-token-cli-days.label", "Срок токена opm login, дней");
	Добавить("settings.key.oshub-auth-token-cli-days.hint",
		"Сколько живёт ключ, который забирает opm login. Больше потолка не выдаётся.");
	Добавить("settings.key.oshub-auth-token-max-days.label", "Потолок срока токена, дней");
	Добавить("settings.key.oshub-auth-token-max-days.hint",
		"Наибольший срок ручного выпуска токена. Бессрочных токенов хаб не выпускает.");

	Добавить("settings.key.oshub-auth-password-enabled.label", "Вход по логину и паролю");
	Добавить("settings.key.oshub-auth-password-enabled.hint",
		"Работает ли на хабе форма логина и пароля. Выключение убирает поля со страницы"
		+ " входа и закрывает POST входа, вход в API и регистрацию с паролем; остаются"
		+ " только провайдеры. Выключить нельзя, пока некому будет войти. Аварийный"
		+ " возврат — OSHUB_AUTH_PASSWORD_ENABLED=true: значение конфигурации перебивает базу.");

	Добавить("settings.key.oshub-admin-login.label", "Логин администратора");
	Добавить("settings.key.oshub-admin-login.hint",
		"Учётная запись администратора, создаваемая при первом запуске.");
	Добавить("settings.key.oshub-admin-password.label", "Пароль администратора");
	Добавить("settings.key.oshub-admin-password.hint",
		"Задаётся только конфигурацией; в интерфейсе не показывается никогда.");
	Добавить("settings.key.oshub-admin-password-file.label", "Файл с паролем администратора");
	Добавить("settings.key.oshub-admin-password-file.hint",
		"Путь к файлу с паролем (docker secret) — альтернатива паролю в конфигурации.");

	Добавить("settings.key.oshub-storage-backend.label", "Бэкенд хранилища");
	Добавить("settings.key.oshub-storage-backend.hint",
		"file — файловая система, s3 — объектное хранилище.");
	Добавить("settings.key.oshub-storage-root.label", "Каталог хранилища");
	Добавить("settings.key.oshub-storage-root.hint", "Корень артефактов при бэкенде file.");
	Добавить("settings.key.oshub-storage-quota-bytes.label", "Общая квота хранилища, байт");
	Добавить("settings.key.oshub-storage-quota-bytes.hint",
		"Сколько места суммарно занимают артефакты хаба; 0 означает «без общего лимита».");

	Добавить("settings.key.oshub-publish-max-upload-bytes.label",
		"Максимальный размер загрузки, байт");
	Добавить("settings.key.oshub-publish-max-upload-bytes.hint",
		"Предельный размер архива, принимаемого при публикации.");
	Добавить("settings.key.oshub-publish-max-unpacked-bytes.label",
		"Максимальный размер распаковки, байт");
	Добавить("settings.key.oshub-publish-max-unpacked-bytes.hint",
		"Предельный объём содержимого архива после распаковки (защита от zip-бомбы).");
	Добавить("settings.key.oshub-publish-max-files.label", "Максимум файлов в пакете");
	Добавить("settings.key.oshub-publish-max-files.hint",
		"Сколько файлов допускается внутри одного архива.");
	Добавить("settings.key.oshub-publish-max-manifest-bytes.label",
		"Максимальный размер packagedef, байт");
	Добавить("settings.key.oshub-publish-max-manifest-bytes.hint",
		"Предельный размер манифеста пакета.");
	Добавить("settings.key.oshub-mirror-sync-enabled.label", "Фоновая синхронизация зеркал");
	Добавить("settings.key.oshub-mirror-sync-enabled.hint",
		"Выключенная синхронизация не принимает заявок ни от расписания, ни от кнопки:"
		+ " зеркала стоят, пока её не включат обратно.");
	Добавить("settings.key.oshub-mirror-max-per-pool.label", "Зеркал на один пул");
	Добавить("settings.key.oshub-mirror-max-per-pool.hint",
		"Сколько зеркал разрешено завести в одном пуле.");
	Добавить("settings.key.oshub-mirror-default-interval-sec.label",
		"Интервал синхронизации по умолчанию, сек");
	Добавить("settings.key.oshub-mirror-default-interval-sec.hint",
		"Период, с которым синхронизируется зеркало, не задавшее свой.");
	Добавить("settings.key.oshub-mirror-min-interval-sec.label",
		"Наименьший интервал синхронизации, сек");
	Добавить("settings.key.oshub-mirror-min-interval-sec.hint",
		"Ниже этой границы зеркало не опустится, даже если попросит: защита апстрима"
		+ " и хаба от слишком частого пула.");
	Добавить("settings.key.oshub-mirror-run-stale-sec.label",
		"Прогон считается брошенным после, сек");
	Добавить("settings.key.oshub-mirror-run-stale-sec.hint",
		"Срок молчания, после которого прогон признаётся брошенным и зеркало снова"
		+ " принимает заявки. Живой обход отмечается на каждом перечисленном имени"
		+ " и на каждой перенесённой версии, поэтому единицы минут ему не мешают.");
	Добавить("settings.key.oshub-mirror-max-packages-per-cycle.label",
		"Пакетов за цикл обхода");
	Добавить("settings.key.oshub-mirror-max-packages-per-cycle.hint",
		"Сколько ИМЁН апстрима перечисляется за один цикл; версии отобранного имени"
		+ " переносятся целиком.");
	Добавить("settings.key.oshub-mirror-max-cycles-per-run.label", "Циклов за плановый прогон");
	Добавить("settings.key.oshub-mirror-max-cycles-per-run.hint",
		"Сколько циклов подряд делает один плановый прогон, прежде чем уступить очередь.");
	Добавить("settings.key.oshub-mirror-queue-max.label", "Потолок очереди синхронизации");
	Добавить("settings.key.oshub-mirror-queue-max.hint",
		"Сколько заявок на синхронизацию ждёт разбора; при переполнении отбрасываются"
		+ " старейшие.");
	Добавить("settings.key.oshub-mirror-cycles-per-turn.label", "Циклов за заход рабочего");
	Добавить("settings.key.oshub-mirror-cycles-per-turn.hint",
		"Сколько циклов рабочий отдаёт одному зеркалу за раз; недобранное зеркало"
		+ " возвращается в хвост очереди.");
	Добавить("settings.key.oshub-mirror-queue-poll-sec.label", "Опрос очереди, сек");
	Добавить("settings.key.oshub-mirror-queue-poll-sec.hint",
		"Как часто рабочий заглядывает в пустую очередь заявок.");

	Добавить("settings.key.oshub-publish-github-legacy.label",
		"Публикация по токену GitHub (легаси)");
	Добавить("settings.key.oshub-publish-github-legacy.hint",
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
	Добавить("settings.key.oshub-publish-inbox-max-pending-per-pool.label",
		"Заявок во «входящих» на пул");
	Добавить("settings.key.oshub-publish-inbox-max-pending-per-pool.hint",
		"Сколько заявок на публикацию пул держит на рассмотрении одновременно."
		+ " Ноль отключает приём заявок во всех пулах.");
	Добавить("settings.key.oshub-publish-inbox-max-pending-per-user.label",
		"Заявок во «входящих» на автора");
	Добавить("settings.key.oshub-publish-inbox-max-pending-per-user.hint",
		"Сколько заявок один пользователь держит на рассмотрении во всём хабе."
		+ " Ноль отключает приём заявок.");
	Добавить("settings.key.oshub-publish-ci-audience.label",
		"Аудитория id-token доверенных конвейеров");
	Добавить("settings.key.oshub-publish-ci-audience.hint",
		"Значение, которое конвейер обязан запросить в audience при выпуске id-token, и"
		+ " которое хаб сверяет с клеймом aud. Пусто — берётся «URL инстанса»; пока пусты"
		+ " оба, доверенные конвейеры не публикуют.");
	Добавить("settings.key.oshub-publish-ci-issuers.label",
		"Дополнительные издатели доверенных конвейеров");
	Добавить("settings.key.oshub-publish-ci-issuers.hint",
		"Адреса издателей (iss) через запятую СВЕРХ встроенных GitHub Actions и GitLab.com —"
		+ " нужны для self-hosted GitLab. Только https и только маршрутизируемые адреса:"
		+ " по этому адресу хаб ходит за ключами сам.");
	Добавить("settings.key.oshub-pools-personal-enabled.label", "Личные пространства");
	Добавить("settings.key.oshub-pools-personal-enabled.hint",
		"Есть ли на хабе личные пулы /{логин}. Включение заводит пространство каждому"
		+ " существующему пользователю, выключение — сносит все личные пулы вместе"
		+ " с пакетами; выключение спрашивает подтверждение.");
	Добавить("settings.key.oshub-pools-default-quota-mb.label", "Квота пула по умолчанию, МБ");
	Добавить("settings.key.oshub-pools-default-quota-mb.hint",
		"Сколько места отводится пулу, не выставившему свою квоту. Ноль — хаб пулы"
		+ " не ограничивает. Пул с собственной квотой это значение не смотрит;"
		+ " квоту пула выставляет администратор хаба.");

	Добавить("settings.key.oshub-jobs-enabled.label", "Фоновые задачи");
	Добавить("settings.key.oshub-jobs-enabled.hint", "Планировщик обслуживания хаба.");
	Добавить("settings.key.oshub-otel-enabled.label", "Телеметрия");
	Добавить("settings.key.oshub-otel-enabled.hint", "Экспорт метрик и трасс OpenTelemetry.");
	Добавить("settings.key.oshub-otel-endpoint.label", "Адрес коллектора");
	Добавить("settings.key.oshub-otel-endpoint.hint",
		"Куда хаб отправляет телеметрию (OTLP over HTTP).");

КонецПроцедуры

// Метки и подсказки ключей подсистем: политика пароля, доставка подписок, прокси
// апстрима, счётчики, расписание фоновых задач, телеметрия и хранилище S3.
Процедура КлючиНастроекПодсистем()

	Добавить("settings.key.oshub-auth-password-min-length.label", "Минимальная длина");
	Добавить("settings.key.oshub-auth-password-min-length.hint",
		"Короче этого пароль не принимается. Значение выше максимальной длины запирает"
		+ " вход, поэтому такое не сохраняется.");
	Добавить("settings.key.oshub-auth-password-max-length.label", "Максимальная длина");
	Добавить("settings.key.oshub-auth-password-max-length.hint",
		"Длиннее этого пароль отвергается сразу и не хешируется вовсе — это и защита"
		+ " от нагрузки гигантским вводом.");
	Добавить("settings.key.oshub-auth-password-require-lowercase.label", "Требовать строчную букву");
	Добавить("settings.key.oshub-auth-password-require-lowercase.hint",
		"Пароль обязан содержать хотя бы одну строчную букву.");
	Добавить("settings.key.oshub-auth-password-require-uppercase.label", "Требовать заглавную букву");
	Добавить("settings.key.oshub-auth-password-require-uppercase.hint",
		"Пароль обязан содержать хотя бы одну заглавную букву.");
	Добавить("settings.key.oshub-auth-password-require-digit.label", "Требовать цифру");
	Добавить("settings.key.oshub-auth-password-require-digit.hint",
		"Пароль обязан содержать хотя бы одну цифру.");
	Добавить("settings.key.oshub-auth-password-require-special.label", "Требовать спецсимвол");
	Добавить("settings.key.oshub-auth-password-require-special.hint",
		"Пароль обязан содержать хотя бы один символ, не являющийся буквой или цифрой.");

	Добавить("settings.key.oshub-webhooks-delivery-enabled.label", "Доставка уведомлений");
	Добавить("settings.key.oshub-webhooks-delivery-enabled.hint",
		"Общий рубильник доставки: выключенный хаб копит события, но никуда их не шлёт.");
	Добавить("settings.key.oshub-webhooks-allow-insecure.label", "Разрешать http и непроверенный TLS");
	Добавить("settings.key.oshub-webhooks-allow-insecure.hint",
		"Позволяет слать уведомления по http и на узлы с непроверяемым сертификатом."
		+ " Содержимое уведомления в этом случае идёт открытым текстом.");
	Добавить("settings.key.oshub-webhooks-max-queue.label", "Потолок очереди доставки");
	Добавить("settings.key.oshub-webhooks-max-queue.hint",
		"Сколько недоставленных уведомлений хаб хранит, прежде чем перестать принимать новые.");
	Добавить("settings.key.oshub-webhooks-max-attempts.label", "Попыток доставки");
	Добавить("settings.key.oshub-webhooks-max-attempts.hint",
		"Сколько раз хаб повторяет недоставленное уведомление, прежде чем сдаться.");
	Добавить("settings.key.oshub-webhooks-backoff-base-sec.label", "Основание паузы повтора, секунд");
	Добавить("settings.key.oshub-webhooks-backoff-base-sec.hint",
		"От этого числа растёт пауза между повторами: каждая следующая длиннее предыдущей.");
	Добавить("settings.key.oshub-webhooks-delivery-interval-sec.label", "Разбор очереди, секунд");
	Добавить("settings.key.oshub-webhooks-delivery-interval-sec.hint",
		"Как часто хаб заглядывает в очередь недоставленного.");
	Добавить("settings.key.oshub-webhooks-delivery-timeout-sec.label", "Таймаут одной доставки, секунд");
	Добавить("settings.key.oshub-webhooks-delivery-timeout-sec.hint",
		"Сколько хаб ждёт ответа принимающей стороны, прежде чем счесть попытку неудачной.");
	Добавить("settings.key.oshub-webhooks-test-max-per-hour.label", "Пробных отправок в час на подписку");
	Добавить("settings.key.oshub-webhooks-test-max-per-hour.hint",
		"Потолок кнопки «Проверить»: сколько раз в час одну подписку разрешено дёргать"
		+ " вручную. Считается в памяти процесса, перезапуск потолок отпускает.");

	Добавить("settings.key.oshub-proxy-offline.label", "Офлайн");
	Добавить("settings.key.oshub-proxy-offline.hint",
		"Хаб обслуживает запросы только из своего кэша и наружу не ходит вовсе. Пакет,"
		+ " которого в кэше нет, при включённом офлайне не найдётся.");
	Добавить("settings.key.oshub-proxy-timeout-sec.label", "Таймаут похода в апстрим, секунд");
	Добавить("settings.key.oshub-proxy-timeout-sec.hint",
		"Сколько хаб ждёт ответа чужого хаба, прежде чем счесть его недоступным.");
	Добавить("settings.key.oshub-proxy-negative-ttl-sec.label", "Срок отрицательного ответа, секунд");
	Добавить("settings.key.oshub-proxy-negative-ttl-sec.hint",
		"Сколько хаб помнит, что у источника такого пакета нет, не переспрашивая заново.");
	Добавить("settings.key.oshub-proxy-upstream-recheck-ttl-sec.label",
		"Перепроверка живости источника, секунд");
	Добавить("settings.key.oshub-proxy-upstream-recheck-ttl-sec.hint",
		"Как часто хаб заново выясняет, отвечает ли источник.");
	Добавить("settings.key.oshub-upstream-probe-enabled.label", "Пробовать подключение к источнику");
	Добавить("settings.key.oshub-upstream-probe-enabled.hint",
		"Перед сохранением источника хаб пробует к нему подключиться и не сохраняет адрес,"
		+ " по которому не дозвонился. Выключайте, если инсталляции ходить наружу нечем.");
	Добавить("settings.key.oshub-proxy-max-redirects.label", "Потолок перенаправлений");
	Добавить("settings.key.oshub-proxy-max-redirects.hint",
		"Сколько переходов по Location хаб делает, прежде чем счесть цепочку бесконечной.");
	Добавить("settings.key.oshub-jobs-upstream-health-interval-sec.label",
		"Проверка живости источников, секунд");
	Добавить("settings.key.oshub-jobs-upstream-health-interval-sec.hint",
		"Как часто хаб сам обходит источники пулов и зеркал, выясняя, отвечают ли они.");

	Добавить("settings.key.oshub-publish-github-org.label", "Организация GitHub");
	Добавить("settings.key.oshub-publish-github-org.hint",
		"Чьё членство даёт право публиковать по легаси-токену GitHub. Действует только"
		+ " при включённом легаси-пути.");

	Добавить("settings.key.oshub-ui-audit-page-size.label", "Записей на странице журнала");
	Добавить("settings.key.oshub-ui-audit-page-size.hint",
		"Сколько записей аудита показывается на одной странице журнала.");
	Добавить("settings.key.oshub-stats-flush-interval-sec.label", "Сброс счётчиков, секунд");
	Добавить("settings.key.oshub-stats-flush-interval-sec.hint",
		"Как часто накопленные счётчики скачиваний уезжают в базу.");
	Добавить("settings.key.oshub-stats-flush-threshold.label", "Досрочный сброс счётчиков, событий");
	Добавить("settings.key.oshub-stats-flush-threshold.hint",
		"Сколько накопленных событий сбрасывают счётчики, не дожидаясь срока.");

	Добавить("settings.key.oshub-jobs-tick-interval-ms.label", "Период тика планировщика, мс");
	Добавить("settings.key.oshub-jobs-tick-interval-ms.hint",
		"Как часто планировщик проверяет, не пора ли запускать задачу.");
	Добавить("settings.key.oshub-jobs-readme-reindex-hour.label", "Час актуализации описаний");
	Добавить("settings.key.oshub-jobs-readme-reindex-hour.hint",
		"В какой час суток (0–23) хаб обходит пакеты и обновляет на диске README тех версий,"
		+ " которые отдаёт установка без версии.");
	Добавить("settings.key.oshub-jobs-mirror-sync-interval-sec.label",
		"Побудка синхронизации зеркал, секунд");
	Добавить("settings.key.oshub-jobs-mirror-sync-interval-sec.hint",
		"Как часто планировщик будит синхронизацию зеркал. Свой период каждого зеркала"
		+ " задаётся отдельно и чаще этой побудки не сработает.");
	Добавить("settings.key.oshub-jobs-proxy-gc-interval-sec.label", "Уборка кэша прокси, секунд");
	Добавить("settings.key.oshub-jobs-proxy-gc-interval-sec.hint",
		"Как часто хаб выбрасывает из кэша апстрима устаревшее.");
	Добавить("settings.key.oshub-jobs-cli-device-gc-interval-sec.label",
		"Уборка кодов входа CLI, секунд");
	Добавить("settings.key.oshub-jobs-cli-device-gc-interval-sec.hint",
		"Как часто хаб удаляет протухшие коды входа opm login.");
	Добавить("settings.key.oshub-jobs-invite-gc-interval-sec.label",
		"Уборка приглашений, секунд");
	Добавить("settings.key.oshub-jobs-invite-gc-interval-sec.hint",
		"Как часто хаб удаляет протухшие приглашения и ссылки установки пароля.");
	Добавить("settings.key.oshub-jobs-pool-volume-audit-interval-sec.label",
		"Пересчёт объёма пулов, секунд");
	Добавить("settings.key.oshub-jobs-pool-volume-audit-interval-sec.hint",
		"Как часто хаб сверяет учтённый объём пулов с фактическим.");

	Добавить("settings.key.oshub-otel-protocol.label", "Протокол выгрузки");
	Добавить("settings.key.oshub-otel-protocol.hint",
		"Каким протоколом хаб отдаёт телеметрию сборщику.");
	Добавить("settings.key.oshub-otel-service-name.label", "Имя службы в трассах");
	Добавить("settings.key.oshub-otel-service-name.hint",
		"Под этим именем инсталляция видна в трассах сборщика.");
	Добавить("settings.key.oshub-otel-sampling-ratio.label", "Доля отбираемых трасс");
	Добавить("settings.key.oshub-otel-sampling-ratio.hint",
		"Какая доля запросов попадает в трассы: 1.0 — все, 0.1 — каждый десятый.");
	Добавить("settings.key.oshub-otel-export-interval-sec.label", "Период выгрузки, секунд");
	Добавить("settings.key.oshub-otel-export-interval-sec.hint",
		"Как часто накопленные спаны уезжают сборщику.");
	Добавить("settings.key.oshub-otel-max-queue.label", "Потолок буфера спанов");
	Добавить("settings.key.oshub-otel-max-queue.hint",
		"Сколько спанов хаб держит в памяти до выгрузки; лишние отбрасываются.");
	Добавить("settings.key.oshub-otel-timeout-sec.label", "Таймаут выгрузки, секунд");
	Добавить("settings.key.oshub-otel-timeout-sec.hint",
		"Сколько хаб ждёт ответа сборщика телеметрии.");
	Добавить("settings.key.oshub-otel-insecure-skip-verify.label", "Не проверять сертификат сборщика");
	Добавить("settings.key.oshub-otel-insecure-skip-verify.hint",
		"Ослабление безопасности: телеметрия уедет и на узел с неподтверждённым сертификатом.");

	Добавить("settings.key.oshub-storage-s3-endpoint.label", "Адрес хранилища S3");
	Добавить("settings.key.oshub-storage-s3-endpoint.hint",
		"Куда хаб кладёт артефакты при бэкенде s3.");
	Добавить("settings.key.oshub-storage-s3-bucket.label", "Корзина S3");
	Добавить("settings.key.oshub-storage-s3-bucket.hint", "Имя корзины, в которой лежат артефакты.");
	Добавить("settings.key.oshub-storage-s3-region.label", "Регион S3");
	Добавить("settings.key.oshub-storage-s3-region.hint", "Регион корзины.");
	Добавить("settings.key.oshub-storage-s3-prefix.label", "Префикс ключей S3");
	Добавить("settings.key.oshub-storage-s3-prefix.hint",
		"Под каким префиксом внутри корзины лежат ключи артефактов.");
	Добавить("settings.key.oshub-storage-s3-force-path-style.label", "Адресация путём");
	Добавить("settings.key.oshub-storage-s3-force-path-style.hint",
		"Обращаться к корзине путём, а не поддоменом. Нужно хранилищам вроде MinIO.");

КонецПроцедуры

// Гварды настроек и общий отказ CSRF (6.C п.9).
Процедура КлючиГвардов()

	Добавить("settings.guard.pool.notfound", "Пул не найден");
	Добавить("settings.guard.pool.forbidden",
		"Настройки пула доступны его владельцу или администратору хаба");
	Добавить("settings.guard.hub.forbidden",
		"Раздел настроек хаба доступен только администратору хаба");
	Добавить("settings.guard.group.notfound", "Группа не найдена");
	Добавить("settings.guard.group.readonly",
		"Настройки группы доступны её участникам (только чтение) и администратору хаба");
	Добавить("settings.guard.group.admin-only",
		"Изменять состав и связки группы может только администратор хаба");
	Добавить("settings.guard.package.notfound", "Пакет не найден");
	Добавить("settings.guard.package.forbidden",
		"Настройки пакета доступны его мейнтейнерам и владельцу пула");
	Добавить("settings.reply.csrf.invalid", "Неверный или отсутствующий CSRF-токен");

КонецПроцедуры

// Публичная часть: страница пула, витрина пакетов, статика (6.C п.9).
Процедура КлючиПубличныеОбщие()

	Добавить("public.static.notfound", "Не найдено");
	Добавить("public.catalog.back", "← К каталогу");
	Добавить("public.pool.notfound", "Пул «%1» не найден");
	Добавить("public.pool.packages.title", "Пакеты пула");
	Добавить("public.pool.empty.title", "В пуле пока нет пакетов");
	Добавить("public.pool.empty.lead",
		"Опубликуйте первый пакет командой opm push — он появится здесь.");
	Добавить("public.pool.all-packages", "Все пакеты пула");
	Добавить("public.pool.settings", "Настройки пула");
	Добавить("public.showcase.upstream.tag", "с апстрима");
	Добавить("public.showcase.upstream.hint",
		"Ни одна версия этого имени не опубликована здесь — все получены с апстрима");
	Добавить("public.showcase.settings.label", "Настройки");
	Добавить("public.showcase.settings.hint", "Изменить настройки пакета");

КонецПроцедуры

// Страница пакета: подсказка установки (КомандыOpm, ПодсказкаУстановки, КонтроллерПакета).
Процедура КлючиСтраницыПакета()

	Добавить("public.package.install.hint-address",
		"Адрес пула в аргументе разбирает opm %1 и новее. Клиент постарше ответит"
		+ " «Пакет не найден» — ему нужен способ ниже на странице.");
	Добавить("public.package.install.hint-short",
		"Пакет лежит в основном пуле хаба: короткой формы достаточно, если хаб прописан"
		+ " сервером пакетов в opm.cfg.");
	Добавить("public.package.install.title", "Установка на opm младше %1");
	Добавить("public.package.install.lead",
		"Легаси-флоу. Клиент младше %1 адрес пула в аргументе не разбирает: пул сначала"
		+ " прописывают сервером пакетов, и только потом ставят через него. На %1 и новее"
		+ " этот раздел не нужен — хватает команды из шапки страницы.");
	Добавить("public.package.install.config",
		"Добавьте пул сервером пакетов в opm.cfg. Порт продублирован в «Сервер»:"
		+ " у opm push поле «Порт» не читается.");
	Добавить("public.package.install.by-server", "И ставьте пакет, указывая сервер:");
	Добавить("public.package.install.private",
		"Пул приватный: без токена доступа (PAT) хаб отвечает «не найдено». Заведите токен"
		+ " в кабинете и подставьте его значение в поле «Авторизация».");
	Добавить("public.package.channel.hint", "Канал обновления: %1");

	Добавить("public.package.version.upstream", "с апстрима");
	Добавить("public.package.version.upstream.hint",
		"Версия получена с апстрима, а не опубликована здесь");
	Добавить("public.package.version.trusted", "доверенный конвейер");
	Добавить("public.package.version.trusted.hint",
		"Опубликовано доверенным конвейером: версию принёс конвейер сборки, предъявивший"
		+ " короткоживущий токен своего провайдера, а не долгоживущий токен доступа.");
	Добавить("public.package.version.yanked", "отозвана");
	Добавить("public.package.version.yanked.hint",
		"Версия не отдаётся резолвом, но скачивается по точной координате");

КонецПроцедуры

// Главная страница (КонтроллерЛендинга): поиск, сводка, обзор пулов, свежее и популярное.
Процедура КлючиГлавной()

	Добавить("public.landing.lead",
		"Открытый хаб пакетов OneScript: пулы, кэширующий прокси, теги версий"
		+ " и semver — с полной совместимостью с opm.");
	Добавить("public.landing.search.label", "Поиск пакетов");
	Добавить("public.landing.search.placeholder", "Имя пакета или его часть");
	Добавить("public.landing.search.button", "Найти");
	Добавить("public.landing.catalog", "Открыть каталог пакетов");

	Добавить("public.landing.pools.title", "Пулы хаба");
	Добавить("public.landing.pools.lead", "Пространства имён, из которых собран каталог.");
	Добавить("public.landing.pools.packages", "пакетов: %1");
	Добавить("public.landing.pools.more", "Показаны %1 из %2 — остальные ищите в каталоге.");

	Добавить("public.landing.fresh.title", "Недавно опубликовано");
	Добавить("public.landing.fresh.lead", "Свежие версии в доступных вам пулах.");
	Добавить("public.landing.fresh.published", "опубликована");

	Добавить("public.landing.popular.title", "Популярное");
	Добавить("public.landing.popular.lead", "Пакеты, которые скачивают чаще прочих.");
	Добавить("public.landing.popular.downloads", "скачиваний");
	Добавить("public.landing.popular.updated", "обновлён");

	Добавить("public.landing.empty.title", "На хабе пока нет пакетов");
	Добавить("public.landing.empty.lead",
		"Пропишите хаб сервером пакетов в opm.cfg и выполните opm push —"
		+ " первый пакет появится здесь.");
	Добавить("public.landing.empty.login", "Войти");
	Добавить("public.landing.empty.tour", "Как опубликовать первый пакет");

	Добавить("public.landing.start.title", "Быстрый старт");
	Добавить("public.landing.start.config", "Добавьте хаб в opm.cfg как сервер пакетов:");
	Добавить("public.landing.start.install", "И устанавливайте пакеты как обычно:");
	Добавить("public.landing.start.unknown",
		"Образец настройки пока не собрать: не задан URL инстанса (настройки хаба,"
		+ " раздел «Базовые настройки») и не назначен основной пул хаба.");

КонецПроцедуры

// Каркас страницы: шапка, навигация, подвал.
Процедура КлючиКаркасаСтраницы()

	Добавить("chrome.top.nav.title", "Основная навигация");
	Добавить("chrome.top.nav.catalog", "Каталог");
	Добавить("chrome.top.login", "Войти");
	Добавить("chrome.top.logout", "Выйти");
	Добавить("chrome.top.theme.toggle", "Переключить тему");
	Добавить("chrome.top.theme.to-dark", "Включить тёмную тему");
	Добавить("chrome.top.theme.to-light", "Включить светлую тему");

	// ⛔ Следующие два ключа не запрашивает ни один экран хаба, и мёртвыми они не являются:
	// своего словаря у кита нет, а спрашивает он их сам — на ряде разделов кабинета
	// и на учётке тремя ходами. Обеими ветками хаб больше не ходит (ряда нет, учётка —
	// меню), но снести ключи нельзя: кит напечатает на их месте «[?ключ]».
	Добавить("chrome.top.office", "Кабинет");
	Добавить("chrome.office.nav.title", "Разделы кабинета");

	Добавить("chrome.account.menu.title", "Меню учётки");
	Добавить("chrome.account.menu.waiting", "Ждут вашего внимания: %1");
	Добавить("chrome.account.menu.office", "Кабинет");
	Добавить("chrome.account.menu.space", "Личное пространство");
	Добавить("chrome.account.menu.packages", "Мои пакеты");
	Добавить("chrome.account.menu.notifications", "Уведомления");
	Добавить("chrome.account.menu.notifications.unread", "Уведомления (%1)");
	Добавить("chrome.account.menu.inbox", "Входящие заявки");
	Добавить("chrome.account.menu.inbox.waiting", "Входящие заявки (%1)");
	Добавить("chrome.account.menu.account", "Настройки аккаунта");
	Добавить("chrome.account.menu.hub", "Настройки хаба");

КонецПроцедуры

// Раздел «Подписки на события» — один экран на трёх домах (пул · пакет · хаб), плюс
// ДЕКЛАРАЦИИ ОБРАБОТЧИКОВ ДЕЙСТВИЙ (7.C круг B).
//
// Ключи «subscriptions.type.*» и «subscriptions.<тип>.<поле>.*» запрашивает НЕ экран, а
// ДЕКЛАРАЦИЯ типа действия (РендерНастроекПодписки.ОписаниеПолей в папке обработчика):
// плагин называет ключи, форма их разрешает. Скан ключей (КомпонентыUI_Тесты) читает и
// эти файлы — мёртвый ключ подписи поля виден так же, как мёртвый ключ экрана.
Процедура КлючиПодписок()

	Добавить("subscriptions.section.title", "Подписки на события");
	Добавить("subscriptions.notice.created",
		"Подписка создана. Скопируйте секрет подписи сейчас — он больше не будет показан.");
	Добавить("subscriptions.readonly.note",
		"Создавать и менять подписки этого объекта вправе тот, кому выдано право управления"
		+ " им. Раздел показан только для чтения.");

	Добавить("subscriptions.pool.lead",
		"Подписки пула: хаб сообщает о событиях всех пакетов пула. События одного пакета"
		+ " настраиваются на самом пакете.");
	Добавить("subscriptions.pool.error.notfound", "Пул не найден");
	Добавить("subscriptions.pool.error.forbidden",
		"Недостаточно прав для управления подписками этого пула");
	Добавить("subscriptions.package.tab", "Подписки: %1");
	Добавить("subscriptions.package.lead",
		"Куда хаб сообщает о событиях этого пакета. События пула целиком настраиваются на пуле.");
	Добавить("subscriptions.hub.lead",
		"Подписка хаба получает события ВСЕХ пулов инсталляции, включая приватные. Поток"
		+ " прекращается, как только заведший подписку перестаёт быть администратором хаба.");

	Добавить("subscriptions.list.tag.own-bot", "свой бот");
	Добавить("subscriptions.list.tag.own-text", "свой текст");
	Добавить("subscriptions.list.empty", "Подписок пока нет.");
	Добавить("subscriptions.list.note",
		"Секрет подписи скрыт, свой токен бота и шаблон текста — тоже. Чтобы сменить их —"
		+ " удалите подписку и создайте заново.");
	Добавить("subscriptions.events.none", "—");
	Добавить("subscriptions.state.on", "активна");
	Добавить("subscriptions.state.off", "выключена");
	Добавить("subscriptions.button.enable", "Включить");
	Добавить("subscriptions.button.disable", "Выключить");
	Добавить("subscriptions.button.delete", "Удалить");
	Добавить("subscriptions.button.create", "Создать подписку");
	Добавить("subscriptions.button.save", "Сохранить подписку");
	Добавить("subscriptions.button.test", "Отправить пробное");
	Добавить("subscriptions.error.notfound", "Подписка не найдена");
	Добавить("subscriptions.edit.active", "Подписка активна");
	Добавить("subscriptions.edit.type.locked",
		"Тип действия правкой не меняется: другой транспорт — это другая подписка,"
		+ " заведите её заново.");
	Добавить("subscriptions.edit.unsupported",
		"Этот тип действия правку не поддерживает: подписку можно только выключить"
		+ " или удалить.");

	Добавить("subscriptions.form.title", "Новая подписка");
	Добавить("subscriptions.form.events.legend", "События");
	Добавить("subscriptions.form.threshold.label", "Порог заполнения пула, %");
	Добавить("subscriptions.form.threshold.hint",
		"Письмо уходит при пересечении порога и дальше на каждом следующем десятке"
		+ " процентов; падение ниже порога снова взводит уведомление.");
	Добавить("subscriptions.form.type.hint",
		"Что хаб сделает, когда событие произойдёт. Выбор типа перерисовывает форму:"
		+ " показаны поля только выбранного действия.");
	Добавить("subscriptions.form.types.empty",
		"Ни один тип действия не заявил формы настроек — завести подписку с экрана нельзя.");
	Добавить("subscriptions.form.error.no-type", "Не выбран тип действия подписки");
	Добавить("subscriptions.form.error.unknown-type", "Неизвестный тип действия подписки «%1»");
	Добавить("subscriptions.form.error.required", "Не заполнено обязательное поле «%1»");
	Добавить("subscriptions.form.secret.own.hint",
		"Снятый флажок очищает сохранённое значение и возвращает умолчание хаба.");
	Добавить("subscriptions.form.secret.keep", "Пусто — оставить сохранённое.");
	Добавить("subscriptions.form.secret.again",
		"Значение секрета на страницу не возвращается — введите его заново.");
	Добавить("subscriptions.form.error.foreign-field",
		"Поле «%1» не относится к действию «%2» — форма этого действия его не показывает");

	// --- декларации обработчиков действий (обработчики/<тип>/РендерНастроек*) ---

	Добавить("subscriptions.type.webhook.label", "Вебхук (HTTP POST)");
	Добавить("subscriptions.type.webhook.hint",
		"POST с заголовками X-OpenHub-Event, X-OpenHub-Delivery и подписью"
		+ " X-OpenHub-Signature (HMAC-SHA256 тела по секрету).");
	Добавить("subscriptions.webhook.url.label", "Адрес доставки");
	Добавить("subscriptions.webhook.url.hint",
		"Только https; приватные и loopback-адреса запрещены");
	Добавить("subscriptions.webhook.url.placeholder", "https://example.com/hook");
	Добавить("subscriptions.webhook.secret.label", "Секрет подписи");
	Добавить("subscriptions.webhook.secret.hint",
		"Пусто — хаб сгенерирует секрет и покажет его один раз");
	Добавить("subscriptions.webhook.secret.placeholder", "(необязательно)");
	Добавить("subscriptions.webhook.secret.own", "Свой секрет подписи");

	Добавить("subscriptions.type.telegram.label", "Telegram");
	Добавить("subscriptions.type.telegram.hint",
		"Сообщение вашим ботом: у каждой подписки свой бот и свой чат. Общего бота у хаба"
		+ " нет — он писал бы в чужие чаты от имени всего хаба.");
	Добавить("subscriptions.telegram.chat-id.label", "Чат или канал");
	Добавить("subscriptions.telegram.chat-id.hint",
		"Числовой идентификатор чата — работает всегда. Форма «@имя» годится ТОЛЬКО для"
		+ " публичного канала или супергруппы с именем, и в обоих случаях бот обязан быть"
		+ " добавлен туда и иметь право писать. Для личных сообщений и групп без имени"
		+ " нужен номер: узнать его можно у @userinfobot или в getUpdates.");
	Добавить("subscriptions.telegram.chat-id.placeholder", "-1001234567890");
	Добавить("subscriptions.telegram.token.label", "Токен бота");
	Добавить("subscriptions.telegram.token.hint",
		"Обязателен: создайте бота у @BotFather и вставьте выданный токен. Значение"
		+ " скрыто — увидеть его снова нельзя, при правке пустое поле оставляет"
		+ " сохранённый токен.");
	Добавить("subscriptions.telegram.token.placeholder", "123456789:AA…");
	Добавить("subscriptions.telegram.template.label", "Свой текст уведомления");
	Добавить("subscriptions.telegram.template.hint",
		"Пусто — стандартный текст. Плейсхолдеры: {событие}, {тип}, {пул}, {пакет},"
		+ " {версия}, {время}, {кто}, {ссылка}, {процент}; другие имена отклоняются"
		+ " при сохранении. {процент} заполнен только у события заполнения пула.");
	Добавить("subscriptions.telegram.template.placeholder",
		"{событие}: {пакет} {версия} — {ссылка}");

КонецПроцедуры

// Раздел «провайдеры входа» дома «Хаб» (шаг 7.D): социальный логин заводится формой,
// а не только переменными окружения (решение владельца В-7).
Процедура КлючиПровайдеровВхода()

	Добавить("providers.section.title", "Провайдеры входа");
	Добавить("providers.section.lead",
		"Внешние поставщики личности: кнопки на странице входа и привязки учётных записей.");
	Добавить("providers.create.title", "Завести провайдера");
	Добавить("providers.create.lead",
		"Выберите пресет — форма покажет только те поля, которые он не подставляет сам."
		+ " Обычно остаётся внести client_id и client_secret из регистрации приложения"
		+ " у провайдера.");

	Добавить("providers.list.empty", "Провайдеры входа не заведены.");
	Добавить("providers.list.note",
		"Секрет клиента не показывается. Чтобы сменить его, введите новое значение в поле"
		+ " секрета — пустое поле оставляет прежний секрет.");

	Добавить("providers.state.on", "Включён");
	Добавить("providers.state.off", "Выключен");
	Добавить("providers.state.overridden", "Задан конфигурацией");
	Добавить("providers.locked.hint",
		"Провайдер с таким именем объявлен переменными окружения OSHUB_OIDC_*, и"
		+ " конфигурация побеждает. Уберите переменные — строка снова станет управляемой.");

	Добавить("providers.preset.custom", "Свой провайдер");
	Добавить("providers.preset.github", "GitHub");
	Добавить("providers.preset.gitlab", "GitLab");
	Добавить("providers.preset.google", "Google");
	Добавить("providers.protocol.oidc", "OpenID Connect (discovery)");
	Добавить("providers.protocol.oauth2", "OAuth 2.0 (без discovery)");
	Добавить("providers.protocol.hint",
		"OpenID Connect: руками задаётся только издатель (issuer) — конечные точки хаб"
		+ " прочитает у него сам, по адресу /.well-known/openid-configuration; так устроено"
		+ " большинство провайдеров. OAuth 2.0: дискавери у провайдера нет (так устроен"
		+ " GitHub), поэтому конечные точки авторизации, токена и профиля вводятся руками"
		+ " (точка адресов почты — по желанию), а издателя хаб назначает сам.");

	Добавить("providers.icon.key", "Обобщённый значок (ключ)");

	Добавить("providers.field.name", "Имя");
	Добавить("providers.field.label", "Подпись кнопки");
	Добавить("providers.field.icon", "Значок");
	Добавить("providers.field.icon.hint",
		"Картинка рядом с провайдером; выбирается из встроенного набора");
	Добавить("providers.field.preset.label", "Пресет провайдера");
	Добавить("providers.field.preset.hint",
		"Пресет подставляет конечные точки, области, разбор профиля, подпись кнопки"
		+ " и значок. Поля, которых пресет не показывает, он задаёт сам.");
	Добавить("providers.field.protocol", "Протокол");
	Добавить("providers.field.client", "Идентификатор клиента (client_id)");
	Добавить("providers.field.secret", "Секрет клиента (client_secret)");
	Добавить("providers.field.secret.hint",
		"Пустое поле оставляет прежний секрет; показать сохранённый секрет хаб не умеет");
	Добавить("providers.field.redirect", "Адрес возврата (redirect_uri)");
	Добавить("providers.field.redirect.hint",
		"Пусто — хаб подставит адрес из URL инстанса. Заполняется руками, только если хаб"
		+ " стоит за прокси с другим внешним адресом.");
	Добавить("providers.redirect.note",
		"Этот адрес нужно указать в настройках приложения на стороне провайдера.");
	Добавить("providers.redirect.copy", "Скопировать");
	Добавить("providers.redirect.unset",
		"Адрес возврата не определён: URL инстанса не задан (настройки хаба, раздел"
		+ " «Базовые настройки»), а вручную адрес не введён. Пока это так, провайдер"
		+ " работать не будет.");
	Добавить("providers.field.scope", "Области (scope)");
	Добавить("providers.field.scope.hint",
		"Что хаб просит у провайдера при входе. В форме заведения пустая графа означает"
		+ " умолчание — оно уже подставлено в поле. В форме правки пустая графа означает"
		+ " «оставить как было»: очистка поля прежние области не сбрасывает, для замены"
		+ " впишите нужные. Просите ровно то, без чего не собрать личность (обычно"
		+ " openid profile email): каждая лишняя область — это разрешение, которое"
		+ " провайдер покажет на экране согласия КАЖДОМУ входящему, а у части провайдеров"
		+ " ещё и потребует одобрения администратора организации.");
	Добавить("providers.field.base", "Адрес инсталляции (для self-hosted GitLab)");
	Добавить("providers.field.issuer", "Издатель (issuer)");
	Добавить("providers.field.authorize", "Конечная точка авторизации");
	Добавить("providers.field.token", "Конечная точка токена");
	Добавить("providers.field.profile", "Конечная точка профиля");
	Добавить("providers.field.emails", "Конечная точка адресов почты");
	Добавить("providers.field.enabled", "Показывать кнопку на странице входа");

	Добавить("providers.manual.legend", "Свой провайдер");
	Добавить("providers.manual.note",
		"Заполняется только при пресете «Свой провайдер». Адреса обязаны быть https и не"
		+ " вести во внутреннюю сеть. Издатель OAuth2-провайдера назначает хаб сам.");
	Добавить("providers.policies.legend", "Учётные записи и группы");
	Добавить("providers.policies.note",
		"Автосоздание пускает в хаб личность, которая ещё не привязана ни к одной учётной"
		+ " записи. Механизмы групп отдают состав групп хаба стороне провайдера — задайте"
		+ " префикс, чтобы отделить их от локальных групп с правами.");
	Добавить("providers.field.autoprovision", "Создавать учётную запись при первом входе");
	Добавить("providers.field.groups.jit", "Создавать группы из клейма");
	Добавить("providers.field.groups.link", "Связывать клейм с существующей группой по имени");
	Добавить("providers.field.groups.claim", "Имя клейма групп");
	Добавить("providers.field.groups.prefix", "Префикс имён групп");

	Добавить("providers.button.create", "Завести");
	Добавить("providers.button.save", "Сохранить");
	Добавить("providers.button.enable", "Включить");
	Добавить("providers.button.disable", "Выключить");
	Добавить("providers.button.delete", "Удалить");

	// роли адресов провайдера (домен передаёт КЛЮЧ, а не готовое слово)
	Добавить("providers.role.default", "адрес провайдера");
	Добавить("providers.role.issuer", "издатель");
	Добавить("providers.role.authorize", "конечная точка авторизации");
	Добавить("providers.role.token", "конечная точка токена");
	Добавить("providers.role.profile", "конечная точка профиля");
	Добавить("providers.role.emails", "конечная точка адресов почты");

	// отказы SSRF-гейта адресов (oidc/ВалидаторАдресаПровайдера)
	Добавить("providers.error.address.empty", "Не задан %1.");
	Добавить("providers.error.address.control",
		"%1 содержит недопустимый символ (%2): управляющие символы и пробелы"
		+ " в адресе должны быть закодированы.");
	Добавить("providers.error.address.scheme.missing", "%1: адрес должен начинаться с https://.");
	Добавить("providers.error.address.scheme",
		"Схема «%1» недопустима (%2): только https — по этому каналу уходит секрет клиента"
		+ " и приезжают токены.");
	Добавить("providers.error.address.userinfo", "%1: запись вида user@host не допускается.");
	Добавить("providers.error.address.host", "%1: не удалось определить хост.");
	Добавить("providers.error.address.single-label",
		"Хост «%1» (%2) без доменной зоны. Публичный провайдер входа живёт на полном"
		+ " доменном имени; однословное имя ведёт во внутреннюю сеть либо подбирается"
		+ " под чужого издателя.");
	Добавить("providers.error.address.linklocal",
		"Хост «%1» (%2) — link-local (169.254.0.0/16 или fe80::/10, там же живёт сервис"
		+ " метаданных облака). Провайдер входа по такому адресу недопустим.");
	Добавить("providers.error.address.private",
		"Хост «%1» (%2) приватный или loopback. Внутренний провайдер настраивается"
		+ " переменными окружения OSHUB_OIDC_*, а не формой администратора.");
	Добавить("providers.error.issuer.synthetic.required",
		"Издатель OAuth2-провайдера назначает хаб сам (пространство «%1»); задавать его"
		+ " вручную нельзя — это ключ уже существующих привязок личностей.");
	Добавить("providers.error.issuer.synthetic.forbidden",
		"Издатель OIDC-провайдера не может начинаться с «%1»: это пространство синтетических"
		+ " издателей OAuth2, и запись в него подделала бы личности его пользователей.");
	Добавить("providers.error.redirect.empty", "Не задан адрес возврата (redirect_uri).");
	Добавить("providers.error.redirect.control",
		"Адрес возврата содержит недопустимый символ (%1).");
	Добавить("providers.error.redirect.scheme.missing",
		"Адрес возврата должен содержать схему: https:// либо http:// для localhost.");
	Добавить("providers.error.redirect.userinfo",
		"В адресе возврата запись вида user@host не допускается.");
	Добавить("providers.error.redirect.host", "В адресе возврата не удалось определить хост.");
	Добавить("providers.error.redirect.scheme",
		"Адрес возврата «%1://%2…» недопустим: только https (http разрешён лишь на localhost).");

	// отказы доменного сервиса (oidc/СервисПровайдеровВхода)
	Добавить("providers.error.auth", "Управление провайдерами входа требует аутентификации.");
	Добавить("providers.error.key.gate",
		"Управление провайдерами входа по ключу недоступно: гейт ключа доступа не собран.");
	Добавить("providers.error.key.denied", "Действие запрещено ключом доступа: %1.");
	Добавить("providers.error.key.binding",
		"ключ привязан к пулу, а провайдер входа — объект уровня хаба");
	Добавить("providers.error.key.scope", "ключу не хватает скоупа write");
	Добавить("providers.error.key.forbidden",
		"Управление провайдерами входа доступно только из кабинета по обычному входу:"
		+ " тот, кто заводит провайдера, определяет, кто войдёт в хаб, и ключ доступа"
		+ " такого права не передаёт.");
	Добавить("providers.error.admin",
		"Управление провайдерами входа доступно администратору хаба.");
	Добавить("providers.error.name.taken",
		"Провайдер с именем «%1» уже заведён: выберите другое имя или измените существующий.");
	Добавить("providers.error.rename",
		"Имя провайдера не переименовывается: это половина адреса входа и ключ, по которому"
		+ " конфигурация перекрывает базу.");
	Добавить("providers.error.name.empty", "Не задано имя провайдера.");
	Добавить("providers.error.name.length", "Имя провайдера — от 2 до 32 символов.");
	Добавить("providers.error.name.charset",
		"Имя провайдера: латиница, цифры и дефис. Оно попадает в адрес входа и в имена"
		+ " переменных окружения.");
	Добавить("providers.error.name.dash",
		"Имя провайдера не начинается и не заканчивается дефисом.");
	Добавить("providers.error.preset", "Неизвестный пресет «%1».");
	Добавить("providers.error.preset.rejected",
		"Пресет «%1» не принял настройки: проверьте client_id, client_secret и адрес"
		+ " инсталляции.");
	Добавить("providers.error.issuer.derive",
		"Издатель не выведен из адреса авторизации: проверьте адрес.");
	Добавить("providers.error.icon",
		"Неизвестный значок «%1»: выбирается только из встроенного набора.");
	Добавить("providers.error.field.protocol",
		"Поле «%1» не относится к протоколу «%2» — этот набор полей его не показывает."
		+ " При дискавери конечные точки хаб забирает из документа издателя, а издателя"
		+ " OAuth2-провайдера назначает сам.");
	Добавить("providers.error.field.forbidden",
		"Поле «%1» задаёт пресет «%2» — вводом оно не меняется. Уберите его из формы"
		+ " либо выберите пресет «Свой провайдер».");
	Добавить("providers.error.client", "Не задан идентификатор клиента (client_id).");
	Добавить("providers.error.secret", "Не задан секрет клиента (client_secret).");
	Добавить("providers.error.protocol", "Неизвестный протокол «%1»: допустимы oidc и oauth2.");
	Добавить("providers.error.endpoint",
		"OAuth2-провайдеру нужна %1: discovery у него нет.");
	Добавить("providers.error.notfound", "Провайдер «%1» не найден.");
	Добавить("providers.error.overridden",
		"Провайдер «%1» объявлен переменными окружения OSHUB_OIDC_*, и конфигурация"
		+ " побеждает: правка строки базы ни на что не повлияет. Уберите переменные —"
		+ " строка снова станет управляемой; либо удалите её как мёртвую.");

КонецПроцедуры

// Состояние прогона зеркала: подписи кодов хранения, экран состояния дома «Пул»
// и админский обзор зеркал кабинета.
Процедура КлючиЗеркал()

	Добавить("mirror.run.state.idle", "простаивает");
	Добавить("mirror.run.state.queued", "в очереди");
	Добавить("mirror.run.state.running", "идёт");
	Добавить("mirror.run.state.stale", "брошен: рабочий не отвечает");
	Добавить("mirror.run.state.done", "завершён");
	Добавить("mirror.run.state.failed", "ошибка");

	Добавить("settings.pool.mirror-status.title", "Состояние синхронизации");
	Добавить("settings.pool.mirror-status.lead",
		"Что зеркало делает прямо сейчас и чем закончился прошлый прогон.");
	Добавить("settings.pool.mirror-status.crumb", "Состояние");
	Добавить("settings.pool.mirror-status.notfound", "Зеркало не найдено в этом пуле.");
	Добавить("settings.pool.mirror-status.empty", "—");

	Добавить("settings.pool.mirror-status.run.title", "Прогон");
	Добавить("settings.pool.mirror-status.run.lead",
		"Обход апстрима идёт по списку пакетов; курсор помнит, с какого имени продолжить.");
	Добавить("settings.pool.mirror-status.counters.title", "Счётчики прогона");
	Добавить("settings.pool.mirror-status.counters.lead",
		"Сколько пакетов апстрима уже разобрано и с каким исходом.");
	Добавить("settings.pool.mirror-status.mirror.title", "Зеркало");
	Добавить("settings.pool.mirror-status.mirror.lead",
		"Настройки, с которыми идёт синхронизация, и итог прошлого прогона.");

	Добавить("settings.pool.mirror-status.col.metric", "Показатель");
	Добавить("settings.pool.mirror-status.col.value", "Значение");

	Добавить("settings.pool.mirror-status.field.state", "Состояние");
	Добавить("settings.pool.mirror-status.field.started", "Прогон начат");
	Добавить("settings.pool.mirror-status.field.updated", "Последняя запись прогресса");
	Добавить("settings.pool.mirror-status.field.cursor", "Обход дошёл до пакета");
	Добавить("settings.pool.mirror-status.field.crawl", "Способ обхода");
	Добавить("settings.pool.mirror-status.crawl.full", "полный обход");
	Добавить("settings.pool.mirror-status.crawl.increment", "инкремент с %1");
	Добавить("settings.pool.mirror-status.field.by", "Запустил");
	Добавить("settings.pool.mirror-status.field.by-schedule", "по расписанию");
	Добавить("settings.pool.mirror-status.field.upstream", "Апстрим");
	Добавить("settings.pool.mirror-status.field.mode", "Режим");
	Добавить("settings.pool.mirror-status.field.interval", "Интервал синхронизации, сек");
	Добавить("settings.pool.mirror-status.field.enabled", "Зеркало");
	Добавить("settings.pool.mirror-status.field.last-sync", "Последняя синхронизация");
	Добавить("settings.pool.mirror-status.field.result", "Итог последнего прогона");

	Добавить("settings.pool.mirror-status.count.names", "Пакетов у апстрима (после фильтра)");
	Добавить("settings.pool.mirror-status.count.names-done", "Пакетов пройдено обходом");
	Добавить("settings.pool.mirror-status.count.total", "Версий перечислено за обход");
	Добавить("settings.pool.mirror-status.count.downloaded", "Скачано");
	Добавить("settings.pool.mirror-status.count.skipped", "Пропущено");
	Добавить("settings.pool.mirror-status.count.errors", "Ошибок");
	Добавить("settings.pool.mirror-status.count.unavailable", "Недоступно");

	Добавить("settings.pool.mirror-status.progress.label", "Обход апстрима");
	Добавить("settings.pool.mirror-status.progress.caption", "пакетов пройдено %1 из %2");
	Добавить("settings.pool.mirror-status.refresh.note",
		"Пока прогон не закончен, страница обновляется сама каждые %1 с.");
	Добавить("settings.pool.mirror-status.refresh.button", "Обновить");
	Добавить("settings.pool.mirror-status.back", "К списку зеркал");

	Добавить("office.mirrors.title", "Зеркала хабов");
	Добавить("office.mirrors.lead", "Плановая репликация пакетов с другого хаба"
		+ " в ваш local-пул. Выберите пул назначения.");
	Добавить("office.mirrors.pools.title", "Пулы назначения");
	Добавить("office.mirrors.pools.empty.title", "Нет пулов, которыми вы можете управлять");
	Добавить("office.mirrors.pools.empty.lead",
		"Зеркало складывает копию в пул с разрешённой публикацией.");
	Добавить("office.mirrors.pool.title", "Зеркала пула %1");
	Добавить("office.mirrors.pool.lead", "Хаб по расписанию скачивает пакеты апстрима"
		+ " и складывает их копию в этот пул. Апстрим-контент недоверенный: каждый .ospx"
		+ " валидируется, версии иммутабельны (существующие не перезаписываются)."
		+ " Адрес принимается любой http/https — сеть, в которой живёт источник,"
		+ " хаб не судит.");
	Добавить("office.mirrors.list.title", "Зеркала пула");
	Добавить("office.mirrors.col.upstream", "Апстрим");
	Добавить("office.mirrors.col.mode", "Режим");
	Добавить("office.mirrors.col.state", "Состояние");
	Добавить("office.mirrors.col.run", "Прогон");
	Добавить("office.mirrors.col.sync", "Последний синк");
	Добавить("office.mirrors.col.actions", "Действия");
	Добавить("office.mirrors.empty", "Зеркал пока нет.");
	Добавить("office.mirrors.sync.never", "ещё не было");
	Добавить("office.mirrors.state.on", "включено");
	Добавить("office.mirrors.state.off", "выключено");
	Добавить("office.mirrors.button.sync", "Синхронизировать сейчас");
	Добавить("office.mirrors.button.enable", "Включить");
	Добавить("office.mirrors.button.disable", "Выключить");
	Добавить("office.mirrors.button.delete", "Удалить");
	Добавить("office.mirrors.new.title", "Новое зеркало");
	Добавить("office.mirrors.new.url", "URL апстрима (http/https)");
	Добавить("office.mirrors.new.mode", "Режим");
	Добавить("office.mirrors.new.filter", "Фильтр имён (JSON-массив масок; пусто — всё)");
	Добавить("office.mirrors.new.interval", "Интервал синка, сек (пусто — по умолчанию)");
	Добавить("office.mirrors.new.button", "Создать зеркало");
	Добавить("office.mirrors.back", "← Зеркала");
	Добавить("office.mirrors.error.pool-notfound", "Пул «%1» не найден");
	Добавить("office.mirrors.error.forbidden",
		"Недостаточно прав для управления зеркалами этого пула");
	Добавить("office.mirrors.sync.started",
		"Зеркало поставлено в очередь синхронизации: состояние прогона видно"
		+ " в колонке «Прогон».");
	Добавить("office.mirrors.sync.running",
		"Заявка не нужна: синхронизация этого зеркала уже идёт — смотрите колонку «Прогон»:"
		+ " пока её счётчики сдвигаются, рабочий работает.");
	Добавить("office.mirrors.sync.queued",
		"Заявка не нужна: зеркало уже стоит в очереди и ждёт свободного рабочего.");
	Добавить("office.mirrors.sync.disabled",
		"Фоновая синхронизация зеркал выключена на этом хабе: заявку некому разобрать.");
	Добавить("office.mirrors.sync.rejected",
		"Заявка не принята: очередь синхронизации её не взяла.");

КонецПроцедуры

// Почта хаба: письмо подтверждения адреса, публичная страница /confirm-email, секция
// проверки отправки в разделе «Почта» и метки почтовых настроек реестра.
Процедура КлючиПочты()

	Добавить("mail.confirm.subject", "Подтвердите адрес электронной почты");
	Добавить("mail.confirm.body",
		"Здравствуйте!
		|
		|Этот адрес указан в учётной записи «%1» на %2.
		|
		|Чтобы подтвердить, что адрес ваш, откройте ссылку и нажмите кнопку:
		|%3
		|
		|Ссылка срабатывает один раз и действует %4 ч.
		|
		|Если учётную запись заводили не вы — просто ничего не делайте:
		|без перехода по ссылке адрес не подтвердится.");

	Добавить("mail.recover.subject", "Восстановление пароля");
	Добавить("mail.recover.body",
		"Здравствуйте!
		|
		|Кто-то попросил восстановить пароль учётной записи «%1» на %2.
		|
		|Чтобы задать новый пароль, откройте ссылку:
		|%3
		|
		|Ссылка срабатывает один раз и действует %4 дн. Прежний пароль работает до тех пор,
		|пока по ссылке не задан новый.
		|
		|Если восстановление просили не вы — просто ничего не делайте:
		|без перехода по ссылке пароль не изменится.");

	Добавить("password.requirements.title", "Требования к паролю:");

	Добавить("access.page.login", "Страница входа");

	Добавить("recover.page.title", "Восстановление пароля");
	Добавить("recover.page.lead", "Назовите логин или адрес электронной почты своей"
		+ " учётной записи. Если такая учётная запись есть и её адрес подтверждён,"
		+ " хаб пришлёт письмо со ссылкой установки нового пароля.");
	Добавить("recover.page.field", "Логин или email");
	Добавить("recover.page.button", "Выслать ссылку");
	Добавить("recover.page.link", "Забыли пароль?");
	Добавить("recover.page.done", "Если такая учётная запись есть и её адрес подтверждён,"
		+ " письмо со ссылкой уже отправлено. Проверьте почту — включая папку со спамом.");
	Добавить("recover.page.unavailable", "Восстановление пароля на этом хабе не работает:"
		+ " отправка почты не настроена, и письмо со ссылкой слать нечем."
		+ " Обратитесь к администратору хаба — он выдаст ссылку установки пароля.");
	Добавить("recover.page.throttled", "Слишком много запросов восстановления."
		+ " Попробуйте позже.");
	Добавить("recover.page.method", "Разрешены методы GET и POST.");

	Добавить("confirm.page.title", "Подтверждение адреса");
	Добавить("confirm.page.lead",
		"Учётная запись «%1», адрес %2. Нажмите кнопку — и адрес будет подтверждён.");
	Добавить("confirm.page.button", "Подтвердить адрес");
	Добавить("confirm.page.done", "Адрес %1 подтверждён.");
	Добавить("confirm.page.request.lead",
		"Письмо со ссылкой не пришло или ссылка устарела? Назовите логин или адрес"
		+ " электронной почты — вышлем новое.");
	Добавить("confirm.page.request.field", "Логин или email");
	Добавить("confirm.page.request.button", "Выслать письмо");
	Добавить("confirm.page.request.done",
		"Если такая учётная запись есть и её адрес не подтверждён, письмо со ссылкой"
		+ " отправлено. Проверьте почту.");
	Добавить("confirm.page.state.noemail",
		"В учётной записи не указан адрес электронной почты — подтверждать нечего."
		+ " Укажите адрес в кабинете.");
	Добавить("confirm.page.state.confirmed", "Адрес %1 уже подтверждён.");
	Добавить("confirm.page.resend.lead",
		"Адрес %1 не подтверждён. Хаб вышлет на него письмо со ссылкой.");
	Добавить("confirm.page.resend.button", "Выслать письмо ещё раз");
	Добавить("confirm.page.resend.done", "Письмо отправлено на %1. Проверьте почту.");
	Добавить("confirm.page.error.method", "Разрешены методы GET и POST.");
	Добавить("confirm.page.error.form", "Форма устарела. Обновите страницу и повторите.");
	Добавить("confirm.page.error.unknown",
		"Такой ссылки нет. Проверьте адрес целиком — он длинный и легко теряет хвост.");
	Добавить("confirm.page.error.expired",
		"Срок этой ссылки вышел. Войдите в учётную запись и запросите письмо заново.");
	Добавить("confirm.page.error.used",
		"Этой ссылкой уже воспользовались либо её отменило письмо, отправленное позже.");
	Добавить("confirm.page.error.nouser", "Учётной записи этой ссылки больше нет.");
	Добавить("confirm.page.error.changed",
		"Адрес учётной записи изменился после отправки письма — про новый адрес эта ссылка"
		+ " ничего не говорит. Запросите письмо заново.");
	Добавить("confirm.page.error.already", "Адрес учётной записи уже подтверждён.");
	Добавить("confirm.page.error.off",
		"Подтверждение адреса письмом на этом хабе выключено.");
	Добавить("confirm.page.error.mail",
		"Отправка почты на этом хабе не настроена — письмо выслать некуда."
		+ " Обратитесь к администратору хаба.");
	Добавить("confirm.page.error.send",
		"Письмо отправить не удалось: почтовый сервер хаба его не принял."
		+ " Сообщите администратору хаба — причина записана в журнал.");
	Добавить("confirm.page.error.address",
		"Адрес учётной записи не годится для отправки письма: исправьте его в кабинете.");

	Добавить("settings.hub.mail.test.title", "Проверка отправки");
	Добавить("settings.hub.mail.test.lead",
		"Хаб пошлёт проверочное письмо и покажет, чем закончилась попытка."
		+ " Помните: шифрование выбирает библиотека отправки, подлинность сертификата"
		+ " сервера не проверяется, и на порту без TLS пароль SMTP уходит открытым текстом.");
	Добавить("settings.hub.mail.test.note", "Письмо уйдёт на адрес вашей учётной записи: %1.");
	Добавить("settings.hub.mail.test.button", "Отправить проверочное письмо");
	Добавить("settings.hub.mail.test.subject", "Проверка почты хаба");
	Добавить("settings.hub.mail.test.body",
		"Это проверочное письмо. Если вы его читаете, отправка почты с хаба %1 настроена верно.");
	Добавить("settings.hub.mail.test.done", "Письмо отправлено на %1. Проверьте почту.");
	Добавить("settings.hub.mail.test.error.off",
		"Отправка почты не настроена: включите её, укажите сервер и адрес отправителя.");
	Добавить("settings.hub.mail.test.error.noemail",
		"В вашей учётной записи не указан адрес — проверочное письмо слать некуда.");
	Добавить("settings.hub.mail.test.error.address",
		"Адрес вашей учётной записи не годится для отправки: исправьте его в кабинете.");
	Добавить("settings.hub.mail.test.error.send",
		"Письмо не отправлено: почтовый сервер не принял его. Причина — в журнале хаба.");

	Добавить("settings.key.oshub-mail-enabled.label", "Отправка почты");
	Добавить("settings.key.oshub-mail-enabled.hint",
		"Разрешает хабу слать письма. Выключено — хаб работает как обычно, просто без писем.");
	Добавить("settings.key.oshub-mail-smtp-host.label", "Сервер SMTP");
	Добавить("settings.key.oshub-mail-smtp-host.hint",
		"Имя или адрес почтового сервера, через который хаб отправляет письма.");
	Добавить("settings.key.oshub-mail-smtp-port.label", "Порт SMTP");
	Добавить("settings.key.oshub-mail-smtp-port.hint",
		"Порт решает и режим шифрования: 465 — TLS с первого байта, остальные порты —"
		+ " открытое соединение с переходом на TLS, только если сервер его предложит."
		+ " Отдельной настройки шифрования у хаба нет: библиотека отправки выбирает режим"
		+ " сама, и повлиять на выбор нечем.");
	Добавить("settings.key.oshub-mail-smtp-user.label", "Пользователь SMTP");
	Добавить("settings.key.oshub-mail-smtp-user.hint",
		"Имя пользователя для входа на почтовый сервер. Пусто — сервер без аутентификации.");
	Добавить("settings.key.oshub-mail-smtp-password.label", "Пароль SMTP");
	Добавить("settings.key.oshub-mail-smtp-password.hint",
		"Секрет: задаётся только конфигурацией или переменной окружения, в базе не хранится"
		+ " и на экране не показывается. ВНИМАНИЕ: библиотека отправки не проверяет"
		+ " подлинность сертификата сервера и не требует шифрования — на порту без TLS"
		+ " этот пароль уходит по проводу открытым текстом. Указывайте только свой сервер"
		+ " или сервер за доверенным каналом.");
	Добавить("settings.key.oshub-mail-from.label", "Адрес отправителя");
	Добавить("settings.key.oshub-mail-from.hint",
		"Адрес, от имени которого хаб шлёт письма. Пока он не задан или не похож на адрес,"
		+ " писем не будет вовсе — хаб считает почту ненастроенной.");

	Добавить("settings.key.oshub-auth-email-confirm-enabled.label", "Подтверждение адреса письмом");
	Добавить("settings.key.oshub-auth-email-confirm-enabled.hint",
		"Хаб шлёт письмо со ссылкой на адрес новой учётной записи. Права подтверждение"
		+ " не раздаёт: неподтверждённый адрес отличается только тем, что о нём сказано,"
		+ " и на него хаб не шлёт ничего, кроме самого письма подтверждения.");
	Добавить("settings.key.oshub-auth-email-confirm-ttl-hours.label", "Срок ссылки подтверждения, ч");
	Добавить("settings.key.oshub-auth-email-confirm-ttl-hours.hint",
		"Сколько часов живёт ссылка из письма. Сработает она один раз.");

КонецПроцедуры

#КонецОбласти

// Кладёт текст под ключом. Повторный ключ — исключение: тихая перезапись означала бы,
// что один и тот же ключ отдаёт разный текст в зависимости от порядка строк в файле.
Процедура Добавить(Знач Ключ, Знач Текст)

	Если Тексты.Получить(Ключ) <> Неопределено Тогда
		ВызватьИсключение "СловарьТекстов: ключ «" + Ключ + "» объявлен дважды";
	КонецЕсли;

	Тексты.Вставить(Ключ, Текст);

КонецПроцедуры

&Верховный
&Прозвище("СловарьИнтерфейса")
&Желудь
Процедура ПриСозданииОбъекта() Экспорт

	Тексты = Новый Соответствие();

	КлючиКаркаса();
	КлючиКаркасаСтраницы();
	КлючиГвардов();
	КлючиПубличныеОбщие();
	КлючиСтраницыПакета();
	КлючиГлавной();
	КлючиОтветов();
	КлючиДомаАккаунта();
	КлючиДомаГруппы();
	КлючиДомаПула();
	КлючиВходящих();
	КлючиДомаПакета();
	КлючиДоверияCI();
	КлючиДомаХаба();
	КлючиПодписок();
	КлючиПровайдеровВхода();
	КлючиВитриныНастроек();
	КлючиНастроекРеестра();
	КлючиНастроекПодсистем();
	КлючиЗеркал();
	КлючиПочты();
	КлючиУведомлений();
	КлючиГлавнойКабинета();
	КлючиПервойПубликации();

КонецПроцедуры
