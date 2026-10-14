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

// Кабинет «/me» — первый раздел дома «Аккаунт»: сводка дел и витрины её блоков.
Процедура КлючиЛичногоПространства(Словарь)

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
	Словарь.Добавить("settings.inbox.lead", "Push от тех, у кого прав на пул нет: версия ещё не опубликована.");
	Словарь.Добавить("settings.inbox.empty", "Заявок, ждущих решения, нет.");

	Словарь.Добавить("settings.inbox.col.pool", "Пул");
	Словарь.Добавить("settings.inbox.col.package", "Пакет и версия");
	Словарь.Добавить("settings.inbox.col.author", "Кто подал");
	Словарь.Добавить("settings.inbox.col.filed", "Когда");

	Словарь.Добавить("settings.inbox.filed.value", "%1 (заявка №%2)");
	Словарь.Добавить("settings.inbox.size.value", "%1 байт");
	Словарь.Добавить("settings.inbox.manifest.author", " (автор манифеста: %1)");
	Словарь.Добавить("settings.inbox.applicant.gone", "учётка удалена");

	Словарь.Добавить("settings.inbox.button.approve", "Одобрить");
	Словарь.Добавить("settings.inbox.button.reject", "Отклонить");
	Словарь.Добавить("settings.inbox.menu", "Действия с заявкой %1 %2");

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
	Словарь.Добавить("settings.inbox.widget.lead", "Push в ваши пулы от тех, у кого прав нет.");
	Словарь.Добавить("settings.inbox.widget.open", "Все заявки");

	Словарь.Добавить("settings.inbox.error.operation", "Неизвестная операция раздела «Входящие»."
		+ " Ничего не изменено — обновите страницу и повторите действие.");
	Словарь.Добавить("settings.inbox.error.id", "Не задан номер заявки.");
	Словарь.Добавить("settings.inbox.error.missing", "Заявка не найдена.");
	Словарь.Добавить("settings.inbox.error.foreign", "Заявка относится к другому пулу и в этом разделе"
		+ " не рассматривается.");
	Словарь.Добавить("settings.inbox.error.decide", "Заявка недоступна: %1");
	Словарь.Добавить("settings.inbox.error.approve", "Заявка не одобрена: %1");
	Словарь.Добавить("settings.inbox.error.reject", "Заявка не отклонена: %1");
	Словарь.Добавить("settings.inbox.error.stale", "Страница устарела: ничего не изменено. Обновите её"
		+ " и повторите решение.");
	Словарь.Добавить("settings.inbox.error.csrf", "Форма устарела: обновите страницу и повторите решение.");

КонецПроцедуры

// Лента личных уведомлений.
Процедура КлючиУведомлений(Словарь)

	Словарь.Добавить("office.notifications.crumb", "Уведомления");
	Словарь.Добавить("office.notifications.page.title", "Уведомления");
	Словарь.Добавить("office.notifications.page.lead", "Всё, что хаб адресовал лично вам:"
		+ " исход ваших заявок и события вашей учётной записи.");

	Словарь.Добавить("office.notifications.title", "Ваши события");
	Словарь.Добавить("office.notifications.lead", "Свежие сверху, непрочитанные помечены.");
	Словарь.Добавить("office.notifications.empty", "Хаб вам пока ничего не сообщал.");

	Словарь.Добавить("office.notifications.col.state", "Состояние");
	Словарь.Добавить("office.notifications.col.event", "Событие");
	Словарь.Добавить("office.notifications.col.when", "Когда");

	Словарь.Добавить("office.notifications.new", "новое");
	Словарь.Добавить("office.notifications.read.button", "Отметить всё прочитанным");
	Словарь.Добавить("office.notifications.read.done", "Лента отмечена прочитанной.");

	Словарь.Добавить("office.notifications.widget.title", "Новые уведомления: %1");
	Словарь.Добавить("office.notifications.widget.lead", "События, адресованные лично вам.");
	Словарь.Добавить("office.notifications.widget.open", "Открыть ленту");

	Словарь.Добавить("office.notifications.error.csrf", "Форма устарела: обновите страницу"
		+ " и повторите действие.");

КонецПроцедуры

