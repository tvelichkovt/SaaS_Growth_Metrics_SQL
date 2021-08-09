use classicmodels;
select * from customers;

select count(*) from customers
where salesRepEmployeeNumber is null;

#NOT IN /foreign keys/
select count(*) from customers 
where customerNumber not in
(select customerNumber from customers where salesRepEmployeeNumber is not null);


use classicmodels;
select * from customers;

select case when country='france' then 1 else 999 end, customers.* from customers;

select customerName, iif(country = 'france', 1,2) from customers;
