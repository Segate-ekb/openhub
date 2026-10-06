// Отказ входа с устройства в форме RFC 8628.

&Сериализуемое("error")
&Заполнено
&Тип("Строка")
&ОдинИз("invalid_scope", "invalid_request", "authorization_pending", "slow_down", "access_denied", "expired_token")
Перем Код;

&Сериализуемое("error_description")
&Заполнено
&Тип("Строка")
Перем Описание;
