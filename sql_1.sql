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

#select year(orderDate), count(orderNumber), sum(count(orderNumber)) over (partition by sum(count(orderNumber)) order by year(orderDate) ) from orders group by 1 order by 1;


select year(orderDate), month(orderDate), count(orderNumber) from orders group by 1, 2 order by 1, 2;



with cte as (select year(orderDate) a, count(orderNumber) b, lag(count(orderNumber),1) over (order by year(orderDate)) c from orders where status = 'shipped' and status is not null group by year(orderDate))
select *, (1.000*a-b)/(a) YoY_Change from cte;
    
    
    
    