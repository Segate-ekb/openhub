// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Часы os-scheduler, роняющие настройку планировщика — так воспроизводится сбой
// фонового цикла до входа в вечный Пока.

// Контракт часов os-scheduler; всегда бросает исключение.
//
// Возвращаемое значение:
//  Дата - не возвращается.
//
Функция Сейчас() Экспорт
	ВызватьИсключение "ЧасыПадающие: намеренный сбой источника времени";
КонецФункции
