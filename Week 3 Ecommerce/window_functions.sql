-- 71. Rank products by revenue
SELECT p.product_id, p.product_name,
       SUM(oi.quantity * oi.unit_price) AS revenue,
       RANK() OVER (
           ORDER BY SUM(oi.quantity * oi.unit_price) DESC
       ) AS product_rank
FROM PRODUCTS p
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
JOIN ORDERS o ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name;


-- 72. Rank customers by spending
SELECT c.customer_id, c.customer_name,
       SUM(o.total_amount) AS total_spending,
       RANK() OVER (
           ORDER BY SUM(o.total_amount) DESC
       ) AS customer_rank
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name;


-- 73. Rank suppliers by sales
SELECT s.supplier_id, s.supplier_name,
       SUM(oi.quantity * oi.unit_price) AS total_sales,
       RANK() OVER (
           ORDER BY SUM(oi.quantity * oi.unit_price) DESC
       ) AS supplier_rank
FROM SUPPLIERS s
JOIN PRODUCTS p ON s.supplier_id = p.supplier_id
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
JOIN ORDERS o ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY s.supplier_id, s.supplier_name;


-- 74. Find top 3 products per category
SELECT *
FROM (
    SELECT p.product_id, p.product_name,
           c.category_name,
           SUM(oi.quantity) AS total_sold,
           RANK() OVER (
               PARTITION BY p.category_id
               ORDER BY SUM(oi.quantity) DESC
           ) AS product_rank
    FROM PRODUCTS p
    JOIN CATEGORIES c ON p.category_id = c.category_id
    JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
    JOIN ORDERS o ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY p.product_id, p.product_name,
             p.category_id, c.category_name
) AS ranked_products
WHERE product_rank <= 3;


-- 75. Find top 5 customers per city
SELECT *
FROM (
    SELECT c.customer_id, c.customer_name,
           a.city,
           SUM(o.total_amount) AS total_spending,
           RANK() OVER (
               PARTITION BY a.city
               ORDER BY SUM(o.total_amount) DESC
           ) AS customer_rank
    FROM CUSTOMERS c
    JOIN ADDRESSES a ON c.customer_id = a.customer_id
    JOIN ORDERS o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name, a.city
) AS ranked_customers
WHERE customer_rank <= 5;


-- 76. Find running total revenue
SELECT o.order_id, o.order_date,
       o.total_amount,
       SUM(o.total_amount) OVER (
           ORDER BY o.order_date, o.order_id
       ) AS running_total_revenue
FROM ORDERS o
WHERE o.order_status = 'Completed';


-- 77. Find cumulative monthly sales
SELECT sales_year, sales_month, monthly_sales,
       SUM(monthly_sales) OVER (
           PARTITION BY sales_year
           ORDER BY sales_month
       ) AS cumulative_sales
FROM (
    SELECT
        EXTRACT(YEAR FROM o.order_date) AS sales_year,
        EXTRACT(MONTH FROM o.order_date) AS sales_month,
        SUM(o.total_amount) AS monthly_sales
    FROM ORDERS o
    WHERE o.order_status = 'Completed'
    GROUP BY
        EXTRACT(YEAR FROM o.order_date),
        EXTRACT(MONTH FROM o.order_date)
) AS monthly_report;


-- 78. Find highest order per customer
SELECT *
FROM (
    SELECT o.order_id, o.customer_id,
           o.total_amount,
           RANK() OVER (
               PARTITION BY o.customer_id
               ORDER BY o.total_amount DESC
           ) AS order_rank
    FROM ORDERS o
) AS ranked_orders
WHERE order_rank = 1;


-- 79. Find latest order per customer
SELECT *
FROM (
    SELECT o.order_id, o.customer_id,
           o.order_date, o.total_amount,
           ROW_NUMBER() OVER (
               PARTITION BY o.customer_id
               ORDER BY o.order_date DESC, o.order_id DESC
           ) AS row_num
    FROM ORDERS o
) AS latest_orders
WHERE row_num = 1;


-- 80. Find top-rated product in each category
SELECT *
FROM (
    SELECT p.product_id, p.product_name,
           c.category_name,
           AVG(r.rating) AS average_rating,
           RANK() OVER (
               PARTITION BY p.category_id
               ORDER BY AVG(r.rating) DESC
           ) AS product_rank
    FROM PRODUCTS p
    JOIN CATEGORIES c ON p.category_id = c.category_id
    JOIN REVIEWS r ON p.product_id = r.product_id
    GROUP BY p.product_id, p.product_name,
             p.category_id, c.category_name
) AS ranked_products
WHERE product_rank = 1;
