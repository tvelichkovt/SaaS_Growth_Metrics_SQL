# Write an SQL query to find the id and the name of active users. 
	# Active users are those who logged in to their accounts for 5 or more consecutive days. Return the result table ordered by the id.

use classicmodels;
select * from payments;
select * from payments where customerNumber in (141, 452) order by 1, 2 asc;

select *
from Accounts
where id in
    (select distinct t1.id
    from Logins as t1 inner join Logins as t2
    on t1.id = t2.id and datediff(t1.login_date, t2.login_date) between 1 and 4
    group by t1.id, t1.login_date
    having count(distinct(t2.login_date)) = 4)
order by id
