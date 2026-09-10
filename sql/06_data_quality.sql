USE bookstore;

-- =========================================================
-- DATA QUALITY CHECKS
-- =========================================================

-- Duplicate primary keys
SELECT Book_ID, COUNT(*) AS Cnt
FROM books
GROUP BY Book_ID
HAVING COUNT(*) > 1;

SELECT Customer_ID, COUNT(*) AS Cnt
FROM customers
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

SELECT Order_ID, COUNT(*) AS Cnt
FROM orders
GROUP BY Order_ID
HAVING COUNT(*) > 1;

-- Missing values
SELECT
    SUM(Book_ID IS NULL) AS Missing_Book_ID,
    SUM(Title IS NULL) AS Missing_Title,
    SUM(Author IS NULL) AS Missing_Author,
    SUM(Genre IS NULL) AS Missing_Genre,
    SUM(Price IS NULL) AS Missing_Price,
    SUM(Stock IS NULL) AS Missing_Stock
FROM books;

SELECT
    SUM(Customer_ID IS NULL) AS Missing_Customer_ID,
    SUM(Name IS NULL) AS Missing_Name,
    SUM(Email IS NULL) AS Missing_Email,
    SUM(City IS NULL) AS Missing_City,
    SUM(Country IS NULL) AS Missing_Country
FROM customers;

SELECT
    SUM(Order_ID IS NULL) AS Missing_Order_ID,
    SUM(Customer_ID IS NULL) AS Missing_Customer_ID,
    SUM(Book_ID IS NULL) AS Missing_Book_ID,
    SUM(Order_Date IS NULL) AS Missing_Order_Date,
    SUM(Quantity IS NULL) AS Missing_Quantity,
    SUM(Total_Amount IS NULL) AS Missing_Total_Amount
FROM orders;

-- Invalid numeric values
SELECT * FROM books WHERE Price < 0 OR Stock < 0;
SELECT * FROM orders WHERE Quantity <= 0 OR Total_Amount < 0;

-- Referential integrity checks
SELECT o.*
FROM orders o
LEFT JOIN customers c ON o.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

SELECT o.*
FROM orders o
LEFT JOIN books b ON o.Book_ID = b.Book_ID
WHERE b.Book_ID IS NULL;
