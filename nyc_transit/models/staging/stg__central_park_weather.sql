-- clear up central_park_weather table

with source as (

	select * from {{ source('main', 'central_park_weather') }}
	
),

cleaned as (

	SELECT
          STATION,
          NAME,
          CAST(DATE AS DATE) AS DATE,
          CAST(AWND AS DOUBLE) AS AWND,
          CAST(PRCP AS DOUBLE) AS PRCP,
          CAST(SNOW AS DOUBLE) AS SNOW,
          CAST(SNWD AS DOUBLE) AS SNWD,
          CAST(TMAX AS INT) AS TMAX,
          CAST(TMIN AS INT) AS TMIN,
          filename	
        FROM source	
)

-- select distinct * from cleaned
select * from cleaned