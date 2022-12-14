drop SEQUENCE RUNNER_ID_SEQ;
drop table  runners;

CREATE TABLE runners (runner_id NUMBER(6,0) CONSTRAINT runners_id_pk PRIMARY KEY,
first_name VARCHAR2(30),last_name VARCHAR2(30));

CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NOCACHE
NOCYCLE;

select * from user_sequences 
where sequence_name ='RUNNER_ID_SEQ';



SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences
where sequence_name = 'RUNNER_ID_SEQ';

INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (runner_id_seq.NEXTVAL, 'Joanne', 'Everely');

select * from runners ;

SELECT RUNNER_ID_SEQ.currval from dual; 
select 70+30 from dual ;

INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (runner_id_seq.NEXTVAL, 'Adam', 'Curtis');

SELECT RUNNER_ID_SEQ.nextval from dual; 
SELECT RUNNER_ID_SEQ.currval from dual; 

INSERT INTO departments
(department_id, department_name, location_id)
VALUES (departments_seq.NEXTVAL, 'Support2', 2500);

select departments_seq.currval from dual;

delete from departments where department_id = 280;

desc user_objects;

drop table student;
CREATE TABLE student(
  id      NUMBER    GENERATED BY DEFAULT ON NULL AS IDENTITY,
  name   VARCHAR2(100) NOT NULL
);

SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;

insert INTO student (name) VALUES('student1');



SELECT ROWID, last_name  
   FROM employees
   WHERE department_id = 20;
