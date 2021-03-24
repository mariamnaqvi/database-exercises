-- Save your work in a file named tables_exercises.sql


-- Use the employees database
use employees;

-- check current db selected
select database();

-- List all the tables in the database
show tables;

-- Explore the employees table. What different data types are present on this table?
describe employees; -- data types of int, date, varchar, enum

-- Which table(s) do you think contain a numeric type column?
-- almost all tables

-- Which table(s) do you think contain a string type column?
-- current_dept_emp, employees

-- Which table(s) do you think contain a date type column?
-- current_dept_emp,dept_emp_latest_date,  employees, salaries


-- What is the relationship between the employees and the departments tables?
-- no relationship

-- Show the SQL that created the dept_manager table.
show create table dept_manager;