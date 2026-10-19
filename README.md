# SQL Advanced Analytics

A hands-on SQL learning project focused on analyzing sales, customer behavior, and product performance using **Microsoft SQL Server** and **SQL Server Management Studio (SSMS)**.

This repository documents SQL exercises developed while following Data With Baraa's advanced analytics lessons. It covers time-based analysis, window functions, segmentation, and reusable analytical reports. The goal is to demonstrate SQL practice and a structured analytical workflow—not to present the course dataset as original business research.

## Tech stack

- **Database:** Microsoft SQL Server 2022 (or later)
- **IDE:** SQL Server Management Studio (SSMS)
- **SQL techniques:** aggregations, joins, CTEs, window functions, date functions, `CASE`, and views

> SQL Server 2022+ is required for the `DATETRUNC()` expressions used in the scripts.

## Dataset

The `DataWarehouseAnalytics` database contains a `gold` schema with three source tables:

| Table | Purpose |
| --- | --- |
| `gold.fact_sales` | Orders, dates, sales amounts, quantities, and customer/product keys |
| `gold.dim_customers` | Customer identifiers and demographic attributes |
| `gold.dim_products` | Product names, categories, subcategories, and costs |

The setup file at `database/00_init_database.sql` was generated from an SSMS database export and includes both schema and data.

## Analyses

The SQL exercises are organized into 14 scripts, intended to be read and run in numerical order.

| Script | Focus |
| --- | --- |
| `01_sales_by_day_and_year.sql` | Daily and annual sales trends |
| `02_yearly_sales_metrics.sql` | Yearly sales, customers, and quantities |
| `03_monthly_sales_metrics.sql` | Four approaches to monthly sales aggregation |
| `04_monthly_running_total.sql` | Monthly cumulative revenue |
| `05_yearly_running_total.sql` | Annual cumulative revenue |
| `06_yearly_running_total_and_average.sql` | Annual running revenue and cumulative average price |
| `07_product_performance.sql` | Product sales vs. historical averages and prior years |
| `08_product_cost_segmentation.sql` | Product counts by cost bracket |
| `09_customer_spending_segmentation.sql` | Customer segments based on spending and purchase history |
| `10_category_sales_contribution.sql` | Revenue contribution by product category |
| `11_customer_report.sql` | Create the `gold.report_customers` view |
| `12_customer_segment_summary.sql` | Summarize segments from the customer report |
| `13_product_report.sql` | Create the `gold.report_products` view |
| `14_product_report_exploration.sql` | Query the product report view |

### Analytical reports

**Customer report (`gold.report_customers`):** consolidates order counts, total sales, quantities, distinct products, customer age groups, lifespan, recency, segmentation, average order value, and average monthly spending.

**Product report (`gold.report_products`):** consolidates revenue, quantity, orders, customers, average selling price, product lifespan, recency, and performance segments.

> **Learning note:** Script `09_customer_spending_segmentation.sql` uses a **3-month** customer-history threshold, while the customer report view in script `11` uses **12 months**. These are different rules in the current exercises and should not be treated as interchangeable.

## Example outputs

### Sales trends

![Sales trends](screenshots/1.%20Sales%20Trends.png)

### Customer segmentation

![Customer segmentation](screenshots/2.%20Customer%20Segmentation.png)

### Product report

![Product report](screenshots/3.%20Product%20Report.png)

## How to run

1. Install or connect to **SQL Server 2022+** and open **SSMS**.
2. Review `database/00_init_database.sql` before running it. The SSMS-generated `CREATE DATABASE` statement includes **local Windows `.mdf` and `.ldf` file paths**, which may need to be adjusted for your SQL Server instance. It also contains database-level settings.
3. Run the setup script to create `DataWarehouseAnalytics` and populate the `gold` tables. **Do not run it against an existing database without reviewing its effects.**
4. Open the scripts in `scripts/` and execute them in numerical order. Each script selects `DataWarehouseAnalytics` with `USE`.
5. Run script `11` before `12`, and script `13` before `14`, because the latter scripts depend on views created by the former.

The reporting scripts use `CREATE VIEW`; if the views already exist, rerunning those scripts without modification will produce an error.

## Repository structure

```text
.
├── database/
│   └── 00_init_database.sql
├── screenshots/
│   ├── 1. Sales Trends.png
│   ├── 2. Customer Segmentation.png
│   └── 3. Product Report.png
├── scripts/
│   ├── 01_sales_by_day_and_year.sql
│   ├── ...
│   └── 14_product_report_exploration.sql
├── .gitignore
└── README.md
```

Local `study_notes/` files are excluded through `.gitignore` and are not part of the published repository.

## Learning objectives

- Aggregate business metrics across different time periods.
- Use SQL window functions for cumulative metrics and comparisons.
- Compare annual product performance with historical averages and previous years.
- Apply segmentation rules to customers and products.
- Create reusable SQL views for customer- and product-level reporting.
- Organize and document SQL exercises for reproducibility and future reference.

## Credits

This project was developed as part of my SQL learning journey, following the tutorials and exercises provided by Data With Baraa.

Special thanks to Baraa for sharing practical, accessible learning resources that help aspiring data analysts develop their skills and build their portfolios.

**Learning resource:** [SQL Advanced Analytics Tutorial](https://www.youtube.com/watch?v=2jGhQpbzHes)

## Author

[Eder Tolentino](https://github.com/EderTolentino)
