/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_Payments_and_PaymentMethod_Table
*/

-- Using 'northwind' database --------------------------------------------------------------------------------------
use northwind

-- Creating 'PaymentMethod' table (As Parent of 'Payments' table) -------------------------------------------------
create table PaymentMethod
(
	PaymentMethodID int primary key identity(100,1),
	MethodName nvarchar(25)
)

-- Data entry into 'PaymentMethod' table ----------------------------------------------------------------------------
insert PaymentMethod (MethodName)
values ('Cash'),
	   ('PayPal'),
	   ('Debit Card'),
	   ('Mobile Payment'),
	   ('Cryptocurrency'),
	   ('Gift Card'),
	   ('Check'),
	   ('Wire Transfer'),
	   ('Direct Debit'),
	   ('Installment Payment')

-- Creating 'Payments' table (As a child table of 'Orders' table) -------------------------------------------------------
create table Payments
(
	PaymentID int primary key identity(1, 1),
	OrderID int,
		constraint FK_OrdersPeyments
		foreign key (OrderID)
		references Orders(OrderID),
	PaymentDate nchar(23),
	Amount int,
	PaymentMethodID int,
		constraint FK_PaymentMethodPayment
		foreign key (PaymentMethodID)
		references PaymentMethod(PaymentMethodID),
	CustomerID nvarchar(10)
)

-- Data entry into 'Payments' table ----------------------------------------------------------------------------------
---- Copying Orders table into Orders2
select * into Orders2
from Orders

---- Creating a counter for while
declare @cnt int
select @cnt = count(*)
from Orders

---- Declaring two required variables and a non-physical table
declare @paymentmethodid int
declare @orderid_temptable int
declare @PaymentMethodIDs table (orderidcol int, paymentmethodidcol int)

---- Assigning random 'PaymentMethodID' to 'OrderID' and inserting them into a non-physical table
while @cnt > 0
begin
	select top 1 @paymentmethodid = PaymentMethodID
	from PaymentMethod
	order by newid()

	select top 1 @orderid_temptable = OrderID
	from Orders2
	order by newid()

	delete from Orders2
	where Orders2.OrderID = @orderid_temptable

	insert into @PaymentMethodIDs (orderidcol, paymentmethodidcol)
		values (@orderid_temptable, @paymentmethodid)

	set @cnt -= 1
end

---- Inserting 'OrderID', 'PaymentDate'(based on 'RequiredDate' of 'Orders' table),
---- 'CustomerID' and 'PaymentMethodID' columns into 'Payments' table
insert into Payments (OrderID, PaymentDate, CustomerID, PaymentMethodID)
select OrderID, RequiredDate, CustomerID, paymentmethodidcol
from Orders join @PaymentMethodIDs
on OrderID = orderidcol

----Data entry into 'Amount' column of 'Payments' table
select OrderID, sum((UnitPrice * Quantity) * (1 - Discount)) as Price into CalculatedAmounts
from [Order Details]
group by OrderID

update Payments
	set Amount =(
		select Price
		from [dbo].[CalculatedAmounts]
		where Payments.OrderID = [dbo].[CalculatedAmounts].OrderID)

-- Report -----------------------------------------------------------------------------------------------------------
select o.OrderId, o.OrderDate, c.ContactName, p.PaymentID, p.PaymentDate, p.Amount, pm.MethodName
from Customers c join Orders o
on c.CustomerID = o.CustomerID
join Payments p
on o.OrderID = p.OrderID
join PaymentMethod pm
on p.PaymentMethodID = pm.PaymentMethodID