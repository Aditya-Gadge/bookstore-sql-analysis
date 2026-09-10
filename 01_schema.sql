-- Bookstore SQL Analysis
-- Database: MySQL 8+
-- Run this file before the analysis scripts.

CREATE DATABASE IF NOT EXISTS bookstore;
USE bookstore;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS books;

CREATE TABLE books (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    Published_Year INT,
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(50),
    City VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Book_ID INT NOT NULL,
    Order_Date DATE,
    Quantity INT NOT NULL,
    Total_Amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID),
    CONSTRAINT fk_orders_book
        FOREIGN KEY (Book_ID) REFERENCES books(Book_ID)
);

-- Import the CSV files using MySQL Workbench/Table Data Import Wizard,
-- or your preferred MySQL loading method.
--
-- Expected files:
-- data/Books.csv
-- data/Customers.csv
-- data/Orders.csv
