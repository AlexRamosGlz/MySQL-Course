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
    
    -- Referencing child talbe to it's parent table
    FOREIGN KEY(product_id) REFERENCES products(id),
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

ALTER TABLE products
ADD COLUMN coffee_origin VARCHAR(30);

ALTER TABLE products
DROP COLUMN coffee_origin;

DESCRIBE orders;

DROP TABLE orders;

SHOW TABLES;