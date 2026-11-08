-- 36. Display customer names with order details
SELECT c.customer_name, o.order_id, o.order_date,
       o.order_status, o.total_amount
FROM CUSTOMERS c
INNER JOIN ORDERS o
ON c.customer_id = o.customer_id;

-- 37. Display order details with products
SELECT o.order_id, p.product_name,
       oi.quantity, oi.unit_price,
       (oi.quantity * oi.unit_price) AS item_total
FROM ORDERS o
INNER JOIN ORDER_ITEMS oi
ON o.order_id = oi.order_id
INNER JOIN PRODUCTS p
ON oi.product_id = p.product_id;

-- 38. Display product names with category names
SELECT p.product_name, c.category_name
FROM PRODUCTS p
INNER JOIN CATEGORIES c
ON p.category_id = c.category_id;

-- 39. Display product names with supplier names
SELECT p.product_name, s.supplier_name
FROM PRODUCTS p
INNER JOIN SUPPLIERS s
ON p.supplier_id = s.supplier_id;

-- 40. Display reviews with customer names
SELECT r.review_id, c.customer_name,
       r.rating, r.review_text
FROM REVIEWS r
INNER JOIN CUSTOMERS c
ON r.customer_id = c.customer_id;

-- 41. Display payment details with customer names
SELECT pay.payment_id, c.customer_name,
       pay.payment_date, pay.payment_method,
       pay.payment_status, pay.amount
FROM PAYMENTS pay
INNER JOIN ORDERS o
ON pay.order_id = o.order_id
INNER JOIN CUSTOMERS c
ON o.customer_id = c.customer_id;

-- 42. Display shipment details with order details
SELECT s.shipment_id, o.order_id,
       o.order_date, o.order_status,
       s.shipment_date, s.delivery_date,
       s.shipment_status
FROM SHIPMENTS s
INNER JOIN ORDERS o
ON s.order_id = o.order_id;

-- 43. Display cart items with product names
SELECT ci.cart_item_id, ci.cart_id,
       p.product_name, ci.quantity, p.price
FROM CART_ITEMS ci
INNER JOIN PRODUCTS p
ON ci.product_id = p.product_id;

-- 44. Display wishlist items with product names
SELECT w.wishlist_id, w.customer_id, p.product_name
FROM WISHLIST w
INNER JOIN PRODUCTS p
ON w.product_id = p.product_id;

-- 45. Display customer addresses with customer names
SELECT c.customer_name, a.address_type,
       a.city, a.state, a.pincode
FROM CUSTOMERS c
INNER JOIN ADDRESSES a
ON c.customer_id = a.customer_id;
