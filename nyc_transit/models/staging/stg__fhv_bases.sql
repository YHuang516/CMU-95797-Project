-- clear up fhv_bases table

with source as (

	select * from {{ source('main', 'fhv_bases') }}
	
),

cleaned as (

        SELECT 
          base_number,
          base_name,
          dba,
          dba_category,
          filename
	FROM source	
)

select DISTINCT* from cleaned