
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_SP_for_Registering_Invoice_for_a_Supplier_of_a_Specific_Country
*/

----------------------------------------------SP Immplementation--------------------------------------------
----Copying '[Order Details]' Table
select * into [Order Details 2]
from [Order Details]

----Creating 'SupplierIDSales' Function
create function SupplierIDSales (@Name_of_Country nvarchar(15))
returns table
	return(
		select s.SupplierID, sum(od2.Quantity * od2.UnitPrice * (1 - od2.Discount)) as 'TotalAmount'
		from Suppliers s join Products p
		on s.SupplierID = p.SupplierID
		join [Order Details 2] od2
		on p.ProductID = od2.ProductID
		where s.Country = @Name_of_Country
		group by s.SupplierID
		)

----Creating 'MinSupplierIDSale' Function
create function MinSupplierIDSale (@Name_of_Country nvarchar(15))
returns int
begin
	return(
		select top 1 SupplierID
		from dbo.SupplierIDSales(@Name_of_Country)
		order by TotalAmount asc
		)
end

----Implementing 'InvoiceRegirstrationSP' SP
create procedure InvoiceRegirstrationSP (@CountryName nvarchar(15))
as
begin
--------Assigning '@Minimun_Saler_SupplierID' Valiable
	declare @Minimun_Saler_SupplierID int
	set @Minimun_Saler_SupplierID = dbo.MinSupplierIDSale (@CountryName)

--------Assigning '@ProdID' Valiable
	declare @ProdID int
	set @ProdID = (
		select top 1 p.ProductID
		from Products p
		where p.SupplierID = @Minimun_Saler_SupplierID
		order by newid())

--------Assigning '@UPrice' Valiable
	declare @UPrice money
	set @UPrice = (
		select p.UnitPrice
		from Products p
		where p.ProductID = @ProdID)

--------Inserting a new Invoice into '[Order Details 2]' Table
	insert [Order Details 2] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount])
	values(11078, @ProdID, @UPrice, 10000, 0)
end

----------------------------------------------SP Calling--------------------------------------------
--------Finding 'SupplierIDSales' for 'France'
select *
from dbo.SupplierIDSales('France')
---------------------------------------------------------------
--SupplierID  TotalAmount
----------- ----------------------
--18          153691.275178909
--27          5881.67504882813
--28          117981.180160522
--(3 rows affected)
--Completion time: 2025-02-14T15:44:13.4188210+03:30
---------------------------------------------------------------

--------Finding 'MinSupplierIDSale' for 'France'
select dbo.MinSupplierIDSale('France')
---------------------------------------------------------------
--27
--(1 row affected)
--Completion time: 2025-02-14T15:48:48.0657784+03:30
---------------------------------------------------------------

--------Adding an Invoice for the Minimum Saler Supplier of 'France' Using 'InvoiceRegirstration' SP
exec InvoiceRegirstrationSP 'France'

select *
from [Order Details 2]
where OrderID = 11078
------------------------------------------------------------------------
--OrderID     ProductID   UnitPrice             Quantity Discount
------------- ----------- --------------------- -------- -------------
--11078       58          13.25                 10000     0
--(1 row affected)
--Completion time: 2025-02-14T15:57:50.2311460+03:30
------------------------------------------------------------------------

--------Checking the New 'SupplierIDSales' for 'France' After Addition of an Invoice 
select *
from dbo.SupplierIDSales('France')
------------------------------------------------------------------------
--SupplierID  TotalAmount
------------- ----------------------
--18          153691.275178909
--27          138381.675048828
--28          117981.180160522
--(3 rows affected)
--Completion time: 2025-02-14T16:08:05.8017235+03:30
------------------------------------------------------------------------

--------Checking the New 'MinSupplierIDSale' for 'France' After Addition of an Invoice 
select dbo.MinSupplierIDSale('France')
------------------------------------------------------------------------
--28
--(1 row affected)
--Completion time: 2025-02-14T16:09:19.0803702+03:30
------------------------------------------------------------------------