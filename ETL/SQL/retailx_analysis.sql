-- ==========================================
-- RETAILX SQL ANALYTICS
-- ==========================================


-- Step 1: Total Customers

SELECT COUNT(*) AS total_customers
FROM customers;


-- Step 2: Total Products

SELECT COUNT(*) AS total_products
FROM products;


-- Step 3: Total Orders

SELECT COUNT(*) AS total_orders
FROM orders;


-- Step 4: Total Revenue

SELECT SUM(sales_amount) AS total_revenue
FROM orders;


-- Step 5: Total Profit

SELECT SUM(profit_amount) AS total_profit
FROM orders;


-- Step 6: Average Order Value

SELECT AVG(sales_amount) AS average_order_value
FROM orders;


-- Step 7: Total Units Sold

SELECT SUM(quantity) AS total_units_sold
FROM orders;


-- Step 8: Overall Profit Margin

SELECT
    SUM(profit_amount) / SUM(sales_amount) * 100 AS overall_profit_margin
FROM orders;


-- Step 9: Orders by Status

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;


-- Step 10: Revenue by Order Status

SELECT
    order_status,
    SUM(sales_amount) AS total_revenue
FROM orders
GROUP BY order_status
ORDER BY total_revenue DESC;


-- Step 11: Revenue by Country

SELECT
    c.country,
    SUM(o.sales_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;


-- Step 12: Revenue by Product Category

SELECT
    p.category,
    SUM(o.sales_amount) AS total_revenue
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- Step 13: Top 10 Products by Revenue

SELECT
    p.product_id,
    p.product_name,
    SUM(o.sales_amount) AS total_revenue
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- Step 14: Top 10 Products by Profit

SELECT
    p.product_id,
    p.product_name,
    SUM(o.profit_amount) AS total_profit
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_profit DESC
LIMIT 10;


-- Step 15: Monthly Revenue

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(sales_amount) AS monthly_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- Step 16: Monthly Profit

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(profit_amount) AS monthly_profit
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- Step 17: Revenue by Payment Method

SELECT
    p.payment_method,
    SUM(o.sales_amount) AS total_revenue
FROM payments p
JOIN orders o
    ON p.order_id = o.order_id
GROUP BY p.payment_method
ORDER BY total_revenue DESC;
SELECT
    p.payment_method,
    SUM(o.sales_amount) AS total_revenue
FROM payments p
JOIN orders o
    ON p.order_id = o.order_id
GROUP BY p.payment_method
ORDER BY total_revenue DESC;
-- Step 18: Revenue by Payment Status

SELECT
    p.payment_status,
    SUM(o.sales_amount) AS total_revenue
FROM payments p
JOIN orders o
    ON p.order_id = o.order_id
GROUP BY p.payment_status
ORDER BY total_revenue DESC;
-- Step 19: Average Delivery Time by Shipping Provider

SELECT
    shipping_provider,
    AVG(delivery_days) AS average_delivery_days
FROM shipments
GROUP BY shipping_provider
ORDER BY average_delivery_days;
-- Step 20: Average Delivery Time by Warehouse

SELECT
    warehouse,
    AVG(delivery_days) AS average_delivery_days
FROM shipments
GROUP BY warehouse
ORDER BY average_delivery_days;
-- Step 21: Total Shipping Cost by Provider

SELECT
    shipping_provider,
    SUM(shipping_cost) AS total_shipping_cost
FROM shipments
GROUP BY shipping_provider
ORDER BY total_shipping_cost DESC;
-- Step 22: Revenue by City

SELECT
    c.city,
    c.country,
    SUM(o.sales_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.city,
    c.country
ORDER BY total_revenue DESC;
-- Step 23: Revenue by Customer

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.sales_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_revenue DESC;
-- Step 24: Orders per Customer

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders DESC;
-- Step 25: Average Order Value per Customer

SELECT
    c.customer_id,
    c.customer_name,
    AVG(o.sales_amount) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY average_order_value DESC;
-- Step 26: Top 10 Customers by Profit

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.profit_amount) AS total_profit
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- Step 27: Customer Profit Margin

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.sales_amount) AS total_revenue,
    SUM(o.profit_amount) AS total_profit,
    SUM(o.profit_amount) / SUM(o.sales_amount) * 100 AS profit_margin
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY profit_margin DESC
LIMIT 10;
-- Step 28: Revenue by Gender

