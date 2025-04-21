
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_Products_with_No_Order
*/

----محصولاتی که هیچ سفارشی ندارند

select p.ProductID
from Products p
except
select od.ProductID
from [Order Details] od