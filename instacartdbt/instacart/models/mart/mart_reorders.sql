{{ config(materialized = 'table') }}

WITH items AS (
    SELECT * FROM {{ ref('fct_order_items') }}
),
products AS (
    SELECT * FROM {{ ref('dim_products') }}
)

SELECT
    p.product_name,
    COUNT(*) AS total_orders,
    SUM(i.reordered) AS reordered_count,
    ROUND(SUM(i.reordered)::FLOAT / COUNT(*),6) AS reorder_rate
FROM items i
JOIN products p ON i.product_id = p.product_id
GROUP BY p.product_name