SELECT
    c.gender,
    SUM(o.sales_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.gender
ORDER BY total_revenue DESC;-- Step 29: Revenue by Age Group

SELECT
    CASE
        WHEN c.age < 25 THEN 'Under 25'
        WHEN c.age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    SUM(o.sales_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    CASE
        WHEN c.age < 25 THEN 'Under 25'
        WHEN c.age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END
ORDER BY total_revenue DESC;
-- Step 30: Revenue by Product Sub-Category

SELECT
    p.category,
    p.sub_category,
    SUM(o.sales_amount) AS total_revenue
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.category,
    p.sub_category
ORDER BY total_revenue DESC;
-- Step 31: Profit by Product Category

SELECT
    p.category,
    SUM(o.profit_amount) AS total_profit
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.category
ORDER BY total_profit DESC;
-- Step 32: Average Discount by Product Category

SELECT
    p.category,
    AVG(o.discount) * 100 AS average_discount_percentage
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.category
ORDER BY average_discount_percentage DESC;
-- Step 33: Total Units Sold by Product Category

SELECT
    p.category,
    SUM(o.quantity) AS total_units_sold
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.category
ORDER BY total_units_sold DESC;
-- Step 34: Shipment Delivery Status

SELECT
    delivery_status,
    COUNT(*) AS total_shipments
FROM shipments
GROUP BY delivery_status
ORDER BY total_shipments DESC;
-- Step 35: Average Shipping Cost by Provider

SELECT
    shipping_provider,
    AVG(shipping_cost) AS average_shipping_cost
FROM shipments
GROUP BY shipping_provider
ORDER BY average_shipping_cost DESC;
-- Step 36: Revenue by Warehouse

SELECT
    s.warehouse,
    SUM(o.sales_amount) AS total_revenue
FROM shipments s
JOIN orders o
    ON s.order_id = o.order_id
GROUP BY
    s.warehouse
ORDER BY total_revenue DESC;
-- Step 37: Profit by Country

SELECT
    c.country,
    SUM(o.profit_amount) AS total_profit
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.country
ORDER BY total_profit DESC;
-- Step 38: Monthly Order Count

SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
-- Step 39: Monthly Average Order Value

SELECT
    DATE_TRUNC('month', order_date) AS month,
    AVG(sales_amount) AS average_order_value
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
-- Step 40: Payment Success Rate

SELECT
    COUNT(*) AS total_payments,
    SUM(
        CASE
            WHEN payment_status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS successful_payments,
    SUM(
        CASE
            WHEN payment_status = 'Completed' THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(*) AS payment_success_rate
FROM payments;
-- Step 41: Revenue by Shipping Provider

SELECT
    s.shipping_provider,
    SUM(o.sales_amount) AS total_revenue
FROM shipments s
JOIN orders o
    ON s.order_id = o.order_id
GROUP BY
    s.shipping_provider
ORDER BY total_revenue DESC;
-- Step 42: Profit by Shipping Provider

SELECT
    s.shipping_provider,
    SUM(o.profit_amount) AS total_profit
FROM shipments s
JOIN orders o
    ON s.order_id = o.order_id
GROUP BY
    s.shipping_provider
ORDER BY total_profit DESC;
-- Step 43: Monthly Profit Margin

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(sales_amount) AS monthly_revenue,
    SUM(profit_amount) AS monthly_profit,
    SUM(profit_amount) / SUM(sales_amount) * 100 AS profit_margin
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
-- Step 44: Monthly Revenue Growth

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales_amount) AS monthly_revenue
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY month) AS previous_month_revenue,
    (
        (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month))
        / LAG(monthly_revenue) OVER (ORDER BY month)
    ) * 100 AS revenue_growth_percentage
FROM monthly_sales
ORDER BY month;
-- Step 45: Top 10 Customers by Number of Orders

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders DESC
LIMIT 10;
-- Step 47: Revenue by Country and Gender

SELECT
    c.country,
    c.gender,
    SUM(o.sales_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.country,
    c.gender
ORDER BY total_revenue DESC;

-- Step 48: Revenue by Customer City

SELECT
    c.city,
    c.country,
    SUM(o.sales_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.city,
    c.country
ORDER BY total_revenue DESC
LIMIT 10;

-- Step 49: Profit by Product Sub-Category

SELECT
    p.category,
    p.sub_category,
    SUM(o.profit_amount) AS total_profit
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.category,
    p.sub_category
ORDER BY total_profit DESC;

-- Step 51: Revenue by Order Status

SELECT
    order_status,
    COUNT(*) AS total_orders,
    SUM(sales_amount) AS total_revenue
FROM orders
GROUP BY
    order_status
ORDER BY total_revenue DESC;

-- Step 52: Revenue by Payment Method

SELECT
    p.payment_method,
    COUNT(*) AS total_payments,
    SUM(o.sales_amount) AS total_revenue
FROM payments p
JOIN orders o
    ON p.order_id = o.order_id
GROUP BY
    p.payment_method
ORDER BY total_revenue DESC;

-- Step 53: Revenue by Payment Status

SELECT
    p.payment_status,
    COUNT(*) AS total_payments,
    SUM(o.sales_amount) AS total_revenue
FROM payments p
JOIN orders o
    ON p.order_id = o.order_id
GROUP BY
    p.payment_status
ORDER BY total_revenue DESC;

-- Step 54: Shipping Provider Performance

SELECT
    shipping_provider,
    COUNT(*) AS total_shipments,
    AVG(delivery_days) AS average_delivery_days,
    AVG(shipping_cost) AS average_shipping_cost
FROM shipments
GROUP BY
    shipping_provider
ORDER BY average_delivery_days;

-- Step 55: Warehouse Performance

SELECT
    warehouse,
    COUNT(*) AS total_shipments,
    AVG(delivery_days) AS average_delivery_days,
    AVG(shipping_cost) AS average_shipping_cost
FROM shipments
GROUP BY
    warehouse
ORDER BY total_shipments DESC;
-- Step 56: Revenue by Warehouse

SELECT
    s.warehouse,
    COUNT(DISTINCT s.order_id) AS total_orders,
    SUM(o.sales_amount) AS total_revenue,
    SUM(o.profit_amount) AS total_profit
FROM shipments s
JOIN orders o
    ON s.order_id = o.order_id
GROUP BY
    s.warehouse
ORDER BY total_revenue DESC;

-- Step 57: Profit Margin by Warehouse

SELECT
    s.warehouse,
    SUM(o.sales_amount) AS total_revenue,
    SUM(o.profit_amount) AS total_profit,
    SUM(o.profit_amount) / SUM(o.sales_amount) * 100 AS profit_margin
FROM shipments s
JOIN orders o
    ON s.order_id = o.order_id
GROUP BY
    s.warehouse
ORDER BY profit_margin DESC;

-- Step 58: Customer Lifetime Revenue

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.sales_amount) AS lifetime_revenue,
    SUM(o.profit_amount) AS lifetime_profit
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY lifetime_revenue DESC
LIMIT 10;

-- Step 59: Customer Lifetime Profit Margin

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.sales_amount) AS lifetime_revenue,
    SUM(o.profit_amount) AS lifetime_profit,
    SUM(o.profit_amount) / SUM(o.sales_amount) * 100 AS profit_margin
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY profit_margin DESC
LIMIT 10;

-- Step 60: Top 10 Most Profitable Products

SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(o.sales_amount) AS total_revenue,
    SUM(o.profit_amount) AS total_profit
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_profit DESC
LIMIT 10;

-- Step 61: Top 10 Products by Profit Margin

SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(o.sales_amount) AS total_revenue,
    SUM(o.profit_amount) AS total_profit,
    SUM(o.profit_amount) / SUM(o.sales_amount) * 100 AS profit_margin
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY profit_margin DESC
LIMIT 10;

-- Step 62: Monthly Business Summary

SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(*) AS total_orders,
    SUM(sales_amount) AS total_revenue,
    SUM(profit_amount) AS total_profit
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- Step 64: Create Data Warehouse Schema

CREATE SCHEMA IF NOT EXISTS dw;

-- Step 65: Create Customer Dimension

CREATE TABLE IF NOT EXISTS dw.dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id VARCHAR,
    customer_name VARCHAR,
    gender VARCHAR,
    age INTEGER,
    country VARCHAR,
    city VARCHAR,
    signup_date DATE
);

