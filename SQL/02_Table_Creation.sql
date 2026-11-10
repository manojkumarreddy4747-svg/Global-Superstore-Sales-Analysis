
USE GlobalSuperstoreDB;
GO

--- Create Customers table

CREATE TABLE dbo.Customers
(
    Customer_ID NVARCHAR(50) NOT NULL,
    Customer_Name NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Customers PRIMARY KEY (Customer_ID)
);
GO


--- Create Products table

CREATE TABLE dbo.Products
(
    ProductKey INT IDENTITY(1,1) NOT NULL,
    Product_ID NVARCHAR(50) NOT NULL,
    Product_Name NVARCHAR(500) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    Sub_Category NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Products PRIMARY KEY (ProductKey),
    CONSTRAINT UQ_Products UNIQUE
    (
        Product_ID,
        Product_Name,
        Category,
        Sub_Category
    )
);
GO


--- Create Sales table

CREATE TABLE dbo.Sales
(
    Row_ID INT NOT NULL PRIMARY KEY,
    Order_ID NVARCHAR(50) NOT NULL,
    Order_Date DATE NOT NULL,
    Ship_Date DATE NOT NULL,
    Ship_Mode NVARCHAR(100),
    Customer_ID NVARCHAR(50) NOT NULL,
    ProductKey INT NOT NULL,
    Segment NVARCHAR(100),
    City NVARCHAR(150),
    State NVARCHAR(150),
    Country NVARCHAR(150),
    Postal_Code NVARCHAR(50),
    Market NVARCHAR(100),
    Region NVARCHAR(100),
    Sales DECIMAL(19,4) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(9,4) NOT NULL,
    Profit DECIMAL(19,4) NULL,
    Shipping_Cost DECIMAL(19,4) NOT NULL,
    Order_Priority NVARCHAR(50)
);
GO


--- Insert Customers

INSERT INTO dbo.Customers
(
    Customer_ID,
    Customer_Name
)
SELECT DISTINCT
    Customer_ID,
    Customer_Name
FROM dbo.Global_Superstore2;


--- Insert Products

INSERT INTO dbo.Products
(
    Product_ID,
    Product_Name,
    Category,
    Sub_Category
)
SELECT DISTINCT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category
FROM dbo.Global_Superstore2;


--- Insert Sales using ProductKey

INSERT INTO dbo.Sales
(
    Row_ID, Order_ID, Order_Date, Ship_Date,
    Ship_Mode, Customer_ID, ProductKey,
    Segment, City, State, Country, Postal_Code,
    Market, Region, Sales, Quantity, Discount,
    Profit, Shipping_Cost, Order_Priority
)
SELECT
    S.Row_ID,
    S.Order_ID,
    S.Order_Date,
    S.Ship_Date,
    S.Ship_Mode,
    S.Customer_ID,
    P.ProductKey,
    S.Segment,
    S.City,
    S.State,
    S.Country,
    S.Postal_Code,
    S.Market,
    S.Region,
    S.Sales,
    S.Quantity,
    S.Discount,
    S.Profit,
    S.Shipping_Cost,
    S.Order_Priority
FROM dbo.Global_Superstore2 AS S
INNER JOIN dbo.Products AS P
    ON S.Product_ID = P.Product_ID
    AND S.Product_Name = P.Product_Name
    AND S.Category = P.Category
    AND S.Sub_Category = P.Sub_Category;


--- Create customer relationship

ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_Sales_Customers
FOREIGN KEY (Customer_ID)
REFERENCES dbo.Customers(Customer_ID);


--- Create product relationship

ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_Sales_Products
FOREIGN KEY (ProductKey)
REFERENCES dbo.Products(ProductKey);


--- Verify all table record counts

SELECT 'Staging' AS Table_Name, COUNT(*) AS Total_Rows
FROM dbo.Global_Superstore2
UNION ALL
SELECT 'Customers', COUNT(*) FROM dbo.Customers
UNION ALL
SELECT 'Products', COUNT(*) FROM dbo.Products
UNION ALL
SELECT 'Sales', COUNT(*) FROM dbo.Sales;


--- Verify foreign key relationships

SELECT
    fk.name AS Foreign_Key_Name,
    OBJECT_NAME(fk.parent_object_id) AS Child_Table,
    OBJECT_NAME(fk.referenced_object_id) AS Parent_Table
FROM sys.foreign_keys AS fk
WHERE fk.parent_object_id = OBJECT_ID('dbo.Sales');


--- Verify Sales primary key

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Row_ID) AS Unique_Row_IDs
FROM dbo.Sales;


--- Verify missing customer relationships

SELECT COUNT(*) AS Missing_Customer_Relationships
FROM dbo.Sales AS S
LEFT JOIN dbo.Customers AS C
    ON S.Customer_ID = C.Customer_ID
WHERE C.Customer_ID IS NULL;


--- Verify missing product relationships

SELECT COUNT(*) AS Missing_Product_Relationships
FROM dbo.Sales AS S
LEFT JOIN dbo.Products AS P
    ON S.ProductKey = P.ProductKey
WHERE P.ProductKey IS NULL;
GO
