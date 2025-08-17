{{
  config(
    materialized='table',
    post_hook="ALTER TABLE {{ this }} ADD CONSTRAINT pk_dim_customers PRIMARY KEY (customer_id) NOT ENFORCED"
  )
}}

select
    c.customer_id,
    c.customer_name,
    c.email,
    c.country,
    count_orders.total_orders,
    count_orders.total_spent,
    count_orders.first_order_date,
    count_orders.last_order_date,
    case 
        when count_orders.total_orders >= 5 then 'VIP'
        when count_orders.total_orders >= 2 then 'Regular' 
        else 'New'
    end as customer_segment,
    current_timestamp() as created_at,
    current_timestamp() as updated_at
from {{ ref('stg_customers') }} c
left join (
    select 
        customer_id,
        count(*) as total_orders,
        sum(total_order_value) as total_spent,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date
    from {{ ref('fct_daily_order_revenue') }}
    group by customer_id
) count_orders on c.customer_id = count_orders.customer_id
