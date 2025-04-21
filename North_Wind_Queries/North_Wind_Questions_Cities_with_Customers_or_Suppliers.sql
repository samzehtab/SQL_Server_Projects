
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_Cities_with_Customers_or_Suppliers
*/

----لیست تمام شهرهایی که در آن ها مشتری یا تامین کننده وجود دارد؟

select City
from Customers
union
select City
from Suppliers