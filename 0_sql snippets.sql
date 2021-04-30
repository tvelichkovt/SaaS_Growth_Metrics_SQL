use classicmodels;

select * from customers;

select * from payments;

select * from customers c inner join payments p on c.customerNumber = p.customerNumber;

select country, sum(amount) from customers c inner join payments p on c.customerNumber = p.customerNumber
	group by country order by sum(amount) desc;
    
select year(paymentDate), extract(month from paymentDate), sum(amount) from customers c inner join payments p on c.customerNumber = p.customerNumber
	group by 1, 2 order by 1, 2, 3;
    
select *, year(paymentDate), month(paymentDate) from payments;
    
select year(paymentDate), month(paymentDate), sum(amount) from payments group by 1, 2 order by 1, 2;

select sum(amount) from payments;

select payments.*, sum(amount) over (order by paymentDate) from payments;

with cte as(select year(paymentDate) a, sum(amount) b from payments group by 1 order by 1) select a, b, sum(b) over (order by a) from cte;

with cte1 as(select year(paymentDate) a, sum(amount) b from payments group by 1 order by 1),
	cte2 as(select a, b, lag(b) over (order by a) c from cte1)
		select * from cte2;

with cte1 as(select year(paymentDate) a, sum(amount) b from payments group by 1 order by 1),
	cte2 as(select a, b, lag(b,1) over (order by a) c from cte1)
		select a, b, c, (b-c)/c d from cte2;
        
with cte1 as(select year(paymentDate) a, sum(amount) b from payments group by 1 order by 1),
	cte2 as(select a, b, lag(b) over (order by a) c from cte1)
		select a, b, round((b - c) / c * 100.0, 1) d from cte2;

select country, sum(amount) from customers c inner join payments p on c.customerNumber = p.customerNumber
	group by country order by sum(amount) desc limit 1;
    
select country, city, sum(amount) from customers c inner join payments p on c.customerNumber = p.customerNumber
	group by 1, 2 order by 3 desc;
    
select * from customers order by creditLimit desc;

select * from (select *, row_number() over (order by creditLimit desc) my_rank from customers) subqury where my_rank = 2;

select country, city, count(customerNumber) from customers group by 1, 2 order by 3 desc, 1, 2;
    
select * from orders;

select sum(case when status != 'shipped' and status is not null then 1 end) from orders;  

select (select count(orderNumber) from orders where status != 'shipped' and status is not null)/(select count(orderNumber) from orders where status = 'shipped' and status is not null) not_shipped_perc;

select * from payments;

select year(o.paymentDate), month(o.paymentDate), sum(case when status != 'shipped' and status is not null then 1 end)
from customers c inner join orders o on c.customerNumber = o.customerNumber group by 1, 2 order by 1;
    
select year(orderDate), month(orderDate), sum(case when status = 'shipped' and status is not null then 1 end) from orders group by 1, 2;
    
select year(orderDate), month(orderDate), 
count(*),
sum(case when status = 'shipped' and status is not null then 1 end),
sum(case when status != 'shipped' and status is not null then 1 end) from orders group by 1, 2;

with cte1 as (select orderNumber from Orders where status = 'shipped' and status is not null),
	cte2 as (select orderNumber from Orders where status != 'shipped' and status is not null),
	cte3 as (select count(orderNumber) a from cte1),
	cte4 as (select count(orderNumber) b from cte2)
select a, b, b/a from cte3, cte4;

select count(*) from orders;

select year(orderDate), count(orderNumber) from orders group by 1 order by 1;
    
with cte1 as(select year(orderDate) a, count(orderNumber) b from orders group by 1 order by 1), cte2 as (select a, b, sum(b) over (order by a) c from cte1) select a, b, c from cte2;

with cte1 as(select year(orderDate) a, count(orderNumber) b from orders group by 1 order by 1), cte2 as (select a, b, lag(b) over (order by a) c from cte1) select a, b, c from cte2;

with cte1 as(select year(orderDate) a, count(orderNumber) b from orders group by 1 order by 1), cte2 as (select a, b, lag(b) over (order by a) c from cte1) 
select a, b, c, round((b-c)/c*100.0,2) d from cte2;

with cte1 as(select year(orderDate) a, count(orderNumber) b from orders group by 1 order by 1), cte2 as (select a, b, lead(b) over (order by a) c from cte1) 
select a, b, c from cte2;

select count(distinct c.customerNumber) from customers c inner join payments p on c.customerNumber = p.customerNumber; #98

