{{ config(materialized = 'table') }}

WITH item AS (
    SELECT * FROM {{ ref('fct_order_items')}}
)

SELECT
    order_id,
    count(product_id) as basket_size
FROM item
GROUP BY order_id