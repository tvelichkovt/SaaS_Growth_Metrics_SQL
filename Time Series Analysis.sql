#Time Series Analysis

use classicmodels;
select * from classicmodels.payments;

select 

extract(year from paymentDate) YY, 
sum(amount)/100000 EURO,
lag(sum(amount/100000)) over (order by paymentDate) LAG1,
lead(sum(amount/100000)) over (order by paymentDate) LEAD2

from payments 
group by 1
order by 1;

with cte1 as(
select 
extract(year from paymentDate) YY, 
sum(amount)/100000 REVENUE1,
lag(sum(amount/100000)) over (order by paymentDate) REVENUE2 
from payments group by 1 order by 1) 
select cte1.*, REVENUE2-REVENUE1 DIFF from cte1;

with cte1 as(
select extract(year from paymentDate) YR, sum(amount) REV, lag(sum(amount)) over (order by extract(year from paymentDate)) COMP from classicmodels.payments group by 1 order by 1)
select YR, REV, ifnull((REV/COMP-1)*100, 'na') ROI from cte1;