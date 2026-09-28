import pandas as pd
import pyodbc
from sqlalchemy import create_engine

server = "localhost"
database = "nyc_taxi"
driver = "ODBC Driver 18 for SQL Server"

#extract the data
df= pd.read_csv("./Data/taxi_zone_lookup.csv")

# connection details
conn_str = (
    f"Driver={{ODBC Driver 18 for SQL Server}};"
    f"Server={server};"
    f"Database={database};"
    "Trusted_Connection=yes;"
    "Encrypt=no;"
    "TrustServerCertificate=yes;" # Set to 'yes' if using a self-signed local certificate
)

# 2. Establish connection
engine = create_engine(
    f"mssql+pyodbc://@{server}/{database}?driver=ODBC+Driver+18+for+SQL+Server&trusted_connection=yes&Encrypt=no&TrustServerCertificate=yes")
print(engine)

# 3. Export DataFrame to SQL
df.to_sql(
    name='taxi_zone_lookup',
    con=engine,
    if_exists='append',
    index=False
)


