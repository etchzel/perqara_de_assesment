{{ config(materialized='view') }}

select
	review_id,
	order_id,
	review_score,
	review_comment_title,
	review_comment_message,
	review_creation_date::date,
	review_answer_timestamp::timestamp
from {{ source('raw', 'order_reviews_dataset') }}