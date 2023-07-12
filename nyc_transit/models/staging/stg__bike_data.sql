-- clear up bike_data table

with source as (

	select * from {{ source('main', 'bike_data') }}
	
),

cleaned AS (
    
	SELECT
        COALESCE(CAST(starttime AS TIMESTAMP), CAST(started_at AS TIMESTAMP)) AS started_at,
        COALESCE(CAST(stoptime AS TIMESTAMP), CAST(ended_at AS TIMESTAMP)) AS ended_at,
        COALESCE("start station id", start_station_id) AS start_station_id,
        COALESCE("start station name", start_station_name) AS start_station_name,
        COALESCE(CAST("start station latitude" AS DOUBLE), CAST(start_lat AS DOUBLE)) AS start_lat,
        COALESCE(CAST("start station longitude" AS DOUBLE), CAST(start_lng AS DOUBLE)) AS start_lng,
        COALESCE("end station id", end_station_id) AS end_station_id,
        COALESCE("end station name", end_station_name) AS end_station_name,
        COALESCE(CAST("end station latitude" AS DOUBLE), CAST(end_lat AS DOUBLE)) AS end_lat,
        COALESCE(CAST("end station longitude" AS DOUBLE), CAST(end_lng AS DOUBLE)) AS end_lng,
    --  CAST(tripduration AS INT) AS tripduration,
    --  Calculate tripduration for missing ones
        COALESCE(tripduration::int, datediff('second', started_at, ended_at)) tripduration,
        CAST(bikeid AS INT) AS bikeid,
        usertype,
        CAST("birth year" AS INT) AS birth_year,
        CAST(gender AS INT) AS gender,
        ride_id,
        rideable_type,
        member_casual,
        filename
    FROM source
)

SELECT * FROM cleaned
