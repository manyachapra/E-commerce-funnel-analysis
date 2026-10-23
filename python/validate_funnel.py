
import pandas as pd

# Funnel results from your BigQuery sequential funnel query
data = {
    "stage_order": [1, 2, 3, 4],
    "funnel_stage": [
        "Product view",
        "Add to cart after view",
        "Checkout after cart",
        "Purchase after checkout",
    ],
    "sessions": [77020, 15146, 5293, 2751],
}

df = pd.DataFrame(data)

# Calculate conversion from the previous funnel stage
df["previous_stage_sessions"] = df["sessions"].shift(1)
df["stage_conversion_pct"] = (
    df["sessions"] / df["previous_stage_sessions"] * 100
).round(2)

# Calculate drop-off from the previous funnel stage
df["stage_dropoff_pct"] = (
    100 - df["stage_conversion_pct"]
).round(2)

# First stage is the baseline, so it has no previous stage
df.loc[0, ["stage_conversion_pct", "stage_dropoff_pct"]] = pd.NA

# Overall conversion from product view to purchase
overall_conversion = round(
    df.iloc[-1]["sessions"] / df.iloc[0]["sessions"] * 100, 2
)

print("\nECOMMERCE FUNNEL VALIDATION")
print("=" * 65)
print(df.to_string(index=False))
print(f"\nOverall view-to-purchase conversion: {overall_conversion}%")

# Basic data-quality checks
assert df["sessions"].notna().all(), "Missing session counts found."
assert (df["sessions"] >= 0).all(), "Negative session counts found."
assert df["sessions"].is_monotonic_decreasing, (
    "Funnel counts should decrease or remain the same at each stage."
)
df.to_csv("funnel_results.csv", index=False)
print("\nSaved funnel results to funnel_results.csv")

print("\nValidation checks passed.")