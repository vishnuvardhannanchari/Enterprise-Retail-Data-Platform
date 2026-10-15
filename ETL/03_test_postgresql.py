from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL

database_url = URL.create(
    drivername="postgresql+psycopg2",
    username="postgres",
    password="YOUR_PASSWORD",
    host="localhost",
    port=5432,
    database="retailx_db"
)

engine = create_engine(database_url)

with engine.connect() as connection:
    result = connection.execute(text("SELECT 1"))

    print("PostgreSQL connection successful!")
    print("Test result:", result.scalar())
password="YOUR_PASSWORD"
