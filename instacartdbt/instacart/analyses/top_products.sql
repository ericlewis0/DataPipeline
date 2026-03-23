SELECT
    p.product_name,
    count(*) AS total_purchases
FROM {{ ref('fct_order_items') }} f
JOIN {{ ref('dim_products') }} p ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_purchases DESC
LIMIT 20