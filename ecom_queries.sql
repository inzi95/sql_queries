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

-- Counting the number of orders per UserID
SELECT
  o.user_id,
  COUNT(o.user_id) as number_of_orders
FROM
  `bigquery-public-data.thelook_ecommerce.orders` AS o
GROUP BY
  o.user_id
ORDER BY
  2 desc
 
--  Inner Joining the top Selling Products
WITH
  top_products AS (
  SELECT
    oi.product_id,
    COUNT(product_id) AS number_of_orders,
  FROM
    `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  GROUP BY
    product_id
  ORDER BY
    2 DESC)
SELECT
  p.*
FROM
  `bigquery-public-data.thelook_ecommerce.products` AS p
INNER JOIN
  top_products
ON
  top_products.product_id = p.id
WHERE
  top_products.number_of_orders > 10
