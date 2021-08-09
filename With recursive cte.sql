use classicmodels;

with recursive cte as(select 1 a, 1 b, -1 c union all select a+1, b*2, c*2 from cte where a<3) select * from cte;

select * from customers;

with recursive fibonacci(n, fib_n, next_fib_n) as(select 1, 0, 1 union all select n+1, next_fib_n, fib_n+next_fib_n from fibonacci where n<11)
select * from fibonacci where n=10;

select * from orders order by orderDate, customerNumber;

select orderDate a, sum(customerNumber) b from orders
where(orderDate)='2003-05-21'
group by 1
order by 1, 2;

with recursive dates(d) as (
select min(orderDate) from orders
union all
select d + interval 1 day from dates
where d + interval 1 day <= (select max(orderDate) from orders)
)
select dates.d, ifnull(sum(customerNumber),0) b from dates
left join orders on dates.d=orders.orderDate
group by 1
order by 1