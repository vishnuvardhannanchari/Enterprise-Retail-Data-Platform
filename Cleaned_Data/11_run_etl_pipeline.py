from pathlib import Path
import subprocess
import sys

# Project directories
PROJECT_DIR = Path(__file__).resolve().parent.parent
CLEANED_DIR = PROJECT_DIR / "Cleaned_Data"

# Pipeline steps
PIPELINE_STEPS = [
    {
        "name": "Data Quality Checks",
        "script": CLEANED_DIR / "09_data_quality_checks.py",
    },
    {
        "name": "Data Quality Report",
        "script": CLEANED_DIR / "10_data_quality_report.py",
    },
]


def run_pipeline():
    print("\n" + "=" * 60)
    print("RETAILX AUTOMATED DATA QUALITY PIPELINE")
    print("=" * 60)

    for step in PIPELINE_STEPS:
        step_name = step["name"]
        script_path = step["script"]

        print(f"\nRunning: {step_name}")
        print(f"Script: {script_path.name}")

        # Check whether the script exists
        if not script_path.is_file():
            print(f"ERROR: Script not found: {script_path}")
            sys.exit(1)

        # Execute the script
        result = subprocess.run(
            [sys.executable, str(script_path)],
            cwd=PROJECT_DIR,
        )

        # Stop if the script fails
        if result.returncode != 0:
            print(f"\nFAILED: {step_name}")
            print("Pipeline stopped because an error occurred.")
            sys.exit(result.returncode)

        print(f"SUCCESS: {step_name}")

    print("\n" + "=" * 60)
    print("PIPELINE COMPLETED SUCCESSFULLY!")
    print("=" * 60)


if __name__ == "__main__":
    run_pipeline()