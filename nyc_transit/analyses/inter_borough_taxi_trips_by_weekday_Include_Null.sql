--SELECT
--    weekday(taxi_trips.pickup_datetime) AS weekday,
--    count(*) AS total_trips,
--    sum(CASE WHEN pickup_locations.Borough != dropoff_locations.Borough THEN 1 ELSE 0 END) AS different_borough_trips,
--    (different_borough_trips * 100.0 / count(*)) AS percentage_diff_borough
--FROM 
--    {{ ref('mart__fact_all_taxi_trips') }} AS taxi_trips
--JOIN 
--    {{ ref('mart__dim_locations') }} AS pickup_locations
--ON 
--    CAST(taxi_trips.PUlocationID AS INT) = pickup_locations.LocationID OR taxi_trips.PUlocationID IS NULL
--JOIN 
--    {{ ref('mart__dim_locations') }} AS dropoff_locations
--ON 
--    CAST(taxi_trips.DOlocationID AS INT) = dropoff_locations.LocationID OR taxi_trips.DOlocationID IS NULL
--GROUP BY 
--    weekday(taxi_trips.pickup_datetime)
--
--The Query above is very inefficient due to the JOIN conditions

WITH all_trips AS
(SELECT
    weekday(pickup_datetime) as weekday,
    count(*) trips
 FROM {{ ref('mart__fact_all_taxi_trips')}} taxi_trips
 GROUP BY ALL
),

inter_borough AS
(SELECT
    weekday(pickup_datetime) as weekday,
    count(*) as inter_trips
 FROM {{ ref('mart__fact_all_taxi_trips')}} taxi_trips
 JOIN {{ ref('mart__dim_locations')}} PL on taxi_trips.PUlocationID = PL.LocationID
 JOIN {{ ref('mart__dim_locations')}} DL on taxi_trips.DOlocationID = DL.LocationID
 WHERE PL.Borough != DL.Borough
 GROUP BY ALL
)

SELECT all_trips.weekday,
       all_trips.trips as total_trips,
       inter_borough.inter_trips as different_borough_trips,
       inter_borough.inter_trips * 100.0 / all_trips.trips as percentage_diff_borough
FROM all_trips
JOIN inter_borough on (all_trips.weekday = inter_borough.weekday);