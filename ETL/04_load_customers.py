import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# 1. Read cleaned customer data
customers = pd.read_csv("Cleaned_Data/customers_clean.csv")

print("Customers CSV loaded.")
print("Number of rows:", len(customers))

# 2. Create PostgreSQL connection
database_url = URL.create(
    drivername="postgresql+psycopg2",
    username="postgres",
    password="YOUR_PASSWORD",
    host="localhost",
    port=5432,
    database="retailx_db",
)

engine = create_engine(database_url)

# 3. Load customers into the existing warehouse table
customers.to_sql(
    "dim_customer",
    engine,
    schema="dw",
    if_exists="append",
    index=False,
)

print("Customer loading script completed.")