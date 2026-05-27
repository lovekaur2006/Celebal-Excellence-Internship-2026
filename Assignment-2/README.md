Week-2 Assignment --------SQL BASICS

Section A — SQL Basics (SELECT, Constraints, Primary Keys) 
 

Q1. Write a query to display all columns and rows from the customer's table. 

SELECT * from customers;
![alt text](<Screenshot 2026-05-27 155304.png>)

Q2. Retrieve only the first_name, last_name, and city of all customers. 

SELECT first_name, last_name, city 
from customers;
![alt text](<Screenshot 2026-05-27 155454.png>)

Q3. List all unique categories available in the products table. 

SELECT DISTINCT category from products; 
![alt text](<Screenshot 2026-05-27 155711.png>)

Q4. Identify the Primary Key of each table in the schema. Explain why a Primary Key must be unique and NOT NULL. 

The primary Key of all the tables are as follows:

-customers table: customer_id

-products table: product_id

-orders table: order_id

-order_items table: item_id

The primary key must be unique because:

-It prevent duplicate data.
-Eliminates data ambiguity or confusion.
-To create accuarate links as foreign keys in other tables

The primary key must be not null because:

-Each row must have an indentity to exist
-Database cannnot reliable compare null values.
-A missing Id cannot safely connect to other tables.


Q5. What constraints are applied to the email column in the customers table? What would happen if you tried to insert a duplicate email? 

The constraints applied to the email column in the customers table are 'Unique' and 'not null'.
If you tried to insert a duplicate email , the database rejects the row and throws an error of duplicate entry.


Q6. Try inserting a product with unit_price = -50. What happens and which constraint prevents it? Write both the INSERT statement and explain the error

INSERT INTO orders VALUES 
(1011, 108, '2024-08-11', 'Delivered',  -50.00); 

It will throw an error of check constraints as in table defination total_amount have constraint :CHECK (total_amount >= 0)
![alt text](<Screenshot 2026-05-27 161325.png>)