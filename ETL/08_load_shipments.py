import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL


# --------------------------------------------------
# 1. Load the cleaned shipments data
# --------------------------------------------------

shipments = pd.read_csv("Cleaned_Data/shipments_clean.csv")

print("Shipments CSV loaded.")
print("Number of rows:", len(shipments))


# --------------------------------------------------
# 2. Create the PostgreSQL connection
# --------------------------------------------------

database_url = URL.create(
    drivername="postgresql+psycopg2",
    username="postgres",
    password="YOUR_PASSWORD",
    host="localhost",
    port=5432,
    database="retailx_db"
)

engine = create_engine(database_url)


# --------------------------------------------------
# 3. Check how many shipments are already in PostgreSQL
# --------------------------------------------------

existing_shipments = pd.read_sql(
    "SELECT shipment_id FROM shipments",
    engine
)

print("Existing shipments in PostgreSQL:", len(existing_shipments))


# --------------------------------------------------
# 4. Find only new shipments
# --------------------------------------------------

new_shipments = shipments[
    ~shipments["shipment_id"].isin(existing_shipments["shipment_id"])
]

print("New shipments to load:", len(new_shipments))


# --------------------------------------------------
# 5. Load only new shipments
# --------------------------------------------------

if len(new_shipments) > 0:

    new_shipments.to_sql(
        "shipments",
        engine,
        if_exists="append",
        index=False
    )

    print("New shipments loaded successfully!")

else:

    print("No new shipments to load.")
    print("All shipments are already in PostgreSQL.")


# --------------------------------------------------
# 6. Close the database connection
# --------------------------------------------------

engine.dispose()

print("Shipment ETL process completed successfully!")