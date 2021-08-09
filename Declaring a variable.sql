use classicmodels;

select * from products;

SELECT 
    @msrp:=MAX(msrp)
FROM
    products;
    
select @msrp;

select * from products
where msrp=@msrp;
