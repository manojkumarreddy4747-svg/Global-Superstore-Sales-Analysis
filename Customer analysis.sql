
--- Find top 10 customers by sales

SELECT TOP 10
    C.Customer_ID,
    C.Customer_Name,
    SUM(S.Sales) AS Total_Sales,
    SUM(S.Profit) AS Total_Profit
FROM dbo.Sales AS S
INNER JOIN dbo.Customers AS C
    ON S.Customer_ID = C.Customer_ID
GROUP BY
    C.Customer_ID,
    C.Customer_Name
ORDER BY Total_Sales DESC;


--- Find customers who placed more than five distinct orders

SELECT
    C.Customer_ID,
    C.Customer_Name,
    COUNT(DISTINCT S.Order_ID) AS Total_Orders
FROM dbo.Sales AS S
INNER JOIN dbo.Customers AS C
    ON S.Customer_ID = C.Customer_ID
GROUP BY
    C.Customer_ID,
    C.Customer_Name
HAVING COUNT(DISTINCT S.Order_ID) > 5
ORDER BY Total_Orders DESC;
