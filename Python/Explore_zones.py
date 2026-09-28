import pandas as pd

df = pd.read_csv("Data/taxi_zone_lookup.csv")
print(df.dtypes)
print(df.head())
print(df.describe())
print(df.columns[df.isnull().any()])
print(df[df.isnull().any(axis=1)])
print(df['Zone'].str.len().max())
print(df['Borough'].str.len().max())
print(df['service_zone'].str.len().max())
print(df['LocationID'].is_unique)