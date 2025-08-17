{{
  config(
    materialized='table',
    post_hook="ALTER TABLE {{ this }} ADD CONSTRAINT pk_stg_customers PRIMARY KEY (customer_id) NOT ENFORCED"
  )
}}

select
    id as customer_id,
    name as customer_name,
    email,
    country,
    current_timestamp() as created_at
from {{ source('finance_raw', 'customers') }}
where id is not null
  and name is not null
  and email is not null