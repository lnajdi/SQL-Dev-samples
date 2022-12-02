show user;
create index upper_last_name_index 
on employees(upper(last_name)) ; 

select * from user_indexes
where table_name = 'EMPLOYEES'
and  index_name = upper('upper_last_name_index');

desc user_indexes;


select * from user_ind_columns 
where table_name = 'EMPLOYEES'
and  index_name = upper('upper_last_name_index');

