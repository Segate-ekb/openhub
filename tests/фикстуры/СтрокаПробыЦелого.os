// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Сущность-проба набора ДефектыБиблиотек_Тесты: целое число в колонке типа «Целое», таблица своя —
// авто-DDL не добавляет колонок в уже созданную таблицу пробы дефектов.

&Идентификатор
&ГенерируемоеЗначение
&Колонка(Тип = "Целое")
Перем Идентификатор Экспорт;

&Колонка(Тип = "Целое")
Перем Число Экспорт;

&Сущность(ИмяТаблицы = "ПробыЦелогоБиблиотек")
Процедура ПриСозданииОбъекта()
КонецПроцедуры
