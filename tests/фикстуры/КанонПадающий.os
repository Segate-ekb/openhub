// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Канон IP, у которого приведение адреса всегда падает: сбой канона не уносит операцию.

// Контракт КанонIP: каноническая строка адреса.
//
// Параметры:
//  Запись - Строка - адрес в любой записи.
//
// Возвращаемое значение:
//  Строка - никогда не возвращается: метод всегда бросает исключение.
//
Функция Строкой(Знач Запись) Экспорт
	ВызватьИсключение "Канон адреса сломан: " + Лев(Строка(Запись), 40);
КонецФункции

Процедура ПриСозданииОбъекта()
КонецПроцедуры
