# Identify cities with higher than average home prices when compared to the national average. 
	# Output the city names.

use classicmodels;
select * from customers;

select country, sum(creditLimit) HOMEprices from customers group by 1 having(HOMEprices) > 305718 order by 1;

drop view db;
create view db as select country, sum(creditLimit) HOMEprices from customers group by 1 order by 1;
select * from db;
select avg(HOMEprices) from db; # 305718

select * from db group by 1 having(HOMEprices >= (select avg(HOMEprices) from db)) order by 1 desc;

select country, sum(creditLimit) HOMEprices from customers group by 1 having(HOMEprices) > 305718 order by 1;
