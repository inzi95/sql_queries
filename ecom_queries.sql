-- Finding the daily total revenue
SELECT
  DATE(o.created_at) AS order_date,
  ROUND(SUM(oi.sale_price),2) AS revenue,
  COUNT(DISTINCT o.order_id) AS order_count,
  COUNT(DISTINCT o.user_id) AS customers_ordered
FROM
  `bigquery-public-data.thelook_ecommerce.orders` AS o
LEFT JOIN
  `bigquery-public-data.thelook_ecommerce.order_items` AS oi
ON
  o.order_id = oi.order_id
WHERE
  o.status NOT IN ('Returned',
    'Cancelled')
GROUP BY
  order_date
ORDER BY
  order_date desc
