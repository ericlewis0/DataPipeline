WITH src_aisles AS (
    SELECT * FROM {{ ref('src_aisles') }}
)

SELECT 
    aisle_id,
    aisle 
FROM src_aisles

