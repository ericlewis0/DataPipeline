{{ config(materialized =  'table')}}

WITH items AS (
    SELECT * FROM {{ ref('fct_order_items')}}
),
products AS (
    SELECT * FROM {{ ref('dim_products') }}
),
aisles AS (
    SELECT * FROM {{ ref('dim_aisles') }}
),
departments AS (
    SELECT * FROM {{ ref('dim_departments') }}
)

SELECT
    a.aisle,
    d.department,
    COUNT(DISTINCT i.order_id) AS total_items
FROM items i
JOIN products p ON i.product_id = p.product_id
JOIN aisles a ON a.aisle_id = p.aisle_id
JOIN departments d ON d.department_id = p.department_id
GROUP BY 
    a.aisle,
    d.department
ORDER BY total_items DESC  