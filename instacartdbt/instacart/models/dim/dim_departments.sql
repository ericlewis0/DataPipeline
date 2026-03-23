WITH src_departments AS (
    SELECT * FROM {{ ref('src_departments') }}
)
SELECT 
    department_id,
    department
FROM src_departments
