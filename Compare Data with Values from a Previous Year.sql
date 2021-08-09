# Compare Data with Values from a Previous Year
# Count the number of products (checkNumber) launched by companies (customerNumber) for 2020 (2005) compared to the previous year (2004). 
	# Output the name of the companies and a count of net products released for 2020 compared to the previous year. 
	# If a company is new or had no products in 2019, then any product released in 2020 would be considered as new.

use classicmodels;
select * from payments where customerNumber in(202, 205) order by 1, 3;
	# 103 1(JM555205) 2003
	# 103 2(HQ336336.OM314933) 2004

select t1.customerNumber, t1.PREVyear, t1.PREV_q, t1.PREVsales, t2.CURRyear, t2.CURR_q, t2.CURRsales from
(select customerNumber, year(paymentDate) PREVyear, count(checkNumber) PREV_q, coalesce(sum(amount), 0) PREVsales from payments where year(paymentDate) = 2003 group by 1 order by 1) t1
left OUTER join
(select customerNumber, year(paymentDate) CURRyear, count(checkNumber) CURR_q, coalesce(sum(amount), 0) CURRsales from payments where year(paymentDate) = 2004 group by 1 order by 1) t2
on t1.customerNumber = t2.customerNumber;

select
case when year(paymentDate) = 2005 then '2005' when year(paymentDate) = 2004 then '2004' end as a,
customerNumber, count(checkNumber)
from payments where year(paymentDate) in (2004,2005) group by a;






