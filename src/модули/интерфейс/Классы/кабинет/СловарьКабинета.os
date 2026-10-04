// Тексты района «Кабинет»: личное пространство, входящие, уведомления, первые шаги,
// сводка зеркал и настройки пула, пакета и группы.

// Кладёт тексты в словарь интерфейса.
//
// Параметры:
//  Словарь - СловарьТекстов - словарь, который собирается из частей.
//
Процедура Наполнить(Знач Словарь) Экспорт

	КлючиЛичногоПространства(Словарь);
	КлючиВходящих(Словарь);
	КлючиУведомлений(Словарь);
	КлючиПервойПубликации(Словарь);
	КлючиЗеркал(Словарь);
	КлючиДомаПула(Словарь);
	КлючиДомаПакета(Словарь);
	КлючиДоверияCI(Словарь);
	КлючиПодписокПулаИПакета(Словарь);
	КлючиДомаГруппы(Словарь);
	КлючиГвардов(Словарь);

КонецПроцедуры

// Личное пространство «/me»: сводка дел и витрины её блоков.
Процедура КлючиЛичногоПространства(Словарь)

	Словарь.Добавить("office.home.title", "Личное пространство");
	Словарь.Добавить("office.home.lead", "Что происходит с вашими пакетами, пулами и ключами.");

	Словарь.Добавить("office.home.packages.title", "Мои пакеты");
	Словарь.Добавить("office.home.packages.lead", "Пакеты, которыми вы управляете как автор,"
		+ " владелец пула или мейнтейнер. Свежие публикации сверху.");
	Словарь.Добавить("office.home.packages.open", "Открыть каталог");
	Словарь.Добавить("office.home.packages.rest", "И ещё %1 — в каталоге с отбором «мои».");
	Словарь.Добавить("office.home.packages.published", "опубликована");
	Словарь.Добавить("office.home.packages.downloads", "скачиваний");

	Словарь.Добавить("office.home.space.title", "Место в пуле %1");
	Словарь.Добавить("office.home.space.lead", "Ваше личное пространство: пакеты, опубликованные"
		+ " под вашим логином.");
	Словарь.Добавить("office.home.space.open", "Открыть пул");
	Словарь.Добавить("office.home.space.meter.label", "Занято в личном пространстве");
	Словарь.Добавить("office.home.space.meter.value", "%1 из %2");
	Словарь.Добавить("office.home.space.meter.unlimited", "Занято %1, ограничения нет.");
	Словарь.Добавить("office.home.space.packages", "Пакетов в пространстве: %1");

	Словарь.Добавить("office.home.keys.title", "Токены на исходе: %1");
	Словарь.Добавить("office.home.keys.lead", "Истёкшим ключом opm не опубликует и не установит:"
		+ " выпустите новый заранее.");
	Словарь.Добавить("office.home.keys.open", "Мои токены");
	Словарь.Добавить("office.home.keys.col.name", "Имя");
	Словарь.Добавить("office.home.keys.col.prefix", "Префикс");
	Словарь.Добавить("office.home.keys.col.until", "Действует до");
	Словарь.Добавить("office.home.keys.col.state", "Состояние");
	Словарь.Добавить("office.home.keys.noname", "(без имени)");
	Словарь.Добавить("office.home.keys.state.expired", "истёк");
	Словарь.Добавить("office.home.keys.state.soon", "скоро истечёт");

	Словарь.Добавить("office.home.mirrors.title", "Зеркала ваших пулов");
	Словарь.Добавить("office.home.mirrors.lead", "Плановая репликация с чужих хабов."
		+ " Настраивается в доме пула.");
	Словарь.Добавить("office.home.mirrors.col.pool", "Пул");
	Словарь.Добавить("office.home.mirrors.col.upstream", "Апстрим");
	Словарь.Добавить("office.home.mirrors.col.state", "Прогон");
	Словарь.Добавить("office.home.mirrors.col.sync", "Последний синк");
	Словарь.Добавить("office.home.mirrors.never", "ни разу");

КонецПроцедуры

// «Входящие» — очередь заявок на публикацию: раздел пула и сводка кабинета.
Процедура КлючиВходящих(Словарь)

	Словарь.Добавить("settings.inbox.title", "Заявки на публикацию");
	Словарь.Добавить("settings.inbox.lead", "Артефакты, присланные push от тех, у кого прав на пул нет:"
		+ " версия ещё не опубликована, имя не занято.");
	Словарь.Добавить("settings.inbox.empty", "Заявок, ждущих решения, нет.");
	Словарь.Добавить("settings.inbox.note", "Одобрение публикует версию и делает заявителя мейнтейнером"
		+ " пакета. Отклонение стирает артефакт и не выдаёт никаких прав; имя остаётся свободным.");

	Словарь.Добавить("settings.inbox.col.pool", "Пул");
	Словарь.Добавить("settings.inbox.col.package", "Пакет и версия");
	Словарь.Добавить("settings.inbox.col.author", "Кто подал");
	Словарь.Добавить("settings.inbox.col.filed", "Когда");
	Словарь.Добавить("settings.inbox.col.artifact", "Артефакт");
	Словарь.Добавить("settings.inbox.col.action", "Решение");

	Словарь.Добавить("settings.inbox.filed.value", "%1 (заявка №%2)");
	Словарь.Добавить("settings.inbox.artifact.value", "%1 байт, канал %2");
	Словарь.Добавить("settings.inbox.size.value", "%1 байт");
	Словарь.Добавить("settings.inbox.manifest.author", " (автор манифеста: %1)");
	Словарь.Добавить("settings.inbox.applicant.gone", "учётка удалена");

	Словарь.Добавить("settings.inbox.button.approve", "Одобрить");
	Словарь.Добавить("settings.inbox.button.reject", "Отклонить");

	Словарь.Добавить("settings.inbox.card.pool", "Пул");
	Словарь.Добавить("settings.inbox.card.package", "Пакет и версия");
	Словарь.Добавить("settings.inbox.card.applicant", "Заявитель");
	Словарь.Добавить("settings.inbox.card.manifest-author", "Автор из манифеста");
	Словарь.Добавить("settings.inbox.card.filed", "Подана");
	Словарь.Добавить("settings.inbox.card.size", "Размер артефакта");
	Словарь.Добавить("settings.inbox.card.channel", "Канал");
	Словарь.Добавить("settings.inbox.card.file", "Имя файла");
	Словарь.Добавить("settings.inbox.card.sha256", "sha256");

	Словарь.Добавить("settings.inbox.manifest.deps", "зависимостей: %1");
	Словарь.Добавить("settings.inbox.manifest.details", "Подробнее");
	Словарь.Добавить("settings.inbox.manifest.details.about", "Подробнее о пакете %1 %2");
	Словарь.Добавить("settings.inbox.manifest.missing", "Сведений из packagedef у заявки нет: она подана"
		+ " раньше, чем хаб начал их сохранять.");
	Словарь.Добавить("settings.inbox.manifest.field.description", "Описание");
	Словарь.Добавить("settings.inbox.manifest.field.repository", "Репозиторий");
	Словарь.Добавить("settings.inbox.manifest.field.author", "Автор");
	Словарь.Добавить("settings.inbox.manifest.field.engine", "Версия OneScript");
	Словарь.Добавить("settings.inbox.manifest.field.deps", "Зависимости");
	Словарь.Добавить("settings.inbox.manifest.field.dev-deps", "Для разработки");

	Словарь.Добавить("settings.inbox.approve.title", "Одобрить заявку №%1");
	Словарь.Добавить("settings.inbox.approve.lead", "Версия будет опубликована от имени заявителя,"
		+ " а он станет мейнтейнером этого пакета.");
	Словарь.Добавить("settings.inbox.approve.button", "Одобрить и опубликовать");

	Словарь.Добавить("settings.inbox.reject.title", "Отклонить заявку №%1");
	Словарь.Добавить("settings.inbox.reject.lead", "Артефакт будет стёрт, права не выдаются,"
		+ " имя останется свободным. Причину увидит заявитель.");
	Словарь.Добавить("settings.inbox.reject.button", "Отклонить заявку");
	Словарь.Добавить("settings.inbox.reason.label", "Причина отказа");
	Словарь.Добавить("settings.inbox.reason.placeholder", "Что не так с заявкой");
	Словарь.Добавить("settings.inbox.reason.hint", "Текст увидит заявитель — назовите, что исправить.");

	Словарь.Добавить("settings.inbox.crumb", "Входящие");
	Словарь.Добавить("settings.inbox.page.title", "Заявки на публикацию");
	Словарь.Добавить("settings.inbox.page.lead", "Всё, что ждёт вашего решения: заявки из пулов,"
		+ " где вы мейнтейнер и выше.");

	Словарь.Добавить("settings.inbox.widget.title", "Заявки ждут решения: %1");
	Словарь.Добавить("settings.inbox.widget.lead", "Push в ваши пулы от тех, у кого прав нет."
		+ " Пока заявка не рассмотрена, версия не опубликована.");
	Словарь.Добавить("settings.inbox.widget.open", "Разобрать заявки");
	Словарь.Добавить("settings.inbox.widget.rest", "И ещё %1 — в полном списке.");

	Словарь.Добавить("settings.inbox.error.operation", "Неизвестная операция раздела «Входящие»."
		+ " Ничего не изменено — обновите страницу и повторите действие.");
	Словарь.Добавить("settings.inbox.error.id", "Не задан номер заявки.");
	Словарь.Добавить("settings.inbox.error.foreign", "Заявка относится к другому пулу и в этом разделе"
		+ " не рассматривается.");
	Словарь.Добавить("settings.inbox.error.decide", "Заявка недоступна: %1");
	Словарь.Добавить("settings.inbox.error.approve", "Заявка не одобрена: %1");
	Словарь.Добавить("settings.inbox.error.reject", "Заявка не отклонена: %1");
	Словарь.Добавить("settings.inbox.error.csrf", "Форма устарела: обновите страницу и повторите решение.");

КонецПроцедуры

