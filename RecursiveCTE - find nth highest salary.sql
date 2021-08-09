use tve1;

create TABLE emp (
  id         INT PRIMARY KEY NOT NULL,
  FirstName nvarchar(50),
     LastName nvarchar(50),
     Gender nvarchar(50),
     Salary int
);

Insert into emp values ('1', 'Ben', 'Hoskins', 'Male', 70000);
Insert into emp values ('2', 'Mark', 'Hastings', 'Male', 60000);
Insert into emp values ('3', 'Steve', 'Pound', 'Male', 45000);
Insert into emp values ('4', 'Ben', 'Hoskins', 'Male', 70000);
Insert into emp values ('5', 'Philip', 'Hastings', 'Male', 45000);
Insert into emp values ('6', 'Mary', 'Lambeth', 'Female', 30000);
Insert into emp values ('7', 'Valarie', 'Vikings', 'Female', 35000);
Insert into emp values ('8', 'John', 'Stanmore', 'Male', 80000);

select * from emp order by Salary desc;

select e.* from (select distinct Salary from emp order by Salary desc limit 2) t
join emp e on e.salary = t.salary
order by e.salary desc; 

use tve1;

	#1st three
select e.* from (select distinct Salary from emp order by Salary desc limit 3) t join emp e on e.salary=t.salary order by salary desc;

	#The 3d
select * from emp e1 where 3 = (select count(distinct salary) from emp e2 where e1.salary <= e2.salary);