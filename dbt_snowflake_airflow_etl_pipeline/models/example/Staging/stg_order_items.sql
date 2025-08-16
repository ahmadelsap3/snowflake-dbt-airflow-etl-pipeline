select
id as item_id,
order_id,
product_id,
quantity,
unit_price,
quantity * unit_price as total_price
from {{ source('finance_raw', 'order_items') }}