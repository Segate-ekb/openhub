// Тексты панели «Подписки на события» и полей обработчиков действий.

// Кладёт тексты в словарь интерфейса.
//
// Параметры:
//  Словарь - СловарьТекстов - словарь, который собирается из частей.
//
Процедура Наполнить(Знач Словарь) Экспорт

	КлючиПодписок(Словарь);
	КлючиОтбораИСужения(Словарь);
	КлючиДереваПолучателей(Словарь);
	КлючиСводкиИРазделовФормы(Словарь);
	КлючиПроверкиДоСохранения(Словарь);

КонецПроцедуры

// Раздел «Подписки на события»: список, форма, действия и события.
Процедура КлючиПодписок(Словарь)

	Словарь.Добавить("subscriptions.section.title", "Подписки на события");
	Словарь.Добавить("subscriptions.section.add", "Добавить подписку");
	Словарь.Добавить("subscriptions.error.stale",
		"Страница устарела: ничего не изменено. Обновите её и повторите действие.");
	Словарь.Добавить("subscriptions.button.edit", "Изменить");
	Словарь.Добавить("subscriptions.button.recipients", "Получатели");
	Словарь.Добавить("subscriptions.toggle.label", "Подписка «%1» включена");
	Словарь.Добавить("subscriptions.fact.events", "события");
	Словарь.Добавить("subscriptions.fact.recipients", "получатели");
	Словарь.Добавить("subscriptions.caption.where", "%1 · %2");
	Словарь.Добавить("subscriptions.prop.where", "куда");
	Словарь.Добавить("subscriptions.prop.channel", "способ доставки");
	Словарь.Добавить("subscriptions.prop.events", "события");
	Словарь.Добавить("subscriptions.prop.tags", "теги");
	Словарь.Добавить("subscriptions.prop.tags.all", "все версии");
	Словарь.Добавить("subscriptions.prop.tags.dropped", "тегов %1 больше нет — отбор по ним снят");
	Словарь.Добавить("subscriptions.prop.recipients", "получатели");
	Словарь.Добавить("subscriptions.prop.below", "нижестоящие");
	Словарь.Добавить("subscriptions.prop.below.closed", "не могут сузить");

	Словарь.Добавить("subscriptions.step.where", "Куда");
	Словарь.Добавить("subscriptions.step.what", "О чём");
	Словарь.Добавить("subscriptions.step.text", "Текст");
	Словарь.Добавить("subscriptions.window.edit", "Подписка «%1»");
	Словарь.Добавить("subscriptions.form.type.about", "Как устроен этот способ");
	Словарь.Добавить("subscriptions.form.secret.once", "После сохранения не показывается.");

	Словарь.Добавить("subscriptions.delete.title", "Удалить подписку «%1»?");
	Словарь.Добавить("subscriptions.delete.consequence", "Уведомления по ней перестанут уходить.");
	Словарь.Добавить("subscriptions.delete.consequence.narrowed",
		"Уведомления по ней перестанут уходить, поправки нижестоящих (%1) пропадут вместе с ней.");
	Словарь.Добавить("subscriptions.delete.echo", "Имя подписки");
	Словарь.Добавить("subscriptions.delete.echo.mismatch", "Наберите имя подписки точно: %1");

	Словарь.Добавить("subscriptions.secret.title", "Секрет подписи");
	Словарь.Добавить("subscriptions.secret.label", "секрет");

	Словарь.Добавить("subscriptions.notice.created",
		"Подписка создана. Скопируйте секрет подписи сейчас — он больше не будет показан.");
	Словарь.Добавить("subscriptions.readonly.note",
		"Создавать и менять подписки этого объекта вправе тот, кому выдано право управления"
		+ " им. Раздел показан только для чтения.");

	Словарь.Добавить("subscriptions.button.preview", "Показать, как придёт");
	Словарь.Добавить("subscriptions.preview.title", "Так придёт уведомление");
	Словарь.Добавить("subscriptions.list.tag.own-text", "свой текст");
	Словарь.Добавить("subscriptions.list.empty", "Подписок пока нет.");
	Словарь.Добавить("subscriptions.state.off", "выключена");
	Словарь.Добавить("subscriptions.button.delete", "Удалить");
	Словарь.Добавить("subscriptions.button.create", "Создать подписку");
	Словарь.Добавить("subscriptions.button.save", "Сохранить");
	Словарь.Добавить("subscriptions.button.test", "Отправить пробное");
	Словарь.Добавить("subscriptions.error.notfound", "Подписка не найдена");
	Словарь.Добавить("subscriptions.edit.type.locked",
		"Тип действия правкой не меняется: другой транспорт — это другая подписка,"
		+ " заведите её заново.");

	Словарь.Добавить("subscriptions.form.title", "Новая подписка");
	Словарь.Добавить("subscriptions.form.events.legend", "События");
	Словарь.Добавить("subscriptions.form.threshold.label", "Порог заполнения пула, %");
	Словарь.Добавить("subscriptions.form.threshold.hint",
		"Письмо уходит при пересечении порога и дальше на каждом следующем десятке"
		+ " процентов; падение ниже порога снова взводит уведомление.");
	Словарь.Добавить("subscriptions.form.types.empty",
		"Ни один тип действия не заявил формы настроек — завести подписку с экрана нельзя.");
	Словарь.Добавить("subscriptions.form.error.no-type", "Не выбран тип действия подписки");
	Словарь.Добавить("subscriptions.form.error.unknown-type", "Неизвестный тип действия подписки «%1»");
	Словарь.Добавить("subscriptions.form.error.required", "Не заполнено обязательное поле «%1»");
	Словарь.Добавить("subscriptions.form.secret.own.hint",
		"Снятый флажок очищает сохранённое значение и возвращает умолчание хаба.");
	Словарь.Добавить("subscriptions.form.secret.keep", "Пусто — оставить сохранённое.");
	Словарь.Добавить("subscriptions.form.secret.again",
		"Значение секрета на страницу не возвращается — введите его заново.");

	// поля обработчиков действий: их ключи спрашивает декларация типа действия
	Словарь.Добавить("subscriptions.type.webhook.label", "Вебхук (HTTP POST)");
	Словарь.Добавить("subscriptions.type.webhook.hint",
		"POST с заголовками X-OpenHub-Event, X-OpenHub-Delivery и подписью"
		+ " X-OpenHub-Signature (HMAC-SHA256 тела по секрету).");
	Словарь.Добавить("subscriptions.webhook.url.label", "Адрес доставки");
	Словарь.Добавить("subscriptions.webhook.url.hint",
		"Только https; приватные и loopback-адреса запрещены");
	Словарь.Добавить("subscriptions.webhook.url.placeholder", "https://example.com/hook");
	Словарь.Добавить("subscriptions.webhook.secret.label", "Секрет подписи");
	Словарь.Добавить("subscriptions.webhook.secret.hint",
		"Пусто — хаб сгенерирует секрет и покажет его один раз");
	Словарь.Добавить("subscriptions.webhook.secret.placeholder", "(необязательно)");
	Словарь.Добавить("subscriptions.webhook.secret.own", "Свой секрет подписи");

	Словарь.Добавить("subscriptions.type.telegram.label", "Telegram");
	Словарь.Добавить("subscriptions.type.telegram.hint",
		"Сообщение вашим ботом: у каждой подписки свой бот и свой чат. Общего бота у хаба"
		+ " нет — он писал бы в чужие чаты от имени всего хаба.");
	Словарь.Добавить("subscriptions.telegram.chat-id.label", "Чат или канал");
	Словарь.Добавить("subscriptions.telegram.chat-id.hint",
		"Числовой идентификатор чата — работает всегда. Форма «@имя» годится ТОЛЬКО для"
		+ " публичного канала или супергруппы с именем, и в обоих случаях бот обязан быть"
		+ " добавлен туда и иметь право писать. Для личных сообщений и групп без имени"
		+ " нужен номер: узнать его можно у @userinfobot или в getUpdates.");
	Словарь.Добавить("subscriptions.telegram.chat-id.placeholder", "-1001234567890");
	Словарь.Добавить("subscriptions.telegram.token.label", "Токен бота");
	Словарь.Добавить("subscriptions.telegram.token.hint",
		"Обязателен: создайте бота у @BotFather и вставьте выданный токен. Значение"
		+ " скрыто — увидеть его снова нельзя, при правке пустое поле оставляет"
		+ " сохранённый токен.");
	Словарь.Добавить("subscriptions.telegram.token.placeholder", "123456789:AA…");
	Словарь.Добавить("subscriptions.telegram.template.label", "Свой текст уведомления");
	Словарь.Добавить("subscriptions.telegram.template.hint",
		"Оставьте пустым — придёт текст по умолчанию, он показан в пустом поле.");