// Лента личных уведомлений.
Процедура КлючиУведомлений(Словарь)

	Словарь.Добавить("office.notifications.crumb", "Уведомления");
	Словарь.Добавить("office.notifications.page.title", "Уведомления");
	Словарь.Добавить("office.notifications.page.lead", "Всё, что хаб адресовал лично вам:"
		+ " исход ваших заявок и события вашей учётной записи.");

	Словарь.Добавить("office.notifications.title", "Ваши события");
	Словарь.Добавить("office.notifications.lead", "Свежие сверху. Непрочитанные помечены.");
	Словарь.Добавить("office.notifications.empty", "Хаб вам пока ничего не сообщал.");

	Словарь.Добавить("office.notifications.col.state", "");
	Словарь.Добавить("office.notifications.col.event", "Событие");
	Словарь.Добавить("office.notifications.col.when", "Когда");

	Словарь.Добавить("office.notifications.new", "новое");
	Словарь.Добавить("office.notifications.read.button", "Отметить всё прочитанным");
	Словарь.Добавить("office.notifications.read.done", "Лента отмечена прочитанной.");

	Словарь.Добавить("office.notifications.widget.title", "Новые уведомления: %1");
	Словарь.Добавить("office.notifications.widget.lead", "События, адресованные лично вам.");
	Словарь.Добавить("office.notifications.widget.open", "Открыть ленту");
	Словарь.Добавить("office.notifications.widget.rest", "И ещё %1 — в полной ленте.");

	Словарь.Добавить("office.notifications.error.csrf", "Форма устарела: обновите страницу"
		+ " и повторите действие.");

КонецПроцедуры

// Путь первой публикации: проводник «/tour» и кабинет новичка.
Процедура КлючиПервойПубликации(Словарь)

	Словарь.Добавить("office.start.title", "Первая публикация");
	Словарь.Добавить("office.start.lead", "Четыре шага от свежей инсталляции до версии в каталоге.");
	Словарь.Добавить("office.start.open", "Открыть проводник");

	// кнопка шага «пул»: пула нет — в каталог; управляющему — в настройки; райтеру — на страницу
	Словарь.Добавить("office.start.pool.catalog", "Посмотреть каталог");
	Словарь.Добавить("office.start.pool.settings", "Настройки пула");
	Словарь.Добавить("office.start.pool.page", "Страница пула");

КонецПроцедуры

// Состояние зеркала пула и сводка зеркал кабинета.
Процедура КлючиЗеркал(Словарь)

	Словарь.Добавить("settings.pool.mirror-status.title", "Состояние синхронизации");
	Словарь.Добавить("settings.pool.mirror-status.lead",
		"Что зеркало делает прямо сейчас и чем закончился прошлый прогон.");
	Словарь.Добавить("settings.pool.mirror-status.crumb", "Состояние");
	Словарь.Добавить("settings.pool.mirror-status.notfound", "Зеркало не найдено в этом пуле.");
	Словарь.Добавить("settings.pool.mirror-status.empty", "—");

	Словарь.Добавить("settings.pool.mirror-status.run.title", "Прогон");
	Словарь.Добавить("settings.pool.mirror-status.run.lead",
		"Обход апстрима идёт по списку пакетов; курсор помнит, с какого имени продолжить.");
	Словарь.Добавить("settings.pool.mirror-status.counters.title", "Счётчики прогона");
	Словарь.Добавить("settings.pool.mirror-status.counters.lead",
		"Сколько пакетов апстрима уже разобрано и с каким исходом."
		+ " Если ниже нет раздела с причинами — обход не потерял ни одной версии.");
	Словарь.Добавить("settings.pool.mirror-status.mirror.title", "Зеркало");
	Словарь.Добавить("settings.pool.mirror-status.mirror.lead",
		"Настройки, с которыми идёт синхронизация, и итог прошлого прогона.");

	Словарь.Добавить("settings.pool.mirror-status.col.metric", "Показатель");
	Словарь.Добавить("settings.pool.mirror-status.col.value", "Значение");

	Словарь.Добавить("settings.pool.mirror-status.field.state", "Состояние");
	Словарь.Добавить("settings.pool.mirror-status.field.started", "Прогон начат");
	Словарь.Добавить("settings.pool.mirror-status.field.updated", "Последняя запись прогресса");
	Словарь.Добавить("settings.pool.mirror-status.field.cursor", "Обход дошёл до пакета");
	Словарь.Добавить("settings.pool.mirror-status.field.crawl", "Способ обхода");
	Словарь.Добавить("settings.pool.mirror-status.crawl.full", "полный обход");
	Словарь.Добавить("settings.pool.mirror-status.crawl.increment", "инкремент с %1");
	Словарь.Добавить("settings.pool.mirror-status.field.by", "Запустил");
	Словарь.Добавить("settings.pool.mirror-status.field.by-schedule", "по расписанию");
	Словарь.Добавить("settings.pool.mirror-status.field.upstream", "Апстрим");
	Словарь.Добавить("settings.pool.mirror-status.field.protocol", "Протокол источника");
	Словарь.Добавить("settings.pool.mirror-status.field.interval", "Интервал синхронизации, сек");
	Словарь.Добавить("settings.pool.mirror-status.field.enabled", "Зеркало");
	Словарь.Добавить("settings.pool.mirror-status.field.last-sync", "Последняя синхронизация");
	Словарь.Добавить("settings.pool.mirror-status.field.result", "Итог последнего прогона");

	Словарь.Добавить("settings.pool.mirror-status.count.names", "Пакетов у апстрима (после фильтра)");
	Словарь.Добавить("settings.pool.mirror-status.count.names-done", "Пакетов пройдено обходом");
	Словарь.Добавить("settings.pool.mirror-status.count.total", "Версий перечислено за обход");
	Словарь.Добавить("settings.pool.mirror-status.count.downloaded", "Скачано");
	Словарь.Добавить("settings.pool.mirror-status.count.skipped",
		"Пропущено (включая версии, которые уже лежат в пуле)");
	Словарь.Добавить("settings.pool.mirror-status.count.errors", "Ошибок");
	Словарь.Добавить("settings.pool.mirror-status.count.unavailable", "Недоступно");

	Словарь.Добавить("settings.pool.mirror-status.reasons.title", "Почему версии не приехали");
	Словарь.Добавить("settings.pool.mirror-status.reasons.lead",
		"Здесь только то, что НЕ приехало: что именно не взято в текущем обходе и почему."
		+ " Одинаковые причины по одному пакету собраны в строку со счётчиком.");
	Словарь.Добавить("settings.pool.mirror-status.reasons.col.subject", "Пакет");
	Словарь.Добавить("settings.pool.mirror-status.reasons.col.reason", "Причина");
	Словарь.Добавить("settings.pool.mirror-status.reasons.col.outcome", "Исход");
	Словарь.Добавить("settings.pool.mirror-status.reasons.col.count", "Повторов");
	Словарь.Добавить("settings.pool.mirror-status.reasons.col.last", "Последний раз");
	Словарь.Добавить("settings.pool.mirror-status.reasons.retry", "пройдёт следующим заходом");
	Словарь.Добавить("settings.pool.mirror-status.reasons.final", "пропущено насовсем");
	Словарь.Добавить("settings.pool.mirror-status.reasons.unclear", "причина не разобрана — см. текст");
	Словарь.Добавить("settings.pool.mirror-status.reasons.more", "Ещё причин: %1");
	Словарь.Добавить("settings.pool.mirror-status.reasons.whole-run", "весь обход");
	Словарь.Добавить("settings.pool.mirror-status.reasons.unreadable",
		"Причины прочитать не удалось: хаб их запомнил, но сейчас они недоступны."
		+ " Счётчики выше верны.");

	Словарь.Добавить("settings.pool.mirror-status.progress.label", "Обход апстрима");
	Словарь.Добавить("settings.pool.mirror-status.progress.caption", "пакетов пройдено %1 из %2");
	Словарь.Добавить("settings.pool.mirror-status.refresh.note",
		"Пока прогон не закончен, страница обновляется сама каждые %1 с.");
	Словарь.Добавить("settings.pool.mirror-status.refresh.button", "Обновить");
	Словарь.Добавить("settings.pool.mirror-status.back", "К списку зеркал");

	Словарь.Добавить("office.mirrors.title", "Зеркала хабов");
	Словарь.Добавить("office.mirrors.lead", "Плановая репликация пакетов с другого хаба"
		+ " в ваш local-пул. Выберите пул назначения.");
	Словарь.Добавить("office.mirrors.pools.title", "Пулы назначения");
	Словарь.Добавить("office.mirrors.pools.empty.title", "Нет пулов, которыми вы можете управлять");
	Словарь.Добавить("office.mirrors.pools.empty.lead",
		"Зеркало складывает копию в пул с разрешённой публикацией.");
	Словарь.Добавить("office.mirrors.pool.title", "Зеркала пула %1");
	Словарь.Добавить("office.mirrors.pool.lead", "Хаб по расписанию скачивает пакеты апстрима"
		+ " и складывает их копию в этот пул. Апстрим-контент недоверенный: каждый .ospx"
		+ " валидируется, версии иммутабельны (существующие не перезаписываются)."
		+ " Адрес принимается любой http/https — сеть, в которой живёт источник,"
		+ " хаб не судит.");
	Словарь.Добавить("office.mirrors.list.title", "Зеркала пула");
	Словарь.Добавить("office.mirrors.col.upstream", "Апстрим");
	Словарь.Добавить("office.mirrors.col.protocol", "Протокол");
	Словарь.Добавить("office.mirrors.col.state", "Состояние");
	Словарь.Добавить("office.mirrors.col.run", "Прогон");
	Словарь.Добавить("office.mirrors.col.sync", "Последний синк");
	Словарь.Добавить("office.mirrors.col.actions", "Действия");
	Словарь.Добавить("office.mirrors.empty", "Зеркал пока нет.");
	Словарь.Добавить("office.mirrors.sync.never", "ещё не было");
	Словарь.Добавить("office.mirrors.state.on", "включено");
	Словарь.Добавить("office.mirrors.state.off", "выключено");
	Словарь.Добавить("office.mirrors.button.sync", "Синхронизировать сейчас");
	Словарь.Добавить("office.mirrors.button.enable", "Включить");
	Словарь.Добавить("office.mirrors.button.disable", "Выключить");
	Словарь.Добавить("office.mirrors.button.delete", "Удалить");
	Словарь.Добавить("office.mirrors.new.title", "Новое зеркало");
	Словарь.Добавить("office.mirrors.new.url", "URL апстрима (http/https)");
	Словарь.Добавить("office.mirrors.new.filter", "Фильтр имён (JSON-массив масок; пусто — всё)");
	Словарь.Добавить("office.mirrors.new.interval", "Интервал синка, сек (пусто — по умолчанию)");
	Словарь.Добавить("office.mirrors.new.button", "Создать зеркало");
	Словарь.Добавить("office.mirrors.back", "← Зеркала");
	Словарь.Добавить("office.mirrors.error.pool-notfound", "Пул «%1» не найден");
	Словарь.Добавить("office.mirrors.error.forbidden",
		"Недостаточно прав для управления зеркалами этого пула");
	Словарь.Добавить("office.mirrors.sync.started",
		"Зеркало поставлено в очередь синхронизации: состояние прогона видно"
		+ " в колонке «Прогон».");
	Словарь.Добавить("office.mirrors.sync.running",
		"Заявка не нужна: синхронизация этого зеркала уже идёт — смотрите колонку «Прогон»:"
		+ " пока её счётчики сдвигаются, рабочий работает.");
	Словарь.Добавить("office.mirrors.sync.queued",
		"Заявка не нужна: зеркало уже стоит в очереди и ждёт свободного рабочего.");
	Словарь.Добавить("office.mirrors.sync.disabled",
		"Фоновая синхронизация зеркал выключена на этом хабе: заявку некому разобрать.");
	Словарь.Добавить("office.mirrors.sync.rejected",
		"Заявка не принята: очередь синхронизации её не взяла.");

