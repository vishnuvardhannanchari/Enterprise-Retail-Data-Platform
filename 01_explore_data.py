import pandas as pd

customers = pd.read_csv("Data/customers.csv")

print(customers.head())
print("Number of customers:", len(customers))
print("Columns:", customers.columns.tolist())
print("\nMissing values:")
print(customers.isnull().sum())
print("\nDuplicate rows:")
print(customers.duplicated().sum())

print("\nData types:")
print(customers.dtypes)
print("\nCustomer age statistics:")
print(customers["age"].describe())
print("\nCustomers by country:")
print(customers["country"].value_counts())
print("\nTop 10 customer cities:")
print(customers["city"].value_counts().head(10))
print("\n--- ORDERS ANALYSIS ---")

orders = pd.read_csv("Data/orders.csv")

print(orders.head())

print("Number of orders:", len(orders))

print("Columns:", orders.columns.tolist())

print("\nMissing values:")
print(orders.isnull().sum())

print("\nDuplicate rows:")
print(orders.duplicated().sum())

print("\nData types:")
print(orders.dtypes)
print("\nOrder status:")
print(orders["order_status"].value_counts())

print("\nOrder statistics:")
print(orders[["quantity", "discount", "sales_amount", "cost_amount", "profit_amount"]].describe())

print("\n--- KEY BUSINESS METRICS ---")

total_sales = orders["sales_amount"].sum()
total_cost = orders["cost_amount"].sum()
total_profit = orders["profit_amount"].sum()

print("Total Sales:", total_sales)
print("Total Cost:", total_cost)
print("Total Profit:", total_profit)

print("\n--- PROFITABILITY & ORDER VALUE ---")

profit_margin = (total_profit / total_sales) * 100
average_order_value = total_sales / len(orders)

print("Profit Margin:", round(profit_margin, 2), "%")
print("Average Order Value:", round(average_order_value, 2))

orders["order_date"] = pd.to_datetime(orders["order_date"])
orders["month"] = orders["order_date"].dt.to_period("M")

monthly_sales = orders.groupby("month")["sales_amount"].sum()

print("\n--- MONTHLY SALES ---")
print(monthly_sales)

monthly_profit = orders.groupby("month")["profit_amount"].sum()

print("\n--- MONTHLY PROFIT ---")
print(monthly_profit)
print("\n--- PRODUCTS ANALYSIS ---")

products = pd.read_csv("Data/products.csv")

print(products.head())

print("Number of products:", len(products))

print("Columns:", products.columns.tolist())

print("\nMissing values:")
print(products.isnull().sum())

print("\nDuplicate rows:")
print(products.duplicated().sum())
print("\nProduct categories:")
print(products["category"].value_counts())

print("\nProduct sub-categories:")
print(products["sub_category"].value_counts().head(10))

print("\n--- ORDERS + PRODUCTS ANALYSIS ---")

orders_products = orders.merge(
    products,
    on="product_id",
    how="left"
)

print(orders_products.head())
print("\n--- SALES BY CATEGORY ---")

category_sales = (
    orders_products
    .groupby("category")["sales_amount"]
    .sum()
    .sort_values(ascending=False)
)

print(category_sales)
print("\n--- PROFIT BY CATEGORY ---")

category_profit = (
    orders_products
    .groupby("category")["profit_amount"]
    .sum()
    .sort_values(ascending=False)
)

print(category_profit)
print("\n--- TOP 10 PRODUCTS BY SALES ---")

top_products = (
    orders_products
    .groupby("product_name")["sales_amount"]
    .sum()
    .sort_values(ascending=False)
    .head(10)
)

print(top_products)
print("\n--- CUSTOMERS + ORDERS ANALYSIS ---")

orders_customers = orders.merge(
    customers,
    on="customer_id",
    how="left"
)

print(orders_customers.head())
print("\n--- SALES BY COUNTRY ---")

country_sales = (
    orders_customers
    .groupby("country")["sales_amount"]
    .sum()
    .sort_values(ascending=False)
)

print(country_sales)
print("\n--- SALES BY CITY ---")

city_sales = (
    orders_customers
    .groupby("city")["sales_amount"]
    .sum()
    .sort_values(ascending=False)
    .head(10)
)

print(city_sales)
print("\n--- PAYMENTS ANALYSIS ---")

payments = pd.read_csv("Data/payments.csv")

print(payments.head())

print("Number of payments:", len(payments))

print("Columns:", payments.columns.tolist())

print("\nMissing values:")
print(payments.isnull().sum())

