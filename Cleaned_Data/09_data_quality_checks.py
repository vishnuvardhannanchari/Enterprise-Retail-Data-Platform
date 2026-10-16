
from pathlib import Path
import pandas as pd

# Project folder
BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = BASE_DIR / "Data"
CLEANED_DIR = BASE_DIR / "Cleaned_Data"

# CSV files to check
FILES = {
    "customers": "customers.csv",
    "products": "products.csv",
    "orders": "orders.csv",
    "payments": "payments.csv",
    "shipments": "shipments.csv",
}

def check_file(table_name, file_name):
    file_path = CLEANED_DIR / file_name

    # Check whether the cleaned CSV exists
    if not file_path.exists():
        file_path = DATA_DIR / file_name

    if not file_path.exists():
        print(f"\n❌ {table_name}: File not found")
        return

    df = pd.read_csv(file_path)

    print(f"\n{'=' * 45}")
    print(f"TABLE: {table_name.upper()}")
    print(f"{'=' * 45}")

    print(f"File: {file_path.name}")
    print(f"Rows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")

    # Check missing values
    missing_values = df.isnull().sum()
    missing_columns = missing_values[missing_values > 0]

    if missing_columns.empty:
        print("Missing values: PASS")
    else:
        print("Missing values: CHECK")
        print(missing_columns.to_string())

    # Check duplicate rows
    duplicate_count = df.duplicated().sum()

    if duplicate_count == 0:
        print("Duplicate rows: PASS")
    else:
        print(f"Duplicate rows: CHECK - {duplicate_count:,} duplicates")

    # Check column names
    if len(df.columns) == len(set(df.columns)):
        print("Column names: PASS")
    else:
        print("Column names: FAIL - duplicate column names found")


def main():
    print("\nRETAILX DATA QUALITY REPORT")

    for table_name, file_name in FILES.items():
        check_file(table_name, file_name)

    print("\nData quality checks completed.")


if __name__ == "__main__":
    main()
    