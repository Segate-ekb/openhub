// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Задача при готовности для тестов: считает прогоны.

Перем Вызовов_;

// Число прогонов.
//
// Возвращаемое значение:
//  Число
//
Функция Вызовов() Экспорт
	Возврат Вызовов_;
КонецФункции

// Контракт ЗадачаПриГотовности: один прогон — плюс один.
//
Процедура Исполнить() Экспорт
	Вызовов_ = Вызовов_ + 1;
КонецПроцедуры

&Прозвище("ЗадачаПриГотовности")
&Порядок(20)
&Желудь
Процедура ПриСозданииОбъекта()
	Вызовов_ = 0;
КонецПроцедуры
