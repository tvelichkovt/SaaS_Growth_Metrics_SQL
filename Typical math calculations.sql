use classicmodels;

select * from customers;

select count(distinct(customerNumber)) from customers
union all
select count(*) from customers;

select city, sum(creditLimit) a from customers where salesRepEmployeeNumber is not null group by 1 having sum(creditLimit) > 80000 order by 1;

select format(sum(creditLimit), 0) from customers;

select city, sum(creditLimit) a from customers where salesRepEmployeeNumber is not null group by 1 having sum(creditLimit) > 80000 order by 2 desc;

select truncate (1.555,1);

select round (1.555, 1);

select round (1.555); # == (1.555, 0)

select mod(11, 3); #2

select * from customers where mod(customerNumber, 2) > 0 limit 2; #odd

select * from customers where mod(customerNumber, 2) = 0 limit 2; #even

select abs(10), abs(-10), abs(0);

select * from orderdetails;

use classicmodels;
select * from orderdetails;

	# dense_rank() over
select *, dense_rank() over (order by quantityOrdered) from orderdetails;

	# dense_rank() over PARTITION BY
select *, dense_rank() over (PARTITION BY orderNumber order by quantityOrdered) from orderdetails;

SELECT (.1 + .2) = .3;

select sqrt(25);

select * from classicmodels.customers;

select sqrt(format(sum(salesRepEmployeeNumber),2)) from classicmodels.customers;

select sqrt(abs(-36));

select ceil(2.01);

select ceil(-2.91);

select 12 div 3;

select 12/3;

select mod(17,5); #2

select mod(3,2)>0; #even

select pow(3,2); #9
