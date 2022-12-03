
create or replace VIEW view_emp_sal_max
  as   
SELECT e.last_name, e.salary, e.department_id, d.maxsal
FROM employees e,
        (SELECT department_id, max(salary) maxsal
        FROM employees
        GROUP BY department_id) d
WHERE e.department_id= d.department_id
AND e.salary= d.maxsal;


select * from view_emp_sal_max ;

select * from user_views;

select view_name ,text from user_views;
--drop view EMP_DETAILS_VIEW;

DESCRIBE employees;
desc view_emp_sal_max;


select table_name from user_tables
where table_name like '%EMPL%';

drop table copy_employees;
create table copy_employees as select * from employees;

desc copy_employees;

select count(*) from copy_employees;


CREATE OR replace VIEW view_dept50
AS SELECT department_id, employee_id, 
        first_name, last_name, salary
    FROM copy_employees
    WHERE department_id= 50;


select employee_id , department_id 
from  view_dept50 where employee_id = 124;

select count(*) from view_dept50;

UPDATE view_dept50
SET department_id= 90
WHERE employee_id= 124;



CREATE OR replace VIEW view_dept50
AS SELECT department_id, employee_id, 
        first_name, last_name, salary
    FROM copy_employees
    WHERE department_id= 50
with check option CONSTRAINT con_view_dept50 ;


select employee_id , department_id 
from  view_dept50 where employee_id = 124;

UPDATE view_dept50
SET department_id= 90
WHERE employee_id= 124;


select * from user_constraints
where constraint_name = upper('con_view_dept50');

desc employees;
select * from user_tables 
where table_name = 'EMPLOYEES';



create view view_city_salary_report
as
select city, max(salary) max_sal ,
        min(salary) min_sal , 
        sum(salary) sum_sal
from employees emp  
left JOIN departments dep on emp.department_id = dep.department_id
left join locations loc on dep.location_id = loc.location_id
 group by city;


--Solution one 
SELECT e.last_name,e.department_id,
        e.salary ,dep.avgSalDep,job.avgSalJob
FROM employees e,
            (SELECT department_id, round(avg(salary),2)  avgSalDep
        FROM employees
        GROUP BY department_id) dep ,
        (SELECT job_id, round(avg(salary),2)  avgSalJob
        FROM employees
        GROUP BY job_id) job
WHERE e.department_id= dep.department_id
and e.job_id= job.job_id;


--Second Solution  usign analytical functions
SELECT last_name,first_name, salary,
    avg(salary) over(partition by department_id) as avgsal_dep ,
    avg(salary) over(partition by job_id) as avgsal_job    
FROM employees 