-- 96. Create index on product_name

CREATE INDEX idx_products_product_name
ON PRODUCTS(product_name);


-- 97. Create index on customer_email

CREATE INDEX idx_customers_email
ON CUSTOMERS(email);


-- 98. Compare query performance before and after index

-- Before creating an index, run this query:
EXPLAIN ANALYZE
SELECT *
FROM PRODUCTS
WHERE product_name = 'Laptop';

-- Create an index:
CREATE INDEX idx_products_name_performance
ON PRODUCTS(product_name);

-- Run the same query again:
EXPLAIN ANALYZE
SELECT *
FROM PRODUCTS
WHERE product_name = 'Laptop';


-- 99. Use EXPLAIN ANALYZE on revenue report

EXPLAIN ANALYZE
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM PRODUCTS p
JOIN ORDER_ITEMS oi
    ON p.product_id = oi.product_id
JOIN ORDERS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;


-- 100. Optimize highest-selling-product query

CREATE INDEX idx_order_items_product_id
ON ORDER_ITEMS(product_id);

CREATE INDEX idx_order_items_order_id
ON ORDER_ITEMS(order_id);

CREATE INDEX idx_orders_status
ON ORDERS(order_status);

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM PRODUCTS p
JOIN ORDER_ITEMS oi
    ON p.product_id = oi.product_id
JOIN ORDERS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;
