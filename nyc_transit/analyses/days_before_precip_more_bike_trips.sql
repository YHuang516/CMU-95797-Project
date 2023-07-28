-- The key of this question is: We should only consider days without precipitation or snow
-- when it was before precipitation and snow (that makes sense!) There were days of continuing
-- precipitation or snow, it is wrong to simply include day before a weather day, that will include
-- some of the rainning/snowing days into the "previous days"

WITH 
weather_days AS (
    SELECT 
        date, 
        trips
    FROM 
        {{ ref('stg__daily_citi_bike_trip_counts_and_weather') }}
    WHERE 
        precipitation > 0 OR snowfall > 0
),

non_weather_days AS (
    SELECT 
        date, 
        trips
    FROM 
        {{ ref('stg__daily_citi_bike_trip_counts_and_weather') }}
    WHERE 
        precipitation = 0 AND snowfall = 0
),

weather_days_and_pre_non_weather_days AS (
SELECT 
    w.date AS weather_date, 
    w.trips AS weather_day_trips,
    n.date AS pre_non_weather_date, 
    n.trips AS pre_non_weather_day_trips
FROM 
    weather_days w
LEFT JOIN 
    non_weather_days n ON w.date = n.date + INTERVAL '1 day'
ORDER BY
    w.date
)

SELECT 
    ROUND(AVG(weather_day_trips))::INTEGER AS avg_trips_on_days_with_weather,
    ROUND(AVG(pre_non_weather_day_trips))::INTEGER AS avg_trips_on_days_before_weather
FROM 
    weather_days_and_pre_non_weather_days