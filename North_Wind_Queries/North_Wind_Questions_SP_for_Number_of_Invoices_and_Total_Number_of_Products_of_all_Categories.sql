
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_SP_for_Number_of_Invoices_and_Total_Number_of_Products_of_all_Categories
*/

------------------------------------------SP Implementation-----------------------------------
create procedure StartEndOrderHistory_ByCategory (@Beginning_Date DateTime, @Ending_Date DateTime)
as
begin
	select c.CategoryName, count(o.OrderID) as 'NumberOfInvoices', sum(od.Quantity) as 'TotalNumberOfProducts'
	from Orders o join [Order Details] od
	on o.OrderID = od.OrderID
	join Products p
	on od.ProductID = p.ProductID
	join Categories c
	on p.CategoryID = c.CategoryID
	where @Beginning_Date <= o.OrderDate and o.OrderDate <= @Ending_Date
	group by c.CategoryName
end

------------------------------------------SP Running-----------------------------------
exec StartEndOrderHistory_ByCategory '1996-07-22', '1996-07-31'