КонецПроцедуры

// Дом «Пул»: разделы настроек пула.
Процедура КлючиДомаПула(Словарь)

	Словарь.Добавить("settings.pool.title", "Настройки пула");
	Словарь.Добавить("settings.pool.lead", "Настройки пула редактирует его владелец или администратор хаба.");
	Словарь.Добавить("settings.pool.nav.general", "Общие");
	Словарь.Добавить("settings.pool.nav.visibility", "Видимость и доступ");
	Словарь.Добавить("settings.pool.nav.reserved", "Резерв имён");
	Словарь.Добавить("settings.pool.nav.inbox", "Входящие");
	Словарь.Добавить("settings.pool.nav.tags", "Теги");
	Словарь.Добавить("settings.pool.nav.upstreams", "Апстримы");
	Словарь.Добавить("settings.pool.nav.mirrors", "Зеркала");
	Словарь.Добавить("settings.pool.nav.webhooks", "Подписки на события");
	Словарь.Добавить("settings.pool.nav.access", "Права доступа");
	Словарь.Добавить("settings.pool.nav.quota", "Квота");
	Словарь.Добавить("settings.pool.nav.danger", "Опасная зона");
	Словарь.Добавить("settings.pool.crumb", "настройки");

	Словарь.Добавить("settings.pool.error.section", "Раздел настроек не найден");
	Словарь.Добавить("settings.pool.error.save", "Не удалось сохранить: %1");
	Словарь.Добавить("settings.pool.error.visibility",
		"Видимость должна быть «public» или «private». Ничего не изменено.");
	Словарь.Добавить("settings.pool.error.quota.number", "Квота должна быть целым числом мегабайт"
		+ " (−1 — как в хабе, 0 — без ограничения). Значение не распознано, квота НЕ изменена.");
	Словарь.Добавить("settings.pool.error.quota.forbidden",
		"Квоту пула назначает администратор хаба — изменить её отсюда нельзя.");
	Словарь.Добавить("settings.pool.error.quota.limit",
		"Квота слишком велика: максимум %1 МБ (примерно эксабайт). Квота НЕ изменена.");
	Словарь.Добавить("settings.pool.error.upstream.operation", "Неизвестная операция раздела «Апстримы»."
		+ " Ничего не изменено — обновите страницу и повторите действие.");
	Словарь.Добавить("settings.pool.error.upstream.url", "Не задан адрес апстрима.");
	Словарь.Добавить("settings.pool.error.upstream.ttl", "TTL кэша должен быть целым числом секунд.");
	Словарь.Добавить("settings.pool.error.upstream.target", "Не указано, какой апстрим менять.");

	Словарь.Добавить("settings.pool.general.title", "Общие");
	Словарь.Добавить("settings.pool.general.lead", "Базовые свойства пула.");
	Словарь.Добавить("settings.pool.general.name.label", "Имя пула");
	Словарь.Добавить("settings.pool.general.name.hint", "Имя пула входит в адреса пакетов и не переименовывается");
	Словарь.Добавить("settings.pool.general.default.label", "Основной пул хаба");
	Словарь.Добавить("settings.pool.general.default.hint", "Короткие адреса /download, /dev-channel"
		+ " и /push ведут в основной пул; он публичен и неудаляем."
		+ " Основной пул назначается в настройках хаба (/hub/settings/pools)");
	Словарь.Добавить("settings.pool.general.default.yes", "да");
	Словарь.Добавить("settings.pool.general.default.no", "нет");
	Словарь.Добавить("settings.pool.general.visibility.label", "Видимость");
	Словарь.Добавить("settings.pool.general.visibility.hint", "Меняется в разделе «Видимость и доступ»");

	Словарь.Добавить("settings.pool.visibility.title", "Видимость");
	Словарь.Добавить("settings.pool.visibility.lead", "Кто может читать пакеты пула.");
	Словарь.Добавить("settings.pool.visibility.label", "Видимость");
	Словарь.Добавить("settings.pool.visibility.hint",
		"Приватный пул означает, что ВСЕ его пакеты приватны: доступ строго по правам");
	Словарь.Добавить("settings.pool.visibility.option.public", "Публичный — виден всем");
	Словарь.Добавить("settings.pool.visibility.option.private", "Приватный — только по правам");

	Словарь.Добавить("settings.pool.access.title", "Права доступа");
	Словарь.Добавить("settings.pool.access.lead", "Кто и в какой роли допущен к пулу помимо владельца.");
	Словарь.Добавить("settings.pool.access.empty", "Ролей на пуле никому не выдано.");
	Словарь.Добавить("settings.pool.access.col.action", "Действие");
	Словарь.Добавить("settings.pool.access.note", "Администратор хаба распоряжается пулом"
		+ " независимо от этого списка.");
	Словарь.Добавить("settings.pool.access.readonly", "Роли на пуле раздаёт его мейнтейнер"
		+ " или администратор хаба — у вас только просмотр.");
	Словарь.Добавить("settings.pool.access.error.subject",
		"Субъект не найден (проверьте логин пользователя или имя группы)");
	Словарь.Добавить("settings.pool.access.error.object",
		"Раздел управляет правами только на свой пул");
	Словарь.Добавить("settings.pool.access-new.title", "Выдать роль на пул");
	Словарь.Добавить("settings.pool.access-new.lead", "Роль выдаётся пользователю или группе"
		+ " целиком на пул и наследуется всеми его пакетами.");

	Словарь.Добавить("settings.pool.reserved.title", "Зарезервированные имена");
	Словарь.Добавить("settings.pool.reserved.lead", "Имена, занятые заранее: пакет заведён, версий ещё нет.");
	Словарь.Добавить("settings.pool.reserved.col.name", "Имя пакета");
	Словарь.Добавить("settings.pool.reserved.col.rights", "Права на имя");
	Словарь.Добавить("settings.pool.reserved.col.action", "Действие");
	Словарь.Добавить("settings.pool.reserved.grant", "выдать права");
	Словарь.Добавить("settings.pool.reserved.empty", "Занятых заранее имён в пуле нет.");
	Словарь.Добавить("settings.pool.reserved.note", "Здесь же оказывается имя, пакет которого завели,"
		+ " но ни одной версии так и не опубликовали. Снятие освобождает имя для всех.");
	Словарь.Добавить("settings.pool.reserved.button.release", "Снять резерв");
	Словарь.Добавить("settings.pool.reserved.release.title", "Снять резерв имени");
	Словарь.Добавить("settings.pool.reserved.release.lead", "Имя освободится, выданные на него роли исчезнут.");
	Словарь.Добавить("settings.pool.reserved.release.note", "Снять резерв имени %1?"
		+ " Вместе с ним пропадут и роли, выданные на это имя: следующий, кто его займёт,"
		+ " ничего не унаследует.");
	Словарь.Добавить("settings.pool.reserved.release.button", "Снять резерв");
	Словарь.Добавить("settings.pool.reserved.release.confirm", "Снять резерв имени «%1»?"
		+ " Вместе с ним пропадут и роли, выданные на это имя.");
	Словарь.Добавить("settings.pool.reserved.error.operation", "Неизвестная операция раздела «Резерв имён»."
		+ " Ничего не изменено — обновите страницу и повторите действие.");
	Словарь.Добавить("settings.pool.reserved.error.name", "Не задано имя пакета.");
	Словарь.Добавить("settings.pool.reserved.error.reserve", "Имя не занято: %1");
	Словарь.Добавить("settings.pool.reserved.error.release", "Резерв не снят: %1");

	Словарь.Добавить("settings.pool.reserve-new.title", "Занять имя");
	Словарь.Добавить("settings.pool.reserve-new.lead", "Пакет появится пустым, и первая публикация"
		+ " придёт уже в него, а не заведёт имя заново.");
	Словарь.Добавить("settings.pool.reserve-new.name.label", "Имя пакета");
	Словарь.Добавить("settings.pool.reserve-new.name.hint", "Латинские буквы, цифры, «-», «_», «.»;"
		+ " права на занятое имя выдаются в его настройках");
	Словарь.Добавить("settings.pool.reserve-new.button", "Занять имя");
	Словарь.Добавить("settings.pool.reserve-new.blocked",
		"Публикация в пул выключена, поэтому занимать имена нельзя: имя осталось бы"
		+ " занятым навсегда — опубликовать в него не смог бы никто. Включите публикацию"
		+ " в разделе «Публикация».");

	Словарь.Добавить("settings.pool.tags.title", "Теги");
	Словарь.Добавить("settings.pool.tags.lead", "Теги, которые получает каждый пакет пула.");
	Словарь.Добавить("settings.pool.tags.inherit.label", "Теги пула для пакетов");
	Словарь.Добавить("settings.pool.tags.inherit.on", "пакеты наследуют теги пула");
	Словарь.Добавить("settings.pool.tags.inherit.off", "у пакетов только свои теги");
	Словарь.Добавить("settings.pool.tags.inherit.hint", "Включено — каждый пакет пула отдаёт теги пула,"
		+ " ничего не заводя у себя, а правка тега пула доезжает до пакетов сразу. Первое включение"
		+ " заводит stable, prerelease и develop. Выключено — пакеты тегов пула не видят,"
		+ " набор хранится и вернётся с галкой.");
	Словарь.Добавить("settings.pool.tags.note", "Мейнтейнер пакета правит тег пула у себя копией —"
		+ " она заменяет тег пула целиком — или выключает его у пакета. Ручных тегов у пула нет:"
		+ " ручной состав ведут в настройках пакета.");
	Словарь.Добавить("settings.pool.tags.set.title", "Теги пула");
	Словарь.Добавить("settings.pool.tags.set.lead", "Их наследует каждый пакет пула, у которого"
		+ " нет своей копии тега.");
	Словарь.Добавить("settings.pool.tags.set.empty", "У пула нет тегов: заведите тег конструктором ниже.");
	Словарь.Добавить("settings.pool.tags.new.title", "Новый тег пула");
	Словарь.Добавить("settings.pool.tags.edit.title", "Изменение тега пула");
	Словарь.Добавить("settings.pool.tags.new.lead", "Тег пула — правило: диапазон semver"
		+ " или регулярное выражение по строке версии.");
	Словарь.Добавить("settings.pool.tags.new.button", "Сохранить тег пула");
	Словарь.Добавить("settings.pool.tags.rule.label", "Правило");
	Словарь.Добавить("settings.pool.tags.rule.hint", "semver — например «^1.2»; regex сличается"
		+ " со строкой версии целиком и с учётом регистра.");
	Словарь.Добавить("settings.pool.tags.default.hint", "Основной тег пула — основной у пакета,"
		+ " пока у пакета нет своего основного.");
	Словарь.Добавить("settings.pool.tags.error.operation", "Неизвестная операция раздела «Теги».");
	Словарь.Добавить("settings.pool.tags.error.kind", "Вид тега не принят: у пула только правила"
		+ " semver или regex.");
	Словарь.Добавить("settings.pool.tags.error.version", "Имя тега занято версией пакета этого пула:"
		+ " запись «пакет@имя» читается сначала как точная версия, и тег у этого пакета остался бы"
		+ " недостижим. Назовите тег иначе.");
	Словарь.Добавить("settings.pool.tags.error.save", "Тег пула не сохранён: %1");

	Словарь.Добавить("settings.pool.publication.title", "Публикация");
	Словарь.Добавить("settings.pool.publication.lead", "Принимает ли пул собственные пакеты.");
	Словарь.Добавить("settings.pool.publication.label", "Публикация разрешена");
	Словарь.Добавить("settings.pool.publication.on", "принимает opm push");
	Словарь.Добавить("settings.pool.publication.off", "чистый прокси-кэш");
	Словарь.Добавить("settings.pool.publication.hint", "Выключите, чтобы получился чистый прокси-кэш:"
		+ " пул только раздаёт то, что взял с апстримов, и не принимает opm push");

	Словарь.Добавить("settings.pool.upstreams.title", "Апстримы");
	Словарь.Добавить("settings.pool.upstreams.lead", "Порядок обхода внешних хабов при промахе в пуле.");
	Словарь.Добавить("settings.pool.upstreams.col.position", "№");
	Словарь.Добавить("settings.pool.upstreams.col.url", "Апстрим");
	Словарь.Добавить("settings.pool.upstreams.col.ttl", "TTL, сек");
	Словарь.Добавить("settings.pool.upstreams.col.state", "Состояние");
	Словарь.Добавить("settings.pool.upstreams.col.order", "Порядок");
	Словарь.Добавить("settings.pool.upstreams.empty", "Апстримов нет: пул раздаёт только свои пакеты.");
	Словарь.Добавить("settings.pool.upstreams.note", "Свои пакеты всегда проверяются РАНЬШЕ апстримов —"
		+ " одноимённый пакет снаружи не может подменить ваш.");
	Словарь.Добавить("settings.pool.upstreams.button.up", "Выше");
	Словарь.Добавить("settings.pool.upstreams.button.down", "Ниже");
	Словарь.Добавить("settings.pool.upstreams.button.on", "Включить");
	Словарь.Добавить("settings.pool.upstreams.button.off", "Выключить");
	Словарь.Добавить("settings.pool.upstreams.button.remove", "Удалить");
	Словарь.Добавить("settings.pool.upstreams.state.off", "выключен вручную — не опрашивается");
	Словарь.Добавить("settings.pool.upstreams.state.unknown", "ещё не проверялся");
	Словарь.Добавить("settings.pool.upstreams.state.alive", "жив, проверен %1");
	Словарь.Добавить("settings.pool.upstreams.state.down", "лежит с %1: %2");
	Словарь.Добавить("settings.pool.upstreams.col.access", "Доступ");
	Словарь.Добавить("settings.pool.upstreams.access.token", "по токену");
	Словарь.Добавить("settings.pool.upstreams.access.anonymous", "анонимно");
	Словарь.Добавить("settings.pool.upstreams.button.token-off", "Снять токен");
	Словарь.Добавить("settings.pool.upstreams.state.denied", "не пустил, проверен %1: %2");
	Словарь.Добавить("settings.pool.upstreams.state.unknown.restart", "ещё не проверялся после перезапуска");
	Словарь.Добавить("settings.pool.upstreams.last-failure.down", "в последний раз не отвечал %1: %2");
	Словарь.Добавить("settings.pool.upstreams.last-failure.denied", "в последний раз не пустил %1: %2");
	Словарь.Добавить("settings.pool.upstreams.state.join", "; ");

	Словарь.Добавить("settings.pool.upstream-new.title", "Добавить апстрим");
	Словарь.Добавить("settings.pool.upstream-new.lead",
		"Апстрим — внешний хаб; пул опрашивает апстримы по порядку после промаха у себя.");
	Словарь.Добавить("settings.pool.upstream-new.url.label", "Адрес апстрима");
	Словарь.Добавить("settings.pool.upstream-new.url.hint", "Базовый URL выдачи внешнего хаба (контракт opm)");
	Словарь.Добавить("settings.pool.upstream-new.ttl.label", "TTL кэша, секунд");
	Словарь.Добавить("settings.pool.upstream-new.ttl.hint",
		"Как долго жить кэшу изменяемых ресурсов (list.txt, latest)");
	Словарь.Добавить("settings.pool.upstream-new.probe.note",
		"Адрес принимается любой — хаб в вашей сети, хаб на нестандартном порту, публичный"
		+ " хаб. Перед сохранением хаб пробует к нему подключиться: не подключился —"
		+ " источник не заводится, и на этой же странице будет написано, что именно"
		+ " не получилось.");
	Словарь.Добавить("settings.pool.upstream-new.probe.note.off",
		"Адрес принимается любой — хаб в вашей сети, хаб на нестандартном порту, публичный"
		+ " хаб. Пробное подключение на этом хабе выключено (настройка"
		+ " oshub.upstream.probe.enabled): адрес сохранится, даже если по нему никто"
		+ " не отвечает, и живость источников хаб не проверяет вовсе.");
	Словарь.Добавить("settings.pool.upstream-new.button", "Добавить");
	Словарь.Добавить("settings.pool.upstream-new.token.label", "Токен доступа");
	Словарь.Добавить("settings.pool.upstream-new.token.hint",
		"Нужен, только если выдача источника закрыта. Токен предъявляется каждому запросу"
		+ " к нему и обратно не показывается: пустое поле у заведённого источника означает"
		+ " «оставить прежний», а вернуть анонимное чтение — кнопкой «Снять токен» в списке.");

	Словарь.Добавить("settings.pool.mirrors.title", "Зеркала пула");
	Словарь.Добавить("settings.pool.mirrors.lead",
		"Плановая репликация: хаб по расписанию скачивает пакеты другого хаба и складывает"
		+ " их копию в этот пул.");
	Словарь.Добавить("settings.pool.mirrors.col.upstream", "Апстрим");
	Словарь.Добавить("settings.pool.mirrors.col.protocol", "Протокол");
	Словарь.Добавить("settings.pool.mirrors.col.interval", "Интервал, сек");
	Словарь.Добавить("settings.pool.mirrors.col.state", "Состояние");
	Словарь.Добавить("settings.pool.mirrors.col.run", "Прогон");
	Словарь.Добавить("settings.pool.mirrors.col.sync", "Последний синк");
	Словарь.Добавить("settings.pool.mirrors.col.actions", "Действия");
	Словарь.Добавить("settings.pool.mirrors.sync.never", "ещё не было");
	Словарь.Добавить("settings.pool.mirrors.empty", "Зеркал пока нет: пул ничего не реплицирует.");
	Словарь.Добавить("settings.pool.mirrors.note", "Зеркало отличается от апстрима: апстрим отдаёт чужой"
		+ " пакет по запросу, зеркало заранее копирует набор пакетов к себе. Содержимое апстрима"
		+ " недоверенное — каждый .ospx проверяется, а уже существующие версии не перезаписываются.");
	Словарь.Добавить("settings.pool.mirrors.state.on", "включено");
	Словарь.Добавить("settings.pool.mirrors.state.off", "выключено");
	Словарь.Добавить("settings.pool.mirrors.button.sync", "Синхронизировать сейчас");
	Словарь.Добавить("settings.pool.mirrors.button.enable", "Включить");
	Словарь.Добавить("settings.pool.mirrors.button.disable", "Выключить");
	Словарь.Добавить("settings.pool.mirrors.button.delete", "Удалить");
	Словарь.Добавить("settings.pool.mirrors.error.disabled",
		"Фоновая синхронизация зеркал выключена на этом хабе: заявку некому разобрать.");
	Словарь.Добавить("settings.pool.mirrors.sync.queued",
		"Заявка принята: зеркало поставлено в очередь синхронизации. Прогон начнётся, когда"
		+ " фоновый рабочий освободится: занятое зеркало он дочитывает порциями, и это"
		+ " могут быть минуты и десятки минут.");
	Словарь.Добавить("settings.pool.mirrors.sync.running",
		"Заявка не нужна: синхронизация этого зеркала уже идёт. Живой обход виден по полю"
		+ " «Обновлён» — пока отметка сдвигается, рабочий работает.");
	Словарь.Добавить("settings.pool.mirrors.sync.waiting",
		"Заявка не нужна: зеркало уже стоит в очереди и ждёт свободного рабочего.");
	Словарь.Добавить("settings.pool.mirrors.sync.rejected",
		"Заявка не принята: очередь синхронизации её не взяла.");
	Словарь.Добавить("settings.pool.mirrors.col.access", "Доступ");
	Словарь.Добавить("settings.pool.mirrors.access.token", "по токену");
	Словарь.Добавить("settings.pool.mirrors.access.anonymous", "анонимно");
	Словарь.Добавить("settings.pool.mirrors.button.token-off", "Снять токен");

	Словарь.Добавить("settings.pool.mirror-new.title", "Новое зеркало");
	Словарь.Добавить("settings.pool.mirror-new.lead",
		"Зеркало складывает копию в этот пул. Выключенная публикация ему не мешает:"
		+ " она закрывает пул для людей, а не для хаба.");
	Словарь.Добавить("settings.pool.mirror-new.url.label", "Адрес апстрима");
	Словарь.Добавить("settings.pool.mirror-new.url.hint", "Базовый URL хаба-источника, только http/https");
	Словарь.Добавить("settings.pool.mirror-new.filter.label", "Фильтр имён");
	Словарь.Добавить("settings.pool.mirror-new.filter.hint",
		"JSON-массив масок имён пакетов; пусто — забирать всё");
	Словарь.Добавить("settings.pool.mirror-new.interval.label", "Интервал синхронизации, секунд");
	Словарь.Добавить("settings.pool.mirror-new.interval.hint",
		"Пусто — интервал по умолчанию; слишком малые значения поднимаются до минимального");
	Словарь.Добавить("settings.pool.mirror-new.probe.note",
		"Адрес принимается любой. Перед сохранением хаб пробует к нему подключиться:"
		+ " не подключился — зеркало не заводится, и причина будет написана здесь же.");
	Словарь.Добавить("settings.pool.mirror-new.probe.note.off",
		"Адрес принимается любой. Пробное подключение на этом хабе выключено (настройка"
		+ " oshub.upstream.probe.enabled): зеркало заведётся, даже если по адресу никто"
		+ " не отвечает, а о недоступности апстрима скажет только первый прогон"
		+ " синхронизации.");
	Словарь.Добавить("settings.pool.mirror-new.button", "Создать зеркало");
	Словарь.Добавить("settings.pool.mirror-new.token.label", "Токен доступа");
	Словарь.Добавить("settings.pool.mirror-new.token.hint",
		"Нужен, только если выдача апстрима закрыта. Токен предъявляется каждому запросу"
		+ " к нему и обратно не показывается; вернуть анонимное чтение — кнопкой"
		+ " «Снять токен» в списке.");

	Словарь.Добавить("settings.pool.quota.title", "Квота");
	Словарь.Добавить("settings.pool.quota.lead", "Сколько места пул может занять.");
	Словарь.Добавить("settings.pool.quota.label", "Квота пула, МБ");
	Словарь.Добавить("settings.pool.quota.hint",
		"−1 — как в хабе, 0 — без ограничения. Квота меряет ВСЁ место, занятое пулом"
		+ " в хранилище: свои публикации, ВКЛЮЧАЯ отозванные (отзыв места не освобождает,"
		+ " артефакт остаётся на диске), кэш прокси, зеркалированное и артефакты заявок."
		+ " Место освобождают удаление пакета и уборка кэша прокси.");
	Словарь.Добавить("settings.pool.quota.meter.label", "Заполнение пула");
	Словарь.Добавить("settings.pool.quota.meter.value", "%1 из %2");
	Словарь.Добавить("settings.pool.quota.meter.unlimited", "занято %1, квота не задана");
	Словарь.Добавить("settings.pool.quota.readonly",
		"Квоту пула назначает администратор хаба. Здесь она видна, но не меняется.");
	Словарь.Добавить("settings.pool.quota.inherited", "Действует квота хаба по умолчанию: %1 МБ.");
	Словарь.Добавить("settings.pool.quota.own", "Собственная квота пула: %1 МБ.");
	Словарь.Добавить("settings.pool.quota.none", "Ограничения нет: пул растёт, пока есть место в хранилище.");

	Словарь.Добавить("settings.pool.danger.title", "Опасная зона");
	Словарь.Добавить("settings.pool.danger.lead", "Необратимые операции над пулом «%1».");
	Словарь.Добавить("settings.pool.danger.delete.title", "Удаление пула");
	Словарь.Добавить("settings.pool.danger.note", "Удаление уносит пул со всем, что на нём висело:"
		+ " пакеты и все их версии, файлы артефактов в хранилище, выданные роли и права,"
		+ " ключи доступа пула, подписки, источники и зеркала, незакрытые заявки."
		+ " Артефакты, на которые ссылаются чужие сборки, после этого не скачаются.");
	Словарь.Добавить("settings.pool.danger.note.free", "Имя «%1» освободится: пул с тем же именем"
		+ " заводится заново и начинается пустым — старое содержимое в нём не появится.");
	Словарь.Добавить("settings.pool.danger.note.softer", "Мягче удаления: сделать пул приватным"
		+ " (раздел «Видимость и доступ») и запретить публикацию (раздел «Апстримы»).");
	Словарь.Добавить("settings.pool.danger.note.yank", "Отзыв отдельных версий — в настройках пакета.");
	Словарь.Добавить("settings.pool.danger.button", "Удалить пул");
	Словарь.Добавить("settings.pool.danger.echo.label", "Имя пула");
	Словарь.Добавить("settings.pool.danger.echo.hint", "Введите «%1» — так подтверждается,"
		+ " что удаляется именно этот пул.");

	// причины запрета удаления пула — те же, что говорит API
	Словарь.Добавить("settings.pool.danger.readonly", "Пул удаляет администратор хаба:"
		+ " это право уровня хаба, роль администратора пула его не даёт.");
	Словарь.Добавить("settings.pool.danger.error.forbidden", "Удаление пула — право уровня хаба;"
		+ " роль администратора пула его не даёт.");
	Словарь.Добавить("settings.pool.danger.error.operation", "Неизвестная операция опасной зоны:"
		+ " пул не тронут.");
	Словарь.Добавить("settings.pool.danger.error.echo", "Пул не удалён: подтверждение не совпало."
		+ " Повторите имя пула «%1» в точности.");
	Словарь.Добавить("settings.pool.danger.error.delete", "Пул не удалён: %1");

