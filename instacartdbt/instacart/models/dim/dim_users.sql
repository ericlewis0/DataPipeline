WITH src_users AS (
    SELECT * FROM {{ ref('src_orders') }}
)

SELECT DISTINCT
    user_id
FROM src_users