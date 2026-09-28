-- Project: Supply Chain & E-Commerce Business Analytics

-- Database: SupplyChainAnalytics
-- Main Table: SupplyChain_Clean
-- Tool: Microsoft SQL Server Management Studio (SSMS)
-- Domain: Supply Chain / E-Commerce Analytics
-- Skills we will cover

-- SELECT → WHERE → GROUP BY → HAVING → CASE WHEN → JOIN → CTE → Subquery → Window Functions → Views → Stored Procedures → Business KPIs

-- 1. Verify Database & Table: Confirm that our clean analytical table is working correctly.
USE SupplyChainAnalytics;
GO
SELECT TOP 10 *
FROM dbo.SupplyChain_Clean;

SELECT COUNT(*) AS TotalRecords
FROM dbo.SupplyChain_Clean;

-- 2. Check Number of Customers & Orders
SELECT
    COUNT(DISTINCT Customer_Id) AS TotalCustomers,
    COUNT(DISTINCT Order_Id) AS TotalOrders
    FROM dbo.SupplyChain_Clean;
-- 3. Check Missing Values
SELECT

    COUNT(*) AS TotalRecords,
    SUM(CASE WHEN Order_Id IS NULL THEN 1 ELSE 0 END) AS MissingOrderId,

    SUM(CASE WHEN Customer_Id IS NULL THEN 1 ELSE 0 END) AS MissingCustomerId,

    SUM(CASE WHEN Product_Name IS NULL THEN 1 ELSE 0 END) AS MissingProductName,

    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS MissingSales,

    SUM(CASE WHEN Category_Name IS NULL THEN 1 ELSE 0 END) AS MissingCategory,

    SUM(CASE WHEN Shipping_Mode IS NULL THEN 1 ELSE 0 END) AS MissingShippingMode

FROM dbo.SupplyChain_Clean;

-- 4. Duplicate Order Analysis
SELECT
    Order_Id,
    COUNT(*) AS RecordCount
FROM dbo.SupplyChain_Clean
GROUP BY Order_Id
HAVING COUNT(*) > 1
ORDER BY RecordCount DESC;

-- 5. Check Duplicate Rows
SELECT
    Order_Id,
    Product_Name,
    Customer_Id,
    Sales,
    COUNT(*) AS DuplicateCount
FROM dbo.SupplyChain_Clean
GROUP BY
    Order_Id,
    Product_Name,
    Customer_Id,
    Sales
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;





