-- Step 66: Create Product Dimension

CREATE TABLE IF NOT EXISTS dw.dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id VARCHAR,
    product_name VARCHAR,
    category VARCHAR,
    sub_category VARCHAR,
    price NUMERIC,
    cost NUMERIC
);

-- Step 67: Create Date Dimension

CREATE TABLE IF NOT EXISTS dw.dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    month_name VARCHAR,
    day INTEGER,
    day_name VARCHAR
);

-- Step 68: Load Customer Dimension

INSERT INTO dw.dim_customer (
    customer_id,
    customer_name,
    gender,
    age,
    country,
    city,
    signup_date
)
SELECT
    customer_id,
    customer_name,
    gender,
    age,
    country,
    city,
    signup_date
FROM customers;


-- Step 69: Verify Customer Dimension

SELECT COUNT(*) AS total_customers
FROM dw.dim_customer;

-- Step 70: Clear Customer Dimension

TRUNCATE TABLE dw.dim_customer;

-- Step 71: Reload Customer Dimension

INSERT INTO dw.dim_customer (
    customer_id,
    customer_name,
    gender,
    age,
    country,
    city,
    signup_date
)
SELECT
    customer_id,
    customer_name,
    gender,
    age,
    country,
    city,
    signup_date
FROM customers;

-- Step 72: Verify Customer Dimension

