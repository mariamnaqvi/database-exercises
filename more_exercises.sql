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


-- find the difference between the highest salaries found in the marketing and development departments

SELECT m_sal.salary - d_sal.salary2 'Salary Difference'
FROM 
-- getting max salary from marketing
(SELECT MAX(salary) AS salary
FROM salaries 
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE dept_name IN ('marketing')
GROUP BY dept_name) AS m_sal,
-- getting max salary from development
(SELECT MAX(salary) AS salary2 
FROM salaries 
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE dept_name IN ('development')
GROUP BY dept_name) AS d_sal;

+-----------+------------++-----------+------------++-----------+------------++-----------+------------++-----------+------------+

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

/* What languages are spoken in Santa Monica?
+-----------+------------+
| Language   | Percentage |
+------------+------------+
| Portuguese |        0.2 |
| Vietnamese |        0.2 |
| Japanese   |        0.2 |
| Korean     |        0.3 |
| Polish     |        0.3 |
| Tagalog    |        0.4 |
| Chinese    |        0.6 |
| Italian    |        0.6 |
| French     |        0.7 |
| German     |        0.7 |
| Spanish    |        7.5 |
| English    |       86.2 |
+------------+------------+
12 rows in set (0.01 sec)
*/

SELECT LANGUAGE AS languages_spoken_in_SantaMonica
FROM countrylanguage co
JOIN city c ON c.countrycode = co.countrycode
AND NAME = 'Santa Monica'
WHERE co.countryCODE = 'USA';

/* How many different countries are in each region?
+---------------------------+---------------+
| Region                    | num_countries |
+---------------------------+---------------+
| Micronesia/Caribbean      |             1 |
| British Islands           |             2 |
| Baltic Countries          |             3 |
| Antarctica                |             5 |
| North America             |             5 |
| Australia and New Zealand |             5 |
| Melanesia                 |             5 |
| Southern Africa           |             5 |
| Northern Africa           |             7 |
| Micronesia                |             7 |
| Nordic Countries          |             7 |
| Central America           |             8 |
| Eastern Asia              |             8 |
| Central Africa            |             9 |
| Western Europe            |             9 |
| Eastern Europe            |            10 |
| Polynesia                 |            10 |
| Southeast Asia            |            11 |
| Southern and Central Asia |            14 |
| South America             |            14 |
| Southern Europe           |            15 |
| Western Africa            |            17 |
| Middle East               |            18 |
| Eastern Africa            |            20 |
| Caribbean                 |            24 |
+---------------------------+---------------+
25 rows in set (0.00 sec) */

SELECT Region, count(NAME) AS num_countries
FROM country
GROUP BY region
ORDER BY num_countries;

/* What is the population for each region?

+---------------------------+------------+
| Region                    | population |
+---------------------------+------------+
| Eastern Asia              | 1507328000 |
| Southern and Central Asia | 1490776000 |
| Southeast Asia            |  518541000 |
| South America             |  345780000 |
| North America             |  309632000 |
| Eastern Europe            |  307026000 |
| Eastern Africa            |  246999000 |
| Western Africa            |  221672000 |
| Middle East               |  188380700 |
| Western Europe            |  183247600 |
| Northern Africa           |  173266000 |
| Southern Europe           |  144674200 |
| Central America           |  135221000 |
| Central Africa            |   95652000 |
| British Islands           |   63398500 |
| Southern Africa           |   46886000 |
| Caribbean                 |   38140000 |
| Nordic Countries          |   24166400 |
| Australia and New Zealand |   22753100 |
| Baltic Countries          |    7561900 |
| Melanesia                 |    6472000 |
| Polynesia                 |     633050 |
| Micronesia                |     543000 |
| Antarctica                |          0 |
| Micronesia/Caribbean      |          0 |
+---------------------------+------------+
25 rows in set (0.00 sec) */

SELECT Region, sum(population) AS population
FROM country
GROUP BY region
ORDER BY population DESC;

/* What is the population for each continent?
+---------------+------------+
| Continent     | population |
+---------------+------------+
| Asia          | 3705025700 |
| Africa        |  784475000 |
| Europe        |  730074600 |
| North America |  482993000 |
| South America |  345780000 |
| Oceania       |   30401150 |
| Antarctica    |          0 |
+---------------+------------+
7 rows in set (0.00 sec) */

