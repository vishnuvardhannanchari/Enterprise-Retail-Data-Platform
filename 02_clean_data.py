
import pandas as pd

print("Starting data cleaning...")
# Load all datasets

customers = pd.read_csv("Data/customers.csv")
products = pd.read_csv("Data/products.csv")
orders = pd.read_csv("Data/orders.csv")
payments = pd.read_csv("Data/payments.csv")
shipments = pd.read_csv("Data/shipments.csv")

print("All datasets loaded successfully!")
# Standardize column names

customers.columns = customers.columns.str.strip().str.lower().str.replace(" ", "_")
products.columns = products.columns.str.strip().str.lower().str.replace(" ", "_")
orders.columns = orders.columns.str.strip().str.lower().str.replace(" ", "_")
payments.columns = payments.columns.str.strip().str.lower().str.replace(" ", "_")
shipments.columns = shipments.columns.str.strip().str.lower().str.replace(" ", "_")

print("Column names standardized.")
# Check missing values

print("\n--- MISSING VALUES ---")

print("Customers:")
print(customers.isnull().sum())

print("\nProducts:")
print(products.isnull().sum())

print("\nOrders:")
print(orders.isnull().sum())

print("\nPayments:")
print(payments.isnull().sum())

print("\nShipments:")
print(shipments.isnull().sum())
# Remove completely duplicated rows

customers = customers.drop_duplicates()
products = products.drop_duplicates()
orders = orders.drop_duplicates()
payments = payments.drop_duplicates()
shipments = shipments.drop_duplicates()

print("Duplicate rows removed.")
# Standardize date columns

customers["signup_date"] = pd.to_datetime(customers["signup_date"])
orders["order_date"] = pd.to_datetime(orders["order_date"])
shipments["shipping_date"] = pd.to_datetime(shipments["shipping_date"])
shipments["delivery_date"] = pd.to_datetime(shipments["delivery_date"])

print("Date columns standardized.")
customers = pd.read_csv("Data/customers.csv")
orders = pd.read_csv("Data/orders.csv")
orders["order_date"] = pd.to_datetime(orders["order_date"])
# Calculate delivery duration

shipments["delivery_days"] = (
    shipments["delivery_date"] - shipments["shipping_date"]
).dt.days

print("Delivery days calculated.")
# Calculate profit margin

orders["profit_margin"] = (
    orders["profit_amount"] / orders["sales_amount"] * 100
)

print("Profit margin calculated.")
# Validate profit margin calculation

expected_profit_margin = (
    orders["profit_amount"] / orders["sales_amount"] * 100
)

margin_difference = (
    orders["profit_margin"] - expected_profit_margin
)

print(
    "Orders with incorrect profit margin:",
    (margin_difference.abs() > 0.01).sum()
)

print(
    "Missing profit margins:",
    orders["profit_margin"].isnull().sum()
)
# Verify cleaned customer file



customers.to_csv("Cleaned_Data/customers_clean.csv", index=False)
products.to_csv("Cleaned_Data/products_clean.csv", index=False)
orders.to_csv("Cleaned_Data/orders_clean.csv", index=False)
payments.to_csv("Cleaned_Data/payments_clean.csv", index=False)
shipments.to_csv("Cleaned_Data/shipments_clean.csv", index=False)

print("All cleaned datasets saved successfully.")

