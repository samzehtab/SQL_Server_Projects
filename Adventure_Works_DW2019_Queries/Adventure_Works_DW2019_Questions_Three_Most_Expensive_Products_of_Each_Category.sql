
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
Adventure_Works_DW2019_Questions:_Three_Most_Expensive_Products_of_Each_Category
*/

with CTE1
as
(
select rank() over(partition by pc.ProductCategoryKey order by p.StandardCost desc) as PriceRankPerCategory,
	   p.EnglishProductName, p.FrenchProductName, p.SpanishProductName, p.StandardCost, p.[Weight],
	   pc.EnglishProductCategoryName as ProductCategry
from DimProductCategory pc join DimProductSubcategory psc
on pc.ProductCategoryKey = psc.ProductCategoryKey
join DimProduct p
on psc.ProductSubcategoryKey = p.ProductSubcategoryKey
)

select EnglishProductName, FrenchProductName, SpanishProductName, StandardCost, [Weight], ProductCategry
from CTE1
where PriceRankPerCategory <= 3
order by ProductCategry