КонецПроцедуры

// Дом «Пакет»: разделы настроек пакета.
Процедура КлючиДомаПакета(Словарь)

	Словарь.Добавить("settings.package.title", "Настройки пакета");
	Словарь.Добавить("settings.package.lead", "Карточка, права доступа, теги, версии"
		+ " и подписки на события пакета.");
	Словарь.Добавить("settings.package.nav.card", "Карточка");
	Словарь.Добавить("settings.package.nav.access", "Права доступа");
	Словарь.Добавить("settings.package.nav.tags", "Теги");
	Словарь.Добавить("settings.package.nav.versions", "Версии и метки");
	Словарь.Добавить("settings.package.nav.webhooks", "Подписки на события");
	Словарь.Добавить("settings.package.nav.ci", "Доверенная публикация");
	Словарь.Добавить("settings.package.nav.danger", "Опасная зона");
	Словарь.Добавить("settings.package.crumb", "настройки");
	Словарь.Добавить("settings.package.tab", "Настройки: %1");

	Словарь.Добавить("settings.package.error.section", "Раздел настроек не найден");
	Словарь.Добавить("settings.package.error.save", "Не удалось сохранить: %1");

	Словарь.Добавить("settings.package.card.title", "Карточка пакета");
	Словарь.Добавить("settings.package.card.lead", "Метаданные, которые видит потребитель.");
	Словарь.Добавить("settings.package.card.description.label", "Описание");
	Словарь.Добавить("settings.package.card.keywords.label", "Ключевые слова");
	Словарь.Добавить("settings.package.card.keywords.hint", "Через запятую");
	Словарь.Добавить("settings.package.card.license.label", "Лицензия");
	Словарь.Добавить("settings.package.card.repo.label", "Адрес репозитория");
	Словарь.Добавить("settings.package.card.repo.hint", "Только http/https");
	Словарь.Добавить("settings.package.card.deprecated.label", "Устаревший (deprecated)");
	Словарь.Добавить("settings.package.card.deprecated.hint",
		"Пакет остаётся доступным, но помечается как устаревший");
	Словарь.Добавить("settings.package.card.hidden.label", "Скрыт из каталога");
	Словарь.Добавить("settings.package.card.hidden.hint",
		"Пакет не показывается в каталоге и поиске, но остаётся доступным по прямой ссылке");

	Словарь.Добавить("settings.package.access.title", "Права доступа на пакет");
	Словарь.Добавить("settings.package.access.lead", "Кто и в какой роли работает с этим пакетом"
		+ " сверх того, что даёт роль на пуле.");
	Словарь.Добавить("settings.package.access.col.action", "Действие");
	Словарь.Добавить("settings.package.access.empty", "Отдельных прав на пакет не выдано:"
		+ " доступ приходит с пула.");
	Словарь.Добавить("settings.package.access.note", "Роль действует только на этот пакет и его версии."
		+ " Права на весь пул выдаются в настройках пула.");
	Словарь.Добавить("settings.package.access.readonly", "Права показаны только для чтения:"
		+ " выдавать и отзывать их может мейнтейнер пакета и выше.");
	Словарь.Добавить("settings.package.access.error.object",
		"Раздел правит права только на этот пакет");
	Словарь.Добавить("settings.package.access.error.subject",
		"Пользователь или группа с таким именем не найдены");

	Словарь.Добавить("settings.package.access-new.title", "Выдать право на пакет");
	Словарь.Добавить("settings.package.access-new.lead", "Роль на пакете не даёт прав на остальной пул.");

	Словарь.Добавить("settings.package.access.inherited.title", "Унаследованный доступ");
	Словарь.Добавить("settings.package.access.inherited.lead",
		"Кто распоряжается пакетом, не значась в списке выше.");
	Словарь.Добавить("settings.package.access.inherited.note", "Список выше — только роли на самом пакете."
		+ " Менять пакет вправе ещё и райтер пула и выше (роль на пуле наследуется его пакетами),"
		+ " администратор хаба и автор любой опубликованной версии этого пакета. Выдавать и"
		+ " отзывать роли на пакете может мейнтейнер пакета и выше — в том числе полученный"
		+ " наследованием с пула.");
	Словарь.Добавить("settings.package.access.inherited.pool",
		"Роли на весь пул выдаются там же, где его видимость: %1.");
	Словарь.Добавить("settings.package.access.inherited.link", "видимость и доступ пула");

	Словарь.Добавить("settings.package.tags.title", "Теги пакета");
	Словарь.Добавить("settings.package.tags.lead", "Тег — канал обновления: он помечает свои версии,"
		+ " а «пакет@тег» отдаёт максимальную из них.");
	Словарь.Добавить("settings.package.tags.col.tag", "Тег");
	Словарь.Добавить("settings.package.tags.col.mode", "Режим");
	Словарь.Добавить("settings.package.tags.col.rule", "Правило");
	Словарь.Добавить("settings.package.tags.col.version", "Версия");
	Словарь.Добавить("settings.package.tags.col.origin", "Откуда");
	Словарь.Добавить("settings.package.tags.origin.own", "свой");
	Словарь.Добавить("settings.package.tags.origin.pool", "от пула");
	Словарь.Добавить("settings.package.tags.origin.override", "перекрывает пул");
	Словарь.Добавить("settings.package.tags.origin.disabled", "выключен у пакета");
	Словарь.Добавить("settings.package.tags.empty", "Тегов нет: сам хаб их не заводит."
		+ " Три обычных канала заводит кнопка «Создать каналы „по умолчанию“» над таблицей,"
		+ " любой другой — конструктор тега ниже.");
	Словарь.Добавить("settings.package.tags.none", "—");
	Словарь.Добавить("settings.package.tags.repush.allowed", "переиздание разрешено");

	// доступное имя раскрывашки начинается видимым словом: так её находит голосовое управление
	Словарь.Добавить("settings.package.tags.rule.show", "Показать");
	Словарь.Добавить("settings.package.tags.rule.about", "Показать правило канала «%1»");

	Словарь.Добавить("settings.package.tags.wizard.button", "Создать каналы «по умолчанию»");
	Словарь.Добавить("settings.package.tags.wizard.title", "Каналы «по умолчанию»");
	Словарь.Добавить("settings.package.tags.wizard.lead", "Три канала, которых чаще всего ждут"
		+ " от пакета. Заводятся один раз; дальше каждый правится как обычный тег,"
		+ " и визард уже заведённый канал не переопределяет.");
	Словарь.Добавить("settings.package.tags.wizard.col.channel", "Канал");
	Словарь.Добавить("settings.package.tags.wizard.col.content", "Что в нём");
	Словарь.Добавить("settings.package.tags.wizard.col.rule", "Правило");
	Словарь.Добавить("settings.package.tags.wizard.stable", "Только стабильные версии."
		+ " Он же станет основным каналом пакета, если основного ещё нет.");
	Словарь.Добавить("settings.package.tags.wizard.prerelease", "Стабильные версии"
		+ " и предрелизы-кандидаты «-rc».");
	Словарь.Добавить("settings.package.tags.wizard.develop", "Сборочные и нестабильные: «-alpha»,"
		+ " «-beta», «-dev», версии со сборочным суффиксом. Слот SNAPSHOT сюда не попадает:"
		+ " его содержимое меняется, и каналу обновления он не принадлежит.");
	Словарь.Добавить("settings.package.tags.wizard.submit", "Создать каналы");

	// перечень имён — после двоеточия: фраза читается и с одним именем, и с тремя
	Словарь.Добавить("settings.package.tags.wizard.busy", "Ни один канал не заведён — занято"
		+ " номерами версий этого пакета: %1. Заведите каналы под другими именами"
		+ " в конструкторе тега.");
	Словарь.Добавить("settings.package.tags.wizard.skipped", "Каналы заведены, кроме занятых"
		+ " номерами версий этого пакета: %1.");
	Словарь.Добавить("settings.package.tags.wizard.skipped.nodefault", "Каналы заведены, кроме"
		+ " занятых номерами версий этого пакета: %1. Основного тега у пакета нет —"
		+ " назначьте его действием «Сделать основным» в меню строки, иначе установка"
		+ " без тега пойдёт за последней версией, а не за каналом.");
	Словарь.Добавить("settings.package.tags.wizard.nothing", "Заводить нечего: все предлагаемые"
		+ " каналы у пакета уже есть.");
	Словарь.Добавить("settings.package.tags.menu.title", "Действия с каналом «%1»");
	Словарь.Добавить("settings.package.tags.button.default", "Сделать основным");
	Словарь.Добавить("settings.package.tags.button.edit", "Изменить");
	Словарь.Добавить("settings.package.tags.button.remove", "Удалить");
	Словарь.Добавить("settings.package.tags.button.disable", "Выключить у пакета");
	Словарь.Добавить("settings.package.tags.button.restore", "Вернуть тег пула");
	Словарь.Добавить("settings.package.tags.button.enable", "Включить снова");
	Словарь.Добавить("settings.package.tags.error.operation", "Неизвестная операция раздела «Теги»."
		+ " Нажмите «Сохранить тег» или «Проверить правило».");

	Словарь.Добавить("settings.package.tag-new.title", "Конструктор тега");
	Словарь.Добавить("settings.package.tag-new.edit.title", "Изменение тега");
	Словарь.Добавить("settings.package.tag-new.lead", "Ручной тег заводится пустым — версии вешаются"
		+ " в разделе «Версии и метки», у самой версии. Тег-правило отбирает версии само,"
		+ " по выражению.");
	Словарь.Добавить("settings.package.tag-new.name.label", "Имя тега");
	Словарь.Добавить("settings.package.tag-new.name.error", "Имя тега не принято: разрешены латиница,"
		+ " цифры, дефис, подчёркивание и точка, не длиннее 64 символов. Имя участвует"
		+ " в адресе и в записи «пакет@тег».");
	Словарь.Добавить("settings.package.tag-new.name.version.error", "Имя тега занято версией пакета:"
		+ " запись «пакет@имя» читается сначала как точная версия, и тег с таким именем"
		+ " остался бы недостижим. Назовите тег иначе.");
	Словарь.Добавить("settings.package.tag-new.mode.label", "Вид тега");
	Словарь.Добавить("settings.package.tag-new.mode.hint", "Правило отбирает версии само;"
		+ " ручному тегу версии назначает мейнтейнер.");
	Словарь.Добавить("settings.package.tag-new.mode.manual", "ручной — версии вешает мейнтейнер");
	Словарь.Добавить("settings.package.tag-new.style.label", "Стиль плашки");
	Словарь.Добавить("settings.package.tag-new.style.hint", "Стиль говорит, ЧТО за канал, а не какого"
		+ " он цвета: цвет берётся из темы, поэтому плашка читается и в светлой, и в тёмной.");
	Словарь.Добавить("settings.package.tag-new.style.plain", "Обычный");
	Словарь.Добавить("settings.package.tag-new.style.stable", "Стабильный");
	Словарь.Добавить("settings.package.tag-new.style.prerelease", "Предварительный");
	Словарь.Добавить("settings.package.tag-new.style.deprecated", "Устаревший");
	Словарь.Добавить("settings.package.tag-new.style.special", "Особый");
	Словарь.Добавить("settings.package.tag-new.icon.label", "Значок");
	Словарь.Добавить("settings.package.tag-new.icon.hint",
		"Значок наследует цвет стиля, поэтому меняется вместе с ним и с темой");
	Словарь.Добавить("settings.package.tag-new.icon.none", "Без значка");
	Словарь.Добавить("settings.package.tag-new.icon.check", "Галочка");
	Словарь.Добавить("settings.package.tag-new.icon.verified", "Проверено");
	Словарь.Добавить("settings.package.tag-new.icon.warning", "Внимание");
	Словарь.Добавить("settings.package.tag-new.icon.stop", "Стоп");
	Словарь.Добавить("settings.package.tag-new.icon.lock", "Замок");
	Словарь.Добавить("settings.package.tag-new.icon.history", "История");
	Словарь.Добавить("settings.package.tag-new.icon.cube", "Сборка");
	Словарь.Добавить("settings.package.tag-new.icon.key", "Ключ");
	Словарь.Добавить("settings.package.tag-new.kind.error", "Вид тега не принят: выберите один из"
		+ " предложенных вариантов списка.");
	Словарь.Добавить("settings.package.tag-new.look.error", "Оформление не принято: стиль и значок"
		+ " выбираются из списка, и присланного значения в нём нет.");
	Словарь.Добавить("settings.package.tag-new.default.label", "Тег по умолчанию");
	Словарь.Добавить("settings.package.tag-new.default.hint", "Им резолвится установка без тега."
		+ " Снять признак нельзя — он всегда ровно у одного тега, назначьте его другому.");
	Словарь.Добавить("settings.package.tag-new.repush.label", "Запрет повторной публикации");
	Словарь.Добавить("settings.package.tag-new.repush.hint", "Пока запрет включён, номер, попавший"
		+ " под этот тег, вторым push не заменить: публикатору отвечают конфликтом."
		+ " Заменить номер можно только явно — параметром «?force=1» у адреса push,"
		+ " а в новых версиях клиента «opm push --force». Снимите запрет, если номера этого"
		+ " канала переиздаются постоянно, — тогда любой, кто вправе публиковать, заменит"
		+ " уже установленную у людей версию молча.");
	Словарь.Добавить("settings.package.tag-new.type.semver", "semver — диапазон версий");
	Словарь.Добавить("settings.package.tag-new.type.regex", "regex — по строке версии");
	Словарь.Добавить("settings.package.tag-new.rule.semver.label", "Диапазон версий");
	Словарь.Добавить("settings.package.tag-new.rule.semver.hint", "Например «^1.2» или «>=2.0.0»."
		+ " Диапазон «*» пререлизы НЕ пропускает, «>=0.0.0-0» — пропускает");
	Словарь.Добавить("settings.package.tag-new.rule.regex.label", "Регулярное выражение");
	Словарь.Добавить("settings.package.tag-new.rule.regex.hint", "regex НЕ якорится автоматически и совпадает"
		+ " с ПОДСТРОКОЙ версии: «1\\.2» поймает и «11.2.0». Пользуйтесь якорями ^…$");
	Словарь.Добавить("settings.package.tag-new.check.button", "Проверить правило");
	Словарь.Добавить("settings.package.tag-new.preview.version", "Тег будет отдавать версию %1");
	Словарь.Добавить("settings.package.tag-new.preview.matches", "Под правило попадут: %1");
	Словарь.Добавить("settings.package.tag-new.preview.empty", "Ни одна версия пакета под правило не попадает"
		+ " — такой тег не отдаст ничего.");
	Словарь.Добавить("settings.package.tag-new.preview.error", "Правило не применено: %1");
	Словарь.Добавить("settings.package.tag-new.button", "Сохранить тег");
	Словарь.Добавить("settings.package.tag-new.saved.matches", "Под правило тега %1 попали версии: %2");
	Словарь.Добавить("settings.package.tag-new.saved.matches.yanked", "Под правило тега %1 попали"
		+ " версии: %2. Отозванные тоже попали (%3), но установка их не выбирает.");
	Словарь.Добавить("settings.package.tag-new.saved.yanked", "Под правило тега %1 попали только"
		+ " отозванные версии (%2) — установка их не выбирает, и тег не отдаст ничего.");
	Словарь.Добавить("settings.package.tag-new.saved.empty", "Под правило тега %1 не попала ни одна"
		+ " версия пакета — такой тег не отдаст ничего.");
	Словарь.Добавить("settings.package.tag-new.save.lead", "Сохранение одноимённого тега"
		+ " переопределяет прежний. Ручной тег заводится пустым: версии вешаются в разделе"
		+ " «Версии и метки», в меню нужной версии.");
	Словарь.Добавить("settings.package.tag-new.save.switch.manual", "Тег %1 сейчас в режиме правила."
		+ " После сохранения правило будет стёрто, а канал станет ПУСТЫМ: версии в него"
		+ " набирают вручную, в меню версии.");
	Словарь.Добавить("settings.package.tag-new.save.switch.rule", "Тег %1 сейчас ручной. После"
		+ " сохранения его метки будут сняты, а состав канала начнёт считаться правилом.");

	Словарь.Добавить("settings.package.versions.title", "Версии и метки");
	Словарь.Добавить("settings.package.versions.lead", "Отзыв, восстановление и теги опубликованных версий.");
	Словарь.Добавить("settings.package.versions.col.version", "Версия");
	Словарь.Добавить("settings.package.versions.col.state", "Состояние");
	Словарь.Добавить("settings.package.versions.col.published", "Опубликована");
	Словарь.Добавить("settings.package.versions.col.tags", "Теги");
	Словарь.Добавить("settings.package.versions.col.action", "Действие");
	Словарь.Добавить("settings.package.versions.empty", "Нет опубликованных версий.");
	Словарь.Добавить("settings.package.versions.error.operation", "Неизвестная операция раздела");
	Словарь.Добавить("settings.package.versions.yanked", "отозвана");
	Словарь.Добавить("settings.package.versions.note", "Отзыв не удаляет артефакт: уже собранные"
		+ " проекты продолжают его получать, но новые установки версию не выбирают.");
	Словарь.Добавить("settings.package.versions.button.yank", "Отозвать");
	Словарь.Добавить("settings.package.versions.button.unyank", "Восстановить");
	Словарь.Добавить("settings.package.versions.menu.title", "Действия с версией %1");
	Словарь.Добавить("settings.package.versions.menu.tag.label", "Тег");
	Словарь.Добавить("settings.package.versions.menu.tag.add", "Добавить тег");
	Словарь.Добавить("settings.package.versions.menu.tag.none", "Ручных тегов у пакета нет —"
		+ " вешать нечего. Заведите тег в конструкторе: %1.");
	Словарь.Добавить("settings.package.versions.menu.tag.link", "раздел «Теги пакета»");
	Словарь.Добавить("settings.package.versions.menu.tag.unknown", "Такого ручного тега у пакета нет."
		+ " Выберите тег из списка либо заведите его в разделе «Теги пакета»: тег-правило"
		+ " набирает версии сам, и ручная метка на нём ни на что не влияет.");
	Словарь.Добавить("settings.package.versions.unset.hint", "Снять тег %1 с версии %2");
	Словарь.Добавить("settings.package.versions.unset.title", "Снять тег с версии");
	Словарь.Добавить("settings.package.versions.unset.lead", "Действие обратимо: тег можно повесить"
		+ " обратно тем же меню версии.");
	Словарь.Добавить("settings.package.versions.unset.note", "Снять тег %1 с версии %2?"
		+ " Сам тег останется, из его канала уйдёт только эта версия.");
	Словарь.Добавить("settings.package.versions.unset.button", "Снять");
	Словарь.Добавить("settings.package.versions.unset.confirm", "Снять тег «%1» с версии «%2»?"
		+ " Сам тег останется, из его канала уйдёт только эта версия.");

	Словарь.Добавить("settings.package.danger.title", "Опасная зона");
	Словарь.Добавить("settings.package.danger.lead", "Необратимые операции над пакетом.");
	Словарь.Добавить("settings.package.danger.note", "Удаление пакета не поддерживается: имя пакета — часть"
		+ " публичного контракта хаба, а его артефакты уже могли попасть в чужие сборки."
		+ " Доступные необратимые действия: отзыв версии (раздел «Версии и метки»)"
		+ " и пометка «устаревший» либо «скрыт» (раздел «Карточка»).");
	Словарь.Добавить("settings.package.danger.public", "Публичная страница: %1");

