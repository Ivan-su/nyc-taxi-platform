import pyodbc
import pandas as pd
import numpy as np
from sqlalchemy import create_engine

server = "localhost"
database = "nyc_taxi"
driver = "ODBC Driver 18 for SQL Server"
df = pd.read_parquet("Data/yellow_tripdata_2024-01.parquet")

conn_str = (
    f"Driver={{ODBC Driver 18 for SQL Server}};"
    f"Server={server};"
    f"Database={database};"
    "Trusted_Connection=yes;"
    "Encrypt=no;"
    "TrustServerCertificate=yes;" # Set to 'yes' if using a self-signed local certificate
)

engine = create_engine(
    f"mssql+pyodbc://@{server}/{database}?driver=ODBC+Driver+18+for+SQL+Server&trusted_connection=yes&Encrypt=no&TrustServerCertificate=yes")
print(engine)

try:
    conn = pyodbc.connect(conn_str)
    print("Connected successfully!")
    conn.close()

except pyodbc.Error as e:
    print("Error while connecting to SQL Server:", e)

# transformation logic
# convert current float64 from source to int64 in target
df['passenger_count'] = df['passenger_count'].astype('Int64')
df['RatecodeID'] = df['RatecodeID'].astype('Int64')

print(df[['passenger_count', 'RatecodeID']].dtypes)
print(df[['passenger_count', 'RatecodeID']].head(5))

# Replace NaN with None
df['congestion_surcharge'] = df['congestion_surcharge'].replace({np.nan: None})
df['Airport_fee'] = df['Airport_fee'].replace({np.nan: None})
print(df['congestion_surcharge'])
print(df['Airport_fee'])
# test
print(df['congestion_surcharge'].dtype)

#insert date into newly created column
df['trip_month'] = pd.to_datetime("2024-01-01")
print(df['trip_month'].dtype) # shows data type
print(df['trip_month'].head(5))
print(df['trip_month'].unique())  # should show only ONE value

#inserting the yellow_trip data_2024-01.parquet data into the transformed trip table
df.to_sql(name='trips', con=engine, if_exists='append', chunksize= 10000, index= False)


print(df[['trip_distance', 'fare_amount', 'extra', 'mta_tax', 'tip_amount', 'tolls_amount', 'improvement_surcharge', 'total_amount', 'congestion_surcharge', 'Airport_fee']].describe())

print(df['congestion_surcharge'].max())
print(df['congestion_surcharge'].min())
print(df['Airport_fee'].max())
print(df['Airport_fee'].min())