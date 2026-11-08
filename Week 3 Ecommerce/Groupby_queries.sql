-- 21. Find number of products category-wise
SELECT c.category_name, COUNT(p.product_id) AS total_products
FROM CATEGORIES c
LEFT JOIN PRODUCTS p ON c.category_id = p.category_id
GROUP BY c.category_name;

-- 22. Find total sales category-wise
SELECT c.category_name,
       SUM(oi.quantity * oi.unit_price) AS total_sales
FROM CATEGORIES c
JOIN PRODUCTS p ON c.category_id = p.category_id
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
JOIN ORDERS o ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.category_name;

-- 23. Find total revenue supplier-wise
SELECT s.supplier_name,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM SUPPLIERS s
JOIN PRODUCTS p ON s.supplier_id = p.supplier_id
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
JOIN ORDERS o ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY s.supplier_name;

-- 24. Find customer count city-wise
SELECT city, COUNT(DISTINCT customer_id) AS total_customers
FROM ADDRESSES
GROUP BY city;

-- 25. Find order count status-wise
SELECT order_status, COUNT(*) AS total_orders
FROM ORDERS
GROUP BY order_status;

-- 26. Find average rating product-wise
SELECT p.product_name, AVG(r.rating) AS average_rating
FROM PRODUCTS p
LEFT JOIN REVIEWS r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;

-- 27. Find total products supplier-wise
SELECT s.supplier_name, COUNT(p.product_id) AS total_products
FROM SUPPLIERS s
LEFT JOIN PRODUCTS p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name;

-- 28. Find shipment count status-wise
SELECT shipment_status, COUNT(*) AS total_shipments
FROM SHIPMENTS
GROUP BY shipment_status;

-- 29. Find total payments method-wise
SELECT payment_method, SUM(amount) AS total_payments
FROM PAYMENTS
WHERE payment_status = 'Success'
GROUP BY payment_method;

-- 30. Find monthly sales report
SELECT
    EXTRACT(YEAR FROM o.order_date) AS sales_year,
    EXTRACT(MONTH FROM o.order_date) AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_sales
FROM ORDERS o
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    EXTRACT(YEAR FROM o.order_date),
    EXTRACT(MONTH FROM o.order_date)
ORDER BY sales_year, sales_month;
