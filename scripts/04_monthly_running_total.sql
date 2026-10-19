/*
04 | MONTHLY RUNNING TOTAL

Objective:
    Calculate monthly sales and cumulative sales over time.
*/

USE DataWarehouseAnalytics;
GO

-- Calculate monthly sales and the running total
SELECT
  order_date,
  total_sales,

     -- Calculate cumulative sales
     SUM(total_sales) OVER (
        ORDER BY order_date
     ) AS running_total_sales

FROM
(
  -- Calculate total sales for each month
  SELECT
     DATETRUNC(month, order_date) AS order_date,
     SUM(sales_amount) AS total_sales

     FROM gold.fact_sales

     -- Exclude records without an order date
     WHERE order_date IS NOT NULL

     -- Group sales by month
     GROUP BY DATETRUNC(month, order_date)

) t;