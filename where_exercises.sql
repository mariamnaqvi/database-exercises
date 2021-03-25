-- 1. Create a file named where_exercises.sql. Make sure to use the employees database.
USE employees;

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT * FROM employees

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya','Maya')

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
SELECT first_name
FROM employees
WHERE first_name = 'Irena' 
	OR first_name = 'Vidya' 
	OR first_name = 'Maya'
-- returns 709 records, like q2 above


-- 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned. (returns 441 records)
SELECT first_name, gender
FROM employees
WHERE (first_name ='Irena' OR first_name = 'Vidya' OR first_name ='Maya')
	AND gender = 'M'


-- 5.Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.(returns 7330 rows)
SELECT LAST_NAME
FROM employees
WHERE last_name LIKE 'E%'

-- 6. Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E? (returns 24292 rows and 23393 rows that end with e but not start)
SELECT last_name
FROM employees
WHERE last_name LIKE '%E' OR 'E%'

SELECT last_name
FROM employees
WHERE last_name LIKE '%E' 
AND last_name NOT LIKE 'E%'

-- 7. Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E? (returns 899 rows, 24292 rows)
SELECT last_name
FROM employees
WHERE last_name LIKE '%E' 
AND last_name LIKE'E%'

SELECT last_name
FROM employees
WHERE last_name LIKE '%E'


-- 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned. (returns 135214 rows)
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '199%'

-- 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned. (returns 842 rows)
SELECT first_name, 
	last_name, 
	birth_date
FROM employees
WHERE birth_date LIKE '%12-25'

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned. (returns 362 rows)
SELECT first_name, 
	last_name, 
	hire_date, 
	birth_date
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25'

-- 11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned. (returns 1873 rows)
SELECT last_name, 
	emp_no
FROM employees
WHERE last_name LIKE '%q%'

-- 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found? (returns 547 rows)
SELECT DISTINCT last_name, 
	emp_no
FROM employees
WHERE last_name LIKE '%q%' 
AND last_name NOT LIKE '%qu%'