{{ config(materialized='view') }}


select
    order_id,
    {{ dbt.listagg(
        measure="DISTINCT payment_type", 
        delimiter_text="'_and_'", 
        order_by_clause="order by payment_type"
    ) }} as payment_type,
    sum(payment_value) as payment_total
from {{ ref("order_payments") }}
group by 1