КонецПроцедуры

// Название подписки, отбор по тегам, сужение снизу и раздел «Подписки сверху».
Процедура КлючиОтбораИСужения(Словарь)

	Словарь.Добавить("subscriptions.form.name.label", "Название");
	Словарь.Добавить("subscriptions.form.name.placeholder", "релизы в общий чат");
	Словарь.Добавить("subscriptions.form.name.optional", "Необязательно");
	Словарь.Добавить("subscriptions.form.name.hint",
		"Необязательно. Им подписку видят нижестоящие объекты, если вы разрешили им её сузить.");
	Словарь.Добавить("subscriptions.form.tags.label", "Только версии под тегами");
	Словарь.Добавить("subscriptions.form.tags.hint",
		"Ни одной галки — все версии. Действует на события версии: версия проходит, если в момент"
		+ " события входит хотя бы в один отмеченный тег своего пакета. Тег-правило отбирает по"
		+ " своему правилу; в ручной тег только что опубликованная версия ещё не входит — её туда"
		+ " помечают позже. Удалённый тег пропадает из отбора.");
	Словарь.Добавить("subscriptions.form.tags.empty.pool",
		"У пула нет тегов для отбора: их заводят в разделе «Теги» пула галкой «Теги пула для пакетов».");
	Словарь.Добавить("subscriptions.form.tags.empty.package", "У пакета нет тегов для отбора.");
	Словарь.Добавить("subscriptions.form.tags.link", "Завести теги");
	Словарь.Добавить("subscriptions.form.tags.none", "Ни одной галки — все версии.");
	Словарь.Добавить("subscriptions.form.tags.dropped",
		"Тегов %1 больше нет — отбор по ним снят. Без отмеченных тегов подписка получает все версии.");
	Словарь.Добавить("subscriptions.form.narrowing.label", "Нижестоящие могут сузить");
	Словарь.Добавить("subscriptions.form.narrowing.hint.pool",
		"Пакеты пула увидят подписку — название, способ доставки, события и отбор, без адреса и секретов —"
		+ " и смогут отключить её для себя или сузить. Флажок снят — их поправки не действуют, но хранятся.");
	Словарь.Добавить("subscriptions.form.narrowing.hint",
		"Пулы и пакеты увидят подписку — название, способ доставки, события и отбор, без адреса"
		+ " и секретов — и смогут отключить её для себя или сузить. Флажок снят — их поправки"
		+ " не действуют, но хранятся.");

	Словарь.Добавить("subscriptions.narrowed.legend", "Сузили для себя");
	Словарь.Добавить("subscriptions.narrowed.dormant",
		"Сужение снизу сейчас не разрешено: поправки хранятся, но не действуют.");
	Словарь.Добавить("subscriptions.narrowed.pool", "пул %1");
	Словарь.Добавить("subscriptions.narrowed.package", "пакет %1/%2");
	Словарь.Добавить("subscriptions.narrowed.muted", "не присылать");
	Словарь.Добавить("subscriptions.narrowed.events", "сняты события: %1");
	Словарь.Добавить("subscriptions.narrowed.tags", "только теги: %1");
	Словарь.Добавить("subscriptions.narrowed.packages", "исключено: %1");

	Словарь.Добавить("subscriptions.above.title", "Подписки сверху");
	Словарь.Добавить("subscriptions.above.lead",
		"Подписки хаба и пула, которым приходят события этого объекта: отключите их здесь или оставьте"
		+ " только нужное.");
	Словарь.Добавить("subscriptions.above.readonly",
		"Сужать подписки сверху вправе тот, кто распоряжается подписками этого объекта.");
	Словарь.Добавить("subscriptions.above.state.muted", "не присылается");
	Словарь.Добавить("subscriptions.above.state.narrowed", "сужена");
	Словарь.Добавить("subscriptions.above.events.legend", "Присылать события");
	Словарь.Добавить("subscriptions.above.button.save", "Сохранить поправку");
	Словарь.Добавить("subscriptions.above.button.reset", "Снять поправку");
	Словарь.Добавить("subscriptions.above.button.mute", "Не присылать сюда");
	Словарь.Добавить("subscriptions.above.button.unmute", "Присылать сюда");
	Словарь.Добавить("subscriptions.above.button.narrow", "Сузить события");
	Словарь.Добавить("subscriptions.above.button.packages", "Пакеты пула");
	Словарь.Добавить("subscriptions.above.badge", "сверху");
	Словарь.Добавить("subscriptions.above.caption", "%1 · события: %2");
	Словарь.Добавить("subscriptions.above.window.narrow", "Сузить «%1»");
	Словарь.Добавить("subscriptions.above.window.lead",
		"Оставьте события и теги, о которых сообщать здесь. Саму подписку поправка не меняет.");

	Словарь.Добавить("subscriptions.delivery.title", "Настройки доставки");
	Словарь.Добавить("subscriptions.delivery.on", "включена");
	Словарь.Добавить("subscriptions.delivery.off", "выключена");
	Словарь.Добавить("subscriptions.delivery.proxy", "Прокси Telegram");
	Словарь.Добавить("subscriptions.delivery.proxy.set", "прокси задан");
	Словарь.Добавить("subscriptions.delivery.proxy.unset", "прокси не задан");
	Словарь.Добавить("subscriptions.delivery.proxy.set.short", "задан");
	Словарь.Добавить("subscriptions.delivery.proxy.unset.short", "не задан");
	Словарь.Добавить("subscriptions.delivery.save", "Сохранить");

