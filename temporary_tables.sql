/* 1. Using the example from the lesson, create the employees_with_departments table. */
-- check ryan's code

CREATE TEMPORARY TABLE employees_with_departments (
emp_no INT UNSIGNED,
first_name VARCHAR (20),
last_name VARCHAR (20),
dept_no VARCHAR (20),
dept_name VARCHAR (20)
);

--  Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(40);


-- Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, " ", last_name);

-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;


-- What is another way you could have ended up with this same table? */
-- by not including first and last name columns when creating the table
-- use select with concat to create the full name

--  2. Create a temporary table based on the payment table from the sakila database.

-- clea up any old version of the table if it already exists
drop table if exists payments

CREATE TEMPORARY TABLE payment_from_sakiladb AS
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM sakila.payment;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199. 
ALTER TABLE payment_from_sakiladb MODIFY amount DECIMAL(6,2) -- so row 44 wont fail

UPDATE payment_from_sakiladb
SET amount = amount * 100;

ALTER TABLE payment_from_sakiladb MODIFY amount INT;


/* 3. Find out how the current average pay in each department compares to the overall, historical average pay. 
In order to make the comparison easier, you should use the Z-score for salaries. 
In terms of salary, what is the best department right now to work for? The worst? */

-- z score measures how many std deviations away a given observation is from the population mean
-- calculate z score = salary - average / stddev
-- numerator of zscore is also called de-meaned version
-- to get salary
SELECT salary
FROM employees.salaries;

-- to get avg salary
select avg(salary)
from employees.salaries;
-- historic avg is 63810.7448

-- to get std dev
select stddev(salary)
from employees.salaries;
-- or to get std dev
select std(salary)
from employees.salaries;

-- to get z score
SELECT (((salary) - (SELECT AVG(salary)
FROM employees.salaries)) / (SELECT stddev(salary)
FROM employees.salaries)) AS z_score
FROM employees.salaries;

--  to create the temp table
CREATE TEMPORARY TABLE z_scores AS (
SELECT s.emp_no, d.dept_name, (((salary) - (SELECT AVG(salary)
FROM employees.salaries)) / (SELECT stddev(salary)
FROM employees.salaries)) AS z_score
FROM employees.salaries s
JOIN employees.dept_emp de ON de.emp_no = s.emp_no
JOIN employees.departments d ON d.dept_no = de.dept_no
where employees.dept_emp.to_date > curdate()
GROUP BY dept_name);

-- to find best and worst departments based on z score of salaries
SELECT dept_name, format(AVG(z_score), 6) AS salary_z_score
FROM z_scores
GROUP BY dept_name;
-- best dept based on salary is Sales with the highest z score of 0.997163     ryan's z score was 1.45
-- worst dept based on salary is Customer Serice with the lowest z score of -0.298162    hr had a zscore of .01
