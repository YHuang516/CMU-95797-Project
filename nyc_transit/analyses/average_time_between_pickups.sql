WITH taxi_trip_and_previous AS (
    SELECT 
        PUlocationID,
        pickup_datetime,
        LAG(pickup_datetime, 1) OVER (PARTITION BY PUlocationID ORDER BY pickup_datetime) AS previous_pickup_datetime
    FROM 
        {{ ref('mart__fact_all_taxi_trips')}}
),

time_diffs AS (
    SELECT 
        PUlocationID,
        datediff('second', previous_pickup_datetime, pickup_datetime) AS time_diff_sec,
    FROM 
        taxi_trip_and_previous
    WHERE 
        previous_pickup_datetime IS NOT NULL
)

SELECT 
    lo.Zone,
    AVG(time_diff_sec) AS avg_time_between_pickups
FROM 
    time_diffs td
JOIN 
    {{ ref('mart__dim_locations') }} lo ON td.PUlocationID = lo.LocationID
GROUP BY 
    lo.Zone
ORDER BY
    avg_time_between_pickups
