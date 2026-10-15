
import pandas as pd
from sqlalchemy import create_engine, URL

# 1. Load the cleaned payments CSV
payments = pd.read_csv("Cleaned_Data/payments_clean.csv")

print("Payments CSV loaded.")
print("Number of rows:", len(payments))


# 2. Create the PostgreSQL connection
database_url = URL.create(
    drivername="postgresql+psycopg2",
    username="postgres",
    password="YOUR_PASSWORD",
    host="localhost",
   sport=5432,
    database="retailx_db"
)
engine = create_engine(database_url)



# 3. Load the data into PostgreSQL
payments.to_sql(
    "payments",
    engine,
    if_exists="append",
    index=False
)

print("Payments loaded into PostgreSQL successfully!")
