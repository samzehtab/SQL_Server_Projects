
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_Grains/Cereals_Export
*/

---- من تولیدکننده غلات هستم. گزارشی میخواهم که نشان دهد به کدام کشورها غلات صادر نشده است؟

select distinct o.ShipCountry
from Orders o
where o.ShipCountry not in (
	select o.ShipCountry
	from Orders o join [Order Details] od
	on o.OrderID = od.OrderID
	join Products p
	on od.ProductID = p.ProductID
	join Categories c
	on p.CategoryID = c.CategoryID
	where c.CategoryName like 'Grains/Cereals')