USE bookstore;

-- =========================================================
-- SALES & REVENUE ANALYSIS
-- =========================================================

-- Monthly revenue
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    COUNT(Order_ID) AS Orders,
    SUM(Quantity) AS Units_Sold,
    SUM(Total_Amount) AS Revenue
FROM orders
GROUP BY Month
ORDER BY Month;

-- Revenue by genre
SELECT
    b.Genre,
    COUNT(DISTINCT o.Order_ID) AS Orders,
    SUM(o.Quantity) AS Units_Sold,
    SUM(o.Total_Amount) AS Revenue
FROM books b
JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC;

-- Top 10 books by units sold
SELECT
    b.Book_ID,
    b.Title,
    b.Author,
    SUM(o.Quantity) AS Units_Sold
FROM books b
JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Author
ORDER BY Units_Sold DESC
LIMIT 10;

-- Top 10 books by revenue
SELECT
    b.Book_ID,
    b.Title,
    SUM(o.Total_Amount) AS Revenue
FROM books b
JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Revenue DESC
LIMIT 10;

-- Average order value
SELECT AVG(Total_Amount) AS Average_Order_Value
FROM orders;

-- Daily revenue
SELECT
    Order_Date,
    COUNT(Order_ID) AS Orders,
    SUM(Total_Amount) AS Revenue
FROM orders
GROUP BY Order_Date
ORDER BY Order_Date;

-- Highest-value order
SELECT *
FROM orders
ORDER BY Total_Amount DESC
LIMIT 1;

-- Revenue contribution by genre
SELECT
    b.Genre,
    SUM(o.Total_Amount) AS Revenue,
    ROUND(
        100 * SUM(o.Total_Amount) / (SELECT SUM(Total_Amount) FROM orders),
        2
    ) AS Revenue_Percentage
FROM books b
JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC;
