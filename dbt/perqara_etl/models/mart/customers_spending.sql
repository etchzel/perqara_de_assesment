{{ config(materialized='table') }}

select
	customer_unique_id,
    customer_city as city,
    customer_state as state,
    customer_zip_code as zip_code,
    sum(order_counts) as total_orders,
	sum(order_counts * product_qty) as total_ordered_qty,
	sum(price * order_counts) as total_spent_product_cost,
	sum(freight_value * order_counts) as total_spent_shipping_cost,
	sum(payment_total) as total_spent
from {{ ref('order_summary') }}
where order_status in ({{ get_valid_transaction_status() }})
{{ dbt_utils.group_by(4) }}