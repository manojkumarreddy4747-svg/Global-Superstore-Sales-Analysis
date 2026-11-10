
Database: GlobalSuperstoreDB
Purpose: Data Quality Checks
Source Table: dbo.Global_Superstore2
*/

USE GlobalSuperstoreDB;
GO

-- Check total records
SELECT COUNT(*) AS Total_Rows
FROM dbo.Global_Superstore2;


-- Check duplicate Row_ID values
SELECT Row_ID, COUNT(*) AS Duplicate_Count
FROM dbo.Global_Superstore2
GROUP BY Row_ID
HAVING COUNT(*) > 1;


-- Check missing values
SELECT
    SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Order_ID,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_ID,
    SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Product_ID,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Date,
    SUM(CASE WHEN Ship_Date IS NULL THEN 1 ELSE 0 END) AS Missing_Ship_Date,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Missing_Sales,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Missing_Profit,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Missing_Quantity
FROM dbo.Global_Superstore2;


-- Check exact duplicate records
SELECT
    Row_ID, Order_ID, Product_ID,
    Customer_ID, Order_Date, Sales,
    COUNT(*) AS Duplicate_Count
FROM dbo.Global_Superstore2
GROUP BY
    Row_ID, Order_ID, Product_ID,
    Customer_ID, Order_Date, Sales
HAVING COUNT(*) > 1;


-- Check invalid dates
SELECT *
FROM dbo.Global_Superstore2
WHERE Ship_Date < Order_Date;


-- Check negative sales
SELECT *
FROM dbo.Global_Superstore2
WHERE Sales < 0;


-- Check invalid quantity
SELECT *
FROM dbo.Global_Superstore2
WHERE Quantity <= 0;


-- Check invalid discount
SELECT *
FROM dbo.Global_Superstore2
WHERE Discount < 0 OR Discount > 1;


-- Check negative shipping cost
SELECT *
FROM dbo.Global_Superstore2
WHERE Shipping_Cost < 0;


-- Understand negative, zero and positive profit
SELECT
    CASE
        WHEN Profit < 0 THEN 'Loss'
        WHEN Profit = 0 THEN 'Zero Profit'
        WHEN Profit > 0 THEN 'Profit'
        ELSE 'Missing Profit'
    END AS Profit_Status,
    COUNT(*) AS Total_Records
FROM dbo.Global_Superstore2
GROUP BY
    CASE
        WHEN Profit < 0 THEN 'Loss'
        WHEN Profit = 0 THEN 'Zero Profit'
        WHEN Profit > 0 THEN 'Profit'
        ELSE 'Missing Profit'
    END;


-- Check Product_ID mapping inconsistencies
SELECT
    Product_ID,
    COUNT(DISTINCT Product_Name) AS Product_Name_Count
FROM dbo.Global_Superstore2
GROUP BY Product_ID
HAVING COUNT(DISTINCT Product_Name) > 1;


-- Check customer ID and customer name mapping
SELECT
    Customer_ID,
    COUNT(DISTINCT Customer_Name) AS Customer_Name_Count
FROM dbo.Global_Superstore2
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Customer_Name) > 1;


-- Final row count
SELECT COUNT(*) AS Final_Row_Count
FROM dbo.Global_Superstore2;
