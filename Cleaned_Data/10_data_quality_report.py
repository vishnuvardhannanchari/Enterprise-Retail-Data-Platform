
from pathlib import Path
import pandas as pd

# Project directory
BASE_DIR = Path(__file__).resolve().parent

# Cleaned data directory
DATA_DIR = BASE_DIR / "Cleaned_Data"

# Dataset filenames
FILES = [
    "customers_clean.csv",
    "products_clean.csv",
    "orders_clean.csv",
    "payments_clean.csv",
    "shipments_clean.csv",
]
# Store results
results = []

print("\nRETAILX DATA QUALITY SUMMARY")
print("=" * 50)

for filename in FILES:
    file_path = DATA_DIR / filename

    if not file_path.exists():
        print(f"\nFile not found: {filename}")
        results.append({
            "Dataset": filename,
            "Rows": 0,
            "Columns": 0,
            "Missing Values": "N/A",
            "Duplicate Rows": "N/A",
            "Status": "FILE NOT FOUND",
        })
        continue

    df = pd.read_csv(file_path)

    rows = len(df)
    columns = len(df.columns)
    missing = int(df.isnull().sum().sum())
    duplicates = int(df.duplicated().sum())

    status = "PASS" if missing == 0 and duplicates == 0 else "CHECK"

    results.append({
        "Dataset": filename,
        "Rows": rows,
        "Columns": columns,
        "Missing Values": missing,
        "Duplicate Rows": duplicates,
        "Status": status,
    })

# Display report
report = pd.DataFrame(results)
print(report.to_string(index=False))

# Save report
output_path = BASE_DIR / "data_quality_report.csv"
report.to_csv(output_path, index=False)

print("\n" + "=" * 50)
print(f"Report saved to: {output_path}")
print("Data quality report completed!")
