
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# 1. Read the cleaned customer data
customers = pd.read_csv("Cleaned_Data/customers_clean.csv")

print("Customers CSV loaded.")
print("Number of rows:", len(customers))

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

# 3. Load the data into PostgreSQL
customers.to_sql(
    "customers",
    engine,
    if_exists="append",
    index=False
)

print("Customers loaded into PostgreSQL successfully!")
