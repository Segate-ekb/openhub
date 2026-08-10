/* OpenHub — прогрессивные улучшения интерфейса.
 *
 * Ванильный JS без сборки, бюджет 15–20 КБ. ВСЁ ЗДЕСЬ — ТОЛЬКО УЛУЧШЕНИЕ: страницы
 * обязаны оставаться осмысленными и работоспособными без этого файла (каждый раздел
 * имеет свой URL, каждая мутация — обычную POST-форму). Ни один сценарий ниже не
 * является единственным способом что-либо сделать.
 *
 * Разметку ищем ТОЛЬКО по data-атрибутам, инлайновых обработчиков нет вовсе: обработка
 * делегирована на document, а имена полей форм приезжают из этих же атрибутов — сервер
 * остаётся единственным владельцем контракта формы, здесь его копии нет.
 *
 * Имя файла на диске — без версии; хеш содержимого добавляет в АДРЕС желудь
 * АктивыСтатики (шаг 6.A-0), поэтому правка этого файла сама меняет URL.
 */
(function () {
	'use strict';

	function все(селектор, корень) {
		return Array.prototype.slice.call((корень || document).querySelectorAll(селектор));
	}

	/* --- копирование команды/ENV-сниппета (кнопки [data-copy]) --- */

	function скопировать(кнопка) {
		var текст = кнопка.getAttribute('data-copy') || '';
		var подпись = кнопка.querySelector('span') || кнопка;
		var прежний = подпись.textContent;

		function отчитаться(успех) {
			подпись.textContent = успех ? 'Скопировано' : 'Не вышло';
			setTimeout(function () { подпись.textContent = прежний; }, 1200);
		}

		if (navigator.clipboard && navigator.clipboard.writeText) {
			navigator.clipboard.writeText(текст).then(function () { отчитаться(true); },
				function () { отчитаться(false); });
			return;
		}

		// запасной путь для http-контекста без Clipboard API
		var поле = document.createElement('textarea');
		поле.value = текст;
		поле.setAttribute('readonly', '');
		поле.style.position = 'absolute';
		поле.style.left = '-9999px';
		document.body.appendChild(поле);
		поле.select();
		var получилось = false;
		try { получилось = document.execCommand('copy'); } catch (e) { получилось = false; }
		document.body.removeChild(поле);
		отчитаться(получилось);
	}

	/* --- тосты: закрытие --- */

	function закрытьТост(кнопка) {
		var тост = кнопка.closest('.toast');
		if (тост) { тост.remove(); }
	}

	/* --- панель сохранения: подсветка несохранённых изменений --- */

	function следитьЗаФормами() {
		var панели = document.querySelectorAll('[data-savebar]');
		Array.prototype.forEach.call(панели, function (панель) {
			var форма = панель.closest('form');
			if (!форма) { return; }
			var изменено = false;
			форма.addEventListener('input', function () {
				if (изменено) { return; }
				изменено = true;
				панель.classList.add('savebar--dirty');
			});
			форма.addEventListener('submit', function () {
				изменено = false;
				панель.classList.remove('savebar--dirty');
			});
		});
	}

	/* --- переключателя темы здесь БОЛЬШЕ НЕТ (замечание З-1 и ревью Р-7) --- */
	/* Он целиком серверный: POST-форма /ui/theme, иконку выбирает сервер по текущему
	   оформлению. Промежуточная редакция держала ДВА пути — серверный и клиентский, — и
	   они разошлись на контракте куки: сервер писал значение url-кодированным, транспорт
	   кодировал ещё раз, а `document.cookie` декодируется браузером один раз, поэтому
	   скрипт видел мусор, не находил «=» и при следующем переключении МОЛЧА терял акцент,
	   плотность и радиус. Один путь вместо двух снимает и расхождение, и код: цена —
	   обычная перезагрузка страницы после редиректа. */

	/* --- живая плашка конструктора тега ([data-chip]) ---
	   Ту же плашку печатает сервер при любой перерисовке страницы; здесь она лишь успевает
	   за вводом. Имена полей и текст образца объявлены атрибутами студии.

	   Цвет НЕ трогаем вовсе: вид плашки — это CSS-класс tag--*, а его цвет даёт переменная
	   темы. Соответствие «ключ стиля — класс» объявлено на самих вариантах выбора
	   ([data-chip-view]), поэтому второй копии этого знания в скрипте нет. */

	/* Носитель выбранного значения: у списка это выбранный <option> (на нём же живут
	   data-атрибуты варианта), у радиогруппы — отмеченная кнопка, у поля — оно само. */
	function выбранное(форма, имя) {
		if (!имя) { return null; }
		var поле = форма.querySelector('[name="' + имя + '"]:checked')
			|| форма.querySelector('[name="' + имя + '"]');
		if (поле && поле.tagName === 'SELECT') {
			return поле.options[поле.selectedIndex] || null;
		}
		return поле;
	}

	function перерисоватьПлашку(студия) {
		var цель = студия.querySelector('[data-chip-target]');
		var плашка = цель && цель.firstElementChild;
		if (!плашка) { return; }

		var форма = студия.closest('form');
		if (!форма) { return; }

		var имя = выбранное(форма, студия.getAttribute('data-chip-name'));
		var подпись = плашка.querySelector('[data-chip-caption]');
		var текст = (имя && имя.value.trim()) || студия.getAttribute('data-chip-sample') || '';
		if (подпись) { подпись.textContent = текст; }

		var стиль = выбранное(форма, студия.getAttribute('data-chip-style'));
		var вид = стиль ? стиль.getAttribute('data-chip-view') : null;
		плашка.className = 'tag' + (вид ? ' tag--' + вид : '');

		/* Значок: сервер напечатал ВСЕ допустимые глифы, лишние — с hidden. Синтезировать
		   svg кита в скрипте нечем, да и не нужно: показ переключается той же пометкой,
		   которую ставит сервер. */
		var значок = выбранное(форма, студия.getAttribute('data-chip-icon'));
		var ключ = значок ? значок.value : '';
		все('[data-chip-glyph]', плашка).forEach(function (глиф) {
			глиф.hidden = глиф.getAttribute('data-chip-glyph') !== ключ;
		});
	}

	function оживитьПлашки() {
		все('[data-chip]').forEach(function (студия) {
			var форма = студия.closest('form');
			if (!форма) { return; }
			форма.addEventListener('input', function () { перерисоватьПлашку(студия); });
			форма.addEventListener('change', function () { перерисоватьПлашку(студия); });
			перерисоватьПлашку(студия);
		});
	}

	/* --- переключатель наборов полей ([data-sets] + [data-set]) ---
	   Сервер печатает ВСЕ наборы, а невыбранные — с `disabled` и `hidden`: отключённые
	   поля браузер не отправляет, в них не уходит фокус, и `required` внутри них отправке
	   не мешает. Здесь снимаются и возвращаются ровно те же две пометки, поэтому
	   клиентский путь не может отправить больше, чем серверный.

	   Переключают либо ссылки с ключом в адресе, либо список, названный тем же именем,
	   что и группа: у второго серверный путь — круг через кнопку формы. */

	function ключИзСсылки(ссылка, параметр) {
		var адрес = ссылка.getAttribute('href') || '';
		var вопрос = адрес.indexOf('?');
		if (вопрос < 0) { return null; }
		var части = адрес.slice(вопрос + 1).split('&');
		for (var индекс = 0; индекс < части.length; индекс += 1) {
			var пара = части[индекс].split('=');
			if (decodeURIComponent(пара[0]) === параметр) {
				return decodeURIComponent((пара[1] || '').replace(/\+/g, ' '));
			}
		}
		return null;
	}

	// наборы ищем рядом с переключателем, а не по всей странице: второй такой переключатель
	// на экране не должен переключать чужие наборы
	function областьНаборов(группа) {
		return группа.parentElement || document;
	}

	// Наборы бывают вложенными (у «своего провайдера» внутри его набора живёт ещё один
	// переключатель — по протоколу). Свои переключателю только ВНЕШНИЕ наборы области:
	// вложенным распоряжается тот переключатель, который лежит рядом с ними.
	function наборыОбласти(область) {
		return все('[data-set]', область).filter(function (набор) {
			var родитель = набор.parentElement;
			var внешний = родитель && родитель.closest('[data-set]');
			return !(внешний && внешний !== область && область.contains(внешний));
		});
	}

	function выбратьНабор(группа, ключ) {
		все('a[href]', группа).forEach(function (ссылка) {
			var свой = ключИзСсылки(ссылка, группа.getAttribute('data-sets'));
			if (свой === ключ) {
				ссылка.setAttribute('aria-current', 'true');
			} else {
				ссылка.removeAttribute('aria-current');
			}
		});

		наборыОбласти(областьНаборов(группа)).forEach(function (набор) {
			var выбран = набор.getAttribute('data-set') === ключ;
			набор.disabled = !выбран;
			набор.hidden = !выбран;
		});
	}

	function переключитьНабор(ссылка) {
		var группа = ссылка.closest('[data-sets]');
		if (!группа) { return false; }
		var ключ = ключИзСсылки(ссылка, группа.getAttribute('data-sets'));
		if (ключ === null
			|| !областьНаборов(группа).querySelector('[data-set="' + ключ + '"]')) {
			return false; // набора рядом нет — пусть отработает обычная ссылка
		}
		выбратьНабор(группа, ключ);
		return true;
	}

	/* --- подтверждение отправки ([data-confirm]) ---
	   Без скрипта первый POST только СПРАШИВАЕТ: страницу с вопросом рисует сервер, и
	   он же сверяет поле подтверждения. Здесь тот же вопрос задаётся диалогом, а поле
	   подтверждения добавляется только после согласия — серверная сверка не ослабляется. */

	function подтвердить(форма) {
		// диалог доступен не везде (песочница iframe): без него отправляем форму КАК ЕСТЬ,
		// то есть без подтверждения, — вопрос задаст серверный шаг
		if (typeof window.confirm !== 'function') { return true; }
		if (!window.confirm(форма.getAttribute('data-confirm'))) { return false; }

		var имя = форма.getAttribute('data-confirm-field');
		if (!имя) { return true; }

		var поле = форма.querySelector('input[type="hidden"][name="' + имя + '"]');
		if (!поле) {
			поле = document.createElement('input');
			поле.type = 'hidden';
			поле.name = имя;
			форма.appendChild(поле);
		}
		поле.value = форма.getAttribute('data-confirm-value') || '';
		return true;
	}

	/* --- отбор показанного списка ([data-filter]) ---
	   Сужает СТРОКИ, УЖЕ отданные сервером. Серверный отбор остаётся кнопкой «Найти»:
	   он один видит записи за пределами выдачи, и пока введена подстрока, оговорка об
	   этом показана — иначе усечённый список читался бы как полный. */

	function текстСтроки(строка) {
		var куски = [];
		все('td', строка).forEach(function (ячейка) {
			// ячейка действий — это форма; её кнопки к отбору отношения не имеют
			if (!ячейка.querySelector('form')) { куски.push(ячейка.textContent); }
		});
		return куски.join(' ').toLowerCase();
	}

	function отобрать(область) {
		var поле = область.querySelector('[name="' + область.getAttribute('data-filter') + '"]');
		var запрос = поле ? поле.value.trim().toLowerCase() : '';
		var видимых = 0;

		все('tbody tr', область).forEach(function (строка) {
			var подходит = !запрос || текстСтроки(строка).indexOf(запрос) >= 0;
			строка.hidden = !подходит;
			if (подходит) { видимых += 1; }
		});

		все('[data-filter-partial]', область).forEach(function (узел) {
			узел.hidden = !запрос;
		});
		все('[data-filter-empty]', область).forEach(function (узел) {
			узел.hidden = !запрос || видимых > 0;
		});
	}

	function оживитьОтборы() {
		все('[data-filter]').forEach(function (область) {
			var поле = область.querySelector('[name="' + область.getAttribute('data-filter') + '"]');
			if (!поле) { return; }
			поле.addEventListener('input', function () { отобрать(область); });
		});
	}

	/* --- требования к паролю по мере набора ([data-pwreq]) ---
	   Список печатает сервер, спросив политику; что проверять, объявляет сама строка
	   ([data-pwrule]). Пароль отсюда никуда не уходит: судит его сервер. */

	// буква — символ, у которого регистры различаются (как на сервере)
	function классыПароля(текст) {
		var есть = { lower: 0, upper: 0, digit: 0, special: 0 };
		for (var и = 0; и < текст.length; и += 1) {
			var с = текст.charAt(и), н = с.toLowerCase();
			if (н !== с.toUpperCase()) {
				if (с === н) { есть.lower = 1; } else { есть.upper = 1; }
			} else if (с >= '0' && с <= '9') { есть.digit = 1; } else { есть.special = 1; }
		}
		return есть;
	}

	// null — правила с таким кодом здесь нет
	function выполнено(строка, текст, классы) {
		var код = строка.getAttribute('data-pwrule');
		if (код !== 'length') {
			return классы.hasOwnProperty(код) ? !!классы[код] : null;
		}
		var макс = +строка.getAttribute('data-pwmax') || 0;
		return текст.length >= (+строка.getAttribute('data-pwmin') || 0)
			&& (!макс || текст.length <= макс);
	}

	function оживитьПодсказки() {
		все('[data-pwreq]').forEach(function (блок) {
			var форма = блок.closest('form');
			var поле = форма && форма.querySelector(
				'[name="' + блок.getAttribute('data-pwreq') + '"]');
			if (!поле) { return; }
			// нейтральную отметку печатает сервер
			var пусто = (блок.querySelector('[data-pwmark]') || {}).textContent || '';
			var обновить = function () {
				var текст = поле.value || '';
				var классы = классыПароля(текст);
				все('[data-pwrule]', блок).forEach(function (строка) {
					var метка = строка.querySelector('[data-pwmark]');
					var итог = выполнено(строка, текст, классы);
					строка.classList.remove('pwreq__item--ok', 'pwreq__item--fail');
					// пустое поле — ещё не «не выполнено»
					if (итог === null || !текст) {
						if (метка) { метка.textContent = пусто; }
						return;
					}
					строка.classList.add(итог ? 'pwreq__item--ok' : 'pwreq__item--fail');
					if (метка) { метка.textContent = итог ? '✓' : '✗'; }
				});
			};
			поле.addEventListener('input', обновить);
			обновить();
		});
	}

	/* --- общая делегированная обработка событий --- */

	document.addEventListener('click', function (событие) {
		var цель = событие.target;
		if (!цель || !цель.closest) { return; }

		var копия = цель.closest('[data-copy]');
		if (копия) { скопировать(копия); return; }

		var закрытие = цель.closest('[data-close]');
		if (закрытие) { закрытьТост(закрытие); return; }

		var набор = цель.closest('[data-sets] a[href]');
		if (набор && !событие.defaultPrevented && событие.button === 0
			&& !(событие.metaKey || событие.ctrlKey || событие.shiftKey || событие.altKey)) {
			if (переключитьНабор(набор)) { событие.preventDefault(); }
		}
	});

	document.addEventListener('change', function (событие) {
		var цель = событие.target;
		if (!цель || !цель.closest || цель.tagName !== 'SELECT') { return; }
		var группа = цель.closest('[data-sets]');
		if (!группа || цель.getAttribute('name') !== группа.getAttribute('data-sets')) { return; }
		выбратьНабор(группа, цель.value);
	});

	document.addEventListener('submit', function (событие) {
		var форма = событие.target;
		if (!форма || !форма.getAttribute || !форма.getAttribute('data-confirm')) { return; }
		if (!подтвердить(форма)) { событие.preventDefault(); }
	});

	function запустить() {
		следитьЗаФормами();
		оживитьПлашки();
		оживитьОтборы();
		оживитьПодсказки();
	}

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', запустить);
	} else {
		запустить();
	}
})();
