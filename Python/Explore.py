import pandas as pd

# Step up from Python/ to claude projecct/ then into Data/
df = pd.read_parquet("Data/yellow_tripdata_2024-01.parquet")

print("--- DATA TYPES ---")
print(df.dtypes)

print("\n--- FIRST 5 ROWS ---")
print(df.head(10))

print("\n--- TOTAL ROWS ---")
print(f"{len(df):,} rows")