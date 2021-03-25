USE employees;

--2. 
SELECT DISTINCT last_name 
FROM employees
ORDER BY last_name desc
LIMIT 10;
-- zykh and zongker

-- 3.
SELECT first_name, last_name, hire_date, birth_date
FROM employees
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%12-25'
ORDER BY hire_date 
LIMIT 5;
-- alselm cappello, utz mandell, bouchange scheiter, baocal kushner, petter stroutsrup

-- 4. SELECT *
FROM employees
LIMIT 5 OFFSET 45;
-- limit * page number = offset
-- The offset is where the new page starts. Page 10 will return values 46-50
-- The last page, the 10th page, would be the last segment of 5 in the total of 50 rows
