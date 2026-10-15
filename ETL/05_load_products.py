
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# 1. Read the cleaned products data
products = pd.read_csv("Cleaned_Data/products_clean.csv")

print("Products CSV loaded.")
print("Number of rows:", len(products))

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

# 3. Load the products into PostgreSQL
products.to_sql(
    "products",
    engine,
    if_exists="append",
    index=False
)

print("Products loaded into PostgreSQL successfully!")