-- Day-over-day change in trip volume, January 2024.
-- Answers: how did daily trip counts move from one day to the next?
-- CTE 1 counts trips per day; CTE 2 uses LAG() to fetch the previous day's count;
-- the final SELECT computes change and NULL-safe percent change (NULLIF avoids divide-by-zero).
-- The WHERE excludes 15 trips with pickup dates outside January (2002, 2009, 2023-12-31),
-- which would otherwise distort the comparison, e.g. a fake +810,030% on Jan 1.
with daily_counts as(
select
    cast(tpep_pickup_datetime as Date) as Pickup_date,
    count(*) as trip_counts
    from trips
    where tpep_pickup_datetime >= '2024-01-01'
      and tpep_pickup_datetime <  '2024-02-01'
    group by cast(tpep_pickup_datetime as Date)
    ),
    with_daily_prev as (
    select
           Pickup_date,
           trip_counts,
           lag(trip_counts) over(order by Pickup_date) as previous_day_trips
           from daily_counts
     )
     select pickup_date,
            trip_counts,
            previous_day_trips,
            round(100.0 * (trip_counts - previous_day_trips) / nullif(previous_day_trips, 0), 1) as pct_change
     from with_daily_prev
     order by pickup_date;