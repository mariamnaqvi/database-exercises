-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' 
-- that is a 1 if the employee is still with the company and 0 if not.
SELECT emp_no, 
dept_no, hire_date 'start date', s.to_date 'end date', 
IF ((s.to_date AND de.to_date) LIKE '9999%', 1, 0) AS is_current_employee
FROM employees
JOIN dept_emp USING (emp_no)
JOIN salaries s USING (emp_no);

SELECT 
de.emp_no, 
dept_no, 
de.from_date, 
de.to_date,
CASE 
	WHEN de.to_date = '9999-01-01' THEN 1
	ELSE 0
END AS is_current_employee 
FROM dept_emp AS de
JOIN salaries ON de.emp_no = salaries.emp_no
AND salaries.to_date = '9999-01-01';

SELECT
	dept_emp.emp_no,
	dept_no,
	to_date,
	from_date,
	hire_date,
	IF(to_date = '9999-01-01', 1, 0) AS is_current_employee,
	IF(hire_date = from_date, 1, 0) AS only_one_dept
FROM dept_emp
JOIN (SELECT 
		emp_no,
		MAX(to_date) AS max_date
	FROM dept_emp
	GROUP BY emp_no) AS last_dept
ON dept_emp.emp_no = last_dept.emp_no
	AND dept_emp.to_date = last_dept.max_date
JOIN employees AS e ON e.emp_no = dept_emp.emp_no;

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
-- depending on the first letter of their last name.
SELECT concat(first_name, ' ', last_name) AS employee_name,
CASE 
WHEN last_name BETWEEN 'A' AND 'I' THEN 'A-H'
WHEN last_name BETWEEN 'I' AND 'R' THEN 'I-Q'
else 'R-Z'
END AS alpha_group
FROM employees;
-- returns 300024 rows

SELECT concat(first_name, ' ', last_name) AS employee_name,
CASE 
WHEN last_name BETWEEN 'A%' AND 'I%' THEN 'A-H'
WHEN last_name BETWEEN 'I%' AND 'R%' THEN 'I-Q'
else 'R-Z'
END AS alpha_group
FROM employees;



-- 3. How many employees (current or previous) were born in each decade?
SELECT count(*),
CASE 
WHEN birth_date LIKE '195%' THEN 'born_in_50s'
WHEN birth_date LIKE '196%' THEN 'born_in_60s'
END AS decades
FROM employees
GROUP BY decades;
--  returns 

-- bonus
-- 1. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT CASE
WHEN (dept_name = 'Research' OR dept_name = 'Development') THEN 'R&D'
WHEN (dept_name = 'Sales' OR dept_name = 'Marketing') THEN 'Sales & Marketing'
WHEN (dept_name = 'Production' OR dept_name = 'Quality Management') THEN 'Prod & QM'
WHEN (dept_name = 'Finance' OR dept_name = 'Human Resources') THEN 'Finance & HR'
ELSE 'Customer Service'
END AS Department_Group,
AVG(salary)
FROM salaries s
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE s.to_date > curdate()
GROUP BY Department_Group;
/* Customer Service	66971.3536
Finance & HR	71111.6674
Prod & QM	67315.3668
R&D	67718.5563
Sales & Marketing	86379.3407 */