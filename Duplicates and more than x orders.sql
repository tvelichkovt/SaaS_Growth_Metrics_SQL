
use classicmodels;
select * from orders;
select * from customers;

		#select customers ordered more than twice
select * from orders order by customerNumber;
select customerNumber, count(customerNumber) from orders where customerNumber=103;#3

select c.customerName, o.customerNumber, count(o.customerNumber) from orders o
join customers c on o.customerNumber=c.customerNumber
group by o.customerNumber
having count(o.customerNumber)>2
order by 3;

