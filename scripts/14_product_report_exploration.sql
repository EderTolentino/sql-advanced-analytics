/*
14 | PRODUCT REPORT EXPLORATION

Objective:
    Retrieve all records from the product report view
    created in the previous script.
*/

USE DataWarehouseAnalytics;
GO

-- Display all records from the product report
SELECT
*
FROM gold.report_products;