SELECT Continent, sum(population) AS population
FROM country
GROUP BY Continent
ORDER BY population desc;

/* What is the average life expectancy globally?
+---------------------+
| avg(LifeExpectancy) |
+---------------------+
|            66.48604 |
+---------------------+
1 row in set (0.00 sec) */

SELECT AVG(LifeExpectancy)
FROM country;

/* What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
+---------------+-----------------+
| Continent     | life_expectancy |
+---------------+-----------------+
| Antarctica    |            NULL |
| Africa        |        52.57193 |
| Asia          |        67.44118 |
| Oceania       |        69.71500 |
| South America |        70.94615 |
| North America |        72.99189 |
| Europe        |        75.14773 |
+---------------+-----------------+
7 rows in set (0.00 sec) */

SELECT Continent, AVG(lifeexpectancy) AS Life_expectancy
FROM country
GROUP BY continent
ORDER BY life_expectancy;
/*
+---------------------------+-----------------+
| Region                    | life_expectancy |
+---------------------------+-----------------+
| Antarctica                |            NULL |
| Micronesia/Caribbean      |            NULL |
| Southern Africa           |        44.82000 |
| Central Africa            |        50.31111 |
| Eastern Africa            |        50.81053 |
| Western Africa            |        52.74118 |
| Southern and Central Asia |        61.35000 |
| Southeast Asia            |        64.40000 |
| Northern Africa           |        65.38571 |
| Melanesia                 |        67.14000 |
| Micronesia                |        68.08571 |
| Baltic Countries          |        69.00000 |
| Eastern Europe            |        69.93000 |
| Middle East               |        70.56667 |
| Polynesia                 |        70.73333 |
| South America             |        70.94615 |
| Central America           |        71.02500 |
| Caribbean                 |        73.05833 |
| Eastern Asia              |        75.25000 |
| North America             |        75.82000 |
| Southern Europe           |        76.52857 |
| British Islands           |        77.25000 |
| Western Europe            |        78.25556 |
| Nordic Countries          |        78.33333 |
| Australia and New Zealand |        78.80000 |
+---------------------------+-----------------+
25 rows in set (0.00 sec) */

SELECT Region, AVG(lifeexpectancy) AS Life_expectancy
FROM country
GROUP BY Region
ORDER BY life_expectancy;

/*
+---------------------------+-----------------++---------------------------+-----------------++---------------------------+-----------------+

BONUS */

-- Find all the countries whose local name is different from the official name

SELECT NAME, localname
FROM country
WHERE NAME != localname;

-- How many countries have a life expectancy less than Djibouti?

SELECT NAME, lifeexpectancy AS life_expectancy
FROM country
WHERE lifeexpectancy < (SELECT lifeexpectancy
FROM country 
WHERE NAME = 'Djibouti'
)
ORDER BY name;

-- What state is the city Mazar-e-Sharif located in?

SELECT NAME, district
FROM city
WHERE NAME = 'Mazar-e-Sharif'; 
-- returns Balkh

-- What region of the world is the city Sydney located in?

SELECT c.NAME AS city, region
FROM city c
JOIN country co ON co.code = c.countrycode
WHERE c.name = 'Sydney';
-- returns Australia and New Zealand

-- What country (use the human readable name) is city Emmen located in?

SELECT c.NAME AS City, co.name AS Country
FROM country co
JOIN city c ON c.countrycode = co.code
WHERE c.NAME = 'Emmen';
-- returns country Netherlands


-- What is the life expectancy in city Almirante Brown? 

SELECT lifeexpectancy
FROM country co
JOIN city c ON c.countrycode = co.code
WHERE c.NAME = 'Almirante Brown';
-- returns life expectancy of 75.1

/*
+---------------------------+-----------------++---------------------------+-----------------++---------------------------+-----------------+

Sakila Database */

USE sakila;

-- 1. Display the first and last names in all lowercase of all the actors.

SELECT lower(first_name) AS 'First Name', lower(last_name) AS 'Last Name'
FROM actor;

-- 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query you could use to obtain this information?

SELECT actor_id AS ID, first_name AS 'First Name', last_name AS 'Last Name'
FROM actor
WHERE first_name = 'Joe';
/* returns 
ID	First Name	Last Name
9	JOE	        SWANK
*/

