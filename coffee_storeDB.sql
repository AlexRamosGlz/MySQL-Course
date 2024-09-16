CREATE TABLE products (
	id INT auto_increment PRIMARY KEY,
    name VARCHAR(30),
    price DECIMAL(3,2)
);

CREATE TABLE customers (
	id INT auto_increment PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
	gender ENUM('M', 'F'),
    phone_number VARCHAR(11)
);


CREATE TABLE orders (
	id INT auto_increment PRIMARY KEY,
    product_id INT,
    customer_id INT,
    order_time DATETIME,
    
    -- Referencing child table to it's parent table
    FOREIGN KEY(product_id) REFERENCES products(id),
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

ALTER TABLE orders
DROP FOREIGN KEY FK_productsOrders;


ALTER TABLE orders
ADD CONSTRAINT FK_productsOrders
FOREIGN KEY (product_id) REFERENCES products(id);

ADD COLUMN coffee_origin VARCHAR(30);

ALTER TABLE products
DROP COLUMN coffee_origin;

DESCRIBE orders;

DROP TABLE orders;

SHOW TABLES;

USE coffee_store;

############################### STORE DATA INTO TABLES ##############################

-- INSERT INTO <table_name> (<column_1>, <column_2>, <column_3>, ... <column_n>)
-- VALUES (<value_1>, <value_2>, <value_2>, ... <value_n>);

#######################################################################################

INSERT INTO products (name, price, coffee_origin) VALUES ('Espresso', 2.50, 'Brazil');

INSERT INTO products (name, price, coffee_origin) VALUES ('Macchiato', 3.00, 'Brazil'), ('Capuccino', 3.50, 'Costa Rica');
INSERT INTO products (name, price, coffee_origin) VALUES ('Latte', 3.50, 'Indonesia'), ('Americano', 3.00, 'Brazil'), 
('Flat White', 3.50, 'Indonesia'), ('Filter', 3.00, 'India');


############################## UPDATE DATA IN TABLES ################################

-- UPDATE <table_name> 
-- SET <column_name> = <value> 
-- WHERE <column_name> = <match>;

#####################################################################################

UPDATE products SET coffee_origin = 'Sri Lanka' WHERE id = 22;

/*
	By default, in MySQL sessions, you're only allowed
	to use a key column in the where statement, when you're updating or deleting data.
	That means we are allowed to use the ID column –
	because that's a key column
    
    SET sql_safe_updates = false/true;
*/

SET sql_safe_updates = false;

UPDATE products SET price = 3.25, coffee_origin = 'Ethiopia' WHERE name = 'Americano';

UPDATE products SET coffee_origin = 'Colombia' WHERE coffee_origin = 'Brazil';


###################  SELECTING FROM A TABLE ###########################

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM customers;

SELECT last_name FROM customers;

SELECT * FROM products WHERE coffee_origin = 'Colombia';
SELECT * FROM products WHERE price = 3.00 OR coffee_origin = 'Colombia';

SELECT first_name, phone_number FROM customers WHERE gender = 'F' AND last_name = 'Bluth';
SELECT name FROM products WHERE price > 3.00 OR coffee_origin = 'Sri Lanka';
SELECT COUNT(*) as Man FROM customers WHERE phone_number is NULL and gender = 'M';

-- IN & NOT IN
SELECT * FROM customers WHERE last_name IN ('Taylor', 'Bluth', 'Armstrong'); 
SELECT * FROM customers WHERE first_name NOT IN ('Katie', 'John', 'George'); 

-- BETWEEN 
SELECT * FROM orders WHERE customer_id BETWEEN 5 and 7;

/*
	LIKE
    
    % match any number of characters
    
    _ match just one character
*/

SELECT * FROM customerS WHERE last_name LIKE 'W%';
SELECT * FROM customers WHERE last_name LIKE '%O%';
SELECT * FROM customers WHERE first_name LIKE '_O__';


-- Order By

SELECT * FROM products ORDER BY price ASC;
SELECT DISTINCT last_name FROM customers ORDER BY last_name DESC;