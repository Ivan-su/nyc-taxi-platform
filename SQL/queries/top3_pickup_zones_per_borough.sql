-- Top 3 pickup zones per borough by trip count, January 2024.
-- Answers: within each borough, which zones start the most trips?
-- GROUP BY builds one row per zone; RANK() OVER(PARTITION BY Borough) ranks zones
-- within each borough. The CTE is needed because WHERE can't filter on a window function.

with ranked_zones as (
    select
        lu.Borough,
        lu.Zone,
        count(*) as trip_count,
        rank() over(partition by lu.Borough order by count(*) desc) as zone_rank
    from trips t
    join taxi_zone_lookup lu on t.PULocationID = lu.LocationID
    group by lu.Borough, lu.Zone
)
select *
from ranked_zones
where zone_rank <= 3
order by Borough, zone_rank;