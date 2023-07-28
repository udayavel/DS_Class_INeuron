/*
multiline comment
*/

-- single line comment

/*
Data Type
Character - CHAR(5), VARCHAR(100), TEXT, BLOB
NUMERIC - INT, DECIMAL(5,2), FLOAT, DOUBLE
"NYC  " => CHAR
"NYC" =>VARCHAR
*/

SHOW character SET; -- SQL Supported Character SET (Default value is latin1)

SHOW DATABASES;

CREATE database logicfirst;

DROP database logicfirst;
drop schema logicfirst;

drop schema if exists logicfirst;

use sys;

use logicfirst;

show tables;

CREATE TABLE student(
id int primary key,
name VARCHAR(30),
gpa DECIMAL(3,2)
);

describe student;
drop table student;

alter table student add column department VARCHAR(10);
alter table student drop column department;

insert into student values(1,'Udayavel',7.5);
insert into student values(2,'Velu',7.8);
insert into student values(3,'velan',8.5);

select * from student;

insert into student values(4,'velan',8.5),(5,'vel',8.7),(6,'veli',8.5);

insert into student(id,name) values(7,"noby");

select id,name from student;

-- employee table creation

create table employee(
emp_id int primary key,
ename varchar(30),
job_desc varchar(20),
salary int
);

INSERT INTO employee VALUES(1,'Ram','ADMIN',1000000);
INSERT INTO employee VALUES(2,'Harini','MANAGER',2500000);
INSERT INTO employee VALUES(3,'George','SALES',2000000);
INSERT INTO employee VALUES(4,'Ramya','SALES',1300000);
INSERT INTO employee VALUES(5,'Meena','HR',2000000);
INSERT INTO employee VALUES(6,'Ashok','MANAGER',3000000);
INSERT INTO employee VALUES(7,'Abdul','HR',2000000);
INSERT INTO employee VALUES(8,'Ramya','ENGINEER',1000000);
INSERT INTO employee VALUES(9,'Raghu','CEO',8000000);
INSERT INTO employee VALUES(10,'Arvind','MANAGER',2800000);
INSERT INTO employee VALUES(11,'Akshay','ENGINEER',1000000);
INSERT INTO employee VALUES(12,'John','ADMIN',2200000);
INSERT INTO employee VALUES(13,'Abinaya','ENGINEER',2100000);

select * from employee;

select * from employee where job_desc="MANAGER";

select ename from employee where job_desc<>"MANAGER";

select * from employee where salary>2500000 and job_desc="MANAGER";

select * from employee where job_desc="HR" or job_desc="SALES";

select * from employee where job_desc in ("HR","SALES");

select * from employee where job_desc not in ("HR","SALES");

select * from employee where salary between 2000000 and 25000000;

select * from employee limit 5;

-- LIKE
-- WILDCARDS % (ZERO OR MORE CHAR)
--  _ (ONE CHARACTER)

select * from employee where ename like 'A%';
select * from employee where ename not like 'A%';
select * from employee where ename like 'A%A';
select * from employee where ename like '%I%';
select * from employee where ename like '__I%';

-- ESCAPE CHARACTER (\)

select * from employee where ename like '__I\%';

-- UPDATE

SET SQL_SAFE_UPDATES = 0;

UPDATE employee set job_desc='ANALYST' where job_desc="ENGINEER";

UPDATE employee set job_desc='ANALYST',salary=2000000 where job_desc="ANALYST";

delete from employee where emp_id=12;

--- DISTINCT AND ORDER BY

select distinct job_desc from employee;

select * from employee order by ename;

select * from employee order by salary desc;

select * from employee order by salary,ename;

select * from employee where job_desc='MANAGER' order by salary;

select * from employee order by job_desc;

-- CUSTOM ORDER BY

select * from employee order by(CASE job_desc
when 'CEO' then 1
when 'MANAGER' then 2
when 'HR' then 3
when 'ANALYST' then 4
when 'SALES' then 5
else 100 end
),ename;

-- FUNCTIONS - performs a specific task

select * from employee;

-- AGGREGATE FUNCTIONS
select count(*) total from employee;

select count(*) total_managers from employee where job_desc='MANAGER';

select avg(salary) avg_salary from employee where job_desc='MANAGER';

select sum(salary) sum_of_salary from employee where job_desc='ANALYST';

select max(salary) max_salary from employee;

select min(salary) min_salary from employee;

-- STRING FUNCTION

select ucase(ename)name,salary from employee;  -- name as alias

select ename,char_length(ename)name_length from employee;

select ename,concat('Rs.',salary)salary from employee;

select ename,concat('Rs.',format(salary,2))salary from employee;

select ename,left(job_desc,3) from employee;

-- DATE AND DATE FUNCTIONS
alter table employee add column hire_date date;

select * from employee;

update employee set hire_date="2014-07-05";

update employee set hire_date="2015-08-06" where job_desc="ANALYST";

-- DATETIME FUNCTION

select now();
select date(now());
select curdate();
select date_format(curdate(),"%d-%m-%Y") as date;
select datediff("2023/12/01",curdate()) as marriage;

select date_add(curdate(),interval 1 day) as days;
select date_add(curdate(),interval 1 week) as week;
select date_add(curdate(),interval 1 month) as month;
select date_add(curdate(),interval 1 year) as year;

-- GROUP BY

select * from employee order by job_desc;

select job_desc,avg(salary) from employee group by job_desc;

select job_desc,count(emp_id) from employee group by job_desc;

select * from employee;

-- group by on another group by

select job_desc,count(emp_id) 
from employee 
group by job_desc
having count(emp_id)>1;

-- where filters rows
-- having filters group

select job_desc,count(emp_id) 
from employee
where salary>1500000
group by job_desc
having count(emp_id)>1
order by job_desc;





















