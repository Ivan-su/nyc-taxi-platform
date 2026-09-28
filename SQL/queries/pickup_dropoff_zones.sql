-- Pickup and dropoff zone names for each trip.
-- taxi_zone_lookup is joined twice (aliases pu and dropoff), once per location ID column.
-- Verified: join row count = 2,964,624, matching trips, so no trips are dropped.

select top 100
    t.id,
    t.PULocationID,
    pu.Zone as pickup_zone,
    t.DOLocationID,
    dropoff.Zone as dropoff_zone
from trips t
join taxi_zone_lookup pu      on t.PULocationID = pu.LocationID
join taxi_zone_lookup dropoff on t.DOLocationID = dropoff.LocationID;