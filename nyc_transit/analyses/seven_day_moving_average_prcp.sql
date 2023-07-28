SELECT 
    DATE,
    (LAG(PRCP, 3) OVER (ORDER BY DATE) 
     + LAG(PRCP, 2) OVER (ORDER BY DATE) 
     + LAG(PRCP, 1) OVER (ORDER BY DATE) 
     + PRCP
     + LEAD(PRCP, 1) OVER (ORDER BY DATE) 
     + LEAD(PRCP, 2) OVER (ORDER BY DATE) 
     + LEAD(PRCP, 3) OVER (ORDER BY DATE)) / 7.0 AS moving_avg_prcp
FROM 
    {{ ref('stg__central_park_weather')}}
ORDER BY DATE
