-- 11. Find total customers
SELECT COUNT(*) AS total_customers
FROM CUSTOMERS;

-- 12. Find total products
SELECT COUNT(*) AS total_products
FROM PRODUCTS;

-- 13. Find average product price
SELECT AVG(price) AS average_product_price
FROM PRODUCTS;

-- 14. Find highest priced product
SELECT MAX(price) AS highest_product_price
FROM PRODUCTS;

-- 15. Find lowest priced product
SELECT MIN(price) AS lowest_product_price
FROM PRODUCTS;

-- 16. Find total revenue generated
SELECT SUM(total_amount) AS total_revenue
FROM ORDERS
WHERE order_status = 'Completed';

-- 17. Find total orders placed
SELECT COUNT(*) AS total_orders
FROM ORDERS;

-- 18. Find total stock available
SELECT SUM(stock_quantity) AS total_stock
FROM PRODUCTS;

-- 19. Find average order value
SELECT AVG(total_amount) AS average_order_value
FROM ORDERS;

-- 20. Find total payment received
SELECT SUM(amount) AS total_payment_received
FROM PAYMENTS
WHERE payment_status = 'Success';
