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

SELECT DISTINCT category 
from products; 

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

![alt text](<Screenshot 2026-05-27 161540.png>)


Section B — Filtering & Optimization (WHERE, Indexes) 

Q7. Retrieve all orders with status = 'Delivered'. 

select * from orders where status='Delivered'; 

![alt text](<Screenshot 2026-05-28 133906.png>)

Q8. Find all products in the 'Electronics' category with a unit_price greater than ₹2000. 

select product_name from products where category='Electronics' and unit_price>2000;

![alt text](<Screenshot 2026-05-28 133537.png>)


Q9. List all customers who joined in the year 2024 and belong to the state 'Maharashtra'. 

select * from customers 
where join_date LIKE '2024%' 
&&
 state='Maharashtra';

![alt text](<Screenshot 2026-05-28 134503.png>)

Q10. Find all orders placed between '2024-08-10' and '2024-08-25' (inclusive) that are NOT cancelled. 

select * from orders 
where order_date 
BETWEEN '2024-08-10' AND '2024-08-25' 
&& 
status!='Cancelled';

![alt text](<Screenshot 2026-05-28 134836.png>)

Q11. Explain what the index idx_orders_date does. How would it improve the performance of a query that filters orders by order_date? Write a sample query that would benefit from this index. 

The index idx_orders_date creates a separate, ordered lookup structure for the order_date column. Instead of scanning the entire orders table row by row, the database engine uses this index to jump directly to the requested dates. It stores the order_date values in a sorted B-Tree structure along with pointers to the actual row locations on disk.

How it improves performance:

-The database avoids reading every page of the table.

-It uses binary search matching, reducing complexity from O(N) to O(log N).

-It quickly locates the start and end points for date ranges.

-Because the index is already sorted, ORDER BY order_date queries do not require an expensive sort operation in memory.

Sample query:
SELECT 
    order_id, 
    customer_id, 
    total_amount 
FROM 
    orders 
WHERE 
    order_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY 
    order_date DESC;



Q12. If you run: SELECT * FROM customers WHERE YEAR(join_date) = 2024; — would the index on join_date be used? Explain why or why not, and rewrite the query to be index-friendly (SARGable). 

No, the index on join_date will not be used because applying the YEAR() function to the column prevents the query from being SARGable (Search Argument Able).

It is because :

-Database engines cannot map the output of a function back to raw index values.

-The engine must evaluate YEAR() for every single row in the table.

-The provided schema does not actually contain an index on join_date.

Index-friendly rewrite :

SELECT * 
FROM customers 
WHERE join_date >= '2024-01-01' 
  AND join_date < '2025-01-01';


Section C — Aggregation (GROUP BY, SUM, COUNT, AVG, MIN, MAX) 

Q13. Count the total number of orders in the orders table. 

select COUNT(*) from orders;

![alt text](<Screenshot 2026-05-28 140348.png>)

Q14. Find the total revenue (SUM of total_amount) from all 'Delivered' orders. 

Select SUM(total_amount) 
from orders 
where status ='Delivered';

![alt text](<Screenshot 2026-05-28 140527.png>)

Q15. Calculate the average unit_price of products in each category. 

select category, AVG(unit_price) 
from products 
group by category;

![alt text](<Screenshot 2026-05-28 140738.png>)

Q16. For each order status, find the count of orders and the total revenue. Sort the result by total revenue in descending order. 

select COUNT(*) as total_orders,
SUM(total_amount) as total_revenue, 
status from orders 
group by status 
order by total_revenue DESC;

![alt text](<Screenshot 2026-05-28 141202.png>)

Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category. 

select MAX(unit_price) as Expensive, 
MIN(unit_price) as Cheapest, 
category from products 
group by category;

![alt text](<Screenshot 2026-05-28 141435.png>)

Q18. List all product categories where the average unit_price is greater than ₹2000. (Hint: Use HAVING clause) 

select category, AVG(unit_price) as Average_unit_price from products group by category HAVING Average_unit_price>2000;

![alt text](<Screenshot 2026-05-28 141744.png>)


Section D — Joins & Relationships 

Q19. Write an INNER JOIN query to display each order along with the customer's first_name and last_name. Show: order_id, order_date, first_name, last_name, total_amount. 

SELECT 
    orders.order_id, 
    orders.order_date, 
    customers.first_name, 
    customers.last_name, 
    orders.total_amount 
FROM orders 
INNER JOIN customers 
    ON orders.customer_id = customers.customer_id;


![alt text](<Screenshot 2026-05-28 142243.png>)

Q20. Using a LEFT JOIN, list ALL customers and their orders (if any). Customers with no orders should still appear with NULL values for order columns. 

select customers.customer_id, customers.first_name, customers.last_name, orders.order_id , orders.order_date, orders.total_amount from customers LEFT JOIN orders ON customers.customer_id=orders.customer_id;

![alt text](<Screenshot 2026-05-28 143021.png>)

Q21. Write a query using JOINs across three tables (orders → order_items → products) to show: order_id, product_name, quantity, unit_price, and discount_pct for each order item. 

SELECT 
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.discount_pct
FROM 
    orders o
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id;

![alt text](<Screenshot 2026-05-28 143201.png>)

Q22. Explain the difference between LEFT JOIN and RIGHT JOIN with an example from this schema. When would you use a FULL OUTER JOIN? 

The difference between LEFT JOIN and RIGHT JOIN lies entirely in which table acts as the primary reference point for keeping unmatched rows:

