{{ 
    config(
        materialized='table',
        post_hook="ALTER TABLE {{ this }} ADD PRIMARY KEY (product_id)"
    ) 
}}

SELECT
    id as product_id,
    name as product_name,
    category,
    price
FROM {{ source('finance_raw', 'products') }}
