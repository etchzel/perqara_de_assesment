{{ config(materialized='view') }}

select
    products.product_id,
    products.product_photos_qty as product_qty,
    COALESCE(category_translation.product_category_name_english, 'uncategorized') AS category
from {{ source('raw', 'products_dataset') }} products
left join {{ source('raw', 'product_category_name_translation') }} category_translation
    on products.product_category_name = category_translation.product_category_name