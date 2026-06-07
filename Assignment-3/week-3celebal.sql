CREATE DATABASE superstore_db;
USE superstore_db;

-- Load Superstore dataset into a table (superstore_raw).

CREATE TABLE superstore_raw (
    row_id INT,
    order_id VARCHAR(50),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);
-- Create tables (customers, orders, products) from the dataset.
CREATE TABLE customers (
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50)
);

CREATE TABLE products (
    product_id VARCHAR(20),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255)
);

CREATE TABLE orders (
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);

-- Insert data into these tables using SELECT DISTINCT.
insert into customers
SELECT DISTINCT
	customer_id,
    customer_name,
    segment, 
    country,
    city, 
    state,
    postal_code,
    region
from superstore_raw;
select * from customers;

insert into products 
SELECT DISTINCT
		product_id,
        category,
        sub_category,
        product_name
from superstore_raw;
select * from products;

insert into orders
SELECT DISTINCT
		order_id,
        customer_id,
        STR_TO_DATE(order_date, '%m/%d/%Y'),
		STR_TO_DATE(ship_date, '%m/%d/%Y'),
        ship_mode,
        sales,
        quantity,
        discount,
        profit
from superstore_raw;
select * from orders;
-- -------------------------------------------------------------------------------------
-- Apply subqueries to filter data (above average sales, highest order per customer).

-- Query for filteringd Data with sales above average sales
select *
from orders 
where sales>(select AVG(sales) from orders);

select Count(*) from orders 
where sales>(select AVG(sales) from orders);

-- Query for showing highest sales per customer
select 
c.customer_id,
c.customer_name,
c.country,
c.state,
c.city,
o.order_id,
o.sales as highest_order_per_customer
from customers c
JOIN orders o
ON c.customer_id=o.customer_id
WHERE (o.customer_id, o.sales) in
(select customer_id,
Max(sales)
from orders 
group by customer_id) ORDER BY highest_order_per_customer DESC;

-- Use CTEs to compute aggregations (total sales per customer).
WITH total_sales as(
select customer_id , 
sum(sales) as total_sale from orders
 o group by customer_id)
 
select c.customer_id,
c.customer_name,
c.city,
c.state,
c.country, t.total_sale
from customers c 
JOIN total_sales t
ON c.customer_id=t.customer_id ORDER BY total_sale DESC;

-- avg sale per customer
with avg_sales as(
select customer_id, AVG(sales) as avg_sale
from orders group by customer_id
)
select c.customer_id, c.customer_name,
c.city,
c.state,
c.country,
a.avg_sale from customers c
JOIN avg_sales as a
ON c.customer_id=a.customer_id ORDER BY avg_sale DESC;

-- How often a customer buys
with freq_of_order_per_cust as
(select customer_id, COUNT(order_id) as frequency from orders 
group by customer_id)
select c.customer_id, c.customer_name,
f.frequency as No_of_orders
from customers c
JOIN freq_of_order_per_cust f
on c.customer_id=f.customer_id ORDER BY No_of_orders DESC;

