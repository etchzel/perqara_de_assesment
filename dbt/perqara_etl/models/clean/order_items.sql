{{ config(materialized='view') }}

select distinct
    -- identifiers
    {{ dbt_utils.surrogate_key(['order_id', 'product_id', 'seller_id']) }} as order_detail_id,
	order_id,
	product_id,
	seller_id,

    -- date and/or timestamps
	shipping_limit_date::timestamp,

    -- order details
	count(product_id) over (partition by order_id, seller_id, product_id) as order_counts,
	price,
	freight_value
from {{ source('raw', 'order_items_dataset') }}