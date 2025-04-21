
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_Number_of_Orders_of_a_Country_Function
*/

-----------------------------Function Implementation----------------------

create function Number_of_Orders (@CountryName nvarchar(15))
returns int
begin
	return(
		select count(*)
		from Orders o
		where @CountryName = o.ShipCountry)
end

-----------------------------------Calling Function--------------------------------------

select distinct o.ShipCountry, dbo.Number_of_Orders (o.ShipCountry) as 'Number of Orders'
from Orders o