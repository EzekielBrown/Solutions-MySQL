-- Q1. Create a query to select a list of unique cities from the company , branch and customer tables.

SELECT city AS name
FROM company
WHERE city IS NOT NULL
UNION SELECT city AS name
FROM branch
WHERE city IS NOT NULL
UNION SELECT city AS name
FROM customer
WHERE city IS NOT NULL;

-- Q2. Create a query to update the city with the spelling mistake.

UPDATE customer
SET city = 'Nelson'
WHERE city = 'Nellson';

-- Q3. Create a query to create a new table called city with a surrogate primary key and populate the table with the list of cities from the first query.

CREATE TABLE city
SELECT city AS name
FROM company
WHERE city IS NOT NULL
UNION SELECT city AS name
FROM branch
WHERE city IS NOT NULL
UNION SELECT city AS name
FROM customer
WHERE city IS NOT NULL;

-- Q4. Create a query to add the main cities of New Zealand to the city table.

ALTER TABLE city
ADD PRIMARY KEY(name);
REPLACE INTO city(name)
VALUES
('Auckland'),
('Wellington'),
('Christchurch'),
('Dunedin');
ALTER TABLE city
DROP PRIMARY KEY;

-- Q5. Inspect the city table and create a query to alter the structure of the city table to use a surrogate primary key.

ALTER TABLE city
ADD COLUMN city_id int PRIMARY KEY AUTO_INCREMENT FIRST;

-- Q6. Create a query to alter each of the company , branch and customer tables to create a relationship between the tables and the new city table.

ALTER TABLE company
ADD COLUMN city_id int AFTER city;

ALTER TABLE branch
ADD COLUMN city_id int AFTER city;

ALTER TABLE customer
ADD COLUMN city_id int AFTER city;

ALTER TABLE company
ADD CONSTRAINT
FOREIGN KEY (city_id)
REFERENCES city (city_id);

ALTER TABLE branch
ADD CONSTRAINT
FOREIGN KEY (city_id)
REFERENCES city (city_id);

ALTER TABLE customer
ADD CONSTRAINT
FOREIGN KEY (city_id)
REFERENCES city (city_id);

-- Q7. Create a query to update each of the company , branch and customer tables with the matching primary key in the city table.

UPDATE company
SET city_id = (SELECT city_id FROM city WHERE city.name = company.city);

UPDATE branch
SET city_id = (SELECT city_id FROM city WHERE city.name = branch.city);

UPDATE customer
SET city_id = (SELECT city_id FROM city WHERE city.name = customer .city);

-- Q8. Create a query to alter each of the company , branch and customer tables so that the city is required.

-- Q9. Create a query to alter each of the company , branch and customer tables so that the old city column is removed.

ALTER TABLE company
DROP COLUMN city;

ALTER TABLE branch
DROP COLUMN city;

ALTER TABLE customer
DROP COLUMN city;

-- Q10. Put the queries together to create the migration script. We should be able to run the create the data and migration scripts without errors.

DROP TABLE IF EXISTS city;

SELECT city AS name
FROM company
WHERE city IS NOT NULL
UNION SELECT city AS name
FROM branch
WHERE city IS NOT NULL
UNION SELECT city AS name
FROM customer
WHERE city IS NOT NULL;

UPDATE customer
SET city = 'Nelson'
WHERE city = 'Nellson';

CREATE TABLE city
SELECT city AS name
FROM company
WHERE city IS NOT NULL
UNION SELECT city AS name
FROM branch
WHERE city IS NOT NULL
UNION SELECT city AS name
FROM customer
WHERE city IS NOT NULL;

-- To use REPLACE we need to first add a key so duplicates are updated.

ALTER TABLE city
ADD PRIMARY KEY(name);
REPLACE INTO city(name)
VALUES
('Auckland'),
('Wellington'),
('Christchurch'),
('Dunedin');

ALTER TABLE city
DROP PRIMARY KEY;

-- Add the surrogate primary key

ALTER TABLE city
ADD COLUMN city_id int PRIMARY KEY AUTO_INCREMENT FIRST;

-- Add the column to hold the city ID for each table

ALTER TABLE company
ADD COLUMN city_id int AFTER city;

ALTER TABLE branch
ADD COLUMN city_id int AFTER city;

ALTER TABLE customer
ADD COLUMN city_id int AFTER city;

-- Add the foreign key constraints

ALTER TABLE company
ADD CONSTRAINT
FOREIGN KEY (city_id)
REFERENCES city (city_id);

ALTER TABLE branch
ADD CONSTRAINT
FOREIGN KEY (city_id)
REFERENCES city (city_id);

ALTER TABLE customer
ADD CONSTRAINT
FOREIGN KEY (city_id)
REFERENCES city (city_id);

-- Update the city ID for each record where the names match

UPDATE company
SET city_id = (SELECT city_id FROM city WHERE city.name = company.city);

UPDATE branch
SET city_id = (SELECT city_id FROM city WHERE city.name = branch.city);

UPDATE customer
SET city_id = (SELECT city_id FROM city WHERE city.name = customer .city);

-- drop the redundant column

ALTER TABLE company
DROP COLUMN city;

ALTER TABLE branch
DROP COLUMN city;

ALTER TABLE customer
DROP COLUMN city;
