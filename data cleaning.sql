

SELECT
    COUNT(*) AS Total_Records,

    COUNT(*) - COUNT(Order_Date)
        AS Missing_Order_Date,

    COUNT(*) - COUNT(Ship_Date)
        AS Missing_Ship_Date

FROM dbo.Global_Superstore2;


SELECT
    Order_ID,
    Order_Date,
    Ship_Date
FROM dbo.Global_Superstore2
WHERE Ship_Date < Order_Date;

---how many days it takes to ship products after customers place orders.

SELECT
    Order_ID,
    Order_Date,
    Ship_Date,
    DATEDIFF(DAY, Order_Date, Ship_Date) AS Shipping_Days
FROM dbo.Global_Superstore2;

---AVG day difference
SELECT
    AVG(CAST(DATEDIFF(DAY, Order_Date, Ship_Date) AS DECIMAL(10,2)))
        AS Average_Shipping_Days
FROM dbo.Global_Superstore2;
---Find earliest and latest dates

SELECT
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Last_Order_Date,
    MIN(Ship_Date) AS First_Ship_Date,
    MAX(Ship_Date) AS Last_Ship_Date
FROM dbo.Global_Superstore2;

----Check duplicate order records
SELECT
    Order_ID,
    COUNT(*) AS duplicate_Count
FROM dbo.Global_Superstore2
GROUP BY Order_ID
HAVING COUNT(*) > 1
ORDER BY duplicate_Count DESC;


SELECT *
FROM dbo.Global_Superstore2
WHERE Order_ID = 'CA-2014-100111'
ORDER BY Order_ID;

SELECT
    COUNT(*) AS Duplicate_Row_Groups
FROM
(
    SELECT *
    FROM dbo.Global_Superstore2
    GROUP BY
        Row_ID, Order_ID, Order_Date, Ship_Date,
        Ship_Mode, Customer_ID, Customer_Name,
        Segment, City, State, Country, Postal_Code,
        Market, Region, Product_ID, Category,
        Sub_Category, Product_Name, Sales,
        Quantity, Discount, Profit, Shipping_Cost,
        Order_Priority
    HAVING COUNT(*) > 1
) AS Duplicates;
-----Check missing values (NULL)

SELECT
    COUNT(*) - COUNT(Customer_ID) AS Missing_Customer_ID,
    COUNT(*) - COUNT(Product_ID) AS Missing_Product_ID,
    COUNT(*) - COUNT(Sales) AS Missing_Sales,
    COUNT(*) - COUNT(Quantity) AS Missing_Quantity,
    COUNT(*) - COUNT(Discount) AS Missing_Discount,
    COUNT(*) - COUNT(Profit) AS Missing_Profit,
    COUNT(*) - COUNT(Shipping_Cost) AS Missing_Shipping_Cost
FROM dbo.Global_Superstore2;


SELECT
    COUNT(*) AS Missing_Profit_Rows,
    COUNT(Sales) AS Valid_Sales,
    COUNT(Quantity) AS Valid_Quantity,
    SUM(Sales) AS Total_Sales
FROM dbo.Global_Superstore2
WHERE Profit IS NULL;



SELECT
    COUNT(*) - COUNT(Order_ID) AS Missing_Order_ID,
    COUNT(*) - COUNT(Customer_Name) AS Missing_Customer_Name,
    COUNT(*) - COUNT(City) AS Missing_City,
    COUNT(*) - COUNT(State) AS Missing_State,
    COUNT(*) - COUNT(Country) AS Missing_Country,
    COUNT(*) - COUNT(Category) AS Missing_Category,
    COUNT(*) - COUNT(Sub_Category) AS Missing_Sub_Category,
    COUNT(*) - COUNT(Product_Name) AS Missing_Product_Name
FROM dbo.Global_Superstore2;

------Check numerical values
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Sales = 0 THEN 1 ELSE 0 END) AS Zero_Sales,
    SUM(CASE WHEN Sales < 0 THEN 1 ELSE 0 END) AS Negative_Sales
FROM dbo.Global_Superstore2;

-------Check negative Profit values
SELECT
    COUNT(*) AS Negative_Profit_Rows,
    MIN(Profit) AS Lowest_Profit,
    MAX(Profit) AS Highest_Negative_Profit
