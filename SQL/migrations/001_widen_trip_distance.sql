-- trip_distance overflowed NUMERIC(6,2) on real Jan 2024 data (max value ~312,722.3)
-- widened to NUMERIC(10,2) and reloaded

ALTER TABLE trips
ALTER COLUMN trip_distance NUMERIC(10,2);

TRUNCATE TABLE trips;

-- executed this due to a partial python data load then failed due to trip_distance original schema size didn't fit
--select count(*) as totoal_count from trips;

--check schema column information
--SELECT COLUMN_NAME, DATA_TYPE, NUMERIC_PRECISION, NUMERIC_SCALE
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_NAME = 'trips';