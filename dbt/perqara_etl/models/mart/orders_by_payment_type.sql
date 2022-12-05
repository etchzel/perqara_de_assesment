{{ config(materialized='table') }}

select
    coalesce(payment_type, 'not_defined') as payment_type,
    sum(order_counts) as total_orders_made,
    sum(payment_total) as value_total
from {{ ref('order_summary') }}
group by 1