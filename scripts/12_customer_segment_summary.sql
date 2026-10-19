/*
12 | CUSTOMER SEGMENT SUMMARY

Objective:
    Summarize customer counts and sales by segment
    using the customer report view.
*/

USE DataWarehouseAnalytics;
GO

-- Summarize customers and sales by segment
SELECT
      customer_segment,
      COUNT(customer_number) AS total_customers,
      SUM(total_sales) total_sales
FROM gold.report_customers
GROUP BY customer_segment;