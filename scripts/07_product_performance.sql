/*
07 | PRODUCT PERFORMANCE ANALYSIS

Objective:
    Compare yearly product sales with each product's
    historical average and previous year's sales.
*/

USE DataWarehouseAnalytics;
GO

-- Calculate yearly sales for each product
WITH yearly_product_sales AS (
SELECT
YEAR(f.order_date) AS order_year,
p.product_name,
SUM(f.sales_amount) AS current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
GROUP BY
YEAR(f.order_date), p.product_name
)

SELECT
order_year,
product_name,
current_sales,

-- Compare sales with the product's historical average
AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,

-- Classify sales performance against the average
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 then 'Above Avg'
         WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 then 'Below Avg'
         ELSE 'Avg'
END avg_change,

-- Retrieve the previous year's sales
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) py_sales,

-- Calculate the difference from the previous year
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,

-- Classify year-over-year sales performance
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
         WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
         ELSE 'No change'
END py_change
FROM yearly_product_sales
ORDER BY product_name, order_year;