// Путь первой публикации: проводник «/tour» и кабинет новичка.
Процедура КлючиПервойПубликации(Словарь)

	Словарь.Добавить("office.start.title", "Первая публикация");
	Словарь.Добавить("office.start.lead", "Четыре шага от свежей инсталляции до версии в каталоге.");
	Словарь.Добавить("office.start.open", "Открыть проводник");

	// карточка «Публикация из opm» на проводнике
	Словарь.Добавить("office.start.opm.title", "Публикация из opm");
	Словарь.Добавить("office.start.opm.pool", "opm ходит в ПУЛ, а не в хаб целиком: пул прописывается"
		+ " сервером в opm.cfg.");
	Словарь.Добавить("office.start.opm.pool.placeholder", "<пул>");
	Словарь.Добавить("office.start.opm.default", "opm знает этот хаб по умолчанию: прописывать его"
		+ " в opm.cfg не нужно, пакет уйдёт в основной пул %1.");
	Словарь.Добавить("office.start.opm.config", "{ ""СервераПакетов"": ["
		+ Символы.ПС + "  { ""Имя"": ""openhub"", ""Сервер"": ""https://<адрес-хаба>"", ""Порт"": 443,"
		+ Символы.ПС + "    ""ПутьНаСервере"": ""/api/v1/pools/%1/download/"","
		+ Символы.ПС + "    ""РесурсПубликацииПакетов"": ""/api/v1/pools/%1/push"","
		+ Символы.ПС + "    ""Авторизация"": ""Bearer ${OSHUB_TOKEN}"", ""Приоритет"": 0 }"
		+ Символы.ПС + "] }");
	Словарь.Добавить("office.start.opm.config.token", "Токен из шага «Выпустить токен публикации» кладите"
		+ " в переменную окружения, а не в файл конфигурации.");
	Словарь.Добавить("office.start.opm.command", "opm push --token <токен> -c stable <файл>.ospx");
	Словарь.Добавить("office.start.opm.command.hint", "Вместо <токен> подставьте токен из шага «Выпустить"
		+ " токен публикации», вместо <файл> — имя собранного пакета. Канал -c stable указывайте явно:"
		+ " выпущенный opm определяет его сам только в git-репозитории на ветке master. opm с изменениями"
		+ " под новый хаб предупреждает, что опция -c устарела, — это ожидаемо и публикации не мешает.");

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
	// поток «пул» Х4а: зеркала пула таблицей с меню ⚙ строки, заведение и удаление — окнами
	Словарь.Добавить("office.mirrors.pool.lead", "Хаб по расписанию скачивает пакеты апстрима"
		+ " и складывает их копию в этот пул.");
	Словарь.Добавить("office.mirrors.list.title", "Зеркала пула");
	Словарь.Добавить("office.mirrors.list.lead", "Каждый привезённый .ospx проверяется,"
		+ " существующие версии не перезаписываются.");
	Словарь.Добавить("office.mirrors.menu", "Действия с зеркалом %1");
	Словарь.Добавить("office.mirrors.pools.col.name", "Пул");
	Словарь.Добавить("office.mirrors.pools.col.home", "В настройках пула");
	Словарь.Добавить("office.mirrors.pools.home", "Зеркала в настройках пула");
	Словарь.Добавить("office.mirrors.col.upstream", "Апстрим");
	Словарь.Добавить("office.mirrors.col.protocol", "Протокол");
	Словарь.Добавить("office.mirrors.col.state", "Состояние");
	Словарь.Добавить("office.mirrors.col.run", "Прогон");
	Словарь.Добавить("office.mirrors.col.sync", "Последний синк");
	Словарь.Добавить("office.mirrors.empty", "Зеркал пока нет.");
	Словарь.Добавить("office.mirrors.sync.never", "ещё не было");
	Словарь.Добавить("office.mirrors.state.on", "включено");
	Словарь.Добавить("office.mirrors.state.off", "выключено");
	Словарь.Добавить("office.mirrors.button.sync", "Синхронизировать сейчас");
	Словарь.Добавить("office.mirrors.button.enable", "Включить");
	Словарь.Добавить("office.mirrors.button.disable", "Выключить");
	Словарь.Добавить("office.mirrors.button.delete", "Удалить");
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
	Словарь.Добавить("settings.pool.group.pool", "Пул");
	Словарь.Добавить("settings.pool.group.packages", "Пакеты");
	Словарь.Добавить("settings.pool.group.sources", "Источники");
	Словарь.Добавить("settings.pool.group.notify", "Оповещения");
	Словарь.Добавить("settings.pool.nav.general", "Общие");
	Словарь.Добавить("settings.pool.nav.visibility", "Видимость и доступ");
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
	Словарь.Добавить("settings.pool.error.upstream.url", "Не задан адрес апстрима.");
	Словарь.Добавить("settings.pool.error.upstream.ttl", "TTL кэша должен быть целым числом секунд.");
	Словарь.Добавить("settings.pool.error.upstream.target",
		"Такого апстрима у пула нет: его уже удалили. Обновите страницу.");
	Словарь.Добавить("settings.pool.error.upstream.move", "Стрелка порядка не распознана: порядок не изменён.");
	Словарь.Добавить("settings.pool.error.upstream.stale",
		"Страница устарела: ничего не изменено. Обновите её и повторите действие.");
	Словарь.Добавить("settings.pool.error.publication",
		"Тумблер публикации не распознан: публикация не изменена. Обновите страницу.");

	Словарь.Добавить("settings.pool.general.title", "Общие");
	Словарь.Добавить("settings.pool.general.name", "имя");
	Словарь.Добавить("settings.pool.general.name.note", "входит в адреса пакетов, не меняется");
	Словарь.Добавить("settings.pool.general.opm", "адрес для opm");
	Словарь.Добавить("settings.pool.general.opm.package", "<пакет>");
	Словарь.Добавить("settings.pool.general.visibility", "видимость");
	Словарь.Добавить("settings.pool.general.visibility.link", "изменить в «Видимость и доступ»");
	Словарь.Добавить("settings.pool.general.owner", "владелец");
	Словарь.Добавить("settings.pool.general.owner.none", "нет");
	Словарь.Добавить("settings.pool.general.owner.link", "передать в «Права доступа»");
	Словарь.Добавить("settings.pool.general.default", "основной пул хаба");
	Словарь.Добавить("settings.pool.general.default.link", "назначается в настройках хаба");
	Словарь.Добавить("settings.pool.general.packages", "пакетов");
	Словарь.Добавить("settings.pool.general.packages.link", "открыть пул");
	Словарь.Добавить("settings.pool.general.space", "место");
	Словарь.Добавить("settings.pool.general.space.link", "Квота");
	Словарь.Добавить("settings.pool.general.default.yes", "да");
	Словарь.Добавить("settings.pool.general.default.no", "нет");

	Словарь.Добавить("settings.pool.visibility.title", "Видимость");
	Словарь.Добавить("settings.pool.visibility.lead", "Кто может читать пакеты пула.");
	Словарь.Добавить("settings.pool.visibility.label", "Видимость");
	// поток «пул» Х4а: видимость сегментами, что значит выбор — строкой под ними
	Словарь.Добавить("settings.pool.visibility.hint",
		"Публичный пул читают все; у приватного все пакеты приватны — доступ только по правам.");
	Словарь.Добавить("settings.pool.visibility.option.public", "Публичный");
	Словарь.Добавить("settings.pool.visibility.option.private", "Приватный");

	Словарь.Добавить("settings.pool.access.title", "Права доступа");
	Словарь.Добавить("settings.pool.access.lead", "Кто и в какой роли допущен к пулу помимо владельца.");
	Словарь.Добавить("settings.pool.access.empty", "Ролей на пуле никому не выдано.");
	Словарь.Добавить("settings.pool.access.readonly", "Роли на пуле раздаёт его мейнтейнер"
		+ " или администратор хаба — у вас только просмотр.");
	Словарь.Добавить("settings.pool.access.error.subject",
		"Субъект не найден (проверьте логин пользователя или имя группы)");
	Словарь.Добавить("settings.pool.access.error.object",
		"Раздел управляет правами только на свой пул");
	Словарь.Добавить("settings.pool.access-new.title", "Выдать роль на пул");
	Словарь.Добавить("settings.pool.access-new.lead", "Роль выдаётся пользователю или группе"
		+ " целиком на пул и наследуется всеми его пакетами.");

	Словарь.Добавить("settings.pool.tags.title", "Теги");
	Словарь.Добавить("settings.pool.tags.lead", "Теги, которые получает каждый пакет пула.");
	Словарь.Добавить("settings.pool.tags.inherit.label", "Теги пула для пакетов");
	Словарь.Добавить("settings.pool.tags.inherit.on", "пакеты наследуют теги пула");
	Словарь.Добавить("settings.pool.tags.inherit.off", "у пакетов только свои теги");
	Словарь.Добавить("settings.pool.tags.inherit.hint", "Правка тега пула доезжает до пакетов сразу;"
		+ " первое включение заводит stable, prerelease и develop, выключение набор не стирает.");
	Словарь.Добавить("settings.pool.tags.set.title", "Набор тегов пула");
	Словарь.Добавить("settings.pool.tags.set.lead", "Только правила. Пакет может поправить тег у себя"
		+ " копией или выключить его.");
	Словарь.Добавить("settings.pool.tags.set.empty", "У пула нет тегов. Заведите тег кнопкой «Новый тег».");
	Словарь.Добавить("settings.pool.tags.new.title", "Новый тег пула");
	Словарь.Добавить("settings.pool.tags.new.lead", "Тег пула — правило: его наследует каждый пакет пула"
		+ " без своей копии.");
	Словарь.Добавить("settings.pool.tags.edit.title", "Тег пула «%1»");
	Словарь.Добавить("settings.pool.tags.edit.lead", "Правка доезжает до пакетов пула сразу;"
		+ " свои копии у пакетов не меняются.");
	Словарь.Добавить("settings.pool.tags.default.label", "Основной тег пула");
	Словарь.Добавить("settings.pool.tags.default.hint", "Основной у каждого пакета, пока у пакета"
		+ " нет своего основного.");
	Словарь.Добавить("settings.pool.tags.delete.title", "Удалить тег пула «%1»?");
	Словарь.Добавить("settings.pool.tags.delete.consequence", "Пакеты пула без своей копии перестанут"
		+ " отдавать «%1»; копии у пакетов останутся их тегами, выключения тега снимутся.");
	Словарь.Добавить("settings.pool.tags.error.missing", "Тега пула «%1» нет — его уже удалили.");
	Словарь.Добавить("settings.pool.tags.error.kind", "Вид тега не принят: у пула только правила"
		+ " semver или regex.");
	Словарь.Добавить("settings.pool.tags.error.version", "Имя тега занято версией пакета этого пула:"
		+ " запись «пакет@имя» читается сначала как точная версия, и тег у этого пакета остался бы"
		+ " недостижим. Назовите тег иначе.");
	Словарь.Добавить("settings.pool.tags.error.save", "Тег пула не сохранён: %1");

	// окно тега — одно на дом пула и дом пакета
	Словарь.Добавить("settings.tags.button.new", "Новый тег");
	Словарь.Добавить("settings.tags.button.create", "Создать тег");
	Словарь.Добавить("settings.tags.button.save", "Сохранить");
	Словарь.Добавить("settings.tags.step.rule", "Правило");
	Словарь.Добавить("settings.tags.step.look", "Оформление");
	Словарь.Добавить("settings.tags.field.name.hint", "Латиница, цифры, точка, дефис и подчёркивание.");
	Словарь.Добавить("settings.tags.field.rule", "Правило");
	Словарь.Добавить("settings.tags.field.repush.hint", "Номер под тегом вторым push не заменить:"
		+ " публикатору отвечают конфликтом, заменить можно только явно — «?force=1» у адреса push.");
	Словарь.Добавить("settings.tags.kind.label", "Как отбирать версии");
	Словарь.Добавить("settings.tags.kind.semver", "Диапазон semver");
	Словарь.Добавить("settings.tags.kind.regex", "Регулярное выражение");
	Словарь.Добавить("settings.tags.kind.manual", "Вручную");
	Словарь.Добавить("settings.tags.kind.manual.note", "Ручной тег заводится пустым: версии помечаются"
		+ " в разделе «Версии и метки», в меню версии.");
	Словарь.Добавить("settings.tags.badge.default", "основной");
	Словарь.Добавить("settings.tags.prop.rule", "Правило");
	Словарь.Добавить("settings.tags.prop.repush", "Переиздание номеров");
	Словарь.Добавить("settings.tags.repush.allowed", "разрешено");
	Словарь.Добавить("settings.tags.repush.forbidden", "запрещено");
	Словарь.Добавить("settings.tags.rule.words", "%1 · %2");
	Словарь.Добавить("settings.tags.rule.manual", "вручную");
	Словарь.Добавить("settings.tags.rule.broken", "правило не читается");
	Словарь.Добавить("settings.tags.rule.unbounded", "без границ");
	Словарь.Добавить("settings.tags.delete.echo", "Имя тега");
	Словарь.Добавить("settings.tags.delete.echo.mismatch", "Набрано не имя тега: введите «%1».");
	Словарь.Добавить("settings.tags.badge.repush", "переиздание разрешено");
	Словарь.Добавить("settings.tags.button.edit", "Изменить");
	Словарь.Добавить("settings.tags.button.remove", "Удалить");
	Словарь.Добавить("settings.tags.error.name", "Имя тега не принято: разрешены латиница,"
		+ " цифры, дефис, подчёркивание и точка, не длиннее 64 символов. Имя участвует"
		+ " в адресе и в записи «пакет@тег».");
	Словарь.Добавить("settings.tags.error.look", "Оформление не принято: стиль и значок"
		+ " выбираются из списка, и присланного значения в нём нет.");
	Словарь.Добавить("settings.tags.field.default.label", "Тег по умолчанию");
	Словарь.Добавить("settings.tags.field.default.hint", "Им резолвится установка без тега.");
	Словарь.Добавить("settings.tags.field.default.locked", "Снять признак нельзя — назначьте его другому тегу.");
	Словарь.Добавить("settings.tags.error.stale", "Страница устарела: ничего не изменено. Обновите её"
		+ " и повторите действие.");
	Словарь.Добавить("settings.tags.error.exists", "Тег «%1» уже есть — измените его в списке.");

	Словарь.Добавить("settings.pool.publication.title", "Публикация");
	Словарь.Добавить("settings.pool.publication.lead", "Принимает ли пул собственные пакеты.");
	Словарь.Добавить("settings.pool.publication.label", "Публикация разрешена");
	Словарь.Добавить("settings.pool.publication.on", "принимает opm push");
	Словарь.Добавить("settings.pool.publication.off", "чистый прокси-кэш");

	Словарь.Добавить("settings.pool.upstreams.title", "Апстримы");
	Словарь.Добавить("settings.pool.upstreams.lead",
		"Порядок обхода внешних хабов при промахе в пуле. Свои пакеты всегда первее.");
	Словарь.Добавить("settings.pool.upstreams.add", "Добавить апстрим");
	Словарь.Добавить("settings.pool.upstreams.toggle.label", "Апстрим %1 опрашивается");
	Словарь.Добавить("settings.pool.upstreams.button.create", "Добавить");
	Словарь.Добавить("settings.pool.upstreams.badge.alive", "жив");
	Словарь.Добавить("settings.pool.upstreams.badge.down", "лежит с %1");
	Словарь.Добавить("settings.pool.upstreams.badge.denied", "не пустил");
	Словарь.Добавить("settings.pool.upstreams.badge.off", "выключен");
	Словарь.Добавить("settings.pool.upstreams.badge.unknown", "не проверялся");
	Словарь.Добавить("settings.pool.upstreams.prop.url", "адрес");
	Словарь.Добавить("settings.pool.upstreams.prop.ttl", "TTL кэша");
	Словарь.Добавить("settings.pool.upstreams.prop.ttl.value", "%1 с");
	Словарь.Добавить("settings.pool.upstreams.prop.access", "доступ");
	Словарь.Добавить("settings.pool.upstreams.prop.filter", "фильтр имён");
	Словарь.Добавить("settings.pool.upstreams.prop.state", "состояние");
	Словарь.Добавить("settings.pool.upstreams.window.new", "Новый апстрим");
	Словарь.Добавить("settings.pool.upstreams.window.token", "Снять токен");
	Словарь.Добавить("settings.pool.upstreams.token-off.note",
		"Апстрим будет читаться анонимно. Вернуть токен — заведя тот же адрес заново с токеном.");
	Словарь.Добавить("settings.pool.upstreams.delete.title", "Удалить апстрим?");
	Словарь.Добавить("settings.pool.upstreams.delete.consequence",
		"Пул перестанет брать пакеты с %1; токен и место в порядке обхода пропадут."
		+ " Уже взятое в кэш остаётся.");
	Словарь.Добавить("settings.pool.upstreams.field.url", "Адрес");
	Словарь.Добавить("settings.pool.upstreams.field.url.example", "https://hub.oscript.io/download/");
	Словарь.Добавить("settings.pool.upstreams.field.token", "Токен доступа");
	Словарь.Добавить("settings.pool.upstreams.field.token.hint", "Только если выдача закрыта");
	Словарь.Добавить("settings.pool.upstreams.field.ttl", "TTL кэша, с");
	Словарь.Добавить("settings.pool.upstreams.field.ttl.hint", "Для list.txt и latest");
	Словарь.Добавить("settings.pool.upstreams.empty", "Апстримов нет: пул раздаёт только свои пакеты.");
	Словарь.Добавить("settings.pool.upstreams.button.up", "Выше");
	Словарь.Добавить("settings.pool.upstreams.button.down", "Ниже");
	Словарь.Добавить("settings.pool.upstreams.button.remove", "Удалить");
	Словарь.Добавить("settings.pool.upstreams.state.off", "выключен вручную — не опрашивается");
	Словарь.Добавить("settings.pool.upstreams.state.unknown", "ещё не проверялся");
	Словарь.Добавить("settings.pool.upstreams.state.alive", "жив, проверен %1");
	Словарь.Добавить("settings.pool.upstreams.state.down", "лежит с %1: %2");
	Словарь.Добавить("settings.pool.upstreams.access.token", "по токену");
	Словарь.Добавить("settings.pool.upstreams.access.anonymous", "анонимно");
	Словарь.Добавить("settings.pool.upstreams.button.token-off", "Снять токен");
	Словарь.Добавить("settings.pool.upstreams.state.denied", "не пустил, проверен %1: %2");
	Словарь.Добавить("settings.pool.upstreams.state.unknown.restart", "ещё не проверялся после перезапуска");
	Словарь.Добавить("settings.pool.upstreams.last-failure.down", "в последний раз не отвечал %1: %2");
	Словарь.Добавить("settings.pool.upstreams.last-failure.denied", "в последний раз не пустил %1: %2");
	Словарь.Добавить("settings.pool.upstreams.state.join", "; ");

	Словарь.Добавить("settings.pool.upstream-new.probe.note",
		"Перед сохранением хаб пробует подключиться: не подключился — апстрим не заводится.");
	Словарь.Добавить("settings.pool.upstream-new.probe.note.off",
		"Пробное подключение выключено (oshub.upstream.probe.enabled): адрес сохранится,"
		+ " даже если по нему никто не отвечает, и живость источников хаб не проверяет.");

	Словарь.Добавить("settings.pool.mirrors.title", "Зеркала");
	Словарь.Добавить("settings.pool.mirrors.lead", "Плановая копия пакетов другого хаба в этот пул.");
	Словарь.Добавить("settings.pool.mirrors.add", "Добавить зеркало");
	Словарь.Добавить("settings.pool.mirrors.toggle.label", "Зеркало %1 синхронизируется");
	Словарь.Добавить("settings.pool.mirrors.badge.run", "прогон: %1");
	Словарь.Добавить("settings.pool.mirrors.prop.url", "адрес");
	Словарь.Добавить("settings.pool.mirrors.prop.filter", "фильтр имён");
	Словарь.Добавить("settings.pool.mirrors.prop.interval", "интервал");
	Словарь.Добавить("settings.pool.mirrors.prop.interval.value", "%1 с");
	Словарь.Добавить("settings.pool.mirrors.prop.protocol", "протокол");
	Словарь.Добавить("settings.pool.mirrors.prop.run", "прогон");
	Словарь.Добавить("settings.pool.mirrors.prop.run.value", "%1 · скачано %2 · ошибок %3");
	Словарь.Добавить("settings.pool.mirrors.prop.run.link", "подробно");
	Словарь.Добавить("settings.pool.mirrors.prop.sync", "последний синк");
	Словарь.Добавить("settings.pool.mirrors.prop.migrate", "перенос");
	Словарь.Добавить("settings.pool.mirrors.migrate.yes", "да: привезённое становится здесь своим");
	Словарь.Добавить("settings.pool.mirrors.migrate.no", "нет");
	Словарь.Добавить("settings.pool.mirrors.filter.all", "все имена");
	Словарь.Добавить("settings.pool.mirrors.button.edit", "Изменить");
	Словарь.Добавить("settings.pool.mirrors.button.save", "Сохранить");
	Словарь.Добавить("settings.pool.mirrors.window.new", "Новое зеркало");
	Словарь.Добавить("settings.pool.mirrors.window.edit", "Изменить зеркало");
	Словарь.Добавить("settings.pool.mirrors.window.token", "Снять токен");
	Словарь.Добавить("settings.pool.mirrors.edit.note",
		"Адрес, фильтр, интервал и перенос задаются при заведении; у заведённого зеркала меняется токен.");
	Словарь.Добавить("settings.pool.mirrors.token-off.note",
		"Апстрим зеркала будет читаться анонимно. Вернуть токен можно окном «Изменить».");
	Словарь.Добавить("settings.pool.mirrors.delete.title", "Удалить зеркало?");
	Словарь.Добавить("settings.pool.mirrors.delete.consequence",
		"Зеркало %1 перестанет копировать пакеты, его настройки пропадут. Уже привезённое остаётся в пуле.");
	Словарь.Добавить("settings.pool.mirrors.delete.echo", "Введите «%1»");
	Словарь.Добавить("settings.pool.mirrors.delete.echo.mismatch",
		"Зеркало не удалено: подтверждение не совпало. Введите «%1» в точности.");
	Словарь.Добавить("settings.pool.mirrors.error.missing",
		"Такого зеркала у пула нет: его уже удалили. Обновите страницу.");
	Словарь.Добавить("settings.pool.mirrors.field.url", "Адрес");
	Словарь.Добавить("settings.pool.mirrors.field.url.example", "https://hub.oscript.io/download/");
	Словарь.Добавить("settings.pool.mirrors.field.token", "Токен доступа");
	Словарь.Добавить("settings.pool.mirrors.field.token.hint", "Только если выдача закрыта");
	Словарь.Добавить("settings.pool.mirrors.field.token.keep", "Пусто — оставить прежний токен");
	Словарь.Добавить("settings.pool.mirrors.field.filter", "Фильтр имён");
	Словарь.Добавить("settings.pool.mirrors.field.filter.hint", "Маски через запятую; пусто — забирать всё");
	Словарь.Добавить("settings.pool.mirrors.field.interval", "Интервал, с");
	Словарь.Добавить("settings.pool.mirrors.field.migrate.hint", "Привезённое станет здесь своим");
	Словарь.Добавить("settings.pool.mirrors.sync.never", "ещё не было");
	Словарь.Добавить("settings.pool.mirrors.empty", "Зеркал пока нет: пул ничего не реплицирует.");
	Словарь.Добавить("settings.pool.mirrors.state.on", "включено");
	Словарь.Добавить("settings.pool.mirrors.state.off", "выключено");
	Словарь.Добавить("settings.pool.mirrors.button.sync", "Синхронизировать сейчас");
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
	Словарь.Добавить("settings.pool.mirrors.access.token", "по токену");
	Словарь.Добавить("settings.pool.mirrors.access.anonymous", "анонимно");
	Словарь.Добавить("settings.pool.mirrors.button.token-off", "Снять токен");

	Словарь.Добавить("settings.pool.mirror-new.probe.note",
		"Перед сохранением хаб пробует подключиться: не подключился — зеркало не заводится.");
	Словарь.Добавить("settings.pool.mirror-new.probe.note.off",
		"Пробное подключение выключено (oshub.upstream.probe.enabled): зеркало заведётся, даже если"
		+ " по адресу никто не отвечает; о недоступности скажет первый прогон.");
	Словарь.Добавить("settings.pool.mirror-new.button", "Создать зеркало");

	Словарь.Добавить("settings.pool.quota.title", "Квота");
	Словарь.Добавить("settings.pool.quota.lead", "Сколько места пул может занять.");
	Словарь.Добавить("settings.pool.quota.label", "Квота пула, МБ");
	// поток «пул» Х4а: квота свойством тому, кто её не меняет, и короткая подсказка под полем
	Словарь.Добавить("settings.pool.quota.property", "Квота");
	Словарь.Добавить("settings.pool.quota.hint.short", "−1 — как в хабе, 0 — без ограничения.");
	Словарь.Добавить("settings.pool.quota.hint",
		"Квота меряет ВСЁ место, занятое пулом"
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
	Словарь.Добавить("settings.pool.danger.delete.title", "Удалить пул «%1»?");
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
	Словарь.Добавить("settings.package.nav.card", "Карточка");
	Словарь.Добавить("settings.package.nav.access", "Права доступа");
	Словарь.Добавить("settings.package.nav.tags", "Теги");
	Словарь.Добавить("settings.package.nav.versions", "Версии и метки");
	Словарь.Добавить("settings.package.nav.webhooks", "Подписки на события");
	Словарь.Добавить("settings.package.nav.ci", "Доверенная публикация");
	Словарь.Добавить("settings.package.nav.danger", "Опасная зона");
	Словарь.Добавить("settings.package.crumb", "настройки");

	Словарь.Добавить("settings.package.error.section", "Раздел настроек не найден");
	Словарь.Добавить("settings.package.error.save", "Не удалось сохранить: %1");

	Словарь.Добавить("settings.package.card.title", "Карточка");
	Словарь.Добавить("settings.package.card.lead", "Что видит потребитель в каталоге.");
	Словарь.Добавить("settings.package.card.description.label", "Описание");
	Словарь.Добавить("settings.package.card.description.hint", "Одна строка под именем пакета");
	Словарь.Добавить("settings.package.card.keywords.label", "Ключевые слова");
	Словарь.Добавить("settings.package.card.keywords.hint", "По ним пакет находят в каталоге");
	Словарь.Добавить("settings.package.card.license.label", "Лицензия");
	Словарь.Добавить("settings.package.card.repo.label", "Репозиторий");
	Словарь.Добавить("settings.package.card.repo.hint", "Адрес github.com даёт ссылке на пакет картинку"
		+ " репозитория; версия с адресом в манифесте его обновит");
	Словарь.Добавить("settings.package.card.repo.placeholder", "https://github.com/владелец/репозиторий");

	Словарь.Добавить("settings.package.catalog.title", "В каталоге");
	Словарь.Добавить("settings.package.catalog.lead", "Сохраняется сразу.");
	Словарь.Добавить("settings.package.catalog.on", "да");
	Словарь.Добавить("settings.package.catalog.off", "нет");
	Словарь.Добавить("settings.package.catalog.deprecated.label", "Устаревший");
	Словарь.Добавить("settings.package.catalog.deprecated.hint",
		"Пакет остаётся доступным, но помечен как устаревший");
	Словарь.Добавить("settings.package.catalog.hidden.label", "Скрыт из каталога");
	Словарь.Добавить("settings.package.catalog.hidden.hint",
		"Не показывается в каталоге и поиске; по прямой ссылке доступен");

	Словарь.Добавить("settings.package.access.title", "Права доступа на пакет");
	Словарь.Добавить("settings.package.access.lead", "Кто и в какой роли работает с этим пакетом"
		+ " сверх того, что даёт роль на пуле.");
	Словарь.Добавить("settings.package.access.empty", "Отдельных прав на пакет не выдано:"
		+ " доступ приходит с пула.");
	Словарь.Добавить("settings.package.access.readonly", "Права показаны только для чтения:"
		+ " выдавать и отзывать их может мейнтейнер пакета и выше.");
	Словарь.Добавить("settings.package.access.error.object",
		"Раздел правит права только на этот пакет");
	Словарь.Добавить("settings.package.access.error.subject",
		"Пользователь или группа с таким именем не найдены");

	Словарь.Добавить("settings.package.access-new.title", "Выдать роль на пакет");
	Словарь.Добавить("settings.package.access-new.lead", "Роль на пакете не даёт прав на остальной пул.");

	Словарь.Добавить("settings.package.access.inherited.note", "Таблица — только роли на самом пакете."
		+ " Менять пакет вправе ещё и райтер пула и выше (роль на пуле наследуется его пакетами),"
		+ " администратор хаба и автор любой опубликованной версии этого пакета. Выдавать и"
		+ " отзывать роли на пакете может мейнтейнер пакета и выше — в том числе полученный"
		+ " наследованием с пула.");
	Словарь.Добавить("settings.package.access.inherited.pool", "Роль на пуле действует и на этот пакет: %1.");
	Словарь.Добавить("settings.package.access.inherited.link", "права доступа пула");
	// поток «права»: справка строки о наследовании от пула
	Словарь.Добавить("settings.package.access.inherited.help", "Кто ещё распоряжается пакетом");

	Словарь.Добавить("settings.package.tags.title", "Теги пакета");
	Словарь.Добавить("settings.package.tags.lead", "Тег — канал обновления: «пакет@тег» отдаёт"
		+ " старшую из его версий.");
	Словарь.Добавить("settings.package.tags.col.tag", "Тег");
	Словарь.Добавить("settings.package.tags.col.origin", "Откуда");
	Словарь.Добавить("settings.package.tags.col.rule", "Правило");
	Словарь.Добавить("settings.package.tags.col.version", "Отдаёт");
	Словарь.Добавить("settings.package.tags.origin.own", "свой");
	Словарь.Добавить("settings.package.tags.origin.pool", "из пула %1");
	Словарь.Добавить("settings.package.tags.origin.override", "перекрывает пул %1");
	Словарь.Добавить("settings.package.tags.origin.disabled", "выключен у пакета");
	Словарь.Добавить("settings.package.tags.empty", "Тегов нет: хаб их сам не заводит."
		+ " Три обычных канала заведёт визард, любой другой — «Новый тег».");

	Словарь.Добавить("settings.package.tags.wizard.button", "Создать каналы «по умолчанию»");
	Словарь.Добавить("settings.package.tags.wizard.title", "Каналы «по умолчанию»");
	Словарь.Добавить("settings.package.tags.wizard.lead", "Три канала, которых чаще всего ждут"
		+ " от пакета. Дальше каждый правится как обычный тег.");
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
		+ " кнопкой «Новый тег».");
	Словарь.Добавить("settings.package.tags.wizard.skipped", "Каналы заведены, кроме занятых"
		+ " номерами версий этого пакета: %1.");
	Словарь.Добавить("settings.package.tags.wizard.skipped.nodefault", "Каналы заведены, кроме"
		+ " занятых номерами версий этого пакета: %1. Основного тега у пакета нет —"
		+ " включите «Тег по умолчанию» в окне нужного тега, иначе установка"
		+ " без тега пойдёт за последней версией, а не за каналом.");
	Словарь.Добавить("settings.package.tags.wizard.nothing", "Заводить нечего: все предлагаемые"
		+ " каналы у пакета уже есть.");
	Словарь.Добавить("settings.package.tags.menu.title", "Действия с каналом «%1»");
	Словарь.Добавить("settings.package.tags.button.edit.copy", "Изменить у пакета");
	Словарь.Добавить("settings.package.tags.button.pool", "Изменить в пуле");
	Словарь.Добавить("settings.package.tags.button.disable", "Выключить у пакета");
	Словарь.Добавить("settings.package.tags.button.restore", "Вернуть тег пула");
	Словарь.Добавить("settings.package.tags.button.enable", "Включить снова");
	Словарь.Добавить("settings.package.tags.delete.title", "Удалить тег «%1»?");
	Словарь.Добавить("settings.package.tags.delete.consequence", "Версии останутся на месте,"
		+ " а «%2@%1» перестанет отвечать: установка и подписки по этому тегу получат отказ.");
	Словарь.Добавить("settings.package.tags.restore.title", "Вернуть тег пула «%1»?");
	Словарь.Добавить("settings.package.tags.restore.consequence", "Своя копия снимется: пакет снова"
		+ " отдаёт «%1» по правилу пула %2.");
	Словарь.Добавить("settings.package.tags.error.missing", "Тега «%1» у пакета нет.");
	Словарь.Добавить("settings.package.tags.error.inherited", "Тег «%1» унаследован от пула:"
		+ " у пакета его выключают, а не удаляют.");
	Словарь.Добавить("settings.package.tags.error.notpool", "Тег «%1» не унаследован от пула —"
		+ " выключать у пакета нечего.");
	Словарь.Добавить("settings.package.tags.error.notdisabled", "Тег пула «%1» у пакета не выключен.");

	Словарь.Добавить("settings.package.tag-new.title", "Новый тег");
	Словарь.Добавить("settings.package.tag-new.lead", "Правило отбирает версии само;"
		+ " ручной тег ведёт мейнтейнер.");
	Словарь.Добавить("settings.package.tag-new.edit.title", "Тег «%1»");
	Словарь.Добавить("settings.package.tag-new.edit.lead", "Правка меняет состав канала сразу.");
	Словарь.Добавить("settings.package.tag-new.edit.lead.copy", "Тег унаследован от пула %1:"
		+ " сохранение заведёт у пакета копию, тег пула не изменится.");
	Словарь.Добавить("settings.package.tag-new.name.label", "Имя тега");
	Словарь.Добавить("settings.package.tag-new.name.version.error", "Имя тега занято версией пакета:"
		+ " запись «пакет@имя» читается сначала как точная версия, и тег с таким именем"
		+ " остался бы недостижим. Назовите тег иначе.");
	Словарь.Добавить("settings.package.tag-new.style.label", "Стиль плашки");
	Словарь.Добавить("settings.package.tag-new.style.plain", "Обычный");
	Словарь.Добавить("settings.package.tag-new.style.stable", "Стабильный");
	Словарь.Добавить("settings.package.tag-new.style.prerelease", "Предрелиз");
	Словарь.Добавить("settings.package.tag-new.style.deprecated", "Устаревший");
	Словарь.Добавить("settings.package.tag-new.style.special", "Особый");
	Словарь.Добавить("settings.package.tag-new.icon.label", "Значок");
	Словарь.Добавить("settings.package.tag-new.icon.hint",
		"Значок берёт цвет стиля и меняется вместе с ним и с темой; логотип бренда — своего цвета");
	Словарь.Добавить("settings.package.tag-new.icon.none", "Без значка");
	Словарь.Добавить("settings.package.tag-new.kind.error", "Вид тега не принят: выберите один из"
		+ " предложенных вариантов.");
	Словарь.Добавить("settings.package.tag-new.repush.label", "Запрет повторной публикации");
	Словарь.Добавить("settings.package.tag-new.rule.semver.hint", "Например «^1.2» или «>=2.0.0»."
		+ " Диапазон «*» пререлизы НЕ пропускает, «>=0.0.0-0» — пропускает");
	Словарь.Добавить("settings.package.tag-new.rule.regex.hint", "regex НЕ якорится автоматически и совпадает"
		+ " с ПОДСТРОКОЙ версии: «1\\.2» поймает и «11.2.0». Пользуйтесь якорями ^…$");
	Словарь.Добавить("settings.package.tag-new.check.button", "Проверить состав");
	Словарь.Добавить("settings.package.tag-new.preview.serves", "Отдаёт");
	Словарь.Добавить("settings.package.tag-new.preview.under", "Под тегом");
	Словарь.Добавить("settings.package.tag-new.preview.nothing", "ничего");
	Словарь.Добавить("settings.package.tag-new.preview.empty", "Ни одна версия пакета под правило не попадает"
		+ " — такой тег не отдаст ничего.");
	Словарь.Добавить("settings.package.tag-new.preview.error", "Правило не применено: %1");
	Словарь.Добавить("settings.package.tag-new.saved.matches", "Под правило тега %1 попали версии: %2");
	Словарь.Добавить("settings.package.tag-new.saved.matches.yanked", "Под правило тега %1 попали"
		+ " версии: %2. Отозванные тоже попали (%3), но установка их не выбирает.");
	Словарь.Добавить("settings.package.tag-new.saved.yanked", "Под правило тега %1 попали только"
		+ " отозванные версии (%2) — установка их не выбирает, и тег не отдаст ничего.");
	Словарь.Добавить("settings.package.tag-new.saved.empty", "Под правило тега %1 не попала ни одна"
		+ " версия пакета — такой тег не отдаст ничего.");
	Словарь.Добавить("settings.package.tag-new.save.switch.manual", "Тег %1 сейчас в режиме правила."
		+ " После сохранения правило будет стёрто, а канал станет ПУСТЫМ: версии в него"
		+ " набирают вручную, в меню версии.");
	Словарь.Добавить("settings.package.tag-new.save.switch.rule", "Тег %1 сейчас ручной. После"
		+ " сохранения его метки будут сняты, а состав канала начнёт считаться правилом.");

	Словарь.Добавить("settings.package.versions.title", "Версии и метки");
	Словарь.Добавить("settings.package.versions.lead", "Отзыв, возврат и теги опубликованных версий.");
	Словарь.Добавить("settings.package.versions.col.version", "Версия");
	Словарь.Добавить("settings.package.versions.col.state", "Состояние");
	Словарь.Добавить("settings.package.versions.col.published", "Опубликована");
	Словарь.Добавить("settings.package.versions.col.tags", "Теги");
	Словарь.Добавить("settings.package.versions.empty", "Нет опубликованных версий.");
	Словарь.Добавить("settings.package.versions.error.operation", "Неизвестная операция раздела");
	Словарь.Добавить("settings.package.versions.yanked", "отозвана");
	Словарь.Добавить("settings.package.versions.note", "Отзыв не удаляет артефакт: уже собранные"
		+ " проекты продолжают его получать, но новые установки версию не выбирают.");
	Словарь.Добавить("settings.package.versions.button.yank", "Отозвать");
	Словарь.Добавить("settings.package.versions.button.unyank", "Вернуть");
	Словарь.Добавить("settings.package.versions.menu.title", "Действия с версией %1");
	Словарь.Добавить("settings.package.versions.menu.tag.label", "Тег");
	Словарь.Добавить("settings.package.versions.menu.tag.add", "Поставить тег");
	Словарь.Добавить("settings.package.versions.menu.tag.unknown", "Такого ручного тега у пакета нет."
		+ " Выберите тег из списка либо заведите его в разделе «Теги пакета»: тег-правило"
		+ " набирает версии сам, и ручная метка на нём ни на что не влияет.");
	Словарь.Добавить("settings.package.versions.unset.title", "Снять тег «%1» с версии %2?");
	Словарь.Добавить("settings.package.versions.unset.button", "Снять тег");

	Словарь.Добавить("settings.package.danger.title", "Опасная зона");
	Словарь.Добавить("settings.package.danger.lead", "Необратимые действия над пакетом %1.");
	Словарь.Добавить("settings.package.danger.button", "Удалить пакет");
	Словарь.Добавить("settings.package.danger.note", "У пакета %1 нет ни одной версии. Удаление"
		+ " снимает его вместе со всем, что на него ссылалось, — ролями, доверенными конвейерами"
		+ " и подписками — и освобождает имя в пуле;"
		+ " вернуть пакет нельзя — только завести заново.");
	Словарь.Добавить("settings.package.danger.echo.label", "Имя пакета");
	Словарь.Добавить("settings.package.danger.error.operation", "Форма не назвала операцию:"
		+ " пакет не удалён.");
	Словарь.Добавить("settings.package.danger.error.echo", "Подтверждение не совпало с именем"
		+ " пакета %1: пакет не удалён.");
	Словарь.Добавить("settings.package.danger.error.delete", "Пакет не удалён: %1");

	// поток «пакет» Х4а: версии, доверенная публикация и опасная зона на узлах кита
	Словарь.Добавить("settings.package.versions.col.downloads", "Скачиваний");
	Словарь.Добавить("settings.package.versions.col.size", "Размер");
	Словарь.Добавить("settings.package.versions.menu.tag", "Поставить тег");
	Словарь.Добавить("settings.package.versions.menu.tag.create", "Завести ручной тег");
	Словарь.Добавить("settings.package.versions.menu.unset", "Снять тег «%1»");
	Словарь.Добавить("settings.package.versions.tag.title", "Тег на версию %1");
	Словарь.Добавить("settings.package.versions.tag.lead", "Ручной тег отдаёт версии, на которые"
		+ " его поставили.");
	Словарь.Добавить("settings.package.versions.unset.consequence", "Сам тег останется, из канала"
		+ " «%1» уйдёт только эта версия; поставить его можно снова.");
	Словарь.Добавить("settings.package.versions.error.save", "Не сохранено: %1");
	Словарь.Добавить("settings.package.versions.error.stale", "Страница устарела: ничего не изменено."
		+ " Обновите её и повторите действие.");
	Словарь.Добавить("settings.package.danger.confirm.title", "Удалить пакет «%1»?");
	Словарь.Добавить("settings.package.danger.confirm.consequence", "Пакет %1 пропадёт вместе"
		+ " с ролями, доверенными конвейерами и подписками, имя в пуле освободится."
		+ " Вернуть пакет нельзя — только завести заново.");
	Словарь.Добавить("settings.package.ci.error.stale", "Страница устарела: ничего не изменено."
		+ " Обновите её и повторите действие.");

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
	Словарь.Добавить("settings.package.ci.revoke.title", "Отозвать доверие конвейеру «%1»?");
	Словарь.Добавить("settings.package.ci.revoke.lead", "Следующая попытка публикации из этого"
		+ " конвейера получит отказ.");
	Словарь.Добавить("settings.package.ci.revoke.button", "Отозвать доверие");
	Словарь.Добавить("settings.package.ci.error.forbidden", "Доверенные конвейеры пакета"
		+ " настраивают его мейнтейнеры и выше.");
	Словарь.Добавить("settings.package.ci.error.csrf", "Форма устарела: обновите страницу"
		+ " и повторите действие.");
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
		+ " адрес инсталляции, а не на localhost сервера. Задайте настройку «Адрес хаба»"
		+ " в настройках хаба.");
	Словарь.Добавить("settings.package.ci-snippet.unknown-audience", "Хаб не знает, для кого"
		+ " выпускается его id-token, поэтому доверенные конвейеры сейчас не публикуют"
		+ " вовсе, а готовый конвейер было бы нечем заполнить: аудитория в нём обязана"
		+ " совпасть с той, что сверяет хаб. Задайте настройку «Адрес хаба» либо"
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
	Словарь.Добавить("subscriptions.package.lead",
		"Куда хаб сообщает о событиях этого пакета. События пула целиком настраиваются на пуле.");

КонецПроцедуры

// Дом «Группа»: участники, связка с провайдером, права группы.
Процедура КлючиДомаГруппы(Словарь)

	Словарь.Добавить("settings.group.title", "Настройки группы");
	Словарь.Добавить("settings.group.lead", "Состав группы и связка с OIDC; права выдаются на самих объектах.");
	Словарь.Добавить("settings.group.nav.members", "Участники");
	Словарь.Добавить("settings.group.nav.oidc", "Связка с OIDC");
	Словарь.Добавить("settings.group.nav.grants", "Права доступа группы");
	Словарь.Добавить("settings.group.crumb", "группы");

	Словарь.Добавить("settings.group.error.section", "Раздел настроек не найден");
	Словарь.Добавить("settings.group.readonly", "Вы видите группу как участник:"
		+ " изменять её состав и связки может только администратор хаба.");
	// поток «пул» Х4а: участники и связка с OIDC — экраны списка с окнами по адресу
	Словарь.Добавить("settings.group.error.stale",
		"Страница устарела: ничего не изменено. Обновите её и повторите действие.");

	Словарь.Добавить("settings.group.members.title", "Участники");
	Словарь.Добавить("settings.group.members.lead", "Состав группы и откуда каждое членство.");
	Словарь.Добавить("settings.group.members.col.login", "Логин");
	Словарь.Добавить("settings.group.members.col.source", "Откуда");
	Словарь.Добавить("settings.group.members.source.local", "вручную");
	Словарь.Добавить("settings.group.members.source.oidc", "провайдер");
	Словарь.Добавить("settings.group.members.empty", "В группе нет участников.");
	Словарь.Добавить("settings.group.members.synced", "Сверено с клеймами: %1");
	Словарь.Добавить("settings.group.members.menu", "Действия с участником %1");
	Словарь.Добавить("settings.group.members.button.remove", "Убрать из группы");
	Словарь.Добавить("settings.group.members.remove.title", "Убрать «%1» из группы?");
	Словарь.Добавить("settings.group.members.remove.consequence",
		"Участник потеряет права, которые даёт группа. Учётная запись останется в хабе.");
	Словарь.Добавить("settings.group.members.remove.oidc",
		"Членство пришло от провайдера: если клейм у участника остался, при следующем входе"
		+ " он снова окажется в группе.");
	Словарь.Добавить("settings.group.member.missing", "«%1» не состоит в группе.");

	Словарь.Добавить("settings.group.member-new.title", "Добавить участника");
	Словарь.Добавить("settings.group.member-new.lead", "Учётные записи хаба, которых в группе ещё нет.");
	Словарь.Добавить("settings.group.member-new.filter.label", "Поиск");
	Словарь.Добавить("settings.group.member-new.filter.placeholder", "Логин или email");
	Словарь.Добавить("settings.group.member-new.login", "Учётная запись");
	Словарь.Добавить("settings.group.member-new.choose", "Выберите учётную запись");
	Словарь.Добавить("settings.group.member-new.option", "%1 · %2");
	Словарь.Добавить("settings.group.member-new.empty", "Все учётные записи хаба уже в группе.");
	Словарь.Добавить("settings.group.member-new.notfound", "По запросу «%1» ничего не найдено.");
	Словарь.Добавить("settings.group.member-new.truncated",
		"Показаны первые %1 из %2 — уточните поиск.");
	Словарь.Добавить("settings.group.member-new.required", "Выберите учётную запись.");
	Словарь.Добавить("settings.group.member-new.missing", "Учётной записи «%1» в хабе нет.");
	Словарь.Добавить("settings.group.member-new.duplicate", "Пользователь «%1» уже в группе");
	Словарь.Добавить("settings.group.member-new.button", "Добавить");

	Словарь.Добавить("settings.group.oidc.title", "Связка с OIDC");
	Словарь.Добавить("settings.group.oidc.lead", "Какие клеймы провайдера означают членство в этой группе.");
	Словарь.Добавить("settings.group.oidc.col.issuer", "Издатель (issuer)");
	Словарь.Добавить("settings.group.oidc.col.claim", "Клейм");
	Словарь.Добавить("settings.group.oidc.col.value", "Значение клейма");
	Словарь.Добавить("settings.group.oidc.empty", "Группа не связана ни с одним клеймом.");
	Словарь.Добавить("settings.group.oidc.note", "При входе пользователя клеймы провайдера сопоставляются с"
		+ " этими правилами: совпало — участник добавляется, пропало — исключается.");
	Словарь.Добавить("settings.group.oidc.menu", "Действия с сопоставлением %1");
	Словарь.Добавить("settings.group.oidc.button.remove", "Удалить");
	Словарь.Добавить("settings.group.oidc.delete.title", "Удалить сопоставление «%1»?");
	Словарь.Добавить("settings.group.oidc.delete.consequence", "Клейм %1 со значением «%2» перестанет"
		+ " приводить в группу при входе. Уже добавленные участники останутся до следующей сверки.");
	Словарь.Добавить("settings.group.oidc.missing", "Сопоставления уже нет.");

	Словарь.Добавить("settings.group.policy.title", "Политика выпавших из клейма");
	Словарь.Добавить("settings.group.policy.lead",
		"Что делать с участником, которого IdP перестал возвращать в клейме.");
	Словарь.Добавить("settings.group.policy.label", "Выпавших из клейма — оставлять в группе");
	Словарь.Добавить("settings.group.policy.on", "оставлять: участник остаётся, IdP только добавляет");
	Словарь.Добавить("settings.group.policy.off", "исключать: пропал клейм — снимается членство");
	Словарь.Добавить("settings.group.policy.hint", "Затрагивает только членства с источником oidc;"
		+ " локальные назначения синхронизация не трогает никогда.");
	Словарь.Добавить("settings.group.policy.synced.label", "Последняя сверка с клеймами");
	Словарь.Добавить("settings.group.policy.never", "ещё не сверялся");
	Словарь.Добавить("settings.group.policy.unknown", "Политика не распознана: ничего не изменено.");

	Словарь.Добавить("settings.group.mapping-new.title", "Добавить сопоставление");
	Словарь.Добавить("settings.group.mapping-new.issuer.label", "Издатель (issuer)");
	Словарь.Добавить("settings.group.mapping-new.issuer.hint", "Значение iss из токена провайдера");
	Словарь.Добавить("settings.group.mapping-new.issuer.required", "Укажите издателя.");
	Словарь.Добавить("settings.group.mapping-new.claim.label", "Имя клейма");
	Словарь.Добавить("settings.group.mapping-new.claim.hint", "Обычно groups или roles");
	Словарь.Добавить("settings.group.mapping-new.value.label", "Значение клейма");
	Словарь.Добавить("settings.group.mapping-new.value.required", "Укажите значение клейма.");
	Словарь.Добавить("settings.group.mapping-new.button", "Добавить");

	Словарь.Добавить("settings.group.grants.title", "Права доступа группы");
	Словарь.Добавить("settings.group.grants.lead", "Куда и в какой роли группа открывает доступ своим участникам.");
	Словарь.Добавить("settings.group.grants.col.where", "Где править");
	Словарь.Добавить("settings.group.grants.empty", "Группе не выдано ни одного права доступа.");
	Словарь.Добавить("settings.group.grants.note", "Роль правят на самом объекте; объекты, которых"
		+ " вам не видно, не показаны.");
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
