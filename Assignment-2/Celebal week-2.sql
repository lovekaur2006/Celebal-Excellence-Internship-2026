CREATE DATABASE superstore_db;
USE superstore_db;

CREATE TABLE superstore (
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

SHOW COLUMNS FROM superstore;

SELECT *
FROM superstore
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM superstore;

SELECT *FROM superstore WHERE Region = 'West';

SELECT *FROM superstore WHERE Region = 'East';

SELECT *
FROM superstore
WHERE Category = 'Technology';

SELECT *
FROM superstore
WHERE Sales > 1000;

SELECT *
FROM superstore
WHERE Sales BETWEEN 500 AND 2000;

SELECT *
FROM superstore
WHERE YEAR(STR_TO_DATE(order_date,'%m/%d/%Y')) = 2017;

SELECT *
FROM superstore
WHERE Region = 'West'
AND Category = 'Technology';

SELECT Region,
       SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Region;

SELECT Category,
       SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category;

SELECT Category,
       SUM(Quantity) AS Total_Quantity
FROM superstore
GROUP BY Category;

SELECT Category,
       AVG(Sales) AS Average_Sales
FROM superstore
GROUP BY Category;

SELECT Region,
       AVG(Profit) AS Average_Profit
FROM superstore
GROUP BY Region;

SELECT Category,
       SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Category;

SELECT Category,
       SUM(Sales) AS Total_Sales,
       SUM(Quantity) AS Total_Quantity
FROM superstore
GROUP BY Category;

SELECT product_name,
       SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT Category,
       SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT customer_name,
       SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY customer_name
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT MONTH(STR_TO_DATE(order_date, '%m/%d/%Y')) AS Month,
       SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Month
ORDER BY Month;

SELECT customer_name,
SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY customer_name
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT order_id,
       COUNT(*) AS Frequency
FROM superstore
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS Total_Rows
FROM superstore;

SELECT COUNT(*) AS Missing_Sales
FROM superstore
WHERE Sales IS NULL;

SELECT COUNT(*) AS Missing_Profit
FROM superstore
WHERE Profit IS NULL;

SELECT *
FROM superstore
WHERE Sales < 0;