import pandas as pd

# Step up from Python/ to claude projecct/ then into Data/
df = pd.read_parquet("Data/yellow_tripdata_2024-01.parquet")

print("--- DATA TYPES ---")
print(df.dtypes)

print("\n--- FIRST 5 ROWS ---")
print(df.head(10))

print("\n--- TOTAL ROWS ---")
print(f"{len(df):,} rows")

print("\n--- check store flag datatype ---")
print(df['store_and_fwd_flag'].unique())

# checking if any columns in df has null values
def check_for_nulls(df):
    null_columns = df.columns[df.isnull().any()]

    # Loop through only those columns
    for col in null_columns:
        print(f"Column '{col}' has null values!")

check_for_nulls(df)