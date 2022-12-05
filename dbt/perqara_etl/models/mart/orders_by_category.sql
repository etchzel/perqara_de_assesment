{{ config(materialized='table') }}

select
    coalesce(category, 'NONE') as category,
    sum(order_counts) as total_orders,
    sum(order_counts * product_qty) as total_qty,
    sum((price + freight_value) * order_counts) as value_total
from {{ ref('order_summary') }}
where order_status in (
    {{ get_valid_transaction_status() }},
    'invoiced',
    'created',
    'approved',
    'processing'
)
group by 1