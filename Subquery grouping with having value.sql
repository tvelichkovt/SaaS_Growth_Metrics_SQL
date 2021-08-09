use classicmodels;

select * from payments;

select checkNumber, amount from payments where checkNumber in (
select checkNumber from payments
where paymentDate >'2004-01-01'
group by checkNumber
having sum(5*amount)<5*2000);