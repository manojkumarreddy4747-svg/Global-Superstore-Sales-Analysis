
/*
Project: Global Superstore Sales Analysis
Purpose: Create Sales fact table and relationships
Database: GlobalSuperstoreDB
*/

USE GlobalSuperstoreDB;
GO

-- Create Sales table
CREATE TABLE dbo.Sales
(
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    ProductKey INT,
    Segment VARCHAR(50),
    City NVARCHAR(150),
    State NVARCHAR(150),
    Country NVARCHAR(150),
    Postal_Code VARCHAR(20),
    Market VARCHAR(50),
    Region VARCHAR(50),
    Sales DECIMAL(18,4),
    Quantity INT,
    Discount DECIMAL(10,4),
    Profit DECIMAL(18,4) NULL,
    Shipping_Cost DECIMAL(18,4),
    Order_Priority VARCHAR(50)
);
GO

-- Insert records into Sales
INSERT INTO dbo.Sales
(
    Row_ID, Order_ID, Order_Date, Ship_Date,
    Ship_Mode, Customer_ID, ProductKey,
    Segment, City, State, Country, Postal_Code,
    Market, Region, Sales, Quantity,
    Discount, Profit, Shipping_Cost, Order_Priority
)
SELECT
    G.Row_ID,
    G.Order_ID,
    G.Order_Date,
    G.Ship_Date,
    G.Ship_Mode,
    G.Customer_ID,
    P.ProductKey,
    G.Segment,
    G.City,
    G.State,
    G.Country,
    G.Postal_Code,
    G.Market,
    G.Region,
    G.Sales,
    G.Quantity,
    G.Discount,
    G.Profit,
    G.Shipping_Cost,
    G.Order_Priority
FROM dbo.Global_Superstore2 AS G
INNER JOIN dbo.Products AS P
    ON G.Product_ID = P.Product_ID
    AND G.Product_Name = P.Product_Name
    AND G.Category = P.Category
    AND G.Sub_Category = P.Sub_Category;
GO

-- Add Customer foreign key
ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_Sales_Customers
FOREIGN KEY (Customer_ID)
REFERENCES dbo.Customers(Customer_ID);
GO

-- Add Product foreign key
ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_Sales_Products
FOREIGN KEY (ProductKey)
REFERENCES dbo.Products(ProductKey);
GO

-- Validate final table counts
SELECT COUNT(*) AS Staging_Rows
FROM dbo.Global_Superstore2;

SELECT COUNT(*) AS Sales_Rows
FROM dbo.Sales;

SELECT COUNT(*) AS Customer_Rows
FROM dbo.Customers;

SELECT COUNT(*) AS Product_Rows
FROM dbo.Products;
GO
