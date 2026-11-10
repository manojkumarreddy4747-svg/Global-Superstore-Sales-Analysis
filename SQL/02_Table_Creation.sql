
/*
Project: Global Superstore Sales Analysis
Purpose: Create relational tables
Database: GlobalSuperstoreDB
*/

USE GlobalSuperstoreDB;
GO

-- Create Customers table
CREATE TABLE dbo.Customers
(
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Customer_Name VARCHAR(150)
);
GO

-- Insert unique customers
INSERT INTO dbo.Customers (Customer_ID, Customer_Name)
SELECT DISTINCT Customer_ID, Customer_Name
FROM dbo.Global_Superstore2;
GO

-- Create Products table
CREATE TABLE dbo.Products
(
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    Product_ID VARCHAR(50),
    Product_Name NVARCHAR(500),
    Category VARCHAR(100),
    Sub_Category VARCHAR(100),
    CONSTRAINT UQ_Products UNIQUE
    (Product_ID, Product_Name, Category, Sub_Category)
);
GO

-- Insert unique product combinations
INSERT INTO dbo.Products
(
    Product_ID, Product_Name, Category, Sub_Category
)
SELECT DISTINCT
    Product_ID, Product_Name, Category, Sub_Category
FROM dbo.Global_Superstore2;
GO

-- Check customer and product counts
SELECT COUNT(*) AS Total_Customers
FROM dbo.Customers;

SELECT COUNT(*) AS Total_Products
FROM dbo.Products;
GO
