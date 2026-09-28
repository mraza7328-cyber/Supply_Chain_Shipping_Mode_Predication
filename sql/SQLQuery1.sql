-- Project: Supply Chain & E-Commerce Business Analytics

-- Database: SupplyChainAnalytics
-- Main Table: SupplyChain_Clean
-- Tool: Microsoft SQL Server Management Studio (SSMS)
-- Domain: Supply Chain / E-Commerce Analytics
-- Skills we will cover

-- SELECT → WHERE → GROUP BY → HAVING → CASE WHEN → JOIN → CTE → Subquery → Window Functions → Views → Stored Procedures → Business KPIs

-- Verify Database & Table: Confirm that our clean analytical table is working correctly.
USE SupplyChainAnalytics;
GO
SELECT TOP 10 *
FROM dbo.SupplyChain_Clean;

SELECT COUNT(*) AS TotalRecords
FROM dbo.SupplyChain_Clean;

