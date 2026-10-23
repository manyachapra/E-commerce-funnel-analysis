
SELECT
  event_name,
  COUNT(*) AS total_event_occurrences,
  COUNT(DISTINCT user_pseudo_id) AS distinct_users,
  MIN(_TABLE_SUFFIX) AS start_date,
  MAX(_TABLE_SUFFIX) AS end_date
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  event_name IN (
    'session_start',
    'view_item',
    'add_to_cart',
    'view_cart',
    'begin_checkout',
    'add_shipping_info',
    'add_payment_info',
    'purchase'
  )
GROUP BY event_name
ORDER BY total_event_occurrences DESC;
