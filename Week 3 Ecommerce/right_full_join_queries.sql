-- 51. Find all products and corresponding reviews (FULL JOIN)
SELECT p.product_id, p.product_name,
       r.review_id, r.rating, r.review_text
FROM PRODUCTS p
FULL JOIN REVIEWS r
ON p.product_id = r.product_id;

-- 52. Find all customers and their orders (RIGHT JOIN)
SELECT c.customer_id, c.customer_name,
       o.order_id, o.order_date, o.order_status
FROM ORDERS o
RIGHT JOIN CUSTOMERS c
ON o.customer_id = c.customer_id;

-- 53. Find all suppliers and products (RIGHT JOIN)
SELECT s.supplier_id, s.supplier_name,
       p.product_id, p.product_name
FROM PRODUCTS p
RIGHT JOIN SUPPLIERS s
ON p.supplier_id = s.supplier_id;

-- 54. Find all categories and products (FULL JOIN)
SELECT c.category_id, c.category_name,
       p.product_id, p.product_name
FROM CATEGORIES c
FULL JOIN PRODUCTS p
ON c.category_id = p.category_id;

-- 55. Find all orders and shipments (FULL JOIN)
SELECT o.order_id, o.order_date, o.order_status,
       s.shipment_id, s.shipment_date, s.shipment_status
FROM ORDERS o
FULL JOIN SHIPMENTS s
ON o.order_id = s.order_id;