SELECT COUNT(*) AS total_customers
FROM dw.dim_customer;

-- Step 73: Load Product Dimension

INSERT INTO dw.dim_product (
    product_id,
    product_name,
    category,
    sub_category,
    price,
    cost
)
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    price,
    cost
FROM products;

-- Step 74: Verify Product Dimension

SELECT COUNT(*) AS total_products
FROM dw.dim_product;

-- Step 75: Clear Product Dimension

TRUNCATE TABLE dw.dim_product;
-- Step 76: Reload Product Dimension

INSERT INTO dw.dim_product (
    product_id,
    product_name,
    category,
    sub_category,
    price,
    cost
)
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    price,
    cost
FROM products;

-- Step 77: Verify Product Dimension

SELECT COUNT(*) AS total_products
FROM dw.dim_product;


-- Step 82: Verify Date Dimension


SELECT COUNT(*) AS total_dates
FROM dw.dim_date;

-- Step 83: Create Sales Fact Table

CREATE TABLE IF NOT EXISTS dw.fact_sales (
    sales_key SERIAL PRIMARY KEY,
    order_id VARCHAR,
    customer_key INTEGER,
    product_key INTEGER,
    date_key INTEGER,
    quantity INTEGER,
    discount NUMERIC,
    sales_amount NUMERIC,
    cost_amount NUMERIC,
    profit_amount NUMERIC,
    profit_margin NUMERIC
);

-- Step 84: Load Sales Fact Table

