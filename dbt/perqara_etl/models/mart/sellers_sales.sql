{{ config(materialized='table') }}

select
	seller_id,
    seller_city as city,
    seller_state as state,
    seller_zip_code as zip_code,
    sum(order_counts) as total_orders,
	sum(order_counts * product_qty) as total_ordered_qty,
	sum(price * order_counts) as total_sales_product
from {{ ref('order_summary') }}
where order_status in ({{ get_valid_transaction_status() }})
{{ dbt_utils.group_by(4) }}