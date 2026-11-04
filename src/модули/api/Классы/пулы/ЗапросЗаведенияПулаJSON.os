// Тело заведения пула.

// BSLLS:MissingVariablesDescription-off
&Сериализуемое("name")
&Заполнено
Перем Имя;

&Сериализуемое("type")
&ОдинИз("custom", "user")
Перем Тип;

&Сериализуемое("visibility")
&ОдинИз("public", "private")
Перем Видимость;

&Сериализуемое("quota_mb")
Перем КвотаМб;
// BSLLS:MissingVariablesDescription-on
