
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
Pubs_Questions:_SP_for_Showing_Titles_Written_by_an_Author
*/

------------------------------------SP Implementation-------------------------------------
create procedure TitlesofAuthor (@AutherID varchar(11))
as
begin
	select t.title, t.price, t.pubdate
	from titles t join titleauthor ta
	on t.title_id = ta.title_id
	where ta.au_id like @AutherID
end

------------------------------------SP Running--------------------------------------------
exec TitlesofAuthor '267-41-2394'