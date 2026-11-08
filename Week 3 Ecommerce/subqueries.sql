-- 56. Find highest selling product
SELECT p.product_id, p.product_name,
       SUM(oi.quantity) AS total_sold
FROM PRODUCTS p
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) = (
    SELECT MAX(total_quantity)
    FROM (
        SELECT SUM(quantity) AS total_quantity
        FROM ORDER_ITEMS
        GROUP BY product_id
    ) AS sales
);

-- 57. Find second highest selling product
SELECT p.product_id, p.product_name,
       SUM(oi.quantity) AS total_sold
FROM PRODUCTS p
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) = (
    SELECT MAX(total_quantity)
    FROM (
        SELECT SUM(quantity) AS total_quantity
        FROM ORDER_ITEMS
        GROUP BY product_id
    ) AS sales
    WHERE total_quantity < (
        SELECT MAX(total_quantity)
        FROM (
            SELECT SUM(quantity) AS total_quantity
            FROM ORDER_ITEMS
            GROUP BY product_id
        ) AS first_sales
    )
);

-- 58. Find third highest selling product
SELECT p.product_id, p.product_name,
       SUM(oi.quantity) AS total_sold
FROM PRODUCTS p
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) = (
    SELECT MAX(total_quantity)
    FROM (
        SELECT SUM(quantity) AS total_quantity
        FROM ORDER_ITEMS
        GROUP BY product_id
    ) AS sales
    WHERE total_quantity < (
        SELECT MAX(total_quantity)
        FROM (
            SELECT SUM(total_quantity) AS total_quantity
            FROM (
                SELECT SUM(quantity) AS total_quantity
                FROM ORDER_ITEMS
                GROUP BY product_id
            ) AS first_sales
            GROUP BY total_quantity
        ) AS second_sales
        WHERE total_quantity < (
            SELECT MAX(total_quantity)
            FROM (
                SELECT SUM(quantity) AS total_quantity
                FROM ORDER_ITEMS
                GROUP BY product_id
            ) AS all_sales
        )
    )
);

-- 59. Find customer with highest spending
SELECT c.customer_id, c.customer_name,
       SUM(o.total_amount) AS total_spending
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(customer_spending)
    FROM (
        SELECT SUM(total_amount) AS customer_spending
        FROM ORDERS
        WHERE order_status = 'Completed'
        GROUP BY customer_id
    ) AS spending
);

-- 60. Find customers spending above average
SELECT c.customer_id, c.customer_name,
       SUM(o.total_amount) AS total_spending
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(customer_spending)
    FROM (
        SELECT SUM(total_amount) AS customer_spending
        FROM ORDERS
        WHERE order_status = 'Completed'
        GROUP BY customer_id
    ) AS spending
);

-- 61. Find products priced above average
SELECT product_id, product_name, price
FROM PRODUCTS
WHERE price > (
    SELECT AVG(price)
    FROM PRODUCTS
);

-- 62. Find suppliers supplying highest number of products
SELECT s.supplier_id, s.supplier_name,
       COUNT(p.product_id) AS total_products
FROM SUPPLIERS s
JOIN PRODUCTS p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name
HAVING COUNT(p.product_id) = (
    SELECT MAX(product_count)
    FROM (
        SELECT COUNT(*) AS product_count
        FROM PRODUCTS
        GROUP BY supplier_id
    ) AS supplier_totals
);

-- 63. Find category generating maximum revenue
SELECT c.category_id, c.category_name,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM CATEGORIES c
JOIN PRODUCTS p ON c.category_id = p.category_id
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
JOIN ORDERS o ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.category_id, c.category_name
HAVING SUM(oi.quantity * oi.unit_price) = (
    SELECT MAX(category_revenue)
    FROM (
        SELECT SUM(oi2.quantity * oi2.unit_price) AS category_revenue
        FROM PRODUCTS p2
        JOIN ORDER_ITEMS oi2 ON p2.product_id = oi2.product_id
        JOIN ORDERS o2 ON oi2.order_id = o2.order_id
        WHERE o2.order_status = 'Completed'
        GROUP BY p2.category_id
    ) AS category_totals
);

-- 64. Find customers who ordered every product in a category
-- Example: Category ID 1
SELECT c.customer_id, c.customer_name
FROM CUSTOMERS c
WHERE NOT EXISTS (
    SELECT p.product_id
    FROM PRODUCTS p
    WHERE p.category_id = 1
    AND NOT EXISTS (
        SELECT 1
        FROM ORDERS o
        JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
        WHERE o.customer_id = c.customer_id
        AND oi.product_id = p.product_id
    )
);

-- 65. Find products never purchased
SELECT p.product_id, p.product_name
FROM PRODUCTS p
WHERE NOT EXISTS (
    SELECT 1
    FROM ORDER_ITEMS oi
    WHERE oi.product_id = p.product_id
);
