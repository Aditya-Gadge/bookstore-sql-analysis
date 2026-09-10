USE bookstore;

-- =========================================================
-- ADVANCED SQL ANALYSIS
-- =========================================================

-- 1. Total books sold by genre
SELECT
    b.Genre,
    SUM(o.Quantity) AS Books_Sold
FROM books b
JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Books_Sold DESC;

-- 2. Average book price in Fantasy
SELECT
    Genre,
    AVG(Price) AS Avg_Book_Price
FROM books
WHERE Genre = 'Fantasy'
GROUP BY Genre;

-- 3. Most frequently ordered book
SELECT
    o.Book_ID,
    b.Title,
    COUNT(o.Order_ID) AS Order_Count
FROM orders o
JOIN books b ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Order_Count DESC
LIMIT 1;

-- 4. Handle ties for the most frequently ordered book
WITH book_order_count AS (
    SELECT
        o.Book_ID,
        b.Title,
        COUNT(o.Order_ID) AS Number_Of_Orders
    FROM orders o
    JOIN books b ON o.Book_ID = b.Book_ID
    GROUP BY o.Book_ID, b.Title
)
SELECT *
FROM book_order_count
WHERE Number_Of_Orders = (
    SELECT MAX(Number_Of_Orders)
    FROM book_order_count
);

-- 5. Top 3 most expensive Fantasy books
SELECT
    Book_ID,
    Title,
    Author,
    Price
FROM books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- 6. Total quantity sold by author
SELECT
    b.Author,
    SUM(o.Quantity) AS Books_Sold
FROM books b
JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY Books_Sold DESC;

-- 7. Rank books by price within each genre
SELECT
    Book_ID,
    Title,
    Genre,
    Price,
    RANK() OVER (
        PARTITION BY Genre
        ORDER BY Price DESC
    ) AS Price_Rank
FROM books;

-- 8. Rank customers by total spending
WITH customer_spend AS (
    SELECT
        c.Customer_ID,
        c.Name,
        SUM(o.Total_Amount) AS Total_Spent
    FROM customers c
    JOIN orders o ON c.Customer_ID = o.Customer_ID
    GROUP BY c.Customer_ID, c.Name
)
SELECT
    Customer_ID,
    Name,
    Total_Spent,
    DENSE_RANK() OVER (ORDER BY Total_Spent DESC) AS Spending_Rank
FROM customer_spend
ORDER BY Spending_Rank;

-- 9. Running monthly revenue
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        SUM(Total_Amount) AS Revenue
    FROM orders
    GROUP BY Month
)
SELECT
    Month,
    Revenue,
    SUM(Revenue) OVER (ORDER BY Month) AS Cumulative_Revenue
FROM monthly_revenue
ORDER BY Month;

-- 10. Monthly revenue change
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        SUM(Total_Amount) AS Revenue
    FROM orders
    GROUP BY Month
)
SELECT
    Month,
    Revenue,
    LAG(Revenue) OVER (ORDER BY Month) AS Previous_Month_Revenue,
    Revenue - LAG(Revenue) OVER (ORDER BY Month) AS Revenue_Change
FROM monthly_revenue
ORDER BY Month;

-- 11. Categorize orders by value
SELECT
    Order_ID,
    Total_Amount,
    CASE
        WHEN Total_Amount < 20 THEN 'Low Value'
        WHEN Total_Amount < 50 THEN 'Medium Value'
        ELSE 'High Value'
    END AS Order_Category
FROM orders;

-- 12. Books with no orders
SELECT
    b.Book_ID,
    b.Title,
    b.Stock
FROM books b
LEFT JOIN orders o ON b.Book_ID = o.Book_ID
WHERE o.Order_ID IS NULL;

-- 13. Customers with no orders
SELECT
    c.Customer_ID,
    c.Name,
    c.Country
FROM customers c
LEFT JOIN orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Order_ID IS NULL;

-- 14. Estimated remaining stock.
-- IMPORTANT: This assumes books.Stock represents starting stock.
-- If Stock is already current inventory, do not subtract orders again.
SELECT
    b.Book_ID,
    b.Title,
    b.Stock AS Starting_Stock,
    COALESCE(SUM(o.Quantity), 0) AS Units_Ordered,
    b.Stock - COALESCE(SUM(o.Quantity), 0) AS Estimated_Remaining_Stock
FROM books b
LEFT JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
ORDER BY Estimated_Remaining_Stock ASC;
