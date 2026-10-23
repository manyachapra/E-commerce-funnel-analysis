
import pandas as pd
from pathlib import Path

# Find the CSV in the project root
csv_path = Path(__file__).resolve().parent.parent / "funnel_results.csv"

df = pd.read_csv(csv_path)

print("\nCSV FILE VALIDATION")
print("=" * 45)
print(f"File found: {csv_path.exists()}")
print(f"Rows: {len(df)}")
print(f"Columns: {list(df.columns)}")

# Verify the expected funnel stages
expected_stages = [
    "Product view",
    "Add to cart after view",
    "Checkout after cart",
    "Purchase after checkout",
]

assert df["funnel_stage"].tolist() == expected_stages
assert df["sessions"].notna().all()
assert (df["sessions"] >= 0).all()
assert df["sessions"].is_monotonic_decreasing

# Recalculate overall conversion from the CSV
conversion = round(
    df["sessions"].iloc[-1] / df["sessions"].iloc[0] * 100, 2
)

print(f"\nOverall conversion: {conversion}%")
print("CSV validation passed.")