print("\nDuplicate rows:")
print(payments.duplicated().sum())

print("\nPayment methods:")
print(payments["payment_method"].value_counts())

print("\nPayment statuses:")
print(payments["payment_status"].value_counts())
print("\n--- ORDERS + PAYMENTS ANALYSIS ---")

orders_payments = orders.merge(
    payments,
    on="order_id",
    how="left"
)

print(orders_payments.head())
print("\n--- SUCCESSFUL PAYMENTS BY METHOD ---")

successful_payments = orders_payments[
    orders_payments["payment_status"] == "Completed"
]

payment_method_amount = (
    successful_payments
    .groupby("payment_method")["payment_amount"]
    .sum()
    .sort_values(ascending=False)
)

print(payment_method_amount)
print("\n--- SHIPMENTS ANALYSIS ---")

shipments = pd.read_csv("Data/shipments.csv")

print(shipments.head())

print("Number of shipments:", len(shipments))

print("Columns:", shipments.columns.tolist())

print("\nMissing values:")
print(shipments.isnull().sum())

print("\nDuplicate rows:")
print(shipments.duplicated().sum())

print("\nWarehouses:")
print(shipments["warehouse"].value_counts())

print("\nShipping providers:")
print(shipments["shipping_provider"].value_counts())

print("\nDelivery statuses:")
print(shipments["delivery_status"].value_counts())
print("\n--- SUCCESSFUL PAYMENTS BY METHOD ---")

successful_payments = orders_payments[
    orders_payments["payment_status"] == "Completed"
]

payment_method_amount = (
    successful_payments
    .groupby("payment_method")["payment_amount"]
    .sum()
    .sort_values(ascending=False)
)

print(payment_method_amount)
print("\n--- SHIPMENTS ANALYSIS ---")

shipments = pd.read_csv("Data/shipments.csv")

print(shipments.head())

print("Number of shipments:", len(shipments))

print("Columns:", shipments.columns.tolist())

print("\nMissing values:")
print(shipments.isnull().sum())

print("\nDuplicate rows:")
print(shipments.duplicated().sum())

print("\nWarehouses:")
print(shipments["warehouse"].value_counts())

print("\nShipping providers:")
print(shipments["shipping_provider"].value_counts())

print("\nDelivery statuses:")
print(shipments["delivery_status"].value_counts())
shipments["shipping_date"] = pd.to_datetime(shipments["shipping_date"])
shipments["delivery_date"] = pd.to_datetime(shipments["delivery_date"])

shipments["delivery_days"] = (
    shipments["delivery_date"] - shipments["shipping_date"]
).dt.days

print("\n--- DELIVERY TIME ---")

print("Average delivery time:",
      round(shipments["delivery_days"].mean(), 2), "days")

print("Minimum delivery time:",
      shipments["delivery_days"].min(), "days")

print("Maximum delivery time:",
      shipments["delivery_days"].max(), "days")
print("\n--- DELIVERY PERFORMANCE BY PROVIDER ---")

provider_delivery = (
    shipments
    .groupby("shipping_provider")["delivery_days"]
    .mean()
    .sort_values()
)

print(provider_delivery.round(2))
print("\n--- SHIPPING COST BY PROVIDER ---")

provider_cost = (
    shipments
    .groupby("shipping_provider")["shipping_cost"]
    .sum()
    .sort_values(ascending=False)
)

print(provider_cost.round(2))
print("\n--- ORDERS DATA QUALITY CHECK ---")

print("Negative quantities:")
print((orders["quantity"] < 0).sum())

print("Negative sales:")
print((orders["sales_amount"] < 0).sum())

print("Negative costs:")
print((orders["cost_amount"] < 0).sum())

print("Negative profits:")
print((orders["profit_amount"] < 0).sum())

print("Negative discounts:")
print((orders["discount"] < 0).sum())
print("\n--- ORDER DATE CHECK ---")

print("Earliest order date:", orders["order_date"].min())
print("Latest order date:", orders["order_date"].max())

print("Invalid dates:", orders["order_date"].isnull().sum())
print("\n--- CUSTOMER ID RELATIONSHIP CHECK ---")

missing_customer_ids = ~orders["customer_id"].isin(customers["customer_id"])

print("Orders with invalid customer_id:",
      missing_customer_ids.sum())
print("\n--- PRODUCT ID RELATIONSHIP CHECK ---")

missing_product_ids = ~orders["product_id"].isin(products["product_id"])

print(
    "Orders with invalid product_id:",
    missing_product_ids.sum()
)
print("\n--- SHIPMENT RELATIONSHIP CHECK ---")

