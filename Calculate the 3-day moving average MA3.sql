#Calculate the 3-day moving average MA3: 

use classicmodels;
select * from classicmodels.payments;

select payments.*, 
avg(amount) over (order by paymentDate ASC ROWS 2 PRECEDING) MA3
from payments;

select * from classicmodels.payments order by customerNumber;
select payments.*, avg(amount) over (order by paymentDate asc rows 2 preceding) from payments;