КонецПроцедуры

// Раздел «Доверенная публикация» пакета.
Процедура КлючиДоверияCI(Словарь)

	Словарь.Добавить("settings.package.ci.title", "Доверенные конвейеры");
	Словарь.Добавить("settings.package.ci.lead", "Конвейеры сборки, которым разрешено публиковать"
		+ " версии этого пакета по короткоживущему id-token — без постоянного ключа"
		+ " в секретах репозитория.");
	Словарь.Добавить("settings.package.ci.col.repo", "Репозиторий");
	Словарь.Добавить("settings.package.ci.col.workflow", "Конвейер");
	Словарь.Добавить("settings.package.ci.col.ref", "Реф");
	Словарь.Добавить("settings.package.ci.col.author", "Кем и когда");
	Словарь.Добавить("settings.package.ci.col.action", "Действие");
	Словарь.Добавить("settings.package.ci.issuer", "издатель %1");
	Словарь.Добавить("settings.package.ci.any", "любой");
	Словарь.Добавить("settings.package.ci.ref.wide", "без ограничения");
	Словарь.Добавить("settings.package.ci.empty", "Доверенных конвейеров у пакета нет:"
		+ " публиковать его сейчас может только человек со своим ключом доступа.");
	Словарь.Добавить("settings.package.ci.note", "Совпасть должно КАЖДОЕ поле записи; пустым"
		+ " остаётся только конвейер — это «любой конвейер репозитория»."
		+ " Доверие не заводит новых имён: пакет уже существует, а первую публикацию"
		+ " закрывают резерв имени и очередь заявок пула.");
	Словарь.Добавить("settings.package.ci.button.revoke", "Отозвать");
	Словарь.Добавить("settings.package.ci.revoke.title", "Отозвать доверие конвейеру");
	Словарь.Добавить("settings.package.ci.revoke.lead", "Следующая попытка публикации из этого"
		+ " конвейера получит отказ.");
	Словарь.Добавить("settings.package.ci.revoke.note", "Отозвать доверие конвейеру %1?");
	Словарь.Добавить("settings.package.ci.revoke.button", "Отозвать доверие");
	Словарь.Добавить("settings.package.ci.revoke.confirm", "Отозвать доверие конвейеру «%1»?"
		+ " Следующая попытка публикации из него получит отказ.");
	Словарь.Добавить("settings.package.ci.error.forbidden", "Доверенные конвейеры пакета"
		+ " настраивают его мейнтейнеры и выше.");
	Словарь.Добавить("settings.package.ci.error.csrf", "Форма устарела: обновите страницу"
		+ " и повторите действие.");
	Словарь.Добавить("settings.package.ci.error.operation", "Неизвестная операция раздела"
		+ " «Доверенная публикация».");
	Словарь.Добавить("settings.package.ci.error.id", "Не указана запись доверия.");
	Словарь.Добавить("settings.package.ci.error.trust", "Конвейер не добавлен: %1");
	Словарь.Добавить("settings.package.ci.error.revoke", "Доверие не отозвано: %1");
	Словарь.Добавить("settings.package.ci.error.link", "Ссылка не разобрана. Нужен адрес файла"
		+ " в вебе — GitHub «…/blob/<ветка>/<путь>» либо GitLab «…/-/blob/<ветка>/<путь>»"
		+ " — и инсталляция, которой хаб доверяет выпуск id-token: github.com, gitlab.com"
		+ " либо адрес из настройки хаба oshub.publish.ci.issuers. Ссылку на другую"
		+ " инсталляцию хаб не разбирает: подставить вместо её хоста публичный адрес"
		+ " значило бы направить доверие на чужой репозиторий с тем же именем.");
	Словарь.Добавить("settings.package.ci.error.link.empty", "Ссылка не введена. Вставьте адрес"
		+ " файла workflow — или заполните поля руками и нажмите «Доверить конвейеру».");

	Словарь.Добавить("settings.package.ci-link.title", "Есть ссылка на workflow?");
	Словарь.Добавить("settings.package.ci-link.lead", "Разберём её и заполним поля ниже — запись"
		+ " при этом не создаётся: проверьте поля и нажмите «Доверить конвейеру».");
	Словарь.Добавить("settings.package.ci-link.label", "Ссылка на файл workflow");
	Словарь.Добавить("settings.package.ci-link.hint", "Адрес файла в GitHub или GitLab, как он"
		+ " открывается в браузере. Ветку от тега ссылка не отличает: вид рефа хаб предложит"
		+ " по значению — проверьте его после заполнения");
	Словарь.Добавить("settings.package.ci-link.button", "Разобрать ссылку");

	Словарь.Добавить("settings.package.ci-new.title", "Доверить конвейеру");
	Словарь.Добавить("settings.package.ci-new.lead", "Репозиторий и реф обязательны, издателя хаб"
		+ " выводит из типа репозитория. Конвейер необязателен, пустое поле значит «любой»."
		+ " Подсказки полей ведут к готовому конвейеру ниже — он запускается по тегам «v*»;"
		+ " короткие значения хаб достраивает до строк, которые приезжают в клеймах.");
	Словарь.Добавить("settings.package.ci-new.provider.label", "Тип репозитория");
	Словарь.Добавить("settings.package.ci-new.provider.hint", "От него зависят и набор полей,"
		+ " и издатель токена");
	Словарь.Добавить("settings.package.ci-new.provider.github", "GitHub Actions");
	Словарь.Добавить("settings.package.ci-new.provider.gitlab", "GitLab CI");
	Словарь.Добавить("settings.package.ci-new.advanced", "Дополнительно");
	Словарь.Добавить("settings.package.ci-new.issuer.label", "Издатель (клейм iss)");
	Словарь.Добавить("settings.package.ci-new.issuer.auto", "по типу репозитория");
	Словарь.Добавить("settings.package.ci-new.issuer.hint", "Заполнять нужно только на инсталляции"
		+ " с несколькими издателями одного типа — например с self-hosted GitLab,"
		+ " добавленным настройкой хаба");
	Словарь.Добавить("settings.package.ci-new.repo.label", "Репозиторий");
	Словарь.Добавить("settings.package.ci-new.repo.hint", "owner/repo у GitHub,"
		+ " group/project (можно с подгруппами) у GitLab");
	Словарь.Добавить("settings.package.ci-new.workflow.label", "Конвейер");
	Словарь.Добавить("settings.package.ci-new.workflow.hint", "Имя файла workflow: у GitHub Actions"
		+ " они всегда лежат в .github/workflows, и приставку хаб достроит сам."
		+ " Сверяется workflow, ЗАПУСТИВШИЙСЯ в этом репозитории; что он вызывает внутри"
		+ " — reusable из другого репозитория, чужой action — решает его автор."
		+ " Пусто — любой конвейер репозитория");
	Словарь.Добавить("settings.package.ci-new.workflow.hint.gitlab", "Путь к файлу конфигурации CI"
		+ " от корня репозитория. Почти всегда .gitlab-ci.yml; менять нужно, только если"
		+ " в настройках проекта задан свой путь. Пусто — любой конвейер репозитория");
	Словарь.Добавить("settings.package.ci-new.ref.label", "Ветка, тег или маска");
	Словарь.Добавить("settings.package.ci-new.ref.hint", "Короткое имя либо глоб-маска: «v*» (теги"
		+ " релизов — так запускается готовый конвейер ниже), «main», «release/*» (ветки"
		+ " внутри release/), «**» (любой реф). «*» подставляется вместо любых символов,"
		+ " кроме «/», «**» — включая «/». Значение с refs/ принимается как есть");
	Словарь.Добавить("settings.package.ci-new.ref-kind.label", "Вид рефа");
	Словарь.Добавить("settings.package.ci-new.ref-kind.hint", "Чем считать короткое имя или маску;"
		+ " значение с refs/ и маску «**» этот выбор не трогает. Стоит на том, чем"
		+ " запускается готовый конвейер: тег, записанный веткой, не совпадёт ни с чем");
	Словарь.Добавить("settings.package.ci-new.ref-kind.branch", "ветка");
	Словарь.Добавить("settings.package.ci-new.ref-kind.tag", "тег");
	Словарь.Добавить("settings.package.ci-new.ref.warning", "Маска, не ограничивающая имя — «**»,"
		+ " «*», «refs/heads/*» — означает публикацию с ЛЮБОЙ ветки доверенного"
		+ " репозитория. Это классическая атака на GitHub Actions: ветка или форк"
		+ " с изменённым workflow получает id-token того же репозитория — и вместе с ним"
		+ " право публиковать ваш пакет. Назовите ветку релизов или маску вида «v*».");
	Словарь.Добавить("settings.package.ci-new.button", "Доверить конвейеру");

	Словарь.Добавить("settings.package.ci-snippet.title", "Готовый конвейер");
	Словарь.Добавить("settings.package.ci-snippet.lead", "Скопируйте в репозиторий пакета"
		+ " и поправьте шаги сборки под свой проект.");
	Словарь.Добавить("settings.package.ci-snippet.github",
		"GitHub Actions — .github/workflows/publish.yml");
	Словарь.Добавить("settings.package.ci-snippet.gitlab", "GitLab CI — .gitlab-ci.yml");
	Словарь.Добавить("settings.package.ci-snippet.unknown-host", "Внешний адрес хаба не задан,"
		+ " поэтому готовый конвейер показать не из чего: он обязан ссылаться на настоящий"
		+ " адрес инсталляции, а не на localhost сервера. Задайте настройку «URL инстанса»"
		+ " в настройках хаба.");
	Словарь.Добавить("settings.package.ci-snippet.unknown-audience", "Хаб не знает, для кого"
		+ " выпускается его id-token, поэтому доверенные конвейеры сейчас не публикуют"
		+ " вовсе, а готовый конвейер было бы нечем заполнить: аудитория в нём обязана"
		+ " совпасть с той, что сверяет хаб. Задайте настройку «URL инстанса» либо"
		+ " oshub.publish.ci.audience в настройках хаба.");

