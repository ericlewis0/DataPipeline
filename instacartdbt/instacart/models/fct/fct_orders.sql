WITH fct_orders AS (
    SELECT * FROM {{ ref('src_orders') }}
)

SELECT 
    order_id, 
    user_id, 
    eval_set,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order
FROM fct_orders