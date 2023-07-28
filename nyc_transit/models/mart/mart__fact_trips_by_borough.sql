SELECT borough, count(*) as trip_count
FROM {{ ref('mart__dim_locations')}} locations 
LEFT JOIN {{ ref('mart__fact_all_taxi_trips')}} taxi_trips ON locations.LocationID = taxi_trips.PUlocationID
GROUP BY borough
ORDER BY borough ASC