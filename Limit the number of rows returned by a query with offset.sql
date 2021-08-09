use classicmodels;
select * from products;

select * from products limit 3;#S10_1678, S10_1949, S10_2016
select * from products limit 2; #S10_1678, S10_1949
select * from products limit 2 offset 1; #S10_1949, S10_2016
select * from products limit 3 offset 1; #S10_1949, S10_2016, S10_4698


