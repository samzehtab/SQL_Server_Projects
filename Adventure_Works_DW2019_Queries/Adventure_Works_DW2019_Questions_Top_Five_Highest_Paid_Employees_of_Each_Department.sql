
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
Adventure_Works_DW2019_Questions:_Top_Five_Highest_Paid_Employees_of_Each_Department
*/

with CTE1
as
(
select dense_rank() over(partition by DepartmentName order by BaseRate desc) as SalaryRank,
	   EmployeeKey, FirstName, LastName, BaseRate as Salary, DepartmentName
from DimEmployee
)

select EmployeeKey, FirstName, LastName, Salary, DepartmentName
from CTE1
where SalaryRank <= 5