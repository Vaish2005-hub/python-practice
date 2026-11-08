-- 66. Find products costing above category average
SELECT p.product_id, p.product_name,
       p.price, c.category_name
FROM PRODUCTS p
JOIN CATEGORIES c
ON p.category_id = c.category_id
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM PRODUCTS p2
    WHERE p2.category_id = p.category_id
);

-- 67. Find customers spending above city average
SELECT c.customer_id, c.customer_name,
       a.city,
       SUM(o.total_amount) AS total_spending
FROM CUSTOMERS c
JOIN ADDRESSES a
ON c.customer_id = a.customer_id
JOIN ORDERS o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name, a.city
HAVING SUM(o.total_amount) > (
    SELECT AVG(customer_spending)
    FROM (
        SELECT SUM(o2.total_amount) AS customer_spending
        FROM CUSTOMERS c2
        JOIN ADDRESSES a2
        ON c2.customer_id = a2.customer_id
        JOIN ORDERS o2
        ON c2.customer_id = o2.customer_id
        WHERE a2.city = a.city
        AND o2.order_status = 'Completed'
        GROUP BY c2.customer_id
    ) AS city_average
);

-- 68. Find suppliers with revenue above supplier average
SELECT s.supplier_id, s.supplier_name,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM SUPPLIERS s
JOIN PRODUCTS p
ON s.supplier_id = p.supplier_id
JOIN ORDER_ITEMS oi
ON p.product_id = oi.product_id
JOIN ORDERS o
ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY s.supplier_id, s.supplier_name
HAVING SUM(oi.quantity * oi.unit_price) > (
    SELECT AVG(supplier_revenue)
    FROM (
        SELECT SUM(oi2.quantity * oi2.unit_price) AS supplier_revenue
        FROM SUPPLIERS s2
        JOIN PRODUCTS p2
        ON s2.supplier_id = p2.supplier_id
        JOIN ORDER_ITEMS oi2
        ON p2.product_id = oi2.product_id
        JOIN ORDERS o2
        ON oi2.order_id = o2.order_id
        WHERE o2.order_status = 'Completed'
        GROUP BY s2.supplier_id
    ) AS supplier_average
);

-- 69. Find orders larger than customer average
SELECT o.order_id, o.customer_id,
       o.total_amount
FROM ORDERS o
WHERE o.total_amount > (
    SELECT AVG(o2.total_amount)
    FROM ORDERS o2
    WHERE o2.customer_id = o.customer_id
);

-- 70. Find products with reviews above product average
SELECT p.product_id, p.product_name,
       r.rating
FROM PRODUCTS p
JOIN REVIEWS r
ON p.product_id = r.product_id
WHERE r.rating > (
    SELECT AVG(r2.rating)
    FROM REVIEWS r2
    WHERE r2.product_id = p.product_id
);
