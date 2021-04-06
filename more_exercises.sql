/* How much do the current managers of each department get paid, relative to the average salary for the department? 
Is there any department where the department manager gets paid less than the average salary? */

-- find current managers 
SELECT emp_no, dept_no
FROM dept_manager
WHERE to_date > now();

-- find the current salary for current managers
SELECT dm.emp_no, dept_no, salary
FROM dept_manager dm
JOIN salaries s ON s.emp_no = dm.emp_no
AND s.to_date > now()
WHERE dm.to_date > now();

-- find average salary per department
SELECT Round(AVG(salary),2) AS avg_sal,
CASE 
WHEN dept_no = 'd001' THEN 'd1_salary'
WHEN dept_no = 'd002' THEN 'd2_salary'
WHEN dept_no = 'd003' THEN 'd3_salary'
WHEN dept_no = 'd004' THEN 'd4_salary'
WHEN dept_no = 'd005' THEN 'd5_salary'
WHEN dept_no = 'd006' THEN 'd6_salary'
WHEN dept_no = 'd007' THEN 'd7_salary'
WHEN dept_no = 'd008' THEN 'd8_salary'
WHEN dept_no = 'd009' THEN 'd9_salary'
ELSE 'other'
END AS dept_no_salary
FROM salaries s
JOIN dept_emp de ON de.emp_no = s.emp_no
AND de.to_date > now()
WHERE s.to_date > now()
GROUP BY dept_no_salary;

-- Check current avg salary for d001 (returns 80058 same as above query)
SELECT AVG(salary)
FROM salaries s
JOIN dept_emp de ON de.emp_no = s.emp_no
AND de.to_date > now()
WHERE (dept_no = 'd001')
AND s.to_date > now();

-- create temp table that includes dept avg salary and dept manager's salary to compare