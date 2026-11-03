// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Фейковая запись пула: поля, которых касаются КвотаПула и СторожЗаполненияПула.

Перем Идентификатор Экспорт;
Перем Имя Экспорт;
Перем КвотаМб Экспорт;
Перем ЗанятоБайт Экспорт;

Процедура ПриСозданииОбъекта(Знач _Идентификатор, Знач _Имя, Знач _КвотаМб)
	Идентификатор = Цел(_Идентификатор);
	Имя = Строка(_Имя);
	КвотаМб = Цел(_КвотаМб);
	ЗанятоБайт = 0;
КонецПроцедуры
