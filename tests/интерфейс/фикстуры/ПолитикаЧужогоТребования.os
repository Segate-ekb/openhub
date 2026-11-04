// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Заглушка ПолитикаПароля: одно требование, машинного кода которого хаб не знает, — так выглядит
// требование библиотеки, для которого у хаба нет кода.

// Требования политики с кодами.
//
// Возвращаемое значение:
//  Массив из Структура - одно требование с пустым Кодом.
//
Функция ТребованияПодробно() Экспорт

	Результат = Новый Массив();
	Результат.Добавить(Новый Структура("Код, Текст, Минимум, Максимум",
		"", "требование не из этого мира", 0, 0));
	Возврат Результат;

КонецФункции
