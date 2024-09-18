USE coffee_store;

/*
	Inner Joins
    
    The INNER JOIN keyword selects records that have matching values in both tables.
    
    SELECT <column_name(s)>
	FROM <table_1>
	INNER JOIN <table_2>
	ON <table_1.column_name> = <table_2.column_name>;
*/

SELECT p.name, o.order_time FROM orders o
INNER JOIN products p ON o.product_id = p.id ORDER BY o.order_time;


/*
	The LEFT JOIN keyword returns all records from the left table (table1), and the matching records from the right table (table2). 
    The result is 0 records from the right side, if there is no match.
    
	SELECT <column_name(s)>
	FROM <table_1>
	LEFT JOIN <table_2>
	ON <table_1.column_name> = <table_2.column_name>;
*/

UPDATE orders SET customer_id = null
WHERE id IN (1,3,5);

SELECT o.*, c.* FROM orders o 
LEFT JOIN customers c ON o.customer_id = c.id
ORDER By o.order_time;

SELECT o.*, c.* FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id WHERE c.last_name = 'Bluth'
ORDER BY c.id;

/*
	The RIGHT JOIN keyword returns all records from the right table (table2), and the matching records from the left table (table1). 
    The result is 0 records from the left side, if there is no match.
    
    SELECT <column_name(s)>
	FROM <table_1>
	RIGHT JOIN <table_2>
	ON <table_1.column_name> = <table_2.column_name>;
*/

SELECT o.*, c.* FROM customers c
RIGHT JOIN orders o ON c.id = o.customer_id
ORDER BY o.id;

SELECT o.*, c.* FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_time;


-- Joining more than 2 tables

SELECT p.name, p.price, c.first_name, c.last_name, o.order_time FROM orders o
JOIN products p ON o.product_id = p.id 
JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_time;

-- Exercise 7.1

SELECT o.id, c.phone_number FROM customers c 
JOIN orders o ON c.id = o.customer_id WHERE o.product_id = 4;

SELECT p.name, o.order_time FROM products p 
JOIN orders o ON p.id = o.product_id 
WHERE o.order_time BETWEEN '2023-01-01' AND '2023-03-31 23:59:59'
ORDER BY o.order_time;

SELECT c.first_name, p.name, p.price, o.order_time FROM products p
JOIN orders o ON o.product_id = p.id 
JOIN customers c ON o.customer_id = c.id
WHERE c.gender = 'F' AND o.order_time < '2023-01-01 23:59:59';

SELECT * FROM orders;
