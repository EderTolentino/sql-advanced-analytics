/*
05 | YEARLY RUNNING TOTAL

Objective:
    Calculate yearly sales and cumulative sales over time.
*/

USE DataWarehouseAnalytics;
GO

-- Calculate yearly sales and the running total
SELECT
  order_date,
  total_sales,

     -- Calculate cumulative sales
     SUM(total_sales) OVER (
        ORDER BY order_date
     ) AS running_total_sales

FROM
(
  -- Calculate total sales for each year
  SELECT
     DATETRUNC(year, order_date) AS order_date,
     SUM(sales_amount) AS total_sales

     FROM gold.fact_sales

     -- Exclude records without an order date
     WHERE order_date IS NOT NULL

     -- Group sales by year
     GROUP BY DATETRUNC(year, order_date)

) t;