-- 3. Find all actors whose last name contain the letters "gen":

SELECT first_name AS 'First Name', last_name AS 'Last Name'
FROM actor
WHERE last_name LIKE '%gen%';
/* returns 

First Name	Last Name
VIVIEN	BERGEN
JODIE	DEGENERES
GINA	DEGENERES
NICK	DEGENERES
*/

-- 4. Find all actors whose last names contain the letters "li". 
-- This time, order the rows by last name and first name, in that order.

SELECT last_name, first_name
FROM actor
WHERE last_name like '%li%'
ORDER BY last_name, first_name;

-- 5. Using IN, display the country_id and country columns for the following countries: 
-- Afghanistan, Bangladesh, and China:

SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 6. List the last names of all the actors, as well as how many actors have that last name.

SELECT last_name, count(last_name) AS count
FROM actor
GROUP BY last_name;

-- 7. List last names of actors and the number of actors who have that last name, 
-- but only for names that are shared by at least two actors

SELECT last_name, count(last_name) AS count
FROM actor
GROUP BY last_name
HAVING count >= 2
ORDER BY count;

-- 8. You cannot locate the schema of the address table. 
-- Which query would you use to re-create it?

DESC address;

-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.

SELECT first_name, last_name, address
FROM staff s
JOIN address a ON a.address_id = s.address_id;

-- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.

SELECT sum(amount) AS 'total amount', staff_id
FROM payment p 
JOIN staff s USING (staff_id)
WHERE payment_date LIKE '2005-08%'
GROUP BY staff_id;

-- 11. List each film and the number of actors who are listed for that film.

SELECT title, count(actor_id) AS 'number of actors'
FROM film 
JOIN film_actor USING (film_id)
GROUP BY title;

-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT count(*) AS number_of_copies
FROM inventory
JOIN film USING (film_id)
WHERE title = 'Hunchback Impossible';

/* 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
As an unintended consequence, films starting with the letters K and Q have also soared in popularity.
 Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
 
 returns 15 rows*/

SELECT title
FROM film 
WHERE title IN (SELECT title 
FROM actor 
WHERE title LIKE 'k%' OR title LIKE 'q%')
AND language_id = 1;

-- 14. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name, last_name
FROM actor
JOIN film_actor fa USING (actor_id)
WHERE fa.film_id IN (SELECT 
film_id
FROM film 
WHERE title = 'Alone Trip');

-- 15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.

SELECT lower(concat(first_name, ' ', last_name)) AS customer_name, email
FROM customer
JOIN address USING (address_id)
JOIN city USING (city_id)
WHERE country_id IN (SELECT country_id 
FROM country
WHERE country = 'Canada'); 

-- 16.  Identify all movies categorized as famiy films.

SELECT title, rating
FROM film 
WHERE film_id IN (SELECT film_id 
FROM film_category
WHERE category_id IN (SELECT category_id 
FROM category 
WHERE NAME = 'family'));

-- 17. Write a query to display how much business, in dollars, each store brought in.

-- 18. Write a query to display for each store its store ID, city, and country.

SELECT store_id, city, country
FROM store
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id);

-- 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT category_id, NAME, sum(amount) AS revenue FROM category
JOIN film_category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment p USING (rental_id)
GROUP BY category_id
ORDER BY revenue DESC
LIMIT 5;

-- 1. SELECT statements

-- a. Select all columns from the actor table.
SELECT * 
FROM actor;

-- b. Select only the last_name column from the actor table.
SELECT last_name
FROM actor;

/* c. Select only the following columns from the film table:
title, rental_duration, rental_rate, rating */
SELECT title, rental_duration, rental_rate, rating
FROM film;

/* d. Select only the following columns from the film table:
number of titles, rental_duration, rental_rate, rating */
SELECT count(title), rental_duration, rental_rate, rating
FROM film
GROUP BY rating, rental_rate, rental_duration;

-- 2. DISTINCT operator

-- a. Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name
FROM actor;

-- b. Select all distinct (different) postal codes from the address table.
SELECT DISTINCT postal_code
FROM address;

-- c. Select all distinct (different) ratings from the film table.
SELECT DISTINCT rating
FROM film;

-- 3. WHERE clause

-- a. Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT title, description, rating, length
FROM film
WHERE length > 90;

