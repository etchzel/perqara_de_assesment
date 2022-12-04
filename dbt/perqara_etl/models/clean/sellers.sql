{{ config(materialized='view') }}

select * from {{ source('raw', 'sellers_dataset') }}