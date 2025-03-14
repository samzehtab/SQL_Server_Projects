
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
Final_Project:_Ratatouille
*/

--Results that shows in each restaurant which food is cooked by which chefs; and copying it into 'result1'
select r.restaurant_title, c.chef_title, f.food_title
into result1
from Restaurant_table r join Food_table f
on r.restaurant_id = f.restaurant_id
join Food_chef_table fc
on f.food_id = fc.food_id
join Chef_table c
on fc.chef_id = c.chef_id;

----------------------------------------------------------------------------------------------------------------------
--Results that shows in each restaurant which food is cooked but has no chefs; and copying it into 'result2'
select r.restaurant_title, c.chef_title, f.food_title
into result2
from Restaurant_table r join Food_table f
on r.restaurant_id = f.restaurant_id
left join Food_chef_table fc
on f.food_id = fc.food_id
left join Chef_table c
on fc.chef_id = c.chef_id
where c.chef_id is null;

----------------------------------------------------------------------------------------------------------------------
--Results that shows in each restaurant which chefs do not cook any food; and copying it into 'result3'
select r.restaurant_title, c.chef_title, f.food_title
into result3
from Restaurant_table r join Restaurant_chef_table rc
on r.restaurant_id = rc.restaurant_id
join Chef_table c
on rc.chef_id = c.chef_id
left join Food_chef_table fc
on c.chef_id = fc.chef_id
left join Food_table f
on fc.food_id = f.food_id
where f.food_id is null;

----------------------------------------------------------------------------------------------------------------------
--Note: In two different tables we have restaurant 'Per Se' in which chef 'Thomas Keller' cook two different foods
--		which are 'Steak' and 'Flamenco'. We need to fix this conflict by merging obtained reports and setting
--		and setting the unmatched column of 'food_title' as 'null'.

--Getting source table for 'Per Se' restaurant and 'Thomas Keller' chef and copying it into 'sourcetable1'
select r.restaurant_title, c.chef_title, f.food_title
into sourcetable1
from Food_table f join Food_chef_table fc
on f.food_id = fc.food_id
join Chef_table c
on fc.chef_id = c.chef_id
join Restaurant_chef_table rc
on c.chef_id = rc.chef_id
join Restaurant_table r
on rc.restaurant_id = r.restaurant_id and r.restaurant_title like 'Per Se' and c.chef_title like 'Thomas Keller';

--Presenting source table of 'sourcetable1'
select *
from sourcetable1;

--Getting target table for 'Per Se' restaurant and 'Thomas Keller' chef and copying it into 'targettable1'
select r.restaurant_title, c.chef_title, f.food_title
into targettable1
from Chef_table c join Restaurant_chef_table rc
on c.chef_id = rc.chef_id
join Restaurant_table r
on rc.restaurant_id = r.restaurant_id
join Food_table f
on r.restaurant_id = f.restaurant_id and r.restaurant_title like 'Per Se' and c.chef_title like 'Thomas Keller';

--Presenting target table of 'targettable1'
select *
from targettable1;

--Removing 'not null' constraint from 'targettable1'
alter table targettable1
alter column food_title nvarchar(250);

--Merging 'sourcetable1' into 'targettable1' and updating the not matched column ('food_title') as 'null'
merge into targettable1 as t1
using sourcetable1 as s1
on t1.food_title like s1.food_title
when not matched by source then
	update
		set t1.food_title = null;

--Copying updated 'targettable1' into 'result4'
select *
into result4
from targettable1;

----------------------------------------------------------------------------------------------------------------------
--Note: In two different tables we have restaurant 'Gaggan' in which chef 'Gordon Ramsay' cook three different foods
--      which are 'Steak', 'Sushi' and 'Pasta Alfredo'. We need to fix this conflict by merging obtained reports and
--		setting the unmatched column of 'food_title' as 'null'.

--Getting source table for 'Gaggan' restaurant and 'Gordon Ramsay' chef and copying it into 'sourcetable2'
select r.restaurant_title, c.chef_title, f.food_title
into sourcetable2
from Chef_table c join Restaurant_chef_table rc
on c.chef_id = rc.chef_id
join Restaurant_table r
on rc.restaurant_id = r.restaurant_id
join Food_table f
on r.restaurant_id = f.restaurant_id and r.restaurant_title like 'Gaggan'  and c.chef_title like 'Gordon Ramsay';

--Presenting source table of 'sourcetable2'
select *
from sourcetable2;

--Getting target table for 'Gaggan' restaurant and 'Gordon Ramsay' chef and copying it into 'targettable2'
select r.restaurant_title, c.chef_title, f.food_title
into targettable2
from Food_table f join Food_chef_table fc
on f.food_id = fc.food_id
join Chef_table c
on fc.chef_id = c.chef_id
join Restaurant_chef_table rc
on c.chef_id = rc.chef_id
join Restaurant_table r
on rc.restaurant_id = r.restaurant_id and r.restaurant_title like 'Gaggan' and c.chef_title like 'Gordon Ramsay';

--Presenting target table of 'targettable2'
select *
from targettable2;

--Removing 'not null' constraint from 'targettable2'
alter table targettable2
alter column food_title nvarchar(250);

--Merging 'sourcetable2' into 'targettable2' and updating the not matched column ('food_title') as 'null'
merge into targettable2 as t2
using sourcetable2 as s2
on t2.food_title like s2.food_title
when not matched by source then
	update
		set t2.food_title = null;

--Copying updated 'targettable2' into 'result5'
select *
into result5
from targettable2;

----------------------------------------------------------------------------------------------------------------------
--Getting final report
select * from result1
union
select * from result2
union
select * from result3
union
select * from result4
union
select * from result5;