-LEFT JOIN: Keeps all rows from the left table. It matches rows from the right table. Unmatched right rows return NULL.

-RIGHT JOIN: Keeps all rows from the right table. It matches rows from the left table. Unmatched left rows return NULL.

Ex:

Consider the relationship between products (left) and order_items (right).

SELECT p.product_name, oi.order_id
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id;

If a product has never been ordered, it still appears in the list with a NULL for order_id.

SELECT p.product_name, oi.order_id
FROM products p
RIGHT JOIN order_items oi ON p.product_id = oi.product_id;

If a product row was somehow deleted from the database but the transaction history remained, the order_id would still show up with a NULL for product_name.

You use a  FULL Outer Join if you want to combine records from both the table regardless of whether they match or not. All the unmatched records contain null values.

Q23. Identify all Foreign Key relationships in the schema. Explain what would happen if you tried to insert an order with customer_id = 999 (which doesn't exist in customers).

customers.customer_id  ◀──FK──  orders.customer_id 

orders.order_id        ◀──FK──  order_items.order_id 

products.product_id    ◀──FK──  order_items.product_id 


If we try to insert an order with customer_id = 999, the database will completely block the insert and throw a foreign key constraint violation error.


Section E — Advanced Concepts (CASE, ACID, Transactions) 

Q24. Write a query using CASE to classify products into price tiers: 
  • 'Budget'    → unit_price < 1000 
  • 'Mid-Range' → unit_price BETWEEN 1000 AND 3000 
  • 'Premium'   → unit_price > 3000 
Display: product_name, unit_price, price_tier. 

select product_name, unit_price,
CASE
	when unit_price < 1000 then 'Budget'
    when unit_price BETWEEN 1000 AND 3000 then 'Mid-Range'
    when unit_price > 3000 then 'Premium'
    
END as  price_tier 
from products;

![alt text](<Screenshot 2026-05-28 145942.png>)

Q25. Using a CASE statement inside an aggregate function, count how many orders are 'Delivered' vs 'Not Delivered' (all other statuses). Display the result in a single row. 

select 
	COUNT(CASE when status='Delivered' then 1 END) as delivered_count,
    COUNT(CASE when status!='Delivered' OR status IS NULL then 1 END) as non_delivered_count
from orders;

![alt text](<Screenshot 2026-05-28 150433.png>)

Q26. Explain each letter of ACID: 
  • A – Atomicity 
  • C – Consistency 
  • I – Isolation 
  • D – Durability 
Give a real-world example (e.g., bank transfer) showing why each property is important. 

-Atomicity:A transaction is treated as a single, indivisible "all or nothing" unit. Either every operation within the transaction successfully completes, or none of them are applied.

Ex:A fund transfer of ₹10,000 from Account A to Account B involves two operations: debiting Account A and crediting Account B. If the database crashes after the debit but before the credit, the entire transaction is rolled back. Account A is restored to its original balance, ensuring no currency is lost.

-Consistency: Ensures that a transaction can only transition the database from one valid state to another, strictly maintaining all predefined schema rules, constraints, and data integrity checks.

Ex:A banking database enforces a minimum balance constraint of ₹1,000 on savings accounts. If a user with a balance of ₹1,500 attempts a withdrawal of ₹1,000, the DBMS will abort the transaction to prevent the balance from violating the constraint by dropping to ₹500.

-Isolation:Guarantees that concurrently executing transactions are isolated from one another. The execution of one transaction must not interfere with or expose uncommitted data to another concurrent transaction.

Ex:A joint bank account holds a balance of ₹25,000. Two account holders simultaneously attempt to withdraw ₹20,000 from different ATMs. Isolation ensures the system serializes the requests; the first transaction succeeds and updates the balance to ₹5,000, causing the second transaction to fail due to insufficient funds.

-Durability:Assures that once a transaction has successfully committed, its changes are permanently recorded in non-volatile storage

Ex:A customer deposits ₹50,000 at a cash deposit machine, and the system confirms a successful transaction. If the banking server immediately suffers an ungraceful hardware failure or power loss, the recorded ₹50,000 deposit remains safely recovered on disk when the system reboots.

Q27. Write a SQL transaction that does the following atomically: 
  1. Insert a new order (order_id=1011, customer_id=102, today's date, 'Pending', 1598.00) 
  2. Insert two order items for that order 
  3. Update the stock_qty of the purchased products 
  4. If any step fails, ROLLBACK the entire transaction. Otherwise, COMMIT. 
Write the complete BEGIN...COMMIT/ROLLBACK block. 

DELIMITER //

CREATE PROCEDURE ProcessOrder1011()
BEGIN
  
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Transaction failed and was rolled back.' AS Status;
    END;

    START TRANSACTION;

    INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
    VALUES (1011, 102, CURDATE(), 'Pending', 1598.00);

    INSERT INTO order_items (order_id, product_id, quantity, unit_price)
    VALUES (1011, 501, 2, 499.00),
           (1011, 502, 1, 600.00);

    UPDATE products
    SET stock_qty = stock_qty - 2
    WHERE product_id = 501;

    UPDATE products
    SET stock_qty = stock_qty - 1
    WHERE product_id = 502;

    COMMIT;
    SELECT 'Transaction committed successfully.' AS Status;

END //

DELIMITER ;


CALL ProcessOrder1011();

DROP PROCEDURE IF EXISTS ProcessOrder1011;

![alt text](<Screenshot 2026-05-28 151725.png>)