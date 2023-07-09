-- clear up fhv_tripdata table

with source as (

	select * from {{ source('main', 'fhv_tripdata') }}
	
),

cleaned as (

  SELECT 
        UPPER(dispatching_base_num) AS dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        CAST(PUlocationID AS DOUBLE) AS PULocationID,
        CAST(DOlocationID AS DOUBLE) AS DOLocationID,
        UPPER(Affiliated_base_number) AS Affiliated_base_number,
        filename
	FROM source
  WHERE
        dispatching_base_num ~ '^B[0-9]{5}$'
        AND Affiliated_base_number ~ '^B[0-9]{5}$'
	
)

select DISTINCT * from cleaned