FROM dbo.Global_Superstore2
WHERE Profit < 0;



-----Check zero and positive Profit records

SELECT
    SUM(CASE WHEN Profit = 0 THEN 1 ELSE 0 END) AS Zero_Profit_Rows,
    SUM(CASE WHEN Profit > 0 THEN 1 ELSE 0 END) AS Positive_Profit_Rows,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Missing_Profit_Rows
FROM dbo.Global_Superstore2;


----Check negative Sales and Quantity

SELECT
    SUM(CASE WHEN [Sales] = 0 THEN 1 ELSE 0 END) AS Negative_Sales,
    SUM(CASE WHEN [Quantity] < 0 THEN 1 ELSE 0 END) AS Negative_Quantity,
    SUM(CASE WHEN [Quantity] =0  THEN 1 ELSE 0 END) AS ZERO
FROM dbo.Global_Superstore2;

-----Check Discount values
SELECT
    MIN(Discount) AS Minimum_Discount,
    MAX(Discount) AS Maximum_Discount,
    SUM(CASE WHEN Discount < 0 THEN 1 ELSE 0 END) AS Negative_Discount,
    SUM(CASE WHEN Discount > 1 THEN 1 ELSE 0 END) AS Discount_Above_100_Percent
FROM dbo.Global_Superstore2;

--------Check Shipping Cost
SELECT
    MIN(Shipping_Cost) AS Minimum_Shipping_Cost,
    MAX(Shipping_Cost) AS Maximum_Shipping_Cost,
    SUM(CASE WHEN Shipping_Cost < 0 THEN 1 ELSE 0 END) AS Negative_Shipping_Cost,
    SUM(CASE WHEN Shipping_Cost = 0 THEN 1 ELSE 0 END) AS Zero_Shipping_Cost
FROM dbo.Global_Superstore2;


SELECT *
FROM dbo.Global_Superstore2
WHERE Shipping_Cost = 0;

-------Check Postal Code NULL values
SELECT
    COUNT(*) AS Total_Records,
    COUNT(*) - COUNT(Postal_Code) AS Missing_Postal_Codes
FROM dbo.Global_Superstore2;

SELECT
    Country,
    COUNT(*) AS Missing_Postal_Code_Records
FROM dbo.Global_Superstore2
WHERE Postal_Code IS NULL
GROUP BY Country
ORDER BY Missing_Postal_Code_Records DESC;

SELECT
    Country,
    COUNT(*) AS Total_Records,
    COUNT(Postal_Code) AS Available_Postal_Codes,
    COUNT(*) - COUNT(Postal_Code) AS Missing_Postal_Codes
FROM dbo.Global_Superstore2
GROUP BY Country
ORDER BY Missing_Postal_Codes DESC;
--All 9,994 available Postal Codes belong to the United States. All records from other countries have NULL Postal Codes

---Check Quantity distribution
SELECT
    MIN(Quantity) AS Minimum_Quantity,
    MAX(Quantity) AS Maximum_Quantity,
    AVG(CAST(Quantity AS DECIMAL(10,2))) AS Average_Quantity,
    COUNT(DISTINCT Quantity) AS Unique_Quantity_Values
FROM dbo.Global_Superstore2;

SELECT
    Quantity,
    COUNT(*) AS Number_Of_Records
FROM dbo.Global_Superstore2
GROUP BY Quantity
ORDER BY Quantity;

---Check Order Priority values

SELECT
    Order_Priority,
    COUNT(*) AS Total_Records
FROM dbo.Global_Superstore2
GROUP BY Order_Priority
ORDER BY Total_Records DESC;

---Check Ship Mode distribution
SELECT
    Ship_Mode,
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM dbo.Global_Superstore2
GROUP BY Ship_Mode
ORDER BY Total_Orders DESC;
---Check Customer ID consistency
SELECT
    Customer_ID,
    COUNT(DISTINCT Customer_Name) AS Customer_Name_Count
FROM dbo.Global_Superstore2
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Customer_Name) > 1;

---Check Product  ID consistency
SELECT
    Product_ID,
    COUNT(DISTINCT Product_Name) AS Product_Name_Count
FROM dbo.Global_Superstore2
GROUP BY Product_ID
HAVING COUNT(DISTINCT Product_Name) > 1;

