use classicmodels;
select * from payments;

with cte1 as(select extract(year from paymentDate) YR, extract(month from paymentDate) MO, sum(amount) REVENUE from payments group by 1, 2 order by 1, 2)
select cte1.*, sum(REVENUE) over (order by YR, MO) from cte1 order by 1, 2;

create view test4 as
with cte1 as(select extract(year from paymentDate) YR, extract(month from paymentDate) MO, sum(amount) REVENUE from payments group by 1, 2 order by 1, 2),
cte2 as(select cte1.*, sum(REVENUE) over (order by YR, MO) CUMU_R from cte1 order by 1, 2)
select * from cte2;

# What’s the most popular category in terms of sales quantity (MSRP) for each country (productLine) and each gender (productScale) in 2020?
select * from products order by msrp; 


select productLine, MSRP, count(*) as total
from products p
where productLine<115
group by productLine, MSRP
having count(*) = (select max(total) from 
(select productLine, MSRP, count(*) as total from products group by productLine, MSRP) x 
where productLine = p.productLine)
order by productLine, MSRP desc;

select CustomerNumber, amount, count(*) as total
from payments p
where CustomerNumber<115
group by CustomerNumber, amount
having count(*) = (select top 1 count(*) from 
payments where p.CustomerNumber = CustomerNumber group by CustomerNumber, amount order by count(*) desc);

# What’s the most popular category in terms of sales quantity (MSRP) for each country (productLine) and each gender (productScale) in 2020?

use classicmodels;
select productCode, productName, productLine, productScale, MSRP from products;

select * from (select productLine, productScale, MSRP, rank() over (order by MSRP desc) as my_rank from products group by productLine, productScale) subquery;

select * from
(select productLine, productScale, MSRP, 
rank() over (partition by productScale, productLine order by MSRP desc) as my_rank 
from products group by productLine, productScale, MSRP) subquery
where my_rank = 1 order by productLine, MSRP desc;

select productCode, productName, productLine, productScale, MSRP from products;
