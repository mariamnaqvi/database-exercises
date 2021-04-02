--  1. Find all the current employees with the same hire date as employee 101010 using a sub-query. 
SELECT 
    first_name, 
    last_name, 
    hire_date
FROM employees e
JOIN salaries USING(emp_no)
WHERE hire_date IN 
    (SELECT hire_date 
    FROM employees 
    WHERE emp_no = 101010)
AND to_date > now();
-- returns 55 records

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

-- or do this to group by title
SELECT title, count(title) AS num_of_employees
FROM titles
WHERE emp_no IN (
    SELECT emp_no 
    FROM employees
    WHERE first_name = 'Aamod'
)
AND to_date LIKE '9999%'
GROUP BY title; 
-- returns 168 employees with 6 titles


-- ray solution
SELECT
      t.title AS 'Titles Held by Aamods',
      COUNT(t.title) AS 'Total Aamods Who Held Title'
FROM titles AS t
WHERE
      t.emp_no IN
      (
            SELECT
                  e.emp_no
            FROM employees AS e
            JOIN salaries AS s
                  ON e.emp_no = s.emp_no
                        AND s.to_date > CURDATE()
            WHERE
                first_name LIKE 'Aamod'
      )
GROUP BY
      t.title -- 251 rows

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. 
SELECT count(*) AS number_of_employees
FROM employees 
WHERE emp_no NOT IN (
SELECT emp_no
FROM salaries
WHERE to_date > now()
);
--  returns 59900 employees

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

-- using only subqueries
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
SELECT emp_no
FROM salaries
WHERE salary >= 
    (SELECT avg(salary)
    FROM salaries)
AND to_date > now()
);
--  returns 154543 rows

-- using join and subquery
SELECT emp_no, first_name, last_name, salary  
FROM employees e
JOIN salaries s USING(emp_no)
WHERE salary > (SELECT AVG(salary)
FROM salaries)
AND to_date > now();
-- returns 154543 rows

/* 6. How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this? */
-- to find max salary
SELECT count(salary) AS number_of_salaries
FROM salaries 
WHERE to_date > now()
AND salary >= 
    (SELECT max(salary) - stddev(salary)
    FROM salaries
    where to_date>curdate());
-- returns 83 salaries

--  to find the percentage of all salaries
SELECT 
(SELECT count(salary) 
FROM salaries 
WHERE to_date > now()
AND salary >= 
    (SELECT max(salary) - stddev(salary)
    FROM salaries
    WHERE to_date>curdate()))
    /
(SELECT count(salary)
    FROM salaries 
    WHERE to_date > now()
    ) * 100 AS percent_of_salaries;
-- returns 0.0346%

--  bonus questions
-- 1. Find all the department names that currently have female managers.
SELECT dept_name 
FROM departments d
JOIN dept_manager dm ON dm.dept_no = d.dept_no
WHERE emp_no IN 
(SELECT emp_no 
FROM employees
WHERE gender = 'F')
AND to_date > now();
--  returns 4 department names: Finance, Human Resources, Development. Research

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