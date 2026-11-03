// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Фейк ЗапускВФоне, у которого постановка в фон отказывает: так проверяется, что вход
// переживает даже недоступность фоновых заданий.

// Контракт ЗапускВФоне: всегда бросает.
//
// Параметры:
//  Обработчик - Произвольный - объект с методом Исполнить(); до него дело не доходит.
//
Процедура Запустить(Знач Обработчик) Экспорт
	ВызватьИсключение "ЗапускВФонеПадающий: намеренный отказ постановки задания в фон";
КонецПроцедуры

Процедура ПриСозданииОбъекта()
КонецПроцедуры
