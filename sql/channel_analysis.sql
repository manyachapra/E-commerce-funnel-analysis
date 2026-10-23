
SELECT
  COALESCE(
    traffic_source.source,
    '(not set)'
  ) AS source,
  COALESCE(
    traffic_source.medium,
    '(not set)'
  ) AS medium,
  COUNT(DISTINCT user_pseudo_id) AS users,
  COUNTIF(event_name = 'view_item') AS product_view_events,
  COUNTIF(event_name = 'add_to_cart') AS add_to_cart_events,
  COUNTIF(event_name = 'begin_checkout') AS checkout_events,
  COUNTIF(event_name = 'purchase') AS purchase_events
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  AND event_name IN (
    'view_item',
    'add_to_cart',
    'begin_checkout',
    'purchase'
  )
GROUP BY
  source,
  medium
ORDER BY
  purchase_events DESC
LIMIT 20;
