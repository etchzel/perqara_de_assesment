{{ config(materialized='table') }}


select distinct 
        geolocation_zip_code_prefix as zip_code,
        geolocation_lat as latitude,
        geolocation_lng as longitude,
        {{ unicode_text_normalize('geolocation_city') }} as city,
        geolocation_state as state_code
from {{ source('raw', 'geolocation_dataset') }}
