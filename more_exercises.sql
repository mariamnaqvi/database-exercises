/* 1. How much do the current managers of each department get paid, relative to the average salary for the department? 
Is there any department where the department manager gets paid less than the average salary? */

-- select the db
USE employees;

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
SELECT Round(AVG(salary),2) AS avg_sal, dept_no
FROM salaries s
JOIN dept_emp de ON de.emp_no = s.emp_no
AND de.to_date > now()
WHERE s.to_date > now()
GROUP BY dept_no;

-- find the current salary for current managers
SELECT t1.dept_no, t1.manager_salary, t2.avg_salary FROM 
(SELECT dm.emp_no, dept_no, salary AS manager_salary
FROM dept_manager dm
JOIN salaries s ON s.emp_no = dm.emp_no
AND s.to_date > now()
WHERE dm.to_date > now()) AS t1
JOIN 
(SELECT Round(AVG(salary),2) AS avg_salary, dept_no
FROM salaries s
JOIN dept_emp de ON de.emp_no = s.emp_no
AND de.to_date > now()
WHERE s.to_date > now()
GROUP BY dept_no) AS t2
ON t1.dept_no = t2.dept_no;

/*
"dept_no"|"manager_salary"|"avg_salary"
"d001"   |106491          |80058.85
"d002"   |83457           |78559.94
"d003"   |65400           |63921.90
"d004"   |56654           |67843.30
"d005"   |74510           |67657.92
"d006"   |72876           |65441.99
"d007"   |101987          |88852.97
"d008"   |79393           |67913.37
"d009"   |58745           |67285.23
*/


-- 2. World Database
-- Use the world database for the questions below.
USE world;

-- exploring the tables in world db
SELECT ID, NAME
FROM city
WHERE NAME = 'Santa Monica';

SELECT CODE, NAME
FROM country
WHERE NAME LIKE 'United%';

-- What languages are spoken in Santa Monica?
SELECT LANGUAGE AS languages_spoken_in_SantaMonica
FROM countrylanguage co
JOIN city c ON c.countrycode = co.countrycode
AND NAME = 'Santa Monica'
WHERE co.countryCODE = 'USA';

/*
"languages_spoken_in_SantaMonica"|"percentage"
"Portuguese"                     |0.2
"Vietnamese"                     |0.2
"Japanese"                       |0.2
"Korean"                         |0.3
"Polish"                         |0.3
"Tagalog"                        |0.4
"Italian"                        |0.6
"Chinese"                        |0.6
"French"                         |0.7
"German"                         |0.7
"Spanish"                        |7.5
"English"                        |86.2
*/


