use classicmodels;
select * from orders;
select * from customers;
select * from orderdetails;
select * from products;

select 
p.productName, p.productDescription, 
d.quantityOrdered*d.priceEach
from orders o
join customers c on o.customerNumber=c.customerNumber 
join orderdetails d on o.orderNumber=d.orderNumber
join products p on d.productCode=p.productCode
where c.customerNumber=103;

select * from customers where salesRepEmployeeNumber is not null order by salesRepEmployeeNumber;