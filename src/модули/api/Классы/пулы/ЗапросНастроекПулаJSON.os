// Тело правки настроек пула: присланное меняется, прочее остаётся.

// BSLLS:MissingVariablesDescription-off
&Сериализуемое("publish_allowed")
Перем ПубликацияРазрешена;

&Сериализуемое("pool_tags")
Перем ТегиПула;

&Сериализуемое("quota_mb")
Перем КвотаМб;

&Сериализуемое("visibility")
&ОдинИз("public", "private")
Перем Видимость;
// BSLLS:MissingVariablesDescription-on
