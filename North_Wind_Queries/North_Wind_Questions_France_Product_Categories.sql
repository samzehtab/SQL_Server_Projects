
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_France_Product_Categories
*/
----من یک سرمایه گذار هستم. قصد تاسیس کارخانه دارم. در کشور فرانسه کدام گروه کالا تولیدکننده ای ندارد؟

select c.CategoryName
from Categories c
where c.CategoryName not in (
	select c.CategoryName
	from Categories c join Products p
	on c.CategoryID = p.CategoryID
	join Suppliers s
	on p.SupplierID = s.SupplierID
	where s.Country like 'France'
)