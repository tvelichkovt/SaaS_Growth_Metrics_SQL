# Identify returning active users. 
	#A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. Output a list of user_ids of these returning active users.

use classicmodels;
select * from payments;
select * from payments where customerNumber in (141, 452) order by 1, 2 asc;

with
cte1 as(select payments.*, lag(paymentDate) over (partition by customerNumber order by paymentDate asc) Prev_Purchase from payments order by customerNumber),
cte2 as(select cte1.*, (paymentDate - Prev_Purchase) Diff_NextOrder, dense_rank() over (partition by customerNumber order by paymentDate asc) Second_Purchase from cte1) select * from cte2 where Second_Purchase = 2 and Diff_NextOrder <= 7;

select * from payments as t1 where exists (select * from payments as t2 where t1.customerNumber = t2.customerNumber and t1.paymentDate - t2.paymentDate > 0 and t1.paymentDate - t2.paymentDate <= 7);

