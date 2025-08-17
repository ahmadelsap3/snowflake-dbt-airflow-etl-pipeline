select
id as customer_id,
name as customer_name,
email,
country
from {{ source('finance_raw', 'customers') }}