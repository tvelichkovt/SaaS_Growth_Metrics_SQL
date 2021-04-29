# Find the top 10 users that have traveled the greatest distance

use classicmodels;
select * from payments;

select distinct(customerNumber), sum(amount) over (partition by customerNumber) from payments order by 2 desc limit 10;

select customerNumber, sum(amount) from payments group by 1 order by 2 desc limit 10;

with 
cte1 as(select customerNumber c, sum(amount) a from payments group by 1 order by 2 desc)
select cte1.*, dense_rank() over (order by a desc) from cte1;