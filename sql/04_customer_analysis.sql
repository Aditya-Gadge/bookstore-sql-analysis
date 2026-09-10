USE bookstore;

-- =========================================================
-- CUSTOMER ANALYSIS
-- =========================================================

-- Customers with at least 2 orders
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2
ORDER BY Total_Orders DESC;

-- Top 10 customers by total spending
SELECT
    c.Customer_ID,
    c.Name,
    c.Country,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Spent
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name, c.Country
ORDER BY Total_Spent DESC
LIMIT 10;

-- Customers spending more than $100
SELECT
    c.Customer_ID,
    c.Name,
    SUM(o.Total_Amount) AS Total_Spent
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING SUM(o.Total_Amount) > 100
ORDER BY Total_Spent DESC;

-- Revenue by country
SELECT
    c.Country,
    COUNT(DISTINCT c.Customer_ID) AS Customers,
    COUNT(o.Order_ID) AS Orders,
    SUM(o.Total_Amount) AS Revenue
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Country
ORDER BY Revenue DESC;

-- Cities where at least one order exceeded $30
SELECT DISTINCT c.City
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30
ORDER BY c.City;

-- Number of cities represented by orders above $30
SELECT COUNT(DISTINCT c.City) AS Cities
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30;

-- Customer with the highest lifetime spend
SELECT
    c.Customer_ID,
    c.Name,
    SUM(o.Total_Amount) AS Total_Spent
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spent DESC
LIMIT 1;
