// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Реализация контракта ИменаКэшей с заданными именами.

Перем Имена_;   // Массив из Строка

// Имена кэшей предмета — контракт ИменаКэшей.
//
// Возвращаемое значение:
//  Массив из Строка - заданные имена.
//
Функция Имена() Экспорт
	Возврат Имена_;
КонецФункции

Процедура ПриСозданииОбъекта(Знач СписокИмён)
	Имена_ = СтрРазделить(СписокИмён, ",", Ложь);
КонецПроцедуры
