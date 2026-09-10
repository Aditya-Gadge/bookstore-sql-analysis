USE bookstore;

-- =========================================================
-- BASIC DATA EXPLORATION
-- =========================================================

SHOW TABLES;

SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

-- Number of records
SELECT COUNT(*) AS total_books FROM books;
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;

-- Fiction books
SELECT *
FROM books
WHERE Genre = 'Fiction';

-- Books published after 1950
SELECT *
FROM books
WHERE Published_Year > 1950;

-- Customers from Canada
SELECT *
FROM customers
WHERE Country = 'Canada';

-- Orders placed in November 2023
SELECT *
FROM orders
WHERE Order_Date >= '2023-11-01'
  AND Order_Date < '2023-12-01';

-- Total stock listed in the books table
SELECT SUM(Stock) AS total_stock
FROM books;

-- Most expensive book
SELECT *
FROM books
ORDER BY Price DESC
LIMIT 1;

-- Orders with quantity greater than 1
SELECT *
FROM orders
WHERE Quantity > 1;

-- Orders where total amount exceeds $20
SELECT *
FROM orders
WHERE Total_Amount > 20.00;

-- All available genres
SELECT DISTINCT Genre
FROM books;

-- Book with the lowest listed stock
SELECT *
FROM books
ORDER BY Stock ASC
LIMIT 1;

-- Total revenue
SELECT SUM(Total_Amount) AS total_revenue
FROM orders;
