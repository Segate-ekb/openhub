// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Заглушка ФабрикиОтветов winow: отдаёт пустой ответ-заглушку и помнит все выданные.

Перем Выданные_;

// Пустой ответ — контракт ФабрикиОтветов winow.
//
// Возвращаемое значение:
//  ОтветWinowЗаглушка
//
Функция ПустойОтвет() Экспорт

	Ответ = Новый ОтветWinowЗаглушка();
	Выданные_.Добавить(Ответ);
	Возврат Ответ;

КонецФункции

// Сколько ответов фабрика выдала.
//
// Возвращаемое значение:
//  Число
//
Функция Выданных() Экспорт
	Возврат Выданные_.Количество();
КонецФункции

Процедура ПриСозданииОбъекта()
	Выданные_ = Новый Массив();
КонецПроцедуры
