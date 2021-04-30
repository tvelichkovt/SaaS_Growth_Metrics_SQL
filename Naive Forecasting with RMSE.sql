# Naive Forecasting with RMSE
	# "distance per dollar" = (distance_to_travel/monetary_cost)
		# aggregate 'distance per dollar' values at a monthly level
			# populate the forecasted value for each month
				# calculate the error matrix called root mean squared error (RMSE)
					# RMSE is defined as sqrt(mean(square(actual - forecast)) ,rounded to the 2nd decimal spot
                    
select * from uber_request_logs;

select *, distance_to_travel/monetary_cost dpd from uber_request_logs;

select month(request_date) mo, sum(distance_to_travel/monetary_cost) dpd from uber_request_logs group by 1 order by 1;

#dpd = actual , prev_dpd = forecast

with
cte1 as(select month(request_date) mo, sum(distance_to_travel/monetary_cost) actual from uber_request_logs group by 1 order by 1),
cte2 as(select *, lag(actual) over (order by mo) forecast from cte1)
select *, sqrt(avg(power((actual - forecast), 2))) RMSE from cte2 group by 1 order by 1;

# Mean Absolute Error(MAE)
	# Mean Absolute Percentage Error(MAPE)

        
with
cte1 as(select month(request_date) mo, sum(distance_to_travel/monetary_cost) actual from uber_request_logs group by 1 order by 1),
cte2 as(select *, lag(actual) over (order by mo) forecast from cte1)
select *, 

sqrt(avg(power((actual - forecast), 2))) RMSE,
avg(abs((actual - forecast))) MAE,
avg(abs(actual - forecast) / abs(actual)) * 100 MAPE

from cte2 group by 1 order by 1;
