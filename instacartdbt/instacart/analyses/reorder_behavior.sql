SELECT
    p.product_name,
    count(*) AS total_orders,
    sum(f.reordered) AS reorder_count,
    sum(f.reordered)::FLOAT / count(*) AS reorder_rate
FROM {{ ref('fct_order_items') }} f
JOIN {{ ref('dim_products') }} p ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY reorder_rate DESC
LIMIT 20