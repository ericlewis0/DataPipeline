{% snapshot snap_products %}

{{
    config(
        target_schema='snapshots',
        unique_key='product_id',
        strategy='check',
        check_cols=['product_name', 'aisle_id', 'department_id']
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['product_id', 'product_name', 'aisle_id', 'department_id'])}} as product_key,
    product_id,
    product_name,
    aisle_id,
    department_id
FROM {{ ref('src_products') }}

{% endsnapshot %}