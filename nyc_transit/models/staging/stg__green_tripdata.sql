-- clear up green_tripdata table

with source as (

	select * from {{ source('main', 'green_tripdata') }}
	
),

cleaned as (

  SELECT 
        --CAST(VendorID AS BIGINT) AS VendorID,
        VendorID,
        lpep_pickup_datetime,
        lpep_dropoff_datetime,
        CASE WHEN store_and_fwd_flag = 'Y' THEN TRUE ELSE FALSE END AS store_and_fwd_flag,
        --CAST(RatecodeID AS DOUBLE) AS RatecodeID,
        --CAST(PULocationID AS BIGINT) AS PULocationID,
        --CAST(DOLocationID AS BIGINT) AS DOLocationID,
        RatecodeID,
        Pulocationid,
        Dolocationid,
        passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        --ABS(improvement_surcharge) AS improvement_surcharge,
        improvement_surcharge,
        total_amount,
        --CAST(payment_type AS DOUBLE) AS payment_type,
        payment_type,
        --CAST(trip_type AS DOUBLE) AS trip_type,
        trip_type,
        --ABS(congestion_surcharge) AS congestion_surcharge,
        congestion_surcharge,
        filename
	FROM source
--	WHERE lpep_pickup_datetime < TIMESTAMP '2022-12-31' -- drop rows in the future
--        AND trip_distance >= 0 -- drop negative trip_distance
--        AND extra >= 0 -- drop negative extra
--        AND mta_tax >= 0 -- drop negative mta_tax
--        AND tip_amount >= 0 -- drop negative tip_amount
--        AND tolls_amount >= 0 -- drop negative tolls_amount

)

--select DISTINCT * from cleaned  -- remove duplicates
select * from cleaned