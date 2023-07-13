-- clear up yellow_tripdata table

with source as (

	select * from {{ source('main', 'yellow_tripdata') }}
	
),

cleaned as (

  SELECT 
        VendorID,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        passenger_count,
        trip_distance,
        RatecodeID,
        --CASE WHEN store_and_fwd_flag = 'Y' THEN TRUE ELSE FALSE END AS store_and_fwd_flag,
        {{flag_to_bool("store_and_fwd_flag")}} as store_and_fwd_flag,
        PULocationID,
        DOLocationID,
        payment_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        --ABS(improvement_surcharge) AS improvement_surcharge,
        improvement_surcharge,
        total_amount,
        --ABS(congestion_surcharge) AS congestion_surcharge,
        congestion_surcharge,
        airport_fee,
        filename
	FROM source
--	WHERE tpep_pickup_datetime < TIMESTAMP '2022-12-31' -- drop rows in the future
--        AND trip_distance >= 0 -- drop negative trip_distance
--        AND extra >= 0 -- drop negative extra
--        AND mta_tax >= 0 -- drop negative mta_tax
--        AND tip_amount >= 0 -- drop negative tip_amount
--        AND tolls_amount >= 0 -- drop negative tolls_amount

)

--select DISTINCT * from cleaned
select * from cleaned