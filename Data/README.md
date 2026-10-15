# Enterprise Retail Data Engineering & Business Intelligence Dataset

Synthetic but realistic multi-table retail dataset created for portfolio learning.

Tables:
- customers.csv: customer master data
- products.csv: product catalog and cost/price
- orders.csv: order transactions and sales/profit measures
- payments.csv: payment transactions
- shipments.csv: logistics and delivery data

Recommended project progression:
1. Python/Pandas data profiling
2. Data cleaning and validation
3. PostgreSQL database
4. ETL pipeline
5. Star-schema data warehouse
6. Advanced SQL analytics
7. Power BI dashboards
8. Airflow orchestration
9. Docker
10. Optional AWS deployment

Relationships:
customers.customer_id -> orders.customer_id
products.product_id -> orders.product_id
orders.order_id -> payments.order_id
orders.order_id -> shipments.order_id
