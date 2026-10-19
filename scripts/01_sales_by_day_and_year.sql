/*
01 | SALES BY DAY AND YEAR

Objective:
    Calculate total sales by day and by year.
*/

USE DataWarehouseAnalytics;
GO

-- Calculate total sales by day
SELECT
order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY order_date
ORDER BY order_date

-- Calculate total sales by year
SELECT
YEAR(order_date) AS order_year,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);