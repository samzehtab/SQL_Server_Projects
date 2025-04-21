
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_Products_in_Orders_and_Suppliers
*/

----محصولاتی که هم در سفارشات وجود دارند و هم در موجودی تامین کنندگان؟

select distinct p.ProductName
from Products p join (
	select od.ProductID, p.SupplierID
	from [Order Details] od join Products p
	on od.ProductID = p.ProductID
	intersect
	select p.ProductID, s.SupplierID
	from Products p join Suppliers s
	on p.SupplierID = s.SupplierID) as ps
on p.SupplierID = ps.SupplierID