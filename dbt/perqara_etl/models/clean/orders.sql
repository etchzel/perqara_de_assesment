{{ config(materialized='view') }}

select
	order_id,
	customer_id,
	order_status,
	order_purchase_timestamp::timestamp,
	order_approved_at::timestamp,
	order_delivered_carrier_date::timestamp,
	order_delivered_customer_date::timestamp,
	order_estimated_delivery_date::date
from {{ source('raw', 'orders_dataset') }}