SELECT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    COUNT(*) AS Record_Count
FROM dbo.Global_Superstore2
WHERE Product_ID = 'OFF-PA-10004673'
GROUP BY
    Product_ID,
    Product_Name,
    Category,
    Sub_Category
ORDER BY Product_Name;

SELECT
    COUNT(*) AS Product_IDs_With_Multiple_Names
FROM
(
    SELECT Product_ID
    FROM dbo.Global_Superstore2
    GROUP BY Product_ID
    HAVING COUNT(DISTINCT Product_Name) > 1
) AS ProductIssues;


SELECT
    Product_ID,
    COUNT(DISTINCT Category) AS Category_Count,
    COUNT(DISTINCT Sub_Category) AS Sub_Category_Count
FROM dbo.Global_Superstore2
GROUP BY Product_ID
HAVING
    COUNT(DISTINCT Category) > 1
    OR COUNT(DISTINCT Sub_Category) > 1;

    SELECT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    COUNT(*) AS Record_Count
FROM dbo.Global_Superstore2
WHERE Product_ID = 'OFF-AVE-10002102'
GROUP BY
    Product_ID,
    Product_Name,
    Category,
    Sub_Category
ORDER BY Sub_Category, Product_Name


SELECT
    COUNT(*) AS Product_IDs_With_Multiple_SubCategories
FROM
(
    SELECT Product_ID
    FROM dbo.Global_Superstore2
    GROUP BY Product_ID
    HAVING COUNT(DISTINCT Sub_Category) > 1
) AS ProductIssues;

SELECT
    COUNT(*) AS Distinct_Product_Combinations
FROM
(
    SELECT DISTINCT
        Product_ID,
        Product_Name,
        Category,
        Sub_Category
    FROM dbo.Global_Superstore2
) AS Products;


---- Check duplicate product combinations

SELECT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    COUNT(*) AS Record_Count
FROM dbo.Global_Superstore2
GROUP BY
    Product_ID,
    Product_Name,
    Category,
    Sub_Category
HAVING COUNT(*) > 1
ORDER BY Record_Count DESC;

SELECT
    Ship_Mode,
    COUNT(*) AS Record_Count
FROM dbo.Global_Superstore2
GROUP BY Ship_Mode
ORDER BY Record_Count DESC;

---Check Segment values
SELECT
    Segment,
    COUNT(*) AS Record_Count
FROM dbo.Global_Superstore2
GROUP BY Segment
ORDER BY Record_Count DESC;

----- NULL and blank values
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Segment IS NULL THEN 1 ELSE 0 END) AS Null_Count,
    SUM(CASE WHEN LTRIM(RTRIM(Segment)) = '' THEN 1 ELSE 0 END) AS Blank_Count
FROM dbo.Global_Superstore2;

----- Check Region NULL and blank values
SELECT
    Region,
    COUNT(*) AS Record_Count
FROM dbo.Global_Superstore2
GROUP BY Region
ORDER BY Record_Count DESC;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS Null_Count,
    SUM(CASE
        WHEN LTRIM(RTRIM(Region)) = '' THEN 1
        ELSE 0
    END) AS Blank_Count
FROM dbo.Global_Superstore2;

----Check Market values and  Values

SELECT
    Market,
    COUNT(*) AS Record_Count
FROM dbo.Global_Superstore2
GROUP BY Market
ORDER BY Record_Count DESC;


SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Market IS NULL THEN 1 ELSE 0 END) AS Null_Count,
    SUM(CASE
        WHEN LTRIM(RTRIM(Market)) = '' THEN 1
        ELSE 0
    END) AS Blank_Count
FROM dbo.Global_Superstore2;

---Country and null
SELECT
    Country,
    COUNT(*) AS Record_Count
FROM dbo.Global_Superstore2
GROUP BY Country
ORDER BY Record_Count DESC;
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE
        WHEN Country IS NULL THEN 1
        ELSE 0
    END) AS Null_Count,
    SUM(CASE
        WHEN LTRIM(RTRIM(Country)) = '' THEN 1
        ELSE 0
    END) AS Blank_Count
FROM dbo.Global_Superstore2;

----- City and State validation

