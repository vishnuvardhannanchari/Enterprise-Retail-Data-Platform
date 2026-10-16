from pathlib import Path
import pandas as pd

# Folder containing this script and the cleaned CSV files
DATA_DIR = Path(__file__).resolve().parent

# Dataset filenames
FILES = [
    "customers_clean.csv",
    "products_clean.csv",
    "orders_clean.csv",
    "payments_clean.csv",
    "shipments_clean.csv",
]

# Store data quality results
results = []

print("\n" + "=" * 70)
print("RETAILX DATA QUALITY REPORT")
print("=" * 70)

for filename in FILES:
    file_path = DATA_DIR / filename

    # Check whether the dataset exists
    if not file_path.is_file():
        print(f"\nWARNING: File not found: {filename}")

        results.append({
            "Dataset": filename,
            "Rows": 0,
            "Columns": 0,
            "Missing Values": "N/A",
            "Duplicate Rows": "N/A",
            "Status": "FILE NOT FOUND",
        })
        continue

    try:
        # Read the cleaned dataset
        df = pd.read_csv(file_path)

        # Calculate data quality metrics
        rows = len(df)
        columns = len(df.columns)
        missing = int(df.isnull().sum().sum())
        duplicates = int(df.duplicated().sum())

        # Determine status
        status = "PASS" if missing == 0 and duplicates == 0 else "CHECK"

        # Store results
        results.append({
            "Dataset": filename,
            "Rows": rows,
            "Columns": columns,
            "Missing Values": missing,
            "Duplicate Rows": duplicates,
            "Status": status,
        })

        print(f"\nProcessed: {filename}")

    except Exception as error:
        print(f"\nERROR processing {filename}: {error}")

        results.append({
            "Dataset": filename,
            "Rows": 0,
            "Columns": 0,
            "Missing Values": "N/A",
            "Duplicate Rows": "N/A",
            "Status": "ERROR",
        })

# Create the report DataFrame
report = pd.DataFrame(results)

# Display the results
print("\n" + "-" * 70)
print(report.to_string(index=False))
print("-" * 70)

# Save the report in the Cleaned_Data folder
output_path = DATA_DIR / "data_quality_report.csv"
report.to_csv(output_path, index=False)

print(f"\nReport saved successfully:")
print(output_path)

# Summarize the report
passed = sum(status == "PASS" for status in report["Status"])
checked = sum(status == "CHECK" for status in report["Status"])
failed = sum(
    status in ["FILE NOT FOUND", "ERROR"]
    for status in report["Status"]
)

print("\nFINAL SUMMARY")
print(f"Datasets processed: {len(FILES)}")
print(f"Passed: {passed}")
print(f"Needs review: {checked}")
print(f"Errors or missing files: {failed}")

print("\nData quality report completed!")
print("=" * 70)
