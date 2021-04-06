/*1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. */

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

-- simpler solution 
SELECT emp_no, group_concat(dept_no, ' ') AS department_number , min(from_date) AS start_date , max(to_date) AS end_date,
max(IF(to_date > now(), 1, 0 )) AS is_current_employee
FROM dept_emp
GROUP BY emp_no;
-- returns 300024 rows with no repeating emp_no

/* 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
depending on the first letter of their last name. */
SELECT concat(first_name, ' ', last_name) AS employee_name,
CASE 
WHEN last_name BETWEEN 'A' AND 'I' THEN 'A-H'
WHEN last_name BETWEEN 'I' AND 'R' THEN 'I-Q'
else 'R-Z'
END AS alpha_group
FROM employees;
-- returns 300024 rows

-- 3. How many employees (current or previous) were born in each decade?
SELECT count(*),
CASE 
WHEN birth_date LIKE '195%' THEN 'born_in_50s'
WHEN birth_date LIKE '196%' THEN 'born_in_60s'
END AS decades
FROM employees
GROUP BY decades;
/* returns 182886	born_in_50s
117138	born_in_60s  */

-- bonus
-- 1. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT CASE
WHEN dept_name IN ('Research','Development') THEN 'R&D'
WHEN dept_name IN ('Sales','Marketing') THEN 'Sales & Marketing'
WHEN dept_name IN ('Production','Quality Management') THEN 'Prod & QM'
WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
ELSE 'Customer Service'
END AS dept_group,
AVG(salary) AS avg_salary
FROM salaries s
JOIN dept_emp de ON s.emp_no = de.emp_no 
	AND de.to_date > curdate()
JOIN departments USING (dept_no)
WHERE s.to_date > curdate()
GROUP BY dept_group;
/* returns Customer Service	67285.2302
Finance & HR	71107.7403
Prod & QM	67328.4982
R&D	67709.2620
Sales & Marketing	86368.8643 */