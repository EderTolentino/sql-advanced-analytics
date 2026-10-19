/*
10 | CATEGORY SALES CONTRIBUTION

Objective:
    Calculate each product category's contribution
    to total sales, including its percentage share.
*/

USE DataWarehouseAnalytics;
GO

-- Calculate total sales for each category
WITH category_sales AS (
SELECT
category,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY category
)

-- Calculate each category's percentage of overall sales
SELECT
category,
total_sales,
SUM(total_sales) OVER () overall_sales,
CONCAT(ROUND((CAST (total_sales AS FLOAT) / SUM(total_sales) OVER ())*100, 2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;