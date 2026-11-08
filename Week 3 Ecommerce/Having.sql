-- 31. Display categories having more than 20 products
SELECT c.category_name, COUNT(p.product_id) AS total_products
FROM CATEGORIES c
JOIN PRODUCTS p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
HAVING COUNT(p.product_id) > 20;

-- 32. Display suppliers supplying more than 10 products
SELECT s.supplier_name, COUNT(p.product_id) AS total_products
FROM SUPPLIERS s
JOIN PRODUCTS p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name
HAVING COUNT(p.product_id) > 10;

-- 33. Display customers having more than 5 orders
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 5;

-- 34. Display products having average rating above 4
SELECT p.product_name, AVG(r.rating) AS average_rating
FROM PRODUCTS p
JOIN REVIEWS r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) > 4;

-- 35. Display cities with more than 50 customers
SELECT city, COUNT(DISTINCT customer_id) AS total_customers
FROM ADDRESSES
GROUP BY city
HAVING COUNT(DISTINCT customer_id) > 50;
