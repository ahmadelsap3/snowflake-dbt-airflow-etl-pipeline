{{
  config(
    materialized='table',
    post_hook="ALTER TABLE {{ this }} ADD CONSTRAINT pk_dim_products PRIMARY KEY (product_id) NOT ENFORCED"
  )
}}

select
    p.product_id,
    p.product_name,
    p.category as product_category,
    p.price as product_price,
    coalesce(sales.total_quantity_sold, 0) as total_quantity_sold,
    coalesce(sales.total_revenue, 0) as total_revenue,
    coalesce(sales.total_orders, 0) as total_orders,
    case 
        when sales.total_revenue >= 1000 then 'High Performer'
        when sales.total_revenue >= 500 then 'Medium Performer'
        when sales.total_revenue > 0 then 'Low Performer'
        else 'No Sales'
    end as performance_category,
    current_timestamp() as created_at,
    current_timestamp() as updated_at
from {{ ref('stg_products') }} p
left join (
    select 
        product_id,
        sum(quantity) as total_quantity_sold,
        sum(total_price) as total_revenue,
        count(distinct order_id) as total_orders
    from {{ ref('stg_order_items') }}
    group by product_id
) sales on p.product_id = sales.product_id
