{{ config(materialized='view') }}

select * from {{ source('raw', 'products_dataset') }}