/* OpenHub — прогрессивные улучшения интерфейса.
 *
 * Ванильный JS без сборки, бюджет 32 КБ. ВСЁ ЗДЕСЬ — ТОЛЬКО УЛУЧШЕНИЕ: страницы
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

	/* --- живая форма подписки: предпросмотр на лету ([data-sub-preview]) и проба без
	   перезагрузки ([data-sub-trial]) ---
	   Сообщение собирает только сервер — той же дверью, что боевая доставка; здесь его ответ
	   лишь вставляется на место. Адрес, который отвечает кусочком, и имена секретных полей,
	   которые в предпросмотр не уходят, печатает сервер. Место живёт в окне подписки: окно новой
	   подписки стоит на странице закрытым, окно правки кит приносит запросом, — поэтому место
	   оживает, когда его окно открылось или в его форме набирают. Без скрипта место скрыто,
	   а обе кнопки шлют форму окна, и сервер возвращает окно открытым с итогом. */

	// ответ — разметка с узлом [data-sub-result]; страница отказа гейта его не несёт
	function вставитьОтвет(цель, текст, запасной) {
		var узел = new DOMParser().parseFromString(текст, 'text/html').querySelector('[data-sub-result]');
		цель.textContent = '';
		if (узел) {
			цель.appendChild(document.importNode(узел, true));
		} else {
			цель.textContent = запасной;
		}
	}

	function отправитьКусочек(адрес, поля, сигнал) {
		return fetch(адрес, { method: 'POST', body: поля, credentials: 'same-origin', signal: сигнал })
			.then(function (ответ) { return ответ.text(); });
	}

	function поляФормы(форма, пропустить) {
		var поля = new URLSearchParams();
		new FormData(форма).forEach(function (значение, имя) {
			if (пропустить.indexOf(имя) < 0 && typeof значение === 'string') { поля.append(имя, значение); }
		});
		return поля;
	}

	// предпросмотр, который сейчас в пути, и таймер ввода — у каждого места свои
	var запросыМест = new WeakMap();
	var таймерыМест = new WeakMap();

	function обновитьМесто(место) {
		var форма = место.closest('form');
		var цель = место.querySelector('[data-sub-preview-target]');
		if (!форма || !цель || typeof fetch !== 'function') { return; }

		все('[data-sub-preview-button]', форма).forEach(function (кнопка) { кнопка.hidden = true; });
		место.hidden = false;

		var прежний = запросыМест.get(место);
		if (прежний) { прежний.abort(); }
		var текущий = new AbortController();
		запросыМест.set(место, текущий);
		var секреты = (место.getAttribute('data-sub-omit') || '').split(' ').filter(Boolean);
		отправитьКусочек(место.getAttribute('data-sub-preview'), поляФормы(форма, секреты), текущий.signal)
			.then(function (текст) { вставитьОтвет(цель, текст, место.getAttribute('data-sub-failed')); },
				function (ошибка) {
					if (ошибка.name !== 'AbortError') { цель.textContent = место.getAttribute('data-sub-failed'); }
				});
	}

	function отложитьМеста(форма) {
		все('[data-sub-preview]', форма).forEach(function (место) {
			clearTimeout(таймерыМест.get(место));
			таймерыМест.set(место, setTimeout(function () { обновитьМесто(место); }, 300));
		});
	}

	// место в закрытом окне ждёт, пока окно откроют: страница не спрашивает сервер зря
	function оживитьМестаВидимые(корень) {
		все('[data-sub-preview]', корень).forEach(function (место) {
			var окно = место.closest('dialog');
			if (!окно || окно.open) { обновитьМесто(место); }
		});
	}

	function следитьЗаОкнами() {
		if (typeof MutationObserver !== 'function') { return; }
		new MutationObserver(function (записи) {
			записи.forEach(function (запись) {
				var узел = запись.target;
				if (запись.type === 'attributes' && узел.tagName === 'DIALOG' && узел.open) {
					оживитьМестаВидимые(узел);
				}
			});
		}).observe(document.body, { attributes: true, attributeFilter: ['open'], subtree: true });
	}

	function вводВФорму(событие) {
		var форма = событие.target && событие.target.form;
		if (форма && форма.querySelector('[data-sub-preview]')) { отложитьМеста(форма); }
	}

	function пробовать(кнопка) {
		var проба = кнопка.closest('[data-sub-trial]');
		var форма = кнопка.form;
		var итог = проба.querySelector('[data-sub-trial-result]');
		if (!форма || !итог || typeof fetch !== 'function') { return false; }

		кнопка.disabled = true;
		итог.textContent = проба.getAttribute('data-sub-busy');
		отправитьКусочек(проба.getAttribute('data-sub-trial'), поляФормы(форма, []))
			.then(function (текст) { вставитьОтвет(итог, текст, проба.getAttribute('data-sub-failed')); },
				function () { итог.textContent = проба.getAttribute('data-sub-failed'); })
			.then(function () { кнопка.disabled = false; });
		return true;
	}

	/* --- общая делегированная обработка событий --- */

	document.addEventListener('click', function (событие) {
		var цель = событие.target;
		if (!цель || !цель.closest) { return; }

		var копия = цель.closest('[data-copy]');
		if (копия) { скопировать(копия); return; }

		var закрытие = цель.closest('[data-close]');
		if (закрытие) { закрытьТост(закрытие); return; }

		var проба = цель.closest('[data-sub-trial] button');
		if (проба) {
			if (пробовать(проба)) { событие.preventDefault(); }
		}
	});

	document.addEventListener('submit', function (событие) {
		var форма = событие.target;
		if (!форма || !форма.getAttribute || !форма.getAttribute('data-confirm')) { return; }
		// data-confirm, который называет окно подтверждения кита, спрашивает кит своим окном
		var окно = document.getElementById(форма.getAttribute('data-confirm'));
		if (окно && окно.tagName === 'DIALOG') { return; }
		if (!подтвердить(форма)) { событие.preventDefault(); }
	});

	function запустить() {
		следитьЗаФормами();
		оживитьОтборы();
		оживитьПодсказки();
		оживитьМестаВидимые(document);
		следитьЗаОкнами();
		document.addEventListener('input', вводВФорму);
		document.addEventListener('change', вводВФорму);
	}

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', запустить);
	} else {
		запустить();
	}
})();
