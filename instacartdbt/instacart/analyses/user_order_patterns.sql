SELECT
    order_dow,
    order_hour_of_day,
    count(*) AS orders
FROM {{ ref('fct_orders') }}
GROUP BY
    order_dow,
    order_hour_of_day
ORDER BY
    order_dow,
    order_hour_of_day