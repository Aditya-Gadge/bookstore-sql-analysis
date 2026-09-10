# Bookstore Sales & Customer Analysis — MySQL

## Project Overview

This project analyzes a bookstore dataset containing books, customers, and orders using MySQL.

The goal is to answer practical business questions around:

- Sales and revenue
- Book and genre performance
- Customer purchasing behavior
- Country-level performance
- Inventory analysis
- Data quality
- Advanced SQL analysis

## Dataset

The project contains three CSV files:

| Dataset | Records | Purpose |
|---|---:|---|
| Books | 500 | Book catalog, pricing and listed stock |
| Customers | 500 | Customer and location information |
| Orders | 500 | Order transactions |

### Books

- `Book_ID`
- `Title`
- `Author`
- `Genre`
- `Published_Year`
- `Price`
- `Stock`

### Customers

- `Customer_ID`
- `Name`
- `Email`
- `Phone`
- `City`
- `Country`

### Orders

- `Order_ID`
- `Customer_ID`
- `Book_ID`
- `Order_Date`
- `Quantity`
- `Total_Amount`

## Database Relationship

```text
Customers
    |
    | 1-to-many
    v
 Orders
    ^
    | many-to-1
    |
  Books
```

`Orders.Customer_ID` references `Customers.Customer_ID`.

`Orders.Book_ID` references `Books.Book_ID`.

## SQL Concepts Demonstrated

- SELECT
- WHERE
- DISTINCT
- ORDER BY
- LIMIT
- INNER JOIN
- LEFT JOIN
- GROUP BY
- HAVING
- SUM / AVG / COUNT
- CASE
- COALESCE
- Subqueries
- CTEs
- RANK
- DENSE_RANK
- LAG
- Running totals
- Date functions
- Data-quality checks
- Primary keys
- Foreign keys

## Project Structure

```text
bookstore-sql-analysis/
│
├── README.md
│
├── data/
│   ├── Books.csv
│   ├── Customers.csv
│   └── Orders.csv
│
├── sql/
│   ├── 01_schema.sql
│   ├── 02_basic_exploration.sql
│   ├── 03_sales_analysis.sql
│   ├── 04_customer_analysis.sql
│   ├── 05_advanced_analysis.sql
│   └── 06_data_quality.sql
│
│
└── docs/
    └── data_dictionary.md
```

## Business Questions

### Sales
1. What is the total revenue?
2. What is the average order value?
3. What are monthly revenues?
4. Which genres generate the most revenue?
5. Which books sell the most units?
6. Which books generate the most revenue?
7. What percentage of revenue comes from each genre?

### Customers
8. Which customers have placed at least two orders?
9. Who are the top customers by spending?
10. Which countries generate the most revenue?
11. Which customers spend above a chosen threshold?
12. Which customers have never placed an order?

### Books & Inventory
13. What is the most expensive book?
14. Which books have the lowest listed stock?
15. Which books have never been ordered?
16. Which authors have the highest number of units sold?
17. How are books ranked by price within each genre?

### Advanced SQL
18. Which book is ordered most frequently?
19. What is the cumulative monthly revenue?
20. How does revenue change month over month?
21. How can orders be classified by order value?
22. How can customers be ranked by total spending?

## Verified Dataset Snapshot

Based directly on the supplied CSV files:

- Books: **500**
- Customers: **500**
- Orders: **500**
- Total order revenue: **$75,628.66**
- Total units ordered: **2,697**
- Average order value: **$151.26**
- Highest-revenue genre: **Romance**
- Top book by units ordered: **Realigned multi-tasking installation**
- Highest-revenue customer country: **Cambodia**

These figures are included only as a project snapshot; run the SQL queries yourself to reproduce them.

## Important Inventory Note

The `Stock` field is treated as **listed stock** in the dataset.

The estimated remaining-stock query in `05_advanced_analysis.sql` assumes `Stock` represents starting inventory. If `Stock` is already current inventory, subtracting historical orders would be incorrect.

## How to Run

### 1. Install MySQL

Use MySQL 8+ and MySQL Workbench or another MySQL client.

### 2. Create the database and tables

Run:

```text
sql/01_schema.sql
```

### 3. Import the CSV files

Import:

```text
data/Books.csv
data/Customers.csv
data/Orders.csv
```

into their corresponding tables.

### 4. Run the analysis

Recommended order:

```text
02_basic_exploration.sql
03_sales_analysis.sql
04_customer_analysis.sql
05_advanced_analysis.sql
06_data_quality.sql
```

## Portfolio Value

This project is designed to demonstrate practical SQL skills for entry-level:

- Data Analyst
- Business Analyst
- SQL Developer
- Junior Data Engineer

## Data Privacy

The supplied datasets should be treated as synthetic/educational data for this portfolio. Do not upload real customer PII to a public repository.

## Author

**Aditya Gadge**

GitHub: Add your GitHub profile URL here.

LinkedIn: Add your LinkedIn profile URL here.