missing_shipment_orders = ~orders["order_id"].isin(shipments["order_id"])

print(
    "Orders without a shipment record:",
    missing_shipment_orders.sum()
)
print("\n--- CUSTOMER DATA QUALITY ---")

print("Duplicate customer IDs:",
      customers["customer_id"].duplicated().sum())
print("\n--- CUSTOMER AGE CHECK ---")

print("Minimum age:", customers["age"].min())
print("Maximum age:", customers["age"].max())

print("Customers below 18:",
      (customers["age"] < 18).sum())

print("Customers above 100:",
      (customers["age"] > 100).sum())
print("\n--- CUSTOMER GENDER CHECK ---")

print("Gender values:")
print(customers["gender"].value_counts())

print("\nUnique gender values:")
print(customers["gender"].unique())
print("\n--- CUSTOMER NAME CHECK ---")

print(
    "Missing customer names:",
    customers["customer_name"].isnull().sum()
)

print(
    "Empty customer names:",
    (customers["customer_name"].astype(str).str.strip() == "").sum()
)
print("\n--- CUSTOMER SIGNUP DATE CHECK ---")

customers["signup_date"] = pd.to_datetime(customers["signup_date"])

print("Earliest signup date:",
      customers["signup_date"].min())

print("Latest signup date:",
      customers["signup_date"].max())

print("Missing signup dates:",
      customers["signup_date"].isnull().sum())
print("\n--- PRODUCT DATA QUALITY ---")

print(
    "Duplicate product IDs:",
    products["product_id"].duplicated().sum()
)
print("\n--- PRODUCT PRICE & COST CHECK ---")

print("Products with price <= 0:",
      (products["price"] <= 0).sum())

print("Products with cost <= 0:",
      (products["cost"] <= 0).sum())

print("Products where cost > price:",
      (products["cost"] > products["price"]).sum())
print("\n--- PRODUCT NAME CHECK ---")

print(
    "Missing product names:",
    products["product_name"].isnull().sum()
)

print(
    "Empty product names:",
    (products["product_name"].astype(str).str.strip() == "").sum()
)
print("\n--- ORDER PROFIT VALIDATION ---")

calculated_profit = (
    orders["sales_amount"] - orders["cost_amount"]
)

profit_difference = (
    orders["profit_amount"] - calculated_profit
)

print(
    "Orders with incorrect profit:",
    (profit_difference.abs() > 0.01).sum()
)
print("\n--- ORDER DISCOUNT CHECK ---")

print("Minimum discount:",
      orders["discount"].min())

print("Maximum discount:",
      orders["discount"].max())

print("Discounts below 0:",
      (orders["discount"] < 0).sum())

print("Discounts above 100:",
      (orders["discount"] > 100).sum())
print("\n--- ORDER STATUS CHECK ---")

print("Order status values:")
print(orders["order_status"].value_counts())

print("\nUnique order statuses:")
print(orders["order_status"].unique())
print("\n--- ORDER SALES VALIDATION ---")

calculated_sales = (
    orders_products["quantity"] * orders_products["price"]
)

sales_difference = (
    orders_products["sales_amount"] - calculated_sales
)

print(
    "Orders with sales calculation difference:",
    (sales_difference.abs() > 0.01).sum()
)
print("\n--- SALES VALIDATION WITH DISCOUNT ---")

calculated_sales_after_discount = (
    orders_products["quantity"]
    * orders_products["price"]
    * (1 - orders_products["discount"])
)

sales_difference_discount = (
    orders_products["sales_amount"]
    - calculated_sales_after_discount
)

print(
    "Orders with sales difference after discount:",
    (sales_difference_discount.abs() > 0.01).sum()
)
print("\n--- PAYMENT AMOUNT VALIDATION ---")

payment_difference = (
    orders_payments["payment_amount"]
    - orders_payments["sales_amount"]
)

print(
    "Orders with payment amount difference:",
    (payment_difference.abs() > 0.01).sum()
)
print("\n--- SHIPMENT DATE VALIDATION ---")

invalid_delivery_dates = (
    shipments["delivery_date"] < shipments["shipping_date"]
)

print(
    "Shipments delivered before shipping:",
    invalid_delivery_dates.sum()
)
print("\n--- SHIPPING COST CHECK ---")

print(
    "Negative shipping costs:",
    (shipments["shipping_cost"] < 0).sum()
)

print(
    "Minimum shipping cost:",
    shipments["shipping_cost"].min()
)

print(
    "Maximum shipping cost:",
    shipments["shipping_cost"].max()
)