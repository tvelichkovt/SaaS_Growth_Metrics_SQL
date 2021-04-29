use classicmodels;
select * from payments;

# Find dense_rank, row_number and rank from payments

select payments.*, 
dense_rank() over (order by customerNumber) a, 
row_number() over (order by customerNumber) b,
rank() over (order by customerNumber) c
from payments;