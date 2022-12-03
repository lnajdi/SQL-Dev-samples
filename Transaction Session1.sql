show user

drop table copy_employees;
create table copy_employees 
as select * from employees;

drop table copy_departments;
create table copy_departments 
as select * from departments;

drop public SYNONYM copy_emp;

create public SYNONYM copy_emp 
for lotfi.copy_employees;

create public SYNONYM copy_dep 
for lotfi.copy_departments;

desc copy_dep;

SELECT * FROM copy_emp 
WHERE employee_id IN (102 ,101);

--515.123.4568

UPDATE copy_employees 
SET phone_number  = '515.124.4242' 
WHERE employee_id =101;

SELECT first_name , phone_number
 FROM copy_emp 
WHERE employee_id = 101;



SELECT last_name 
 FROM copy_emp 
WHERE employee_id = 102;

UPDATE copy_employees 
SET last_name  = 'Haan' 
WHERE employee_id = 102;


SELECT last_name 
 FROM copy_emp 
WHERE employee_id = 102;

commit ;


update copy_emp
set salary = salary + 2000;

select  count(*) 
from copy_emp;

rollback ;


select * from copy_dep 
where  department_id = 280;

INSERT INTO copy_dep
(department_id  , department_name ,  manager_id , location_id) 
VALUES (280, 'department1', 202, 1700);

select * from copy_dep
where  department_id = 280;

SAVEPOINT A; 

UPDATE copy_dep
set department_name = 'RD' 
where department_id = 280;

SAVEPOINT B; 

SELECT * from copy_dep 
where  department_id = 80 ;
delete  from copy_dep 
where department_id = 80;

SELECT * from copy_dep
where  department_id IN (280,80) ;

ROLLBACK;
SELECT * from copy_dep
where  department_id IN (280,80) ;

rollback to SAVEPOINT B ;
SELECT * from copy_dep
where  department_id IN (280,80) ;

rollback to SAVEPOINT A;
SELECT * from copy_dep
where  department_id IN (280,80) ;


commit;





