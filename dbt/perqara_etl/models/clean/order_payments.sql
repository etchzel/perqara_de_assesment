{{ config(materialized='view') }}

select * from {{ source('raw', 'order_payments_dataset') }}