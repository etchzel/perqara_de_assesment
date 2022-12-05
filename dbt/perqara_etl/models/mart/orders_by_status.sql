{{ config(materialized='table') }}

select
    order_status,
    sum(order_counts) as total_orders,
    case sum((price + freight_value) * order_counts)
        when 0 then sum(payment_total)
        else sum((price + freight_value) * order_counts)
    end as value_total
from {{ ref('order_summary') }}
group by 1