SELECT
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_Null,
    SUM(CASE WHEN LTRIM(RTRIM(City)) = '' THEN 1 ELSE 0 END) AS City_Blank,

    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null,
    SUM(CASE WHEN LTRIM(RTRIM(State)) = '' THEN 1 ELSE 0 END) AS State_Blank

FROM dbo.Global_Superstore2;



SELECT
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN Customer_ID IS NULL OR LTRIM(RTRIM(Customer_ID)) = '' THEN 1 ELSE 0 END) AS Customer_ID_Missing,

    SUM(CASE WHEN Customer_Name IS NULL OR LTRIM(RTRIM(Customer_Name)) = '' THEN 1 ELSE 0 END) AS Customer_Name_Missing,

    SUM(CASE WHEN Product_ID IS NULL OR LTRIM(RTRIM(Product_ID)) = '' THEN 1 ELSE 0 END) AS Product_ID_Missing,

    SUM(CASE WHEN Product_Name IS NULL OR LTRIM(RTRIM(Product_Name)) = '' THEN 1 ELSE 0 END) AS Product_Name_Missing,

    SUM(CASE WHEN Category IS NULL OR LTRIM(RTRIM(Category)) = '' THEN 1 ELSE 0 END) AS Category_Missing,

    SUM(CASE WHEN Sub_Category IS NULL OR LTRIM(RTRIM(Sub_Category)) = '' THEN 1 ELSE 0 END) AS Sub_Category_Missing,

    SUM(CASE WHEN Order_ID IS NULL OR LTRIM(RTRIM(Order_ID)) = '' THEN 1 ELSE 0 END) AS Order_ID_Missing

FROM dbo.Global_Superstore2;


---Row_ID uniqueness

USE GlobalSuperstoreDB;
GO

-- Check Row_ID uniqueness
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Row_ID) AS Unique_Row_IDs,
    COUNT(*) - COUNT(DISTINCT Row_ID) AS Duplicate_Count
FROM dbo.Global_Superstore2;


--Check Order_ID summary
SELECT
    COUNT(DISTINCT Order_ID) AS Unique_Orders,
    COUNT(*) AS Total_Product_Lines
FROM dbo.Global_Superstore2;


--Find orders linked to multiple customers
SELECT
    Order_ID,
    COUNT(DISTINCT Customer_ID) AS Customer_Count
FROM dbo.Global_Superstore2
GROUP BY Order_ID
HAVING COUNT(DISTINCT Customer_ID) > 1;


-- Find orders linked to multiple dates
SELECT
    Order_ID,
    COUNT(DISTINCT Order_Date) AS Date_Count
FROM dbo.Global_Superstore2
GROUP BY Order_ID
HAVING COUNT(DISTINCT Order_Date) > 1;


-- Find orders linked to multiple countries
SELECT
    Order_ID,
    COUNT(DISTINCT Country) AS Country_Count
FROM dbo.Global_Superstore2
GROUP BY Order_ID
HAVING COUNT(DISTINCT Country) > 1;


--Check Customer_ID uniqueness and mapping
SELECT
    COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM dbo.Global_Superstore2;


--Check customer name consistency
SELECT
    Customer_ID,
    COUNT(DISTINCT Customer_Name) AS Name_Count
FROM dbo.Global_Superstore2
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Customer_Name) > 1;


--Check product combinations
SELECT
    COUNT(*) AS Unique_Product_Combinations
FROM
(
    SELECT DISTINCT
        Product_ID,
        Product_Name,
        Category,
        Sub_Category
    FROM dbo.Global_Superstore2
) AS P;


-- Check Category and Sub_Category combinations
SELECT
    Category,
    Sub_Category,
    COUNT(DISTINCT Product_ID) AS Product_Count
FROM dbo.Global_Superstore2
GROUP BY Category, Sub_Category
ORDER BY Category, Sub_Category;