INSERT INTO dw.fact_sales (
    order_id,
    customer_key,
    product_key,
    date_key,
    quantity,
    discount,
    sales_amount,
    cost_amount,
    profit_amount,
    profit_margin
)
SELECT
    o.order_id,
    c.customer_key,
    p.product_key,
    d.date_key,
    o.quantity,
    o.discount,
    o.sales_amount,
    o.cost_amount,
    o.profit_amount,
    o.profit_margin
FROM orders o
JOIN dw.dim_customer c
    ON o.customer_id = c.customer_id
JOIN dw.dim_product p
    ON o.product_id = p.product_id
JOIN dw.dim_date d
    ON o.order_date = d.full_date;

	-- Step 85: Verify Sales Fact Table

SELECT COUNT(*) AS total_sales_records
FROM dw.fact_sales;
-- Step 86: Clear Sales Fact Table

TRUNCATE TABLE dw.fact_sales;  

-- Step 87: Reload Sales Fact Table

INSERT INTO dw.fact_sales (
    order_id,
    customer_key,
    product_key,
    date_key,
    quantity,
    discount,
    sales_amount,
    cost_amount,
    profit_amount,
    profit_margin
)
SELECT
    o.order_id,
    c.customer_key,
    p.product_key,
    d.date_key,
    o.quantity,
    o.discount,
    o.sales_amount,
    o.cost_amount,
    o.profit_amount,
    o.profit_margin
FROM orders o
JOIN dw.dim_customer c
    ON o.customer_id = c.customer_id
JOIN dw.dim_product p
    ON o.product_id = p.product_id
JOIN dw.dim_date d
    ON o.order_date = d.full_date;
	-- Step 88: Verify Sales Fact Table

SELECT COUNT(*) AS total_sales_records
FROM dw.fact_sales;

-- Step 89: Check Fact Table Relationships

SELECT
    COUNT(*) AS total_records,
    COUNT(customer_key) AS records_with_customer,
    COUNT(product_key) AS records_with_product,
    COUNT(date_key) AS records_with_date
FROM dw.fact_sales;

-- Step 90: Revenue Consistency Check

SELECT
    (SELECT SUM(sales_amount) FROM orders) AS source_revenue,
    (SELECT SUM(sales_amount) FROM dw.fact_sales) AS warehouse_revenue;

	-- Step 91: Profit Consistency Check

SELECT
    (SELECT SUM(profit_amount) FROM orders) AS source_profit,
    (SELECT SUM(profit_amount) FROM dw.fact_sales) AS warehouse_profit;

	-- Step 92: Units Sold Consistency Check

SELECT
    (SELECT SUM(quantity) FROM orders) AS source_units_sold,
    (SELECT SUM(quantity) FROM dw.fact_sales) AS warehouse_units_sold;

	-- Step 93: Order Count Consistency Check

SELECT
    (SELECT COUNT(*) FROM orders) AS source_orders,
    (SELECT COUNT(*) FROM dw.fact_sales) AS warehouse_orders;

	-- Step 94: Create BI Sales View

CREATE OR REPLACE VIEW dw.vw_sales_analysis AS
SELECT
    f.order_id,
    d.full_date,
    d.year,
    d.quarter,
    d.month,
    d.month_name,
    c.customer_id,
    c.customer_name,
    c.country,
    c.city,
    p.product_id,
    p.product_name,
    p.category,
    p.sub_category,
    f.quantity,
    f.discount,
    f.sales_amount,
    f.cost_amount,
    f.profit_amount,
    f.profit_margin
FROM dw.fact_sales f
JOIN dw.dim_customer c
    ON f.customer_key = c.customer_key
JOIN dw.dim_product p
    ON f.product_key = p.product_key
JOIN dw.dim_date d
    ON f.date_key = d.date_key;


-- Step 95: Test BI Sales View

SELECT *
FROM dw.vw_sales_analysis
LIMIT 10;

-- Step 96: Create Revenue Summary View

CREATE OR REPLACE VIEW dw.vw_revenue_summary AS
SELECT
    year,
    month,
    month_name,
    country,
    category,
    SUM(sales_amount) AS total_revenue,
    SUM(profit_amount) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders
