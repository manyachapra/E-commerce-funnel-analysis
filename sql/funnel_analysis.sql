
WITH event_times AS (
  SELECT
    user_pseudo_id,
    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE key = 'ga_session_id'
      LIMIT 1
    ) AS ga_session_id,

    MIN(IF(event_name = 'view_item',
           event_timestamp, NULL)) AS view_time,

    MIN(IF(event_name = 'add_to_cart',
           event_timestamp, NULL)) AS cart_time,

    MIN(IF(event_name = 'begin_checkout',
           event_timestamp, NULL)) AS checkout_time,

    MIN(IF(event_name = 'purchase',
           event_timestamp, NULL)) AS purchase_time

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
    user_pseudo_id, ga_session_id
),
funnel AS (
  SELECT
    *,
    view_time IS NOT NULL AS viewed,
    view_time IS NOT NULL
      AND cart_time >= view_time AS added_after_view,
    view_time IS NOT NULL
      AND cart_time >= view_time
      AND checkout_time >= cart_time AS checkout_after_cart,
    view_time IS NOT NULL
      AND cart_time >= view_time
      AND checkout_time >= cart_time
      AND purchase_time >= checkout_time AS purchased_after_checkout
  FROM event_times
)
SELECT
  1 AS stage_order,
  'Product view' AS funnel_stage,
  COUNTIF(viewed) AS sessions
FROM funnel

UNION ALL

SELECT
  2,
  'Add to cart after view',
  COUNTIF(added_after_view)
FROM funnel

UNION ALL

SELECT
  3,
  'Checkout after cart',
  COUNTIF(checkout_after_cart)
FROM funnel

UNION ALL

SELECT
  4,
  'Purchase after checkout',
  COUNTIF(purchased_after_checkout)
FROM funnel

ORDER BY stage_order;
