-- clear up fhvhv_tripdata table

with source as (

	select * from {{ source('main', 'fhvhv_tripdata') }}
	
),

cleaned as (

  SELECT 
        hvfhs_license_num,
        dispatching_base_num,
        originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        --CAST(PULocationID AS BIGINT) AS PULocationID,
        PULocationID,
        --CAST(DOLocationID AS BIGINT) AS DOLocationID,
        DOLocationID,
        trip_miles,
        --CAST(trip_time AS BIGINT) AS trip_time,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        --CASE WHEN shared_request_flag = 'Y' THEN TRUE ELSE FALSE END AS shared_request_flag,
        --CASE WHEN shared_match_flag = 'Y' THEN TRUE ELSE FALSE END AS shared_match_flag,
        --CASE WHEN access_a_ride_flag = ' ' THEN TRUE ELSE FALSE END AS access_a_ride_flag,
        --CASE WHEN wav_request_flag = 'Y' THEN TRUE ELSE FALSE END AS wav_request_flag,
        --CASE WHEN wav_match_flag = 'Y' THEN TRUE ELSE FALSE END AS wav_match_flag,
        {{flag_to_bool("shared_request_flag")}} as shared_request_flag,
        {{flag_to_bool("shared_match_flag")}} as shared_match_flag,
        {{flag_to_bool("access_a_ride_flag")}} as access_a_ride_flag,
        {{flag_to_bool("wav_request_flag")}} as wav_request_flag,
        {{flag_to_bool("wav_match_flag",)}} as wav_match_flag,
        filename
	FROM source
	
)

select * from cleaned