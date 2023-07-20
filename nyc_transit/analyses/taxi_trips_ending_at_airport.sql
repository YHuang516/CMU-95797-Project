SELECT
    count(*) AS total_trips_to_airport
FROM 
    {{ ref('mart__fact_all_taxi_trips') }} AS taxi_trips
JOIN 
    {{ ref('mart__dim_locations') }} AS locations
ON 
    CAST(taxi_trips.DOlocationID AS INT) = locations.LocationID
WHERE 
    locations.service_zone IN ('Airports', 'EWR')