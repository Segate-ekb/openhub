/* OpenHub — запуск Swagger UI на странице описания API (/swagger-ui.html).
 *
 * Адрес описания, контейнер и тема приезжают РАЗМЕТКОЙ: здесь нет ни одного адреса хаба.
 * Ванильный JS без сборки; движок (swagger-ui-bundle.js) подключён страницей раньше этого
 * файла отложенными скриптами, поэтому к моменту запуска он уже разобран.
 *
 * Имя файла на диске — без версии; хеш содержимого добавляет в АДРЕС желудь АктивыСтатики,
 * поэтому правка этого файла сама меняет URL.
 */
(function () {
	'use strict';

	var контейнер = document.querySelector('[data-swagger-ui]');
	if (!контейнер || typeof SwaggerUIBundle !== 'function') { return; }

	/* Тёмная тема хаба — тёмная тема Swagger UI: движок красится классом на <html>,
	 * хаб объявляет тему атрибутом того же узла. Тема меняется только перезагрузкой
	 * страницы (её пишет сервер в куку), поэтому класс ставится один раз. */
	if (document.documentElement.getAttribute('data-theme') === 'dark') {
		document.documentElement.classList.add('dark-mode');
	}

	window.ui = SwaggerUIBundle({
		url: контейнер.getAttribute('data-openapi'),
		dom_id: '[data-swagger-ui]',
		presets: [SwaggerUIBundle.presets.apis],
		layout: 'BaseLayout',
		deepLinking: true,
		/* Значок проверки схемы по умолчанию рисуется картинкой со стороннего хоста,
		 * а страница хаба собирается из того, что лежит в инсталляции, и наружу
		 * не ходит вовсе. */
		validatorUrl: null,
		/* Описание и адрес задаёт хаб: подмена чужой схемой через ?url= и ?configUrl=
		 * увела бы браузер на посторонний хост. Умолчание движка то же, но здесь оно
		 * сказано вслух — это часть контракта страницы. */
		queryConfigEnabled: false
	});
}());
