-- clear up daily_citi_bike_trip_counts_and_weather table

with source as (

	select * from {{ source('main', 'daily_citi_bike_trip_counts_and_weather') }}
	
),

cleaned as (

    SELECT
        CAST(date AS DATE) AS date,
        CAST(trips AS INT) AS trips,
        CAST(precipitation AS DOUBLE) AS precipitation,
        CAST(snow_depth AS DOUBLE) AS snow_depth,
        CAST(snowfall AS DOUBLE) AS snowfall,
        CAST(max_temperature AS DOUBLE) AS max_temperature,
        CAST(min_temperature AS DOUBLE) AS min_temperature,
        CAST(NULLIF(average_wind_speed, 'NA') AS DOUBLE) AS average_wind_speed,
        CAST(dow AS INT) AS dow,
        CAST(year AS INT) AS year,
        CAST(month AS INT) AS month,
        CAST(holiday AS BOOLEAN) AS holiday,
        CAST(NULLIF(stations_in_service, 'NA') AS INT) AS stations_in_service,
        CAST(weekday AS BOOLEAN) AS weekday,
        CAST(weekday_non_holiday AS BOOLEAN) AS weekday_non_holiday,
        filename
		
	from source
	
)

select distinct * from cleaned