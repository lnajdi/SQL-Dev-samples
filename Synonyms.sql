show user;

--Synonmy
select * from USER_SYNONYMS ;

desc copy_employees; 

CREATE SYNONYM cEmp
FOR copy_employees;

CREATE public SYNONYM Emp
FOR copy_employees;

drop SYNONYM cemp;

--A schema is a collection of database objects. 
--A schema is owned by a database user and has the same name as that user. 
--Schema objects are logical structures created by users. 
--Objects such as tables or indexes hold data, or can consist of a 
-- definition only,such as a view or synonym.
drop public SYNONYM emp;


desc emp;
desc cEmp;
select * from cemp;
select * from USER_SYNONYMS ;

select * from cemp;
select * from user_tables where table_name = 'COPY_EMPLOYEES';

drop SYNONYM cEmp;


CREATE public SYNONYM cEmp 
FOR copy_employees;

--drop public SYNONYM cemp;



