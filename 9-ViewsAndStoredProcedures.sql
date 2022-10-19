-- Q1. Create a query to list all of the branch details.

SELECT * FROM branch;

-- Q2. Create a view called branch_detail using the query from Q1.

CREATE VIEW branch_details
AS
SELECT * FROM branch;

-- Q3. Can you update the data in the branch_detail view? Write a query to update the street address of the Nelson branch. See below if you have forgotten the UPDATE syntax.

UPDATE branch_details SET name = 'Nelson Vines' WHERE branch_id = 1;

-- Q4. Create a query to list the order ID, order date, shipped date, order total and the first and last name of the customer ordered by the order date from most recent to oldest.

SELECT
o.order_id,
o.order_date,
c.customer_id,
c.first_name,
c.last_name,
sum(oi.quantity * oi.price) AS total_amount
FROM winery.order o
JOIN winery.order_item oi ON o.order_id = oi.order_id
JOIN customer c ON c.customer_id = o.customer_id
GROUP BY
o.order_id
ORDER BY
o.order_date DESC;

-- Q5. Create a view called customer_order using the query from Q4.

CREATE VIEW customer_order
AS
SELECT
o.order_id,
o.order_date,
c.customer_id,
c.first_name,
c.last_name,
sum(oi.quantity * oi.price) AS total_amount
FROM `order` o
JOIN order_item oi ON o.order_id = oi.order_id
JOIN customer c ON c.customer_id = o.customer_id
GROUP BY
o.order_id
ORDER BY
o.order_date DESC;

-- Q6. Create a query to list all results from the customer_order view.

SELECT * FROM customer_order;

-- Q7. Can you update the data in the customer_order view? Write a query to update the order shipped date in the Q6 view.

UPDATE customer_order SET order_date = '2021-08-25 00:00:00' WHERE order_id = 30;

-- Q8. You can check if a view in a database is updatable by querying the is_updatable column from the views table in the information_schema database. The following query gets all views from the winery database and shows which views are updatable.

SELECT
table_name,
is_updatable
FROM
information_schema.views
WHERE
table_schema = 'winery';

-- Q9. Create a stored procedure to list all of the branch details

delimiter //
CREATE PROCEDURE branch_details()
BEGIN
SELECT * FROM branch;
END //
delimiter ;

-- Q10. Create a stored procedure to update a branch; the procedure should have input parameters for each of the columns in the branch table.

delimiter //
create procedure update_branch_details(
IN branch_id int,
IN company_id int,
IN name varchar(50),
IN street varchar(100),
IN city varchar(100),
IN postal_code varchar(4)
)
BEGIN
UPDATE branch b
SET b.company_id = company_id,
b.name = name,
b.street = street,
b.city = city,
b.postal_code = postal_code
WHERE b.branch_id = branch_id;
END //
delimiter ;

-- Q11. Create a stored procedure to take the ID of a customer as input and return a rating for a customer based on the total amount of sales. The ratings can be Bronze, Silver, or Gold. The total sales required for each is up to you. (You may want to use a conditional statement here).

delimiter //
CREATE PROCEDURE get_customer_sales_rating(
IN customer_id int,
OUT rating varchar(20)
)
BEGIN
DECLARE total_amount decimal(18,2) DEFAULT 0;
SELECT sum(oi.quantity * oi.price)
INTO total_amount
FROM `order` o
JOIN order_item oi ON o.order_id = oi.order_id
WHERE o.customer_id = customer_id;
IF total_amount <= 200 THEN
SET rating = 'Bronze';
ELSEIF total_amount <= 500 THEN
SET rating = 'Silver';
ELSE
SET rating = 'Gold';
END IF;
END //
delimiter ;

-- Q12. Call the stored procedure from Q9.

CALL get_customer_sales_rating(9,@rating);
SELECT @rating;
