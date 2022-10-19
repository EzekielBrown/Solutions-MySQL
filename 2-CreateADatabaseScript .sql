-- Q1. Create Data Definition Language (DDL) query statements to create the winery database if it does not exist.
CREATE DATABASE IF NOT EXISTS winery;

-- Q2. Create Data Definition Language (DDL) query statements to create the company, branch and customer tables in the database shown in the entity relationship model. Include the columns specifying the primary keys, datatype and required fields. Exclude the foreign key constraints, we will cover foreign key constraints in the next class and use the ALTER TABLE statement to add the foreign keys to the tables.

CREATE TABLE company
(
company_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
street VARCHAR(100),
city VARCHAR(100),
postal_code VARCHAR(4)
);

CREATE TABLE branch
(
branch_id INT PRIMARY KEY AUTO_INCREMENT,
company_id INT NOT NULL,
name VARCHAR(50) NOT NULL,
street VARCHAR(100),
city VARCHAR(100),
postal_code VARCHAR(4)
);

CREATE TABLE customer
(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
company_id INT NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
street VARCHAR(100),
city VARCHAR(100),
postal_code VARCHAR(4)
);

-- Q3. Create Data Manipulation Language (DML) INSERT statements to insert the company details into the company table. Company - Fine Vines Ltd

INSERT INTO company (name) VALUES ('Fine Vines Ltd');

-- Q4. Create Data Manipulation Language (DML) INSERT statements to insert the three branches of the Fine Vines Ltd company into the branch table. Branch 1 - Nelson Vines 12 Water street Nelson 7010. Branch 2 - Richmond Vines 24 Kensington Point Richmond 7020. Branch 3 - Brightwater Vines 300 Main Road Brightwater 7022

INSERT INTO branch (branch_id, company_id, name, street, city, postal_code)
VALUES
(1, 1, 'Nelson Vines', '12 Water street', 'Nelson', '7010'),
(2, 1, 'Richmond Vines', '24 Kensington Point', 'Richmond', '7020'),
(3, 1, 'Brightwater Vines', '300 Main Road', 'Brightwater', '7022');

-- Q5. Create DDL statements to create the remaining tables

CREATE TABLE employee
(
employee_id INT PRIMARY KEY AUTO_INCREMENT,
branch_id INT NOT NULL,
manager_id INT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
position VARCHAR(50) NOT NULL,
salary DECIMAL NOT NULL
);

CREATE TABLE product
(
product_id INT PRIMARY KEY AUTO_INCREMENT,
branch_id INT NOT NULL,
name VARCHAR(50) NOT NULL,
sku VARCHAR(50) NOT NULL,
price DECIMAL(10,2) NOT NULL,
created_date DATETIME NOT NULL,
modified_date DATETIME,
description VARCHAR(255)
);

CREATE TABLE product_ingredient
(
product_id INT NOT NULL,
ingredient_id INT NOT NULL,
amount FLOAT NOT NULL,
PRIMARY KEY (product_id, ingredient_id)
);

CREATE TABLE ingredient
(
ingredient_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
unit VARCHAR(20) NOT NULL,
weight FLOAT NOT NULL
);

CREATE TABLE order
(
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL,
order_date DATETIME NOT NULL,
shipped_date DATETIME NULL,
status ENUM('Unpaid','Paid')
);

CREATE TABLE order_item
(
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
price DECIMAL(10,2) NOT NULL,
PRIMARY KEY (order_id, product_id)
);

-- Q6. Create DDL statements to drop the tables if they exist.
DROP TABLE IF EXISTS order_item;
DROP TABLE IF EXISTS product_ingredient;
DROP TABLE IF EXISTS order;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS branch;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS city;

-- Q7. Combine all of the queries and create a script to create and select the database, drop the tables if they exist then create the tables and add the company and branch information.

CREATE DATABASE IF NOT EXISTS winery;
USE winery;
-- drop the existing tables
DROP TABLE IF EXISTS order_item;
DROP TABLE IF EXISTS product_ingredient;
DROP TABLE IF EXISTS order;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS branch;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS city;

-- Create the tables

CREATE TABLE company
(
company_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
street VARCHAR(100),
city VARCHAR(100),
postal_code VARCHAR(4)
);

CREATE TABLE branch
(
branch_id INT PRIMARY KEY AUTO_INCREMENT,
company_id INT NOT NULL,
name VARCHAR(50) NOT NULL,
street VARCHAR(100),
city VARCHAR(100),
postal_code VARCHAR(4)
);

CREATE TABLE customer
(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
company_id INT NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
street VARCHAR(100),
city VARCHAR(100),
postal_code VARCHAR(4)
);

CREATE TABLE employee
(
employee_id INT PRIMARY KEY AUTO_INCREMENT,
branch_id INT NOT NULL,
manager_id INT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
position VARCHAR(50) NOT NULL,
salary DECIMAL NOT NULL
);

CREATE TABLE product
(
product_id INT PRIMARY KEY AUTO_INCREMENT,
branch_id INT NOT NULL,
name VARCHAR(50) NOT NULL,
sku VARCHAR(50) NOT NULL,
price DECIMAL(10,2) NOT NULL,
created_date DATETIME,
modified_date DATETIME,
description VARCHAR(255)
);

CREATE TABLE product_ingredient
(
product_id INT NOT NULL,
ingredient_id INT NOT NULL,
amount FLOAT NOT NULL,
PRIMARY KEY (product_id, ingredient_id)
);

CREATE TABLE ingredient
(
ingredient_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
unit VARCHAR(20) NOT NULL,
weight FLOAT NOT NULL
);

CREATE TABLE `order`
(
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL,
order_date DATETIME NOT NULL,
shipped_date DATETIME NULL,
status ENUM('Unpaid','Paid') NULL
);

CREATE TABLE order_item
(
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
price DECIMAL(10,2) NOT NULL,
PRIMARY KEY (order_id, product_id)
);
