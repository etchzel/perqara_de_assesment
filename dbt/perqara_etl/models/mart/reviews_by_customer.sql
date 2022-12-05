{{ config(materialized='table') }}

with review_aggregate_customer as (
    select
        review_id,
        order_id,
        customer_unique_id,
        count(order_detail_id) as order_item_count,
        avg(review_score) as review_score
    from {{ ref('reviews_summary') }}
    {{ dbt_utils.group_by(3) }}
)

select
    customer_unique_id,
    count(distinct order_id) as total_orders,
    sum(order_item_count) as total_items_ordered,
    round(avg(review_score), 1) as avg_review_score
from review_aggregate_customer
group by 1