{{ config(materialized='table') }}

select
	product_id,
	category,
	count(order_detail_id) as total_ordered,
	round(avg(coalesce(review_score, 0)), 1) as avg_review_score
from {{ ref('reviews_summary') }}
group by 1,2