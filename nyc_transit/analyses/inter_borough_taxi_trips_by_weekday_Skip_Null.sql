SELECT
    weekday(taxi_trips.pickup_datetime) AS weekday,
    count(*) AS total_trips,
    sum(CASE WHEN pickup_locations.Borough != dropoff_locations.Borough THEN 1 ELSE 0 END) AS different_borough_trips,
    (different_borough_trips * 100.0 / count(*)) AS percentage_diff_borough
FROM 
    {{ ref('mart__fact_all_taxi_trips') }} AS taxi_trips
JOIN 
    {{ ref('mart__dim_locations') }} AS pickup_locations
ON 
    CAST(taxi_trips.PUlocationID AS INT) = pickup_locations.LocationID
JOIN 
    {{ ref('mart__dim_locations') }} AS dropoff_locations
ON 
    CAST(taxi_trips.DOlocationID AS INT) = dropoff_locations.LocationID
GROUP BY 
    weekday(taxi_trips.pickup_datetime)