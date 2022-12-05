{{ config(materialized='view') }}

select
    latest_reviews.review_id,
    order_items.order_id,
    customers.customer_unique_id,
    order_items.order_detail_id,
    order_items.product_id,
    product_category.category,
    latest_reviews.review_score,
    latest_reviews.review_comment_title,
    latest_reviews.review_comment_message
from {{ ref('order_items') }} order_items
left join ({{ dbt_utils.deduplicate(relation=ref('order_reviews'), partition_by='order_id', order_by='review_creation_date desc') }}) latest_reviews
    on order_items.order_id = latest_reviews.order_id
join {{ ref('orders') }} orders on order_items.order_id = orders.order_id
join {{ ref('customers') }} customers on orders.customer_id = customers.customer_id
join {{ ref('product_category') }}  product_category on order_items.product_id = product_category.product_id 
