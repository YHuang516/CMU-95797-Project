SELECT 
    lo.Borough, lo.Zone as Pickup_Zone, 
    COUNT(*) as trip_count, 
    AVG(t.duration_min) as avg_duration_min
FROM 
    {{ ref('mart__fact_all_taxi_trips') }} t
JOIN 
    {{ ref('mart__dim_locations') }} lo ON t.PUlocationID = lo.LocationID
GROUP BY 
    lo.Borough, lo.Zone
ORDER BY 
    lo.Borough ASC, lo.Zone ASC