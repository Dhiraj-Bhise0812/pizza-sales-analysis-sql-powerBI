
# Pizza Sales SQL Analysis

📌 Overview
This repository contains the SQL scripts used to perform deep-dive analysis on pizza store sales
data. The queries within this project served as the Data Processing Layer for the
corresponding Power BI Dashboard, ensuring accurate KPI calculation and data integrity before
visualization.

### Database Schema
The analysis is performed across four interconnected tables:
orders : Contains order ID, date, and time.
order_details : Contains specific items within each order and quantities.
pizzas : Contains pizza IDs, sizes, and prices.
pizza_types : Contains names, categories, and ingredients.

### Key Business Questions Solved (SQL Implementation)
The pizza sales analysis.sql file contains solutions to critical business questions,
categorized by complexity:
1. Basic Metrics
Total Orders: Retrieved using COUNT(order_id) .
Total Revenue: Calculated by joining order_details and pizzas to sum the product of
quantity and price.
Top 5 Most Ordered Pizzas: Identified by aggregating quantities across pizza types.

2. Intermediate Analysis
Category-wise Distribution: Joined pizza_types and order_details to find total
quantity per category.
Hourly/Daily Trends: Extracted time and date components to identify peak order volumes.
Average Quantity per Order: Grouped by order_id to determine order size.

3. Advanced Insights (Window Functions & CTEs)
Cumulative Revenue: Used SUM(...) OVER (ORDER BY date) to track revenue growth
over time.
Category Revenue Percentage: Calculated the contribution of each pizza category to
total revenue.
Top 3 Pizzas per Category: Implemented Common Table Expressions (CTEs) and
ranking to find high-performing products within specific segments (Veggie, Classic, etc.).

### Technical Skills Demonstrated
Joins: Proficient use of INNER JOIN across multiple tables.
Aggregations: Extensive use of SUM , COUNT , AVG , and GROUP BY .
Window Functions: Calculating running totals for time-series analysis.
CTEs: Organizing complex logic for multi-step data transformations.
Subqueries: Nesting queries for refined data extraction.

### Integration with Power BI
The results of these SQL queries were used to:
1. Validated the measures (KPIs) created in Power BI.
2. Provided the logic for DAX formulas used in the dashboard.
3. Ensured that the "Total Revenue" and "Top Sellers" matched perfectly between the
database and the visual report.

### About the Author
Dhiraj Bhise | www.linkedin.com/in/dhiraj-bhise-335532306
