-- 1.
USE join_example_db;

SELECT *
FROM users;

select *
from roles;

-- returns 6 rows, includes nulls

-- 2. 

SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;
-- inner join 
-- returns 4 rows, no nulls

SELECT *
FROM users
left JOIN roles ON users.role_id = roles.id;


SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;
-- returns 5 rows
--  everythign from the roles table and only common parts from the users tables

SELECT *
FROM roles
RIGHT JOIN users ON users.role_id = roles.id;
-- returns 6 rows
-- returns everything from the users table and only common from the roles table

SELECT *
FROM roles
left JOIN users ON users.role_id = roles.id;
--  returns 5 rows
-- returns everything from roles and only common from users


/* 3. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. */
SELECT roles.name AS roles, count(users.role_id) AS users
FROM roles
LEFT JOIN users ON users.role_id = roles.id
GROUP BY roles;

-- from employees db

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

/*  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang   */

SELECT dept_name AS 'Department Name',
CONCAT(first_name, ' ', e.last_name) AS 'Department Manager'
 FROM employees AS e
JOIN dept_manager AS de
  ON de.emp_no = e.emp_no
 JOIN departments AS d
  ON d.dept_no = de.dept_no 
WHERE de.to_date LIKE '9999%'
ORDER BY dept_name;

-- or using the below query:

select dept_name AS 'Department Name', concat(first_name," ", last_name) AS "Department Manager"
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date LIKE '999%'
ORDER BY dept_name;

-- 3. Find the name of all departments currently managed by women.

/* Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil   */

SELECT d.dept_name AS 'Department Name',
CONCAT(first_name, ' ', last_name) AS 'Manager Name'
 FROM employees AS e
JOIN dept_manager AS de
  ON de.emp_no = e.emp_no
 JOIN departments AS d
  ON d.dept_no = de.dept_no 
WHERE de.to_date LIKE '9999%' AND e.gender = 'F'
ORDER BY d.dept_name;




-- 4. Find the current titles of employees currently working in the Customer Service department.

/* Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241  */

SELECT title, count(*)
FROM titles t
JOIN employees e ON t.emp_no = e.emp_no
JOIN dept_emp de ON de.emp_no = e.emp_no
WHERE de.dept_no = 'd009' AND t.to_date LIKE '9999%'
GROUP BY title;


-- 5. Find the current salary of all current managers.

/* Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987   */

SELECT dept_name AS 'Department Name',
CONCAT(first_name, ' ', e.last_name) AS 'Department Manager', salary
 FROM employees AS e
JOIN dept_manager AS de
  ON de.emp_no = e.emp_no
 JOIN departments AS d
  ON d.dept_no = de.dept_no 
  JOIN salaries s 
  ON s.emp_no = e.emp_no
WHERE de.to_date LIKE '9999%'
AND s.to_date LIKE '9999%'
ORDER BY dept_name;


-- 6. Find the number of current employees in each department.

/* +---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+  */

SELECT de.dept_no, dept_name, count(e.emp_no) AS num_employees
FROM dept_emp de
JOIN departments d ON de.dept_no = d.dept_no
JOIN employees e ON de.emp_no = e.emp_no
WHERE de.to_date LIKE '9999%'
GROUP BY d.dept_name
order by d.dept_no;



-- 7. Which department has the highest average salary? Hint: Use current not historic information.

/* +-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+  */

SELECT dept_name, AVG(salary) AS average_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON s.emp_no = de.emp_no
WHERE s.to_date LIKE '9999%' AND de.to_date LIKE '9999%' 
GROUP BY dept_name
ORDER BY average_salary desc
LIMIT 1;



-- 8. Who is the highest paid employee in the Marketing department?

/* +------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+  */

SELECT first_name, last_name
FROM employees e
JOIN  salaries s ON s.emp_no = e.emp_no
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON d.dept_no = de.dept_no
WHERE d.dept_no = 'd001'
ORDER BY salary DESC
LIMIT 1;
 

-- 9. Which current department manager has the highest salary?

/* +------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+  */

SELECT first_name, last_name, salary, dept_name
FROM employees e
JOIN salaries s ON s.emp_no = e.emp_no
	AND s.to_date > now()
JOIN dept_manager dm ON dm.emp_no = e.emp_no
	AND dm.to_date > now()
JOIN departments d ON d.dept_no = dm.dept_no
ORDER BY salary desc
LIMIT 1;


-- 10. Find the names of all current employees, their department name, and their current manager's name.
