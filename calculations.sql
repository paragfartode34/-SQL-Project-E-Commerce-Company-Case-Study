--------------------------------------------------  1. Customer Insights  ---------------------------------------------------
-- 1. Top Locations by Total Spend:
SELECT c.location, SUM(o.total_amount) AS total_spend
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.location
ORDER BY total_spend DESC;
-- Chennai has most amount spend 3890000/-
-------------------------------------------------------------------------------------------------------------------------------
-- 2. Most Frequent Customers:
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;
-- Divya Upadhyay has most orders with custumer_id 57 has 8 orders.
--------------------------------------------------------------------------------------------------------------------------------
-- 3.Customer Purchase Patterns by Product Category:
SELECT c.customer_id, c.name, p.category, COUNT(od.product_id) AS total_purchases
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY c.customer_id, c.name, p.category
ORDER BY total_purchases DESC;
-- Customer_id 32 Name Romil Bora purchase 13 times
----------------------------------------------------------------------------------------------------------------------------------
-- 4.Average Spending Per Customer:
SELECT c.customer_id, c.name, AVG(o.total_amount) AS avg_spending
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY avg_spending DESC;
-- Sahil Chaudhary avg_spending is most 321000.0000/-
-----------------------------------------------------------------------------------------------------------------------------------
-- 5. Customer Retention Analysis:
SELECT c.customer_id, c.name, COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING order_count > 1
ORDER BY order_count DESC
LIMIT 5;
-- Divya Upadhyay,Romil Bora,Saksham Buch,Indrans LAnka,Ayesha Wali are geneuie customers.
--------------------------------------------------------------------------------------------------------------------------------------
========================================================================================================================================
----------------------------------------------------------- 2.Product Analysis --------------------------------------------------------
-- 1. Top-Selling Products:
SELECT p.product_id, p.name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC;
-- Digital SLR Camera sold most 151 Qty and Least Smartphone 6"
------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Revenue by Product Category:
SELECT p.category, SUM(od.quantity * od.price_per_unit) AS total_revenue
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;
-- Electronics items has most revenue 12758000/-
-------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Price Performance Analysis:
SELECT p.product_id, p.name, p.price, SUM(od.quantity) AS total_sold, SUM(od.quantity * od.price_per_unit) AS total_revenue
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name, p.price
ORDER BY total_revenue DESC;
-- laptop 15"Pro has most revenue 7560000/-
--------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Least Selling Products:
SELECT p.product_id, p.name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold ASC
LIMIT 3;
-- Smartphone 6" ,Smartwatch Fitness Tracker and LAptop 15" Pro Sold less 108,119,126 respectively .
------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Product Category Sales Trends:
SELECT p.category, MONTH(o.order_date) AS month, SUM(od.quantity) AS total_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
JOIN Orders o ON od.order_id = o.order_id
GROUP BY p.category, month
ORDER BY month ASC, total_sold DESC;
-- In September(9) sales of Electromics is high, In July(7) sales of Wearable Tech is high , In December(12) Sales is high of Photography.
--------------------------------------------------------------------------------------------------------------------------------------------------
===================================================================================================================================================
----------------------------------------------------------- 3.  Sales Optimization ----------------------------------------------------------------
-- 1. Monthly Sales Performance:
SELECT MONTH(o.order_date) AS month, SUM(o.total_amount) AS total_sales
FROM Orders o
GROUP BY month
ORDER BY total_sales DESC;
-- September(9) month sale is highest 2927000/-
------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.Highest Revenue Orders:
SELECT o.order_id, o.order_date, SUM(od.quantity * od.price_per_unit) AS order_revenue
FROM Orders o
JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY o.order_id, o.order_date
ORDER BY order_revenue DESC
LIMIT 10;
-- single day sale or order_id 188 in highest on 2023-07-01
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Sales Trends Over Time:
SELECT YEAR(o.order_date) AS year, MONTH(o.order_date) AS month, SUM(o.total_amount) AS total_sales
FROM Orders o
GROUP BY year, month
ORDER BY year ASC, month ASC;
-- in February , march sales downs.
---------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4.Average Order Value:
SELECT AVG(total_amount) AS avg_order_value
FROM Orders;
-- avg_order_value 98915.00
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5.Sales by Product Category:
SELECT p.category, SUM(od.quantity * od.price_per_unit) AS total_sales
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_sales DESC;
-- Electronics 12758000/-,Photography 6040000/-,Wearable Tech 985000/-
---------------------------------------------------------------------------------------------------------------------------------------------------------------
===============================================================================================================================================================
---------------------------------------------------------- 4.Inventory Management -----------------------------------------------------------------------------
-- 1. Total Stock Sold by Product:
SELECT p.product_id, p.name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC;
-- Digital SLR Camera solds most 151
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Low Stock Products (asuuming 130)
SELECT p.product_id, p.name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name
HAVING total_sold < 130
ORDER BY total_sold ASC;
-- Smartphone 6",SmartWatch Fitness Tracker,Laptop 15"Pro are our least in stocks
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Inventory Turnover Rate (based on sales):
SELECT p.product_id, p.name, SUM(od.quantity*od.price_per_unit) AS total_turnover
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name
ORDER BY total_turnover DESC;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Inventory Usage Over Time:
SELECT p.product_id, p.name, MONTH(o.order_date) AS month, SUM(od.quantity) AS total_used
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
JOIN Orders o ON od.order_id = o.order_id
GROUP BY p.product_id, p.name, month
ORDER BY month ASC, total_used DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5.High Volume Products:
SELECT p.product_id, p.name, SUM(od.price_per_unit) AS total_volume
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name
HAVING total_volume > 400000
ORDER BY total_volume DESC;
-- Laptop 15" Pro,Digital SLR Camera,E-Book Reader,Smartphone 6",Bluetooth Headphones,Portable Bluetooth Speaker are .
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
=====================================================================================================================================================================
------------------------------------------------- Customer Insights: High vs. Low Spending Customers ----------------------------------------------------------------
SELECT c.customer_id, c.name,
       CASE 
           WHEN SUM(o.total_amount) > 150000 THEN 'High Spender'
           ELSE 'Low Spender'
       END AS spending_category
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Product Analysis: Classify Products as High, Medium, or Low Priced --------------------------------------------------
SELECT p.product_id, p.name, p.price,
       CASE 
           WHEN p.price > 20000 THEN 'High Priced'
           WHEN p.price BETWEEN 10000 AND 20000 THEN 'Medium Priced'
           ELSE 'Low Priced'
       END AS price_category
