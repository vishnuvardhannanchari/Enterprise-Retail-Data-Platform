
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# 1. Read the cleaned orders data
orders = pd.read_csv("Cleaned_Data/orders_clean.csv")

print("Orders CSV loaded.")
print("Number of rows:", len(orders))

# 2. Create the PostgreSQL connection
database_url = URL.create(
    drivername="postgresql+psycopg2",
    username="postgres",
   password="YOUR_PASSWORD",
    host="localhost",
    port=5432,
    database="retailx_db"
)

engine = create_engine(database_url)

# 3. Load the orders into PostgreSQL
orders.to_sql(
    "orders",
    engine,
    if_exists="append",
    index=False
)

print("Orders loaded into PostgreSQL successfully!")