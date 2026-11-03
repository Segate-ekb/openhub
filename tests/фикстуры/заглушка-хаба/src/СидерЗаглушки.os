// BSLLS:MissingVariablesDescription-off
// BSLLS:MissingParameterDescription-off
// BSLLS:MissingReturnedValueDescription-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:InvalidCharacterInFile-off
// BSLLS:YoLetterUsage-off
// Сидер заглушки хаба: дописывает базу, которую видит, — OSHUB_DB_CONNECTION — в файл OSHUB_TEST_STUB_SEED_LOG.

Запись = Новый ЗаписьТекста(ПолучитьПеременнуюСреды("OSHUB_TEST_STUB_SEED_LOG"), "UTF-8", , Истина);
Запись.ЗаписатьСтроку("база " + ПолучитьПеременнуюСреды("OSHUB_DB_CONNECTION"));
Запись.Закрыть();
