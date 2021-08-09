use classicmodels;
select * from classicmodels.payments;

select payments.*, extract(year from paymentDate) from payments;

select extract(year from paymentDate), sum(amount) from payments group by 1;

select extract(year from paymentDate), extract(quarter from paymentDate), sum(amount) from payments group by 1, 2 order by 1;