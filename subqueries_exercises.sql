--  1. Find all the current employees with the same hire date as employee 101010 using a sub-query. 
SELECT first_name, last_name, hire_date
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no 
WHERE hire_date IN (SELECT hire_date
FROM employees e
WHERE emp_no = 101010) AND to_date LIKE '9999%';
-- returns 55 rows


--  2. Find all the titles ever held by all current employees with the first name Aamod. 
SELECT title 
FROM titles
WHERE emp_no IN (
SELECT emp_no 
FROM employees
WHERE first_name = 'Aamod'
)
AND to_date LIKE '9999%';
--  returns 168 rows


-- or do this returns 6 titles
SELECT title
FROM titles
WHERE emp_no IN (
SELECT emp_no 
FROM employees
WHERE first_name = 'Aamod'
)
AND to_date LIKE '9999%'
GROUP BY title;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. 
SELECT count(emp_no)
FROM employees
WHERE emp_no IN (
SELECT emp_no
FROM dept_emp
WHERE to_date NOT LIKE '9999%'
);
--  85108 employees

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
SELECT emp_no 
FROM dept_manager
WHERE to_date > now()
) AND gender = 'F';
-- Isamu	Legleitner
-- Karsten	Sigstam
-- Leon	DasSarma
-- Hilary	Kambil

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
SELECT emp_no
FROM salaries
WHERE salary >= (SELECT avg(salary)
FROM salaries)
AND to_date > now()
);

--  returns 154543 rows


/* 6. How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this? */
-- to find max salary
SELECT max(salary)
FROM salaries
WHERE to_date > now();
-- 158220 is the current highest

--  bonus questions
-- 1. Find all the department names that currently have female managers.
SELECT distinct dept_name
FROM departments d
JOIN dept_emp de ON de.dept_no =d.dept_no
WHERE emp_no IN (SELECT emp_no 
FROM employees
WHERE gender = 'F')
AND to_date > now();
--  returns 9 rows

-- 2. Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN ( 
SELECT emp_no
FROM salaries
WHERE salary >= (SELECT max(salary)
FROM salaries));
-- returns Tokuyasu Pesch

--  3. Find the department name that the employee with the highest salary works in.
SELECT dept_name 
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE de.emp_no IN ( 
SELECT emp_no
FROM salaries
WHERE salary >= (SELECT max(salary)
FROM salaries));
-- returns department name Sales