select count(distinct c.customerNumber) from customers c LEFT join payments p on c.customerNumber = p.customerNumber; #122

# 1. Churn. Analyzing churn, you will have to focus on both customer and revenue churn.

set @threshold = 34999;
    
create view db as select c.customerNumber cn, p.paymentDate da, p.amount am  from customers c inner join payments p on c.customerNumber = p.customerNumber group by c.customerNumber, p.paymentDate order by c.customerNumber, p.paymentDate;

select cn, da, am from db;

with 
monthly_usage as(select cn, (date(now()) - date(da)) time_period from db group by 1 order by 1),
lead_lag as(select cn, time_period, lag(time_period) over (order by time_period) lag_, lead(time_period) over (order by time_period) lead_ from monthly_usage),
lag_lead_with_diffs as(select cn, time_period, lag_, lead_, time_period - lag_ lag_size, lead_ - time_period lead_size from lead_lag)

select * from lag_lead_with_diffs; # lead_size=1 NEW ; lead_size>1 CHURN ; lag_size>1 RETURN ; lag_size=Null New

select * from lag_lead_with_diffs;

select * from (select distinct(c.customerNumber), min(p.paymentDate), max(p.paymentDate), max(p.paymentDate) - min(p.paymentDate) diff
from customers c inner join payments p on c.customerNumber = p.customerNumber where p.amount > 0
group by c.customerNumber order by c.customerNumber) subquery where diff between 1 and 365; # Churned Customers

select * from (select distinct(c.customerNumber), min(p.paymentDate), max(p.paymentDate), max(p.paymentDate) - min(p.paymentDate) diff
from customers c inner join payments p on c.customerNumber = p.customerNumber where p.amount > 0
group by c.customerNumber order by c.customerNumber) subquery where diff = 0; # Inactive Customers

select * from (select distinct(c.customerNumber), min(p.paymentDate), max(p.paymentDate), max(p.paymentDate) - min(p.paymentDate) diff
from customers c inner join payments p on c.customerNumber = p.customerNumber where p.amount > 0
group by c.customerNumber order by c.customerNumber) subquery where diff > 365; # Active Customers

with cte1 as(select c.customerNumber, sum(p.amount) sales from customers c inner join payments p on c.customerNumber = p.customerNumber group by 1),
cte2 as(select count(*) non_Churn from cte1 where sales >= @threshold),
cte3 as(select count(*) Churn from cte1 where sales < @threshold)
select non_Churn, Churn, Churn/non_Churn from cte2, cte3;

# 1.2 Revenue Churn is $ which you lose with departing customers.

with cte1 as(select c.customerNumber, sum(p.amount) sales from customers c inner join payments p on c.customerNumber = p.customerNumber group by 1),
cte2 as(select sum(sales) non_Churn_sales from cte1 where sales >= @threshold),
cte3 as(select sum(sales) Churn_sales from cte1 where sales < @threshold)
select non_Churn_sales, Churn_sales, Churn_sales/non_Churn_sales from cte2, cte3;

select * from payments;

select t1.c1, t1.d1, t2.d2 from

(with cte1 as(select * from (select c.customerNumber a1, sum(p.amount) b1, p.paymentDate c1 from customers c inner join payments p on c.customerNumber = p.customerNumber group by 1 order by 1) subquery1 where b1 > @threshold)
select c1, sum(b1) d1 from cte1 group by 1 order by 1) t1
left join
(with cte2 as(select * from (select c.customerNumber a2, sum(p.amount) b2, p.paymentDate c2 from customers c inner join payments p on c.customerNumber = p.customerNumber group by 1 order by 1) subquery1 where b2 <= @threshold)
select c2, sum(b2) d2 from cte2 group by 1 order by 1) t2

on t1.c1=t2.c2;


select t1.c1, t1.d1, t2.d2 from

(with cte1 as(select * from (select c.customerNumber a1, sum(p.amount) b1, p.paymentDate c1 from customers c inner join payments p on c.customerNumber = p.customerNumber group by 1 order by 1) subquery1 where b1 > @threshold)
select c1, count(a1) d1 from cte1 group by 1 order by 1) t1
left join
(with cte2 as(select * from (select c.customerNumber a2, sum(p.amount) b2, p.paymentDate c2 from customers c inner join payments p on c.customerNumber = p.customerNumber group by 1 order by 1) subquery1 where b2 <= @threshold)
select c2, count(a2) d2 from cte2 group by 1 order by 1) t2

on t1.c1=t2.c2;