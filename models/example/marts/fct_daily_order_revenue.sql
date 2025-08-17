{{
  config(
    materialized='table',
    post_hook=[
      "ALTER TABLE {{ this }} ADD CONSTRAINT pk_fct_daily_revenue PRIMARY KEY (order_date, order_id) NOT ENFORCED",
      "ALTER TABLE {{ this }} ADD CONSTRAINT fk_fct_revenue_order FOREIGN KEY (order_id) REFERENCES {{ ref('stg_orders') }}(order_id) NOT ENFORCED",
      "ALTER TABLE {{ this }} ADD CONSTRAINT fk_fct_revenue_customer FOREIGN KEY (customer_id) REFERENCES {{ ref('stg_customers') }}(customer_id) NOT ENFORCED"
    ]
  )
}}

with order_revenue as (
    select
        o.order_date,
        o.order_id,
        o.customer_id,
        c.customer_name,
        o.order_status,
        coalesce(sum(i.total_price), 0) as total_order_value,
        coalesce(sum(i.quantity), 0) as total_items,
        count(distinct i.product_id) as unique_products,
        current_timestamp() as created_at
    from {{ ref('stg_orders') }} o
    left join {{ ref('stg_order_items') }} i
        on o.order_id = i.order_id
    left join {{ ref('stg_customers') }} c
        on o.customer_id = c.customer_id
    group by 
        o.order_date,
        o.order_id,
        o.customer_id,
        c.customer_name,
        o.order_status
)

select * from order_revenue