-- Check text columns for leading/trailing spaces
SELECT
    SUM(CASE WHEN Customer_ID <> LTRIM(RTRIM(Customer_ID))
        THEN 1 ELSE 0 END) AS Customer_ID_Spaces,
    SUM(CASE WHEN Customer_Name <> LTRIM(RTRIM(Customer_Name))
        THEN 1 ELSE 0 END) AS Customer_Name_Spaces,
    SUM(CASE WHEN Product_ID <> LTRIM(RTRIM(Product_ID))
        THEN 1 ELSE 0 END) AS Product_ID_Spaces,
    SUM(CASE WHEN Product_Name <> LTRIM(RTRIM(Product_Name))
        THEN 1 ELSE 0 END) AS Product_Name_Spaces,
    SUM(CASE WHEN Category <> LTRIM(RTRIM(Category))
        THEN 1 ELSE 0 END) AS Category_Spaces,
    SUM(CASE WHEN Sub_Category <> LTRIM(RTRIM(Sub_Category))
        THEN 1 ELSE 0 END) AS Sub_Category_Spaces,
    SUM(CASE WHEN Order_ID <> LTRIM(RTRIM(Order_ID))
        THEN 1 ELSE 0 END) AS Order_ID_Spaces
FROM dbo.Global_Superstore2;


-- 11Check negative shipping duration
SELECT
    COUNT(*) AS Invalid_Shipping_Duration
FROM dbo.Global_Superstore2
WHERE Ship_Date < Order_Date;


-- 12Final row count
SELECT COUNT(*) AS Final_Total_Rows
FROM dbo.Global_Superstore2;


--- Text whitespace validation

SELECT
    SUM(CASE WHEN Ship_Mode IS NOT NULL
        AND Ship_Mode <> LTRIM(RTRIM(Ship_Mode))
        THEN 1 ELSE 0 END) AS Ship_Mode_Spaces,

    SUM(CASE WHEN Customer_ID IS NOT NULL
        AND Customer_ID <> LTRIM(RTRIM(Customer_ID))
        THEN 1 ELSE 0 END) AS Customer_ID_Spaces,

    SUM(CASE WHEN Customer_Name IS NOT NULL
        AND Customer_Name <> LTRIM(RTRIM(Customer_Name))
        THEN 1 ELSE 0 END) AS Customer_Name_Spaces,

    SUM(CASE WHEN Segment IS NOT NULL
        AND Segment <> LTRIM(RTRIM(Segment))
        THEN 1 ELSE 0 END) AS Segment_Spaces,

    SUM(CASE WHEN City IS NOT NULL
        AND City <> LTRIM(RTRIM(City))
        THEN 1 ELSE 0 END) AS City_Spaces,

    SUM(CASE WHEN State IS NOT NULL
        AND State <> LTRIM(RTRIM(State))
        THEN 1 ELSE 0 END) AS State_Spaces,

    SUM(CASE WHEN Country IS NOT NULL
        AND Country <> LTRIM(RTRIM(Country))
        THEN 1 ELSE 0 END) AS Country_Spaces,

    SUM(CASE WHEN Market IS NOT NULL
        AND Market <> LTRIM(RTRIM(Market))
        THEN 1 ELSE 0 END) AS Market_Spaces,

    SUM(CASE WHEN Region IS NOT NULL
        AND Region <> LTRIM(RTRIM(Region))
        THEN 1 ELSE 0 END) AS Region_Spaces,

    SUM(CASE WHEN Product_ID IS NOT NULL
        AND Product_ID <> LTRIM(RTRIM(Product_ID))
        THEN 1 ELSE 0 END) AS Product_ID_Spaces,

    SUM(CASE WHEN Category IS NOT NULL
        AND Category <> LTRIM(RTRIM(Category))
        THEN 1 ELSE 0 END) AS Category_Spaces,

    SUM(CASE WHEN Sub_Category IS NOT NULL
        AND Sub_Category <> LTRIM(RTRIM(Sub_Category))
        THEN 1 ELSE 0 END) AS Sub_Category_Spaces,

    SUM(CASE WHEN Product_Name IS NOT NULL
        AND Product_Name <> LTRIM(RTRIM(Product_Name))
        THEN 1 ELSE 0 END) AS Product_Name_Spaces,

    SUM(CASE WHEN Order_ID IS NOT NULL
        AND Order_ID <> LTRIM(RTRIM(Order_ID))
        THEN 1 ELSE 0 END) AS Order_ID_Spaces,

    SUM(CASE WHEN Order_Priority IS NOT NULL
        AND Order_Priority <> LTRIM(RTRIM(Order_Priority))
        THEN 1 ELSE 0 END) AS Order_Priority_Spaces

FROM dbo.Global_Superstore2;

