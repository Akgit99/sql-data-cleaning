SELECT *
FROM first_database.students;

--Group by
SELECT country, AVG(Salary), MAX(age), COUNT(name)
From first_database.students
GROUP BY country;

--where is used before grouping or agregate functions but having canbe used with agregate functions with group by
SELECT age 
FROM first_database.students
HAVING age > 25;

--ORDER BY ASC and DESC
SELECT *
FROM first_database.students
ORDER BY country;

--Limit and aliasing
SELECT *
FROM first_database.students
ORDER BY age DESC
LIMIT 5;

SELECT country, AVG(age) AS average_age
FROM first_database.students
GROUP BY country
HAVING average_age > 23 
ORDER BY average_age DESC;

--string functions
SELECT UPPER(name), LENGTH(name) AS 'NAME LENGTH',  SUBSTRING(name, 2 , 3)
FROM students;

--Case statements
SELECT name,
CASE  
    WHEN age < 26 THEN 'hor'
    WHEN age >= 26 THEN 'hard' 
END AS 'horness'
FROM students

--Temporary Tables

CREATE TEMPORARY TABLE temp_table
(first_name VARCHAR(50),
 last_name VARCHAR(50), 
 favorite_movie VARCHAR(100));

INSERT INTO temp_table 
VALUES('John', 'jack', "avengers");

