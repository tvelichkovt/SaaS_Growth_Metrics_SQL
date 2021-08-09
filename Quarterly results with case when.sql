use classicmodels;
select * from orders;

select orders.*, 
case when month(shippedDate) < 7 then '1st half'
when month(shippedDate) > 6 then '2nd half'
else 'n/a' end '? half'
from orders;

select
sum(case when month(shippedDate) between 0 and 3 then 1 end) as Q1,
sum(case when month(shippedDate) between 4 and 6 then 1 end) as Q2,
sum(case when month(shippedDate) between 7 and 9 then 1 end) as Q3,
sum(case when month(shippedDate) between 10 and 12 then 1 end) as Q4
from orders;

select sum(case when month(shippedDate) between 0 and 3 then 1 end) q1, sum(case when month(shippedDate) between 4 and 6 then 1 end) q2 from orders;
