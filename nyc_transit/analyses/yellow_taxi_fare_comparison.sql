SELECT 
    yt.fare_amount,
    AVG(yt.fare_amount) OVER (PARTITION BY l.Zone) AS avg_fare_zone,
    AVG(yt.fare_amount) OVER (PARTITION BY l.Borough) AS avg_fare_borough,
    AVG(yt.fare_amount) OVER () AS avg_fare_overall
FROM 
    {{ ref('stg__yellow_tripdata')}} yt
JOIN
    {{ ref('mart__dim_locations')}} l ON yt.PUlocationID = l.LocationID;