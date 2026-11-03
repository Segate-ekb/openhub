// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Заглушка обновления базы стран: считает заходы, в сеть не ходит.

Перем Заходов_;

// Контракт ОбновлениеБазыСтран: засчитывает заход.
//
Процедура Обойти() Экспорт
	Заходов_ = Заходов_ + 1;
КонецПроцедуры

// Сколько раз звали Обойти().
//
// Возвращаемое значение:
//  Число
//
Функция Заходов() Экспорт
	Возврат Заходов_;
КонецФункции

Процедура ПриСозданииОбъекта()
	Заходов_ = 0;
КонецПроцедуры
