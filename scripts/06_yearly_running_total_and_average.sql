/*
06 | YEARLY RUNNING TOTAL AND AVERAGE PRICE

Objective:
    Calculate cumulative yearly sales and a running
    average of yearly average prices.
*/

USE DataWarehouseAnalytics;
GO

-- Add the running average price to yearly sales analysis
SELECT
  order_date,
  total_sales,

     -- Calculate cumulative sales
     SUM(total_sales) OVER (
        ORDER BY order_date
     ) AS running_total_sales,

          AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price

FROM
(
  -- Calculate yearly sales and average price
  SELECT
     DATETRUNC(year, order_date) AS order_date,
     SUM(sales_amount) AS total_sales,
                 AVG(price) AS avg_price
  FROM gold.fact_sales

     -- Exclude records without an order date
     WHERE order_date IS NOT NULL

     -- Group sales by year
     GROUP BY DATETRUNC(year, order_date)

) t;