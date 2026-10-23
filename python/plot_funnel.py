
import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

project_root = Path(__file__).resolve().parent.parent
csv_path = project_root / "funnel_results.csv"
output_path = project_root / "funnel_chart.png"

df = pd.read_csv(csv_path)

plt.figure(figsize=(10, 6))
plt.barh(df["funnel_stage"], df["sessions"])
plt.gca().invert_yaxis()

plt.title("E-commerce Conversion Funnel")
plt.xlabel("Sessions")
plt.ylabel("Funnel Stage")
plt.tight_layout()

plt.savefig(output_path, dpi=300, bbox_inches="tight")
plt.show()

print(f"Chart saved to: {output_path}")
