# https://platform.stratascratch.com/coding-question?python=&id=10314

# Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased.
	# Do not include returns which are represented by negative purchase values. 
		# Output the month and 3-month rolling average of revenue, sorted from earliest month to latest month.
			# A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. 
				# The first two months will not be a true 3-month rolling average since we are not given data from last year.

use classicmodels;
select * from payments;

select *, 
avg(amount) over (order by paymentDate ASC ROWS 2 PRECEDING) Three_Month_RolAVG
from payments;