-- Top 10 pickup zones by trip count, January 2024.
-- Answers: where do most taxi trips start?
select top 10
    t.PULocationID,
    lu.Zone,
    count(lu.Zone) as trip_start
from trips t
left join taxi_zone_lookup as lu
on t.PULocationID = lu.LocationID
group by t.PULocationID, lu.Zone
order by trip_start desc;