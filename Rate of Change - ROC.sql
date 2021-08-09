use classicmodels;

with t1 as(select year(paymentDate) as YR, sum(amount) CASH from payments group by YR order by YR),
t2 as(select YR, CASH, lag(CASH) over (order by(YR)) CASH_PRV from t1),
t3 as(select YR, CASH, ifnull(CASH_PRV,0) CASH_PRV, ifnull((CASH-CASH_PRV) / CASH_PRV * 100 ,0) ROC from t2)
select YR, ROC from t3;
