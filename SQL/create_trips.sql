-- before any data was loaded through python script, created table with added id column for primary key, added trip month for future purpose
create table trips (
id						   int identity(1,1) primary key,
VendorID                   int not null,
tpep_pickup_datetime       DATETIME2,
tpep_dropoff_datetime      DATETIME2,
passenger_count            int,
trip_distance              NUMERIC(10,2),
RatecodeID                 SMALLINT,
store_and_fwd_flag         char(1),
PULocationID               int not null,
DOLocationID               int not null,
payment_type               int,
fare_amount                NUMERIC(10,2),
extra                      NUMERIC(10,2),
mta_tax                    NUMERIC(10,2),
tip_amount                 NUMERIC(10,2),
tolls_amount               NUMERIC(10,2),
improvement_surcharge      NUMERIC(10,2),
total_amount               NUMERIC(10,2),
congestion_surcharge       NUMERIC(10,2),
Airport_fee                NUMERIC(10,2),
trip_month DATE NOT NULL  -- store as '2024-01-01', represents "this row is from Jan 2024"
)


