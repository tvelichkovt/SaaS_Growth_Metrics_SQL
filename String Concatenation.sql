use classicmodels;
select * from customers;

select concat(contactFirstName,' ', contactLastName) fn from customers;

select concat(contactFirstName,' ', contactLastName) fn, length(concat(contactFirstName,'', contactLastName)) ch from customers;