FROM dw.vw_sales_analysis
GROUP BY
    year,
    month,
    month_name,
    country,
    category;

	-- Step 97: Test Revenue Summary View

SELECT *
FROM dw.vw_revenue_summary
LIMIT 10;

-- Step 98: Create Customer Analytics View

CREATE OR REPLACE VIEW dw.vw_customer_analysis AS
SELECT
    customer_id,
    customer_name,
    country,
    city,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales_amount) AS total_revenue,
    SUM(profit_amount) AS total_profit,
    AVG(sales_amount) AS average_order_value
FROM dw.vw_sales_analysis
GROUP BY
    customer_id,
    customer_name,
    country,
    city;

	-- Step 99: Test Customer Analytics View

SELECT *
FROM dw.vw_customer_analysis
ORDER BY total_revenue DESC
LIMIT 10;

-- Step 100: Create Product Analytics View

CREATE OR REPLACE VIEW dw.vw_product_analysis AS
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold,
    SUM(sales_amount) AS total_revenue,
    SUM(profit_amount) AS total_profit,
    SUM(profit_amount) / SUM(sales_amount) * 100 AS profit_margin
FROM dw.vw_sales_analysis
GROUP BY
    product_id,
    product_name,
    category,
    sub_category;

	-- Step 101: Test Product Analytics View

SELECT *
FROM dw.vw_product_analysis
ORDER BY total_revenue DESC
LIMIT 10;

-- Step 102: Create Customer Performance View

CREATE OR REPLACE VIEW dw.vw_customer_performance AS
SELECT
    customer_id,
    customer_name,
    country,
    city,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_bought,
    SUM(sales_amount) AS total_revenue,
    SUM(profit_amount) AS total_profit,
    AVG(sales_amount) AS average_order_value
FROM dw.vw_sales_analysis
GROUP BY
    customer_id,
    customer_name,
    country,
    city;

	-- Step 103: Test Customer Performance View

SELECT *
FROM dw.vw_customer_performance
ORDER BY total_revenue DESC
LIMIT 10;

-- Step 104: Create Payment Analytics View

CREATE OR REPLACE VIEW dw.vw_payment_analysis AS
SELECT
    p.payment_method,
    p.payment_status,
    COUNT(*) AS total_payments,
    SUM(p.payment_amount) AS total_payment_amount,
    AVG(p.payment_amount) AS average_payment_amount
FROM payments p
GROUP BY
    p.payment_method,
    p.payment_status;

	-- Step 105: Test Payment Analytics View

SELECT *
FROM dw.vw_payment_analysis
ORDER BY total_payment_amount DESC;

-- Step 106: Create Logistics Analytics View

CREATE OR REPLACE VIEW dw.vw_logistics_analysis AS
SELECT
    warehouse,
    shipping_provider,
    delivery_status,
    COUNT(*) AS total_shipments,
    AVG(delivery_days) AS average_delivery_days,
    SUM(shipping_cost) AS total_shipping_cost
FROM shipments
GROUP BY
    warehouse,
    shipping_provider,
    delivery_status;

	-- Step 107: Test Logistics Analytics View

SELECT *
FROM dw.vw_logistics_analysis
ORDER BY average_delivery_days ASC;

-- Step 108: Create Executive KPI View

CREATE OR REPLACE VIEW dw.vw_executive_kpis AS
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales_amount) AS total_revenue,
    SUM(profit_amount) AS total_profit,
    SUM(quantity) AS total_units_sold,
    AVG(sales_amount) AS average_order_value,
    SUM(profit_amount) / SUM(sales_amount) * 100 AS overall_profit_margin
FROM dw.fact_sales;

-- Step 109: Test Executive KPI View

SELECT *
FROM dw.vw_executive_kpis;

-- Step 110: Check our BI views

SELECT
    table_schema,
    table_name
FROM information_schema.views
WHERE table_schema = 'dw'
ORDER BY table_name;