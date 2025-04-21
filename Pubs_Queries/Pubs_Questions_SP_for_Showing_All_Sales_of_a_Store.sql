
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
Pubs_Questions:_SP_for_Showing_All_Sales_of_a_Store
*/

------------------------------------SP Implementation-------------------------------------
create procedure SalesofStore (@StoreID char(4))
as
begin
	select t.title, sa.qty, sa.payterms, sa.ord_date, sa.ord_num
	from stores st join sales sa
	on st.stor_id like sa.stor_id
	join titles t
	on sa.title_id like t.title_id
	where st.stor_id like @StoreID
end

------------------------------------SP Running---------------------------------------------
exec SalesofStore '7131'