КонецПроцедуры

// Окна «Получатели» и «Пакеты пула», получатели в записи подписки.
Процедура КлючиДереваПолучателей(Словарь)

	Словарь.Добавить("subscriptions.recipients.window", "Получатели: %1");
	Словарь.Добавить("subscriptions.recipients.window.amendment", "Пакеты пула: %1");
	Словарь.Добавить("subscriptions.recipients.tree", "Пулы и пакеты");
	Словарь.Добавить("subscriptions.recipients.marked", "Выбрано");
	Словарь.Добавить("subscriptions.recipients.marked.amendment", "Снято пулом");
	Словарь.Добавить("subscriptions.recipients.mode.all", "все");
	Словарь.Добавить("subscriptions.recipients.mode.picked", "выбранные: %1");
	Словарь.Добавить("subscriptions.recipients.mode.none", "никто");
	Словарь.Добавить("subscriptions.recipients.private", "приватный");
	Словарь.Добавить("subscriptions.recipients.package.above", "снят хозяином подписки");
	Словарь.Добавить("subscriptions.recipients.package.pool.all", "пул «Все» — правка в «Выбранных»");
	Словарь.Добавить("subscriptions.recipients.package.pool.none", "пул «Никто» — правка в «Выбранных»");
	Словарь.Добавить("subscriptions.recipients.empty", "Пулов и пакетов пока нет.");
	Словарь.Добавить("subscriptions.recipients.back", "Все пулы");
	Словарь.Добавить("subscriptions.recipients.lead.hub",
		"Получают %1 · %2 · новые пакеты в пулах «Все» попадают сами");
	Словарь.Добавить("subscriptions.recipients.lead.pool", "Получают %1 из %2 · новые пакеты попадают сами");
	Словарь.Добавить("subscriptions.recipients.lead.pool.picked",
		"Получают %1 из %2 · только выбранные, новые не попадают");
	Словарь.Добавить("subscriptions.recipients.brief.all", "все; новые попадают сами");
	Словарь.Добавить("subscriptions.recipients.brief.pools", "пулы: %1 из %2");
	Словарь.Добавить("subscriptions.recipients.brief.picked.of", "выбранные: %1 из %2");
	Словарь.Добавить("subscriptions.recipients.brief.picked.pools", "%1; выбранные: %2 в %3");
	Словарь.Добавить("subscriptions.recipients.chip.pool", "Вернуть пул «%1»");
	Словарь.Добавить("subscriptions.recipients.chip.drop", "Убрать «%1» из выбранных");
	Словарь.Добавить("subscriptions.recipients.chip.more", "ещё %1");

	Словарь.Добавить("subscriptions.recipients.amendment.all",
		"Подписка сообщает обо всех пакетах пула; новые попадают в неё сами.");
	Словарь.Добавить("subscriptions.recipients.amendment.except",
		"Подписка сообщает обо всех пакетах пула, кроме %1. Новые пакеты попадают в неё сами.");
	Словарь.Добавить("subscriptions.recipients.amendment.except.above",
		"Подписка сообщает обо всех пакетах пула, кроме снятых хозяином подписки: %1.");
	Словарь.Добавить("subscriptions.recipients.amendment.except.split",
		"Подписка сообщает обо всех пакетах пула, кроме %1: %2 сняли вы, %3 — хозяин подписки.");

	Словарь.Добавить("subscriptions.count.pools", "%1 пул|%1 пула|%1 пулов");
	Словарь.Добавить("subscriptions.count.pools.in", "%1 пуле|%1 пулах|%1 пулах");
	Словарь.Добавить("subscriptions.count.packages", "%1 пакет|%1 пакета|%1 пакетов");
	Словарь.Добавить("subscriptions.count.packages.except", "%1 пакета|%1 пакетов|%1 пакетов");
	Словарь.Добавить("subscriptions.count.objects", "%1 объект|%1 объекта|%1 объектов");

