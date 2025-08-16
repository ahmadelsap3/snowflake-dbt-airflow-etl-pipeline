select
id as order_id,
customer_id,
order_date,
status as order_status
from {{ source('finance_raw', 'orders') }}