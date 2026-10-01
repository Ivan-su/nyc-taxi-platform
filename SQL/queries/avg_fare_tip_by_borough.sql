-- Average fare and tip amount by borough, January 2024.
-- NULL Borough = trips picked up at LocationID 265 ("Outside of NYC");
-- "Unknown" = LocationID 264, Borough is literally "Unknown" in the source data.

select avg(t.fare_amount) as Average_Fare, avg(t.tip_amount) as tip, lu.Borough
from trips t
left join taxi_zone_lookup as lu
on t.PULocationID = lu.LocationID
group by lu.Borough
order by Average_Fare desc;

select * from taxi_zone_lookup
where Borough is NULL or Borough = 'Unknown';