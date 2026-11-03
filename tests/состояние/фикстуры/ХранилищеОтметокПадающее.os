// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// ХранилищеОтметокВыпуска, у которого лежит база: чтение и запись отметки бросают.

// Чтение отметки — сбой базы.
//
// Возвращаемое значение:
//  Структура - не возвращается: бросает.
//
Функция Прочитать() Экспорт
	ВызватьИсключение "хранилище отметок недоступно";
КонецФункции

// Запись отметки — сбой базы.
//
// Параметры:
//  Отметка - Структура - отметка.
//
Процедура Записать(Знач Отметка) Экспорт
	ВызватьИсключение "хранилище отметок недоступно";
КонецПроцедуры
