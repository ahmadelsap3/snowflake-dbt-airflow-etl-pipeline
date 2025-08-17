{{
  config(
    materialized='table',
    post_hook=[
      "ALTER TABLE {{ this }} ADD CONSTRAINT pk_stg_orders PRIMARY KEY (order_id) NOT ENFORCED",
      "ALTER TABLE {{ this }} ADD CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES {{ ref('stg_customers') }}(customer_id) NOT ENFORCED"
    ]
  )
}}

select
    id as order_id,
    customer_id,
    order_date::date as order_date,
    status as order_status,
    current_timestamp() as created_at
from {{ source('finance_raw', 'orders') }}
where id is not null
  and customer_id is not null
  and order_date is not null