КонецПроцедуры

// Подписки на события пула и пакета.
Процедура КлючиПодписокПулаИПакета(Словарь)

	Словарь.Добавить("subscriptions.pool.lead",
		"Подписки пула: хаб сообщает о событиях всех пакетов пула. События одного пакета"
		+ " настраиваются на самом пакете.");
	Словарь.Добавить("subscriptions.pool.error.notfound", "Пул не найден");
	Словарь.Добавить("subscriptions.pool.error.forbidden",
		"Недостаточно прав для управления подписками этого пула");
	Словарь.Добавить("subscriptions.package.tab", "Подписки: %1");
	Словарь.Добавить("subscriptions.package.lead",
		"Куда хаб сообщает о событиях этого пакета. События пула целиком настраиваются на пуле.");

КонецПроцедуры

// Дом «Группа»: участники, связка с провайдером, права группы.
Процедура КлючиДомаГруппы(Словарь)

	Словарь.Добавить("settings.group.title", "Настройки группы");
	Словарь.Добавить("settings.group.lead", "Группа — субъект прав: её состав и связка с OIDC настраиваются здесь,"
		+ " а права доступа выдаются на самих объектах (пул, пакет).");
	Словарь.Добавить("settings.group.nav.members", "Участники");
	Словарь.Добавить("settings.group.nav.oidc", "Связка с OIDC");
	Словарь.Добавить("settings.group.nav.grants", "Права доступа группы");
	Словарь.Добавить("settings.group.crumb", "группы");

	Словарь.Добавить("settings.group.error.section", "Раздел настроек не найден");
	Словарь.Добавить("settings.group.error.save", "Не удалось сохранить: %1");
	Словарь.Добавить("settings.group.error.operation", "Неизвестная операция раздела");
	Словарь.Добавить("settings.group.readonly", "Вы видите группу как участник:"
		+ " изменять её состав и связки может только администратор хаба.");

	Словарь.Добавить("settings.group.members.title", "Участники");
	Словарь.Добавить("settings.group.members.lead", "Состав группы и происхождение каждого членства.");
	Словарь.Добавить("settings.group.members.col.login", "Логин");
	Словарь.Добавить("settings.group.members.col.source", "Источник");
	Словарь.Добавить("settings.group.members.empty", "В группе нет участников.");
	Словарь.Добавить("settings.group.members.note", "Участник с источником %1 синхронизируется из"
		+ " клеймов провайдера: удаление вручную не удержится, если клейм остался.");
	Словарь.Добавить("settings.group.members.synced", "Сверено с клеймами: %1");
	Словарь.Добавить("settings.group.members.button.remove", "Исключить");

	Словарь.Добавить("settings.group.member-new.title", "Добавить участника");
	Словарь.Добавить("settings.group.member-new.lead", "Учётные записи хаба, которых в группе ещё нет."
		+ " Членство заводится с источником local.");
	Словарь.Добавить("settings.group.member-new.col.login", "Логин");
	Словарь.Добавить("settings.group.member-new.col.email", "Email");
	Словарь.Добавить("settings.group.member-new.filter.label", "Поиск");
	Словарь.Добавить("settings.group.member-new.filter.placeholder", "Логин или email");
	Словарь.Добавить("settings.group.member-new.filter.button", "Найти");
	Словарь.Добавить("settings.group.member-new.empty", "Все учётные записи хаба уже в группе.");
	Словарь.Добавить("settings.group.member-new.notfound", "По запросу «%1» ничего не найдено.");
	Словарь.Добавить("settings.group.member-new.truncated",
		"Показаны первые %1 из %2 — уточните запрос.");
	Словарь.Добавить("settings.group.member-new.duplicate", "Пользователь «%1» уже в группе");
	Словарь.Добавить("settings.group.member-new.button", "Добавить");
	Словарь.Добавить("settings.group.member-new.client.partial",
		"Отбор идёт по показанным строкам. Чтобы искать по всем учётным записям хаба,"
		+ " нажмите «Найти».");
	Словарь.Добавить("settings.group.member-new.client.empty",
		"Среди показанных строк совпадений нет. Нажмите «Найти», чтобы искать по всем"
		+ " учётным записям хаба.");

	Словарь.Добавить("settings.group.oidc.title", "Связка с OIDC");
	Словарь.Добавить("settings.group.oidc.lead", "Какие клеймы провайдера означают членство в этой группе.");
	Словарь.Добавить("settings.group.oidc.col.issuer", "Издатель (issuer)");
	Словарь.Добавить("settings.group.oidc.col.claim", "Клейм");
	Словарь.Добавить("settings.group.oidc.col.value", "Значение клейма");
	Словарь.Добавить("settings.group.oidc.empty", "Группа не связана ни с одним клеймом.");
	Словарь.Добавить("settings.group.oidc.note", "При входе пользователя клеймы провайдера сопоставляются с"
		+ " этими правилами: совпало — участник добавляется, пропало — исключается.");
	Словарь.Добавить("settings.group.oidc.button.remove", "Удалить");

	Словарь.Добавить("settings.group.policy.title", "Политика выпавших из клейма");
	Словарь.Добавить("settings.group.policy.lead",
		"Что делать с участником, которого IdP перестал возвращать в клейме.");
	Словарь.Добавить("settings.group.policy.label", "Выпавших из клейма — оставлять в группе");
	Словарь.Добавить("settings.group.policy.on", "оставлять: участник остаётся, IdP только добавляет");
	Словарь.Добавить("settings.group.policy.off", "исключать: пропал клейм — снимается членство");
	Словарь.Добавить("settings.group.policy.hint", "Затрагивает только членства с источником oidc;"
		+ " локальные назначения синхронизация не трогает никогда.");
	Словарь.Добавить("settings.group.policy.synced", "Состав сверялся с клеймами: %1");
	Словарь.Добавить("settings.group.policy.never", "ещё не сверялся");

	Словарь.Добавить("settings.group.mapping-new.title", "Добавить связку");
	Словарь.Добавить("settings.group.mapping-new.issuer.label", "Издатель (issuer)");
	Словарь.Добавить("settings.group.mapping-new.issuer.hint", "Значение iss из токена провайдера");
	Словарь.Добавить("settings.group.mapping-new.claim.label", "Имя клейма");
	Словарь.Добавить("settings.group.mapping-new.claim.hint", "Обычно groups или roles");
	Словарь.Добавить("settings.group.mapping-new.value.label", "Значение клейма");
	Словарь.Добавить("settings.group.mapping-new.button", "Добавить");

	Словарь.Добавить("settings.group.grants.title", "Права доступа группы");
	Словарь.Добавить("settings.group.grants.lead", "Куда и в какой роли группа открывает доступ своим участникам.");
	Словарь.Добавить("settings.group.grants.col.where", "Где править");
	Словарь.Добавить("settings.group.grants.empty", "Группе не выдано ни одного права доступа.");
	Словарь.Добавить("settings.group.grants.note", "Витрина только для чтения: роль выдаётся и отзывается"
		+ " на самом объекте — право видно рядом с объектом. Объекты, которых вам не видно,"
		+ " в таблице не показаны.");
	Словарь.Добавить("settings.group.grants.object.hub", "весь хаб");
	Словарь.Добавить("settings.group.grants.link.pool", "править на пуле");
	Словарь.Добавить("settings.group.grants.link.package", "править на пакете");

КонецПроцедуры

// Отказы гвардов пула, пакета и группы.
Процедура КлючиГвардов(Словарь)

	Словарь.Добавить("settings.guard.pool.notfound", "Пул не найден");
	Словарь.Добавить("settings.guard.pool.forbidden",
		"Настройки пула доступны его владельцу или администратору хаба");
	Словарь.Добавить("settings.guard.group.notfound", "Группа не найдена");
	Словарь.Добавить("settings.guard.group.readonly",
		"Настройки группы доступны её участникам (только чтение) и администратору хаба");
	Словарь.Добавить("settings.guard.group.admin-only",
		"Изменять состав и связки группы может только администратор хаба");
	Словарь.Добавить("settings.guard.package.notfound", "Пакет не найден");
	Словарь.Добавить("settings.guard.package.forbidden",
		"Настройки пакета доступны его мейнтейнерам и владельцу пула");

КонецПроцедуры

&Прозвище("ЧастьСловаряТекстов")
&Порядок(30)
&Желудь
Процедура ПриСозданииОбъекта() Экспорт
КонецПроцедуры
