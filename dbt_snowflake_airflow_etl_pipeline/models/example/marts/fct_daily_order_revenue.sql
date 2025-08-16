select
order_date,
O.order_id,
sum(total_price) as total_price
from
stg_orders O
left join stg_order_items I
ON O.order_id = I.order_id
group by
O.order_date,
O.order_id