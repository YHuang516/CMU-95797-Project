SELECT 
    DATE,
    MIN(PRCP) OVER seven_days AS moving_min_prcp,
    MAX(PRCP) OVER seven_days AS moving_max_prcp,
    AVG(PRCP) OVER seven_days AS moving_avg_prcp,
    SUM(PRCP) OVER seven_days AS moving_sum_prcp,
    MIN(SNOW) OVER seven_days AS moving_min_snow,
    MAX(SNOW) OVER seven_days AS moving_max_snow,
    AVG(SNOW) OVER seven_days AS moving_avg_snow,
    SUM(SNOW) OVER seven_days AS moving_sum_snow
FROM 
    {{ ref('stg__central_park_weather')}}
WINDOW seven_days AS (
    ORDER BY DATE ASC
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND
                  INTERVAL 3 DAYS FOLLOWING
    )
