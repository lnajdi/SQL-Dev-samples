CREATE OR REPLACE TRIGGER SECURE_EMPLOYEES 
BEFORE INSERT ON employees
BEGIN
    IF ( to_char(sysdate, 'HH24:MI') NOT BETWEEN '10:00' AND '18:00' ) THEN
    raise_application_error(-20500,'You may insert into EMPLOYEES table only during normal business hours.');
END IF;
END;

/

desc user_triggers;
select * from user_triggers where trigger_name = upper('SECURE_EMPLOYEES');


--test secure_emlpoyee
SELECT to_char(sysdate, 'HH24:MI') from dual  ;

INSERT INTO employees (employee_id, last_name,  first_name, email, hire_date, job_id, salary, department_id)
VALUES (300, 'Smith', 'Rob', 'RSMITH', SYSDATE,  'IT_PROG', 4500, 60);


alter TRIGGER SECURE_EMPLOYEES disable; 
/

drop table audit_emp;
--statment level trigger demo 
    CREATE TABLE audit_emp ( user_name VARCHAR2(30), time_stamp DATE );
    
    select * from audit_emp;
    desc audit_emp;

CREATE OR REPLACE TRIGGER audit_employees
AFTER UPDATE ON employees for each row 
BEGIN
    INSERT INTO audit_emp(user_name, time_stamp)
    VALUES(USER, SYSDATE);
END;

/
select * from audit_emp ;
alter trigger audit_employees enable;
drop trigger RESTRICT_SALARY ;
/
update employees set salary = salary +  500 ;

select * from audit_emp ;





/

--Row lovel tigeer 
CREATE TABLE audit_emp2 ( user_name VARCHAR2(30), time_stamp DATE , 
		id NUMBER(6), 
        old_salary NUMBER(8,2), new_salary NUMBER(8,2) ,
        old_commission NUMBER(8,2), new_commission NUMBER(8,2));




/
CREATE OR REPLACE TRIGGER audit_employees
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
INSERT INTO audit_emp2(user_name, time_stamp, id, old_salary, new_salary,
    old_commission, new_commission)
VALUES (USER, SYSDATE, :OLD.employee_id , 
        :OLD.salary, :NEW.salary , 
        :OLD.commission_pct, :NEW.commission_pct);
END;

/

update employees set salary = salary +200
where job_id  = 'SA_REP';

select * from employees  where job_id  = 'SA_REP';
select * from audit_emp2;
drop table audit_emp;



--test audit_employess 
    --INSERT INTO employees (employee_id, last_name, job_id,  salary, email, hire_date)
	--VALUES (999, 'Temp emp', 'SA_REP', 6000, 'TEMPEMP',  TRUNC(SYSDATE));


select * from audit_emp ;
UPDATE employees
SET commission_pct = commission_pct * 1.1 
WHERE commission_pct is  not null ;
ROLLBACK;
SELECT * FROM audit_emp;

/

CREATE OR REPLACE TRIGGER RESTRICT_SALARY 
BEFORE INSERT OR UPDATE OF salary ON employees FOR EACH ROW
BEGIN
    IF  (:NEW.job_id IN ('AD_PRES', 'AD_VP')) AND :NEW.salary > 15000 THEN
    RAISE_APPLICATION_ERROR (-20202,'Employee cannot earn more than $15,000.'); 
    END IF;
END;
/

--test RESTRICT_SALARY 
select * from employees where job_id = 'AD_VP';
select first_name, last_name , job_id , salary from employees  where last_name = 'Kochhar';
UPDATE employees  SET salary = 17000 WHERE last_name = 'Kochhar';

/


--ON database trigger
-- définition de la table log_trig_table utilisée dans l’exemple 
CREATE TABLE log_trig_table( user_id VARCHAR2(30), log_date DATE, action VARCHAR2(40));

select * from log_trig_table;

--AFTER LOGON TRIGGER
CREATE OR REPLACE TRIGGER logon_trig AFTER LOGON
ONSCHEMA
BEGIN
INSERT INTO log_trig_table ( user_id, log_date, action)
VALUES ( user, sysdate,'Logging on' );
END;

--BEFORE LOGOFF TRIGGER
CREATE OR REPLACE TRIGGER logoff_trig BEFORE LOGOFF
ONSCHEMA
BEGIN
INSERT INTO log_trig_table ( user_id, log_date,action)
VALUES ( user, sysdate, 'Logging off' );
END;
/
select * from USER_TRIGGERS;


alter TRIGGER SECURE_EMPLOYEES DISABLE;

drop trigger SECURE_EMPLOYEES ;