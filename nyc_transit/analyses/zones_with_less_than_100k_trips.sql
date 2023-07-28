SELECT 
    lo.Zone, 
    COUNT(t.PUlocationID) as trip_count
FROM 
    {{ ref('mart__fact_all_taxi_trips') }} t
JOIN 
    {{ ref('mart__dim_locations') }} lo ON t.PUlocationID = lo.LocationID
GROUP BY 
    lo.Zone
HAVING 
    COUNT(t.PUlocationID) < 100000
ORDER BY 
    lo.Zone ASC