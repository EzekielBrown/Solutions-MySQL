-- Q1. Create a query to alter the company , branch , employee , customer and product tables to add the UNIQUE constraints as defined in the entity relationship model.

ALTER TABLE company
ADD CONSTRAINT
UNIQUE (name);
ALTER TABLE branch
ADD CONSTRAINT
UNIQUE (name);
ALTER TABLE employee
ADD CONSTRAINT
UNIQUE (email);
ALTER TABLE customer
ADD CONSTRAINT
UNIQUE (email);
ALTER TABLE product
ADD CONSTRAINT
UNIQUE (sku);

-- Q2. Create a query to add a DEFAULT constraint to the status column in the order table to set the value of Unpaid if a value in not supplied.

ALTER TABLE `order`
CHANGE COLUMN status status ENUM('Unpaid','Paid') NULL DEFAULT 'Unpaid'

-- Q3. Create a query to add a DEFAULT constraint to the created_date column in the product and order tables to set the current date and time if a value in not supplied. (Use CURRENT_TIMESTAMP get the current date and time)

ALTER TABLE product
CHANGE COLUMN created_date created_date DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `order`
CHANGE COLUMN order_date order_date DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Q4. Create a query to create a foreign key constraint in the customer table referencing the company table.

ALTER TABLE customer
ADD CONSTRAINT FK_customer_company
FOREIGN KEY (company_id)
REFERENCES company (company_id);

-- Q5. Create queries to create the remaining foreign key constraints for the entity relationship model.

ALTER TABLE branch
ADD CONSTRAINT FK_branch_company
FOREIGN KEY (company_id) REFERENCES company (company_id);

ALTER TABLE employee
ADD CONSTRAINT FK_employee_branch
FOREIGN KEY (branch_id) REFERENCES branch (branch_id);

ALTER TABLE employee
ADD CONSTRAINT FK_employee_employee
FOREIGN KEY (manager_id) REFERENCES employee (employee_id);

ALTER TABLE product
ADD CONSTRAINT FK_product_branch
FOREIGN KEY (branch_id) REFERENCES branch (branch_id);

ALTER TABLE product_ingredient
ADD CONSTRAINT FK_product_ingredient_product
FOREIGN KEY (product_id) REFERENCES product (product_id);

ALTER TABLE product_ingredient
ADD CONSTRAINT FK_product_ingredient_ingredient
FOREIGN KEY (ingredient_id) REFERENCES ingredient (ingredient_id);

ALTER TABLE `order`
ADD CONSTRAINT FK_order_customer
FOREIGN KEY (customer_id) REFERENCES customer (customer_id);

ALTER TABLE order_item
ADD CONSTRAINT FK_order_item_order
FOREIGN KEY (order_id) REFERENCES order (order_id);

ALTER TABLE order_item
ADD CONSTRAINT FK_order_item_product
FOREIGN KEY (product_id) REFERENCES product (product_id);

-- Q6. Create a query to add a CHECK constraint to restrict the value of price column in the product table.

ALTER TABLE product
ADD CONSTRAINT CHECK(price >= 0);

-- Q7. Create a query to add a CHECK constraint to restrict the value of weight column in the ingredient table.

ALTER TABLE ingredient
ADD CONSTRAINT CHECK(weight >= 0);

-- Q8. Create a query to add a CHECK constraint to restrict the value of quantity and price columns in the order_item table.

ALTER TABLE order_item
ADD CONSTRAINT CHECK(quantity > 0),
ADD CONSTRAINT CHECK(price >= 0);