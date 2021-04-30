# Root Mean Squared Error (RMSE)
	# Mean Absolute Error(MAE)
		# Mean Absolute Percentage Error(MAPE)
                    
use classicmodels;
select * from payments;
select year(paymentDate), month(paymentDate), sum(amount) from payments group by 1, 2 order by 1, 2;

with
cte1 as(select year(paymentDate) YR, month(paymentDate) MO, sum(amount) ACTUAL from payments group by 1, 2 order by 1, 2),
cte2 as(select cte1.*, lag(actual) over (order by YR, MO) forecast from cte1 group by 1, 2 order by 1, 2)
select cte2.*, 

sqrt(avg(power((actual - forecast), 2))) RMSE,
avg(abs((actual - forecast))) MAE,
avg(abs(actual - forecast) / abs(actual)) * 100 MAPE

from cte2 
group by 1, 2 
order by 1, 2;