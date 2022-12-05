{{ config(materialized='view') }}

select
	-- identifiers
	orders.order_id,

	-- customer detail
	customers.customer_unique_id,
	customers.customer_zip_code_prefix as customer_zip_code,
	customers.customer_city,
	customers.customer_state,
	
	-- seller detail
	order_items.seller_id,
	sellers.seller_zip_code_prefix as seller_zip_code,
	sellers.seller_city,
	sellers.seller_state,
	
	-- status
	orders.order_status,
	
	-- timestamps
	orders.order_purchase_timestamp as purchased_at,
	orders.order_approved_at as approved_at,
	order_items.shipping_limit_date,
	orders.order_delivered_carrier_date as delivered_at,
	orders.order_estimated_delivery_date as estimated_arrival,
	orders.order_delivered_customer_date as arrived_at,
	
	-- order details
	product_category.category,
	coalesce(order_items.order_counts, 1) as order_counts,
	coalesce(product_category.product_qty, 1) as product_qty,
	coalesce(order_items.price, 0) as price,
	coalesce(order_items.freight_value, 0) as freight_value,
	
	-- payment details
	payments.payment_type,
	payments.payment_total
from {{ ref('orders') }} orders
left join {{ ref('order_items') }} order_items on orders.order_id = order_items.order_id
left join {{ ref('product_category') }} product_category on order_items.product_id = product_category.product_id
left join {{ ref('order_payments_sum') }} payments on orders.order_id = payments.order_id
left join {{ ref('customers') }} customers on orders.customer_id = customers.customer_id
left join {{ ref('sellers') }} sellers on order_items.seller_id = sellers.seller_id