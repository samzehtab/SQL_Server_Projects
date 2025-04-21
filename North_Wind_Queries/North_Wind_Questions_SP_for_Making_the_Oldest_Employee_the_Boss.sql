
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
North_Wind_Questions:_SP_for_Making_the_Oldest_Employee_the_Boss
*/

----------------------------------------------SP Immplementation--------------------------------------------
--------Copying 'Employees' table
select * into Employees2
from Employees

--------Creating 'MakeBoss' Sp
create procedure MakeBoss (@OldestEmpID int output)
as
begin
--------Finding the oldest Employee
	set @OldestEmpID =(
		select top 1 e2.EmployeeID
		from Employees2 e2
		order by year(e2.BirthDate) asc)

--------Changing 'Reportsto' situation of former boss (EmployeeID = 2)
	update Employees2
		set ReportsTo = @OldestEmpID
		where ReportsTo is null

--------Making the oldest employee the boss
	update Employees2
		set ReportsTo = null
		where EmployeeID = @OldestEmpID

--------Making other employees to report to the new boss and the second man (EmployeeID = 5)
	update Employees2
		set ReportsTo = @OldestEmpID
		where ReportsTo not in (5)

end

----------------------------------------------SP Running--------------------------------------------
--------Showing the oldest employee ID
declare @Oldest_Employee_ID int
exec MakeBoss @Oldest_Employee_ID output
select @Oldest_Employee_ID as 'OldestEmployeeID'

--------Showing who is reporting to who
select e2.EmployeeID, e2.ReportsTo
from Employees2 e2
