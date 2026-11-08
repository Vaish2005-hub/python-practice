-- 81. Find category-wise revenue using CTE
WITH category_revenue AS (
    SELECT c.category_id, c.category_name,
           SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM CATEGORIES c
    JOIN PRODUCTS p ON c.category_id = p.category_id
    JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
    JOIN ORDERS o ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.category_id, c.category_name
)
SELECT * FROM category_revenue
ORDER BY total_revenue DESC;


-- 82. Find customer spending summary using CTE
WITH customer_spending AS (
    SELECT c.customer_id, c.customer_name,
           COUNT(o.order_id) AS total_orders,
           SUM(o.total_amount) AS total_spending,
           AVG(o.total_amount) AS average_order_value
    FROM CUSTOMERS c
    JOIN ORDERS o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
)
SELECT * FROM customer_spending
ORDER BY total_spending DESC;


-- 83. Find top 10 customers using CTE
WITH customer_spending AS (
    SELECT c.customer_id, c.customer_name,
           SUM(o.total_amount) AS total_spending
    FROM CUSTOMERS c
    JOIN ORDERS o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
)
SELECT * FROM customer_spending
ORDER BY total_spending DESC
LIMIT 10;


-- 84. Find top products using CTE
WITH product_sales AS (
    SELECT p.product_id, p.product_name,
           SUM(oi.quantity) AS total_quantity_sold,
           SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM PRODUCTS p
    JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
    JOIN ORDERS o ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY p.product_id, p.product_name
)
SELECT * FROM product_sales
ORDER BY total_quantity_sold DESC
LIMIT 10;


-- 85. Find supplier performance report using CTE
WITH supplier_performance AS (
    SELECT s.supplier_id, s.supplier_name,
           COUNT(DISTINCT p.product_id) AS total_products,
           COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold,
           COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_revenue
    FROM SUPPLIERS s
    LEFT JOIN PRODUCTS p ON s.supplier_id = p.supplier_id
    LEFT JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
    LEFT JOIN ORDERS o ON oi.order_id = o.order_id
        AND o.order_status = 'Completed'
    GROUP BY s.supplier_id, s.supplier_name
)
SELECT * FROM supplier_performance
ORDER BY total_revenue DESC;
