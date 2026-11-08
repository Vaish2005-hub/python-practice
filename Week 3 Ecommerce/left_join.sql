-- 46. Find customers who never placed orders
SELECT c.customer_id, c.customer_name
FROM CUSTOMERS c
LEFT JOIN ORDERS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 47. Find products never ordered
SELECT p.product_id, p.product_name
FROM PRODUCTS p
LEFT JOIN ORDER_ITEMS oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- 48. Find products with no reviews
SELECT p.product_id, p.product_name
FROM PRODUCTS p
LEFT JOIN REVIEWS r
ON p.product_id = r.product_id
WHERE r.review_id IS NULL;

-- 49. Find customers without addresses
SELECT c.customer_id, c.customer_name
FROM CUSTOMERS c
LEFT JOIN ADDRESSES a
ON c.customer_id = a.customer_id
WHERE a.address_id IS NULL;

-- 50. Find orders without payments
SELECT o.order_id, o.order_date, o.order_status,
       o.total_amount
FROM ORDERS o
LEFT JOIN PAYMENTS p
ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;