-- Find customers whose total sales are above average. (CTE + Subquery)  
WITH total_sales AS (
    SELECT
        customer_id,
        SUM(sales) AS total_sale
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.state,
    c.country,
    ts.total_sale
FROM customers c
JOIN total_sales ts
    ON c.customer_id = ts.customer_id
WHERE ts.total_sale >
(
    SELECT AVG(total_sale)
    FROM total_sales
);

-- Rank all customers based on total sales. (Window Function)  
select 
c.customer_id,
c.customer_name,
SUM(o.sales) as total_sale,
rank() over(order by SUM(o.sales) DESC) as rnk
from customers c
Join orders o
ON c.customer_id=o.customer_id
group by c.customer_id, c.customer_name;

-- Assign row numbers to each order within a customer

select c.customer_id,
c.customer_name,
o.order_id,
row_number() over(partition by c.customer_id order by o.order_id ASC) as rn
from customers c
JOIN orders o
on c.customer_id=o.customer_id;

-- Display top 3 customers based on total sales. (Window Function) 

select
c.customer_id,
c.customer_name,
SUM(o.sales) as total_sale,
rank() over(order by SUM(o.sales) DESC) as rnk
from customers c
Join orders o
ON c.customer_id=o.customer_id
group by c.customer_id, c.customer_name
LIMIT 3
;

-- OR

with rnked_cust as (select c.customer_id,
c.customer_name,
sum(o.sales) as total_sale,
rank() over(order by sum(o.sales)DESC) as rnk
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id, customer_name)
select customer_id,
customer_name,
total_sale,
rnk
from rnked_cust
where rnk<4;


-- Write one final query that shows: Customer Name , Total Sales ,Rank  
-- (Use JOIN + CTE + Window Function together)

with rnked_cust as (select c.customer_id,
c.customer_name,
sum(o.sales) as total_sale,
rank() over(order by sum(o.sales)DESC) as rnk
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id, customer_name)
select customer_id,
customer_name,
total_sale,
rnk
from rnked_cust;

-- Sanjit Engle> Clay Ludtke>Sanjit Chand are top 3 customers that have highest sale

-- Answer the following using SQL: 

-- Who are the top 5 customers?  
with rnked_cust as (select c.customer_id,
c.customer_name,
sum(o.sales) as total_sale,
rank() over(order by sum(o.sales)DESC) as rnk
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id, customer_name)
select customer_id,
customer_name,
total_sale,
rnk
from rnked_cust
where rnk<6;
-- 1. Sanjit Engle
-- 2. Clay Ludtke
-- 3. Sanjit Chand
-- 4. Ken Lonsdale
-- 5. Sean Miller
-- top 5 cutsomers as per total sales

-- Who are the bottom 5 customers? 
with rnked_cust as (select c.customer_id,
c.customer_name,
sum(o.sales) as total_sale,
rank() over(order by sum(o.sales)ASC) as rnk
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id, customer_name)
select customer_id,
customer_name,
total_sale,
rnk
from rnked_cust
where rnk<6;

-- 1. Lela Donovan
-- 2. Thais Sissman
-- 3. Mitch Gastineau
-- 4. Sung Chung
-- 5. Carl Jackson
-- botton 5 customers as per total sales

-- Which customers made only one order?  
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) = 1;

-- No customer had only one order.

-- Which customers have above-average sales?  
with total_sales as(
select customer_id,
SUM(sales) as total_sale
from orders
group by customer_id
)
select 
c.customer_id, 
c.customer_name,
c.city,
c.state,
c.country,
ts.total_sale as total_sales_above_avg
from customers c
JOIN total_sales ts
ON c.customer_id=ts.customer_id
where ts.total_sale>(select avg(total_sale) from total_sales);

-- Claire Gute, Darrin Van Huff, Darrin Van Huff, Brosina Hoffman,
-- Andrew Allen, Irene Maddox and 4713 others have sales above average.

-- What is the highest order value per customer? 
select 
c.customer_id,
c.customer_name,
c.country,
c.state,
c.city,
o.order_id,
o.sales as highest_order_per_customer
from customers c
JOIN orders o
ON c.customer_id=o.customer_id
WHERE (o.customer_id, o.sales) in
(select customer_id,
Max(sales)
from orders 
group by customer_id) ORDER BY highest_order_per_customer DESC;

-- FINAL BUSINESS INSIGHTS
--
-- 1. Only 23.8% of orders exceed the average sales value, indicating that a small
--    proportion of transactions contribute disproportionately to total revenue.
--
-- 2. Sean Miller recorded the highest individual order value (22,638.48),
--    demonstrating the impact of high-value purchases on overall sales performance.
--
-- 3. Sean Miller, Tamara Chand, and Raymond Buch emerged as major contributors
--    in terms of total customer revenue.
--
-- 4. Mitch Willingham achieved the highest average order value (1,751.29),
--    identifying him as a premium customer with consistently high spending behavior.
--
-- 5. Matt Abelman and William Brown placed the highest number of orders (33 each),
--    indicating strong customer loyalty and repeat purchasing patterns.
--
-- 6. Sanjit Engle, Clay Ludtke, and Sanjit Chand were the top three customers
--    based on total sales, collectively contributing substantial revenue.
--
-- 7. The analysis demonstrates how Subqueries, CTEs, and Window Functions can be
--    leveraged to identify high-value customers, analyze purchasing behavior,
--    and support data-driven business decision making.











        

