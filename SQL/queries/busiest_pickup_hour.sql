-- Trip count by pickup hour, January 2024, with Borough/service_zone kept per row.
-- Answers: what time of day is busiest for pickups, and where?
-- Uses count(*) OVER(PARTITION BY ...) instead of GROUP BY so each individual
-- trip row stays visible alongside its hour's total, rather than collapsing
-- into one summary row per hour.
-- Result: hour 18 (6 PM) peaks at 212,788 trips citywide.

select
    t.id,
    datepart(hh, t.tpep_pickup_datetime) as pickup_hour,
    lu.Borough,
    lu.service_zone,
    count(*) over (partition by datepart(hh, t.tpep_pickup_datetime)) as trips_this_hour
from trips t
join taxi_zone_lookup lu on t.PULocationID = lu.LocationID
order by trips_this_hour desc;