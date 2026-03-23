WITH src_products AS (
    SELECT * FROM {{ ref('src_products') }}
)

SELECT 
    product_id, 
    LOWER(product_name) as product_name, 
    aisle_id, 
    department_id
FROM src_products