
WITH session_events AS (
  SELECT
    user_pseudo_id,
    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE key = 'ga_session_id'
      LIMIT 1
    ) AS ga_session_id,
    event_name
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
),
session_summary AS (
  SELECT
    user_pseudo_id,
    ga_session_id,
    MAX(IF(event_name = 'view_item', 1, 0)) AS viewed_product,
    MAX(IF(event_name = 'add_to_cart', 1, 0)) AS added_to_cart,
    MAX(IF(event_name = 'begin_checkout', 1, 0)) AS began_checkout,
    MAX(IF(event_name = 'purchase', 1, 0)) AS purchased
  FROM session_events
  WHERE ga_session_id IS NOT NULL
  GROUP BY user_pseudo_id, ga_session_id
)
SELECT
  '1. Product view' AS funnel_stage,
  COUNTIF(viewed_product = 1) AS sessions
FROM session_summary

UNION ALL

SELECT
  '2. Add to cart',
  COUNTIF(added_to_cart = 1)
FROM session_summary

UNION ALL

SELECT
  '3. Begin checkout',
  COUNTIF(began_checkout = 1)
FROM session_summary

UNION ALL

SELECT
  '4. Purchase',
  COUNTIF(purchased = 1)
FROM session_summary;