FROM Products p;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------- Sales Optimization Order Size Classification----------------------------------------------------------------------
SELECT o.order_id, o.order_date, o.total_amount,
       CASE 
           WHEN o.total_amount > 50000 THEN 'Large Order'
           WHEN o.total_amount BETWEEN 30000 AND 50000 THEN 'Medium Order'
           ELSE 'Small Order'
       END AS order_size
FROM Orders o;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------- Inventory Management: Sales Volume Category by Product -------------------------------------------------------------
SELECT p.product_id, p.name, SUM(od.quantity) AS total_sold,
       CASE 
           WHEN SUM(od.quantity) > 140 THEN 'High Volume'
           WHEN SUM(od.quantity) BETWEEN 120 AND 140 THEN 'Medium Volume'
           ELSE 'Low Volume'
       END AS sales_volume_category
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ------------------------------------------------------------ Customer Insights: Geographic Customer Analysis-----------------------------------------------------------
 SELECT c.customer_id, c.name, c.location,
       CASE 
           WHEN c.location in ('Delhi','jaipur','lucknow') THEN 'North Region'
           WHEN c.location in  ('Ahmedabad','Mumbai','Pune') THEN 'West Region'
           WHEN c.location in ('Chennai','Hyderabad','Lucknow') THEN 'South Region'
           ELSE 'East Region'
       END AS region
FROM Customers c;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------- Region Wise Sales -------------------------------------------------------------------------------------------
SELECT 
       CASE 
           WHEN c.location IN ('Delhi', 'Jaipur', 'Lucknow') THEN 'North Region'
           WHEN c.location IN ('Ahmedabad', 'Mumbai', 'Pune') THEN 'West Region'
           WHEN c.location IN ('Chennai', 'Hyderabad', 'Bangalore') THEN 'South Region'
           WHEN c.location = 'Kolkata' THEN 'East Region'
       END AS region,
       SUM(o.total_amount) AS region_sales
FROM Customers c 
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY CASE 
           WHEN c.location IN ('Delhi', 'Jaipur', 'Lucknow') THEN 'North Region'
           WHEN c.location IN ('Ahmedabad', 'Mumbai', 'Pune') THEN 'West Region'
           WHEN c.location IN ('Chennai', 'Hyderabad', 'Bangalore') THEN 'South Region'
           WHEN c.location = 'Kolkata' THEN 'East Region'
         END
ORDER BY region_sales DESC;
-- South Region Has maximum sales 7378000/- 
======================================================================================================================================================================







 




