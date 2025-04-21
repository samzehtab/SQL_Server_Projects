
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
Pubs_Questions:_SP_for_Returning_Sum_of_Sales_of_a_Store
*/

------------------------------------SP Implementation-------------------------------------
create procedure StoreSumofSales (@StoreID char(4), @SumofSales int output)
as
begin
	set @SumofSales = (
		select sum(s.qty * t.price)
		from sales s join titles t
		on s.title_id like t.title_id
		where s.stor_id like @StoreID)
end

------------------------------------SP Running---------------------------------------------
declare @StoreSumofSales int
exec StoreSumofSales '7896', @StoreSumofSales output

select stor_name, @StoreSumofSales as SumofSales_$
from stores
where stor_id like '7896'
