# Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased.
	# Do not include returns which are represented by negative purchase values. 
		# Output the month and 3-month rolling average of revenue, sorted from earliest month to latest month.
			# A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. 
				# The first two months will not be a true 3-month rolling average since we are not given data from last year.

use classicmodels;
select * from payments order by paymentDate asc;

drop view db;
create view db as select year(paymentDate) YR, month(paymentDate) MO, sum(amount) REV from payments group by 1, 2 order by 1, 2;
select db.*, avg(REV) over (order by YR, MO asc rows 2 preceding) from db;

select *, avg(REV) over (order by YR, MO asc rows 2 preceding) 3_MO_EOL_AVG from(select year(paymentDate) YR, month(paymentDate) MO, sum(amount) REV from payments where amount >= 0 group by 1, 2 order by 1, 2) subquery_derived_table;