{{
  config(
    materialized='table',
    post_hook=[
      "ALTER TABLE {{ this }} ADD CONSTRAINT pk_stg_order_items PRIMARY KEY (item_id) NOT ENFORCED",
      "ALTER TABLE {{ this }} ADD CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES {{ ref('stg_orders') }}(order_id) NOT ENFORCED",
      "ALTER TABLE {{ this }} ADD CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES {{ ref('stg_products') }}(product_id) NOT ENFORCED"
    ]
  )
}}

select
    id as item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price as total_price,
    current_timestamp() as created_at
from {{ source('finance_raw', 'order_items') }}
where id is not null
  and order_id is not null
  and product_id is not null
  and quantity > 0
  and unit_price >= 0