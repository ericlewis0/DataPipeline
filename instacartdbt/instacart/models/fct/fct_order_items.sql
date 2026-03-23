WITH order_items AS (
    SELECT * FROM {{ ref('src_order_products_prior') }}
    UNION ALL
    SELECT * FROM {{ ref('src_order_products_train') }}
),
orders AS (
    SELECT * FROM {{ ref("src_orders")}}
)

SELECT 
    oi.order_id,
    o.user_id,
    oi.product_id,
    oi.add_to_cart_order,
    oi.reordered,
    o.order_number,
    o.order_dow,
    o.order_hour_of_day,
    o.days_since_prior_order
FROM order_items oi
JOIN orders o on oi.order_id = o.order_id
