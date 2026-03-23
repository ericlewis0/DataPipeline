SELECT
    d.department_name,
    count(*) AS purchases
FROM {{ ref('fct_order_items') }} f
JOIN {{ ref('dim_products') }} p ON f.product_id = p.product_id
JOIN {{ ref('dim_departments') }} d ON p.department_id = d.department_id
GROUP BY d.department_name
ORDER BY purchases DESC