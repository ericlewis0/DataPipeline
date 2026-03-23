WITH basket_sizes AS (
    SELECT
        order_id,
        count(product_id) AS basket_size
    FROM {{ ref('fct_order_items') }}
    GROUP BY order_id

)

SELECT
    basket_size,
    count(*) AS order_count
FROM basket_sizes
GROUP BY basket_size
ORDER BY basket_size