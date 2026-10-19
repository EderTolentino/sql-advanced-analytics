/*
09 | CUSTOMER SPENDING SEGMENTATION

Objective:
    Classify customers based on spending and purchase history.

Segments:
    VIP: At least 3 months of history and spending over $5,000.
    Regular: At least 3 months of history and spending up to $5,000.
    New: Less than 3 months of history.

Note:
    The original analysis used a 12-month threshold.
    This was adjusted to 3 months because the available
    sales data covers only 9 months.
*/

USE DataWarehouseAnalytics;
GO

-- Calculate customer spending and purchase history
WITH customer_spending AS (

     SELECT
       c.customer_key,

       -- Calculate total customer spending
       SUM(f.sales_amount) AS total_spending,

       -- Identify the first purchase date
       MIN(f.order_date) AS first_order,

       -- Identify the last purchase date
       MAX(f.order_date) AS last_order,

       -- Calculate the time between first and last purchases
       DATEDIFF(
          month,
          MIN(f.order_date),
          MAX(f.order_date)
       ) AS lifespan

     FROM gold.fact_sales f

     LEFT JOIN gold.dim_customers c
       ON f.customer_key = c.customer_key

     GROUP BY c.customer_key
),

-- Classify customers using the adjusted 3-month threshold
customer_segments AS (

     SELECT
       customer_key,

       CASE
         WHEN lifespan >= 3
           AND total_spending > 5000
           THEN 'VIP'

         WHEN lifespan >= 3
           AND total_spending <= 5000
           THEN 'Regular'

         ELSE 'New'
       END AS customer_segment

     FROM customer_spending
)

-- Count customers in each segment
SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_customers DESC;