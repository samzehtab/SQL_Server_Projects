
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
Pubs_Questions:_SP_for_Returning_Sum_of_Sales_for_a_City_and_Specific_Time_Period
*/

------------------------------------SP Implementation-------------------------------------
create procedure CityTimePeriodSumofSales (@CityName varchar(20), @StartTime datetime, @EndTime datetime,
										   @SumofSales int output)
as
begin
	set @SumofSales = (
		select sum(sa.qty * t.price)
		from stores st join sales sa
		on st.stor_id like sa.stor_id
		join titles t
		on sa.title_id like t.title_id
		where st.city like @CityName and
		@StartTime <= sa.ord_date and sa.ord_date <= @EndTime)
end

------------------------------------SP Running---------------------------------------------
declare @CityTimePeriodSumofSales int
declare @StartingTime datetime
set @StartingTime = '1992-06-15 00:00:00.000'
declare @EndingTime datetime
set @EndingTime = '1994-09-14 00:00:00.000'

exec CityTimePeriodSumofSales 'Remulade', @StartingTime, @EndingTime,
@CityTimePeriodSumofSales output

select distinct st.city, @StartingTime as FromDate, @EndingTime as ToDate,
				@CityTimePeriodSumofSales as CityTimePeriodSumofSales_$
from stores st join sales sa
on st.stor_id like sa.stor_id
where st.city like 'Remulade'