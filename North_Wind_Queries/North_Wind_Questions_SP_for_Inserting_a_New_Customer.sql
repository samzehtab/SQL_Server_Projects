
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_SP_for_Inserting_a_New_Customer
*/

----Copying 'Customers' into 'Customers2' Table
select * into Customers2
from Customers

----------------------------------------SP Implementation-----------------------------------------------------
create procedure CustomerInsert (@CusID nchar(5), @CoName nvarchar(40), @ContName nvarchar(30),
								 @Add nvarchar(60), @CityName nvarchar(15), @CountryName nvarchar(15),
								 @PhoneNumber nvarchar(24), @CustomerTotalNumber int output)
as
begin

--------Updating when 'ContactName' exist
	if exists(
	select *
	from Customers2
	where ContactName = @ContName)
		update Customers2
			set [CustomerID] = @CusID,
				[CompanyName] = @CoName,
				[Address] = @Add,
				[City] = @CityName,
				[Country] = @CountryName,
				[Phone] = @PhoneNumber
		where ContactName = @ContName

--------Inserting when 'ContactName' does not exist
	else
	begin
		insert into Customers2 ([CustomerID], [CompanyName], [ContactName], [Address],
						   [City], [Country], [Phone])
		values (@CusID, @CoName, @ContName, @Add, @CityName, @CountryName, @PhoneNumber)
	end

--------Counting number of customers after the change
	set @CustomerTotalNumber =(
		select count(*)
		from Customers2)
end

--------------------------------------------SP Running---------------------------------------------------
--------Inserting a new customer
declare @TotalNumberOfCustomers int
exec CustomerInsert 'ALMKI', 'Pepsi', 'Hani', 'Narmak HaftHoz', 'Tehran', 'Iran', '989127175477',
					@TotalNumberOfCustomers output
select @TotalNumberOfCustomers

--------Checking 'Customer2' table after the change
select *
from Customers2