# Identify the largest difference in total score

use classicmodels;
select * from orderdetails;

select *, quantityOrdered + cast(priceEach as unsigned) * 1.0 + orderLineNumber TOTAL  from orderdetails;
select *, quantityOrdered + priceEach * 1 + orderLineNumber TOTAL  from orderdetails;

with
cte1 as(select orderNumber, sum(quantityOrdered + priceEach * 1 + orderLineNumber) TOTAL from orderdetails group by 1 order by 1),
cte2 as(select max(total) - min(total) diff from cte1)
select orderNumber, TOTAL, diff - TOTAL from cte1, cte2; # 2578.91 - 462.84 = 2116.07