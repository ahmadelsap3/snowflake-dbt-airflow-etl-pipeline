-- Check what order status values exist in the data
SELECT 
    order_status,
    COUNT(*) as count
FROM {{ ref('stg_orders') }}
GROUP BY order_status
ORDER BY count DESC
