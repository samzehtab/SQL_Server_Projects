
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_Employees_Not_Serving_Customers
*/

----کارمندانی که به هیچ مشتری ای خدمات نمیدهند؟

select e.FirstName + ' ' + e.LastName as EmployeeFullName
from Employees e
where e.EmployeeID in (
	select e.EmployeeID
	from Employees e
	except
	select o.EmployeeID
	from Orders o)