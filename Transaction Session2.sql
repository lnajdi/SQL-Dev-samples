show user

 drop public SYNONYM copy_emp;
 
 SELECT phone_number
 FROM copy_emp 
WHERE employee_id = 101;


SELECT last_name 
 FROM copy_emp 
WHERE employee_id = 102;


UPDATE copy_emp 
SET last_name  = 'Haadqdadaaadan' 
WHERE employee_id = 102;

--ROLLBACK ;

select * from copy_dep 
where  department_id = 280;

SELECT * from copy_dep
where  department_id IN (280,80) ;
