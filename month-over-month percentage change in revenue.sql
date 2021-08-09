use classicmodels;
select * from payments;

# Given a table of purchases by date, calculate the month-over-month percentage change in revenue. 
	# The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
	# The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.
		# (Value This month – Value Previous month) x 100 / Previous Month= Percentage Growth
with 
cte1 as(select year(paymentDate) yr, month(paymentDate) mo, sum(amount) rev from payments group by 1, 2 order by 1, 2),
cte2 as(select yr, mo, rev, round(100*( (rev - lag(rev) over (order by yr, mo) ) / (lag(rev) over (order by yr, mo)) ),2) MoM_Change from cte1 order by 1, 2) 
select * from cte2;

with 
cte1 as(select year(paymentDate) yr, sum(amount) rev from payments group by 1 order by 1),
cte2 as(select yr, rev, round(100*( (rev - lag(rev) over (order by yr) ) / (lag(rev) over (order by yr)) ),2) YoY_Change from cte1 order by 1) 
select * from cte2;