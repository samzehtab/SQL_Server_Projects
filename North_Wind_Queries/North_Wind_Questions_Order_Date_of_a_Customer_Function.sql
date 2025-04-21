
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_Order_Date_of_a_Customer_Function
*/

-----------------------------Function Implementation----------------------

create function CustomerOrderHistory (@CusID nchar(5))
returns table
	return(
		select c.ContactName, o.OrderDate
		from Orders o join Customers c
		on o.CustomerID = c.CustomerID
		where o.CustomerID = @CusID
	)

-----------------------------------Calling Function--------------------------------------

select *
from CustomerOrderHistory ('ALFKI')
