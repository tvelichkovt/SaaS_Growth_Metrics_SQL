use classicmodels;
select * from orders;
select count(*) from orders; #110

select orders.*, shippedDate - orderDate dateff from orders;

select shippedDate, orderDate, shippedDate - orderDate dateff from orders order by orderDate;


select customerNumber, orderDate, shippedDate, shippedDate - orderDate dateff from orders order by customerNumber;