КонецПроцедуры

// Записи подписки и подписки сверху, шаги её окна.
Процедура КлючиСводкиИРазделовФормы(Словарь)

	Словарь.Добавить("subscriptions.brief.below.allowed", "могут сузить для себя");
	Словарь.Добавить("subscriptions.brief.below.narrowed", "сузили для себя %1");
	Словарь.Добавить("subscriptions.brief.sign.dormant", "поправки снизу не действуют");
	Словарь.Добавить("subscriptions.brief.here", "Здесь");
	Словарь.Добавить("subscriptions.brief.here.events", "только %1");
	Словарь.Добавить("subscriptions.brief.here.tags", "только с тегами %1");
	Словарь.Добавить("subscriptions.brief.here.packages", "сняли %1");
	Словарь.Добавить("subscriptions.brief.owner.hub", "подписка хаба");
	Словарь.Добавить("subscriptions.brief.owner.pool", "подписка пула %1");
	Словарь.Добавить("subscriptions.brief.name.hub", "Подписка хаба");
	Словарь.Добавить("subscriptions.brief.name.pool", "Подписка пула %1");

	Словарь.Добавить("subscriptions.form.type.legend", "Способ доставки");
	Словарь.Добавить("subscriptions.form.whom.recipients.new",
		"Подписка сообщает обо всех пулах и пакетах; исключить лишних можно в её карточке после создания.");
	Словарь.Добавить("subscriptions.form.whom.recipients.pool.new",
		"Подписка сообщает обо всех пакетах пула; исключить лишние можно в её карточке после создания.");
	Словарь.Добавить("subscriptions.form.text.hint.more", "Что можно вставить в текст");
	Словарь.Добавить("subscriptions.form.text.inserts.rules",
		"Другие имена в фигурных скобках отклоняются при сохранении. В тексте из нескольких строк"
		+ " строка, где вставке нечего подставить, не приходит.");

КонецПроцедуры

// Предпросмотр уведомления и проба настройками формы — до сохранения подписки.
Процедура КлючиПроверкиДоСохранения(Словарь)

	Словарь.Добавить("subscriptions.preview.sample",
		"Образец: пул и пакет — этой подписки, время, публикатор и страница релиза — примерные.");
	Словарь.Добавить("subscriptions.trial.busy", "Отправляем пробное…");
	Словарь.Добавить("subscriptions.trial.ok", "✓ Пробное дошло: %1");
	Словарь.Добавить("subscriptions.trial.failed", "✗ Пробное не дошло: %1");
	Словарь.Добавить("subscriptions.live.failed", "Хаб не ответил — обновите страницу и попробуйте снова.");

КонецПроцедуры

&Прозвище("ЧастьСловаряТекстов")
&Порядок(50)
&Желудь
Процедура ПриСозданииОбъекта() Экспорт
КонецПроцедуры
