USE employees;

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title
FROM titles;
-- 7 unique titles

--  3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;
-- returns 5 rows

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name, first_name;
-- returns 846 rows

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' 
AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
-- returns 3 rows: Chleq, Lindqvist, Qiwen

-- 6. Add a COUNT() to your results (the query above) and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT last_name, count(last_name)
FROM employees
WHERE last_name LIKE '%q%' 
AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY count(last_name);
-- qiwen 168, chleq 189, lindq 190

/* 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. */
SELECT gender, first_name, count(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender, first_name;
-- returns 6 rows

/* 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. 
Are there any duplicate usernames? BONUS: How many duplicate usernames are there? */
SELECT
LOWER(
    CONCAT(
        SUBSTR(first_name,1,1), 
        SUBSTR(last_name,1,4), 
        '_', 
        SUBSTR(birth_date,6,2), 
        SUBSTR(birth_date,3, 2))) 
        AS username, count(*)
FROM employees
GROUP BY username
HAVING count(*) > 1; -- to find duplicates
-- 285,872 rows
-- yes, duplicate usernames
-- 13,251 duplicates
-- 272,621 uniques