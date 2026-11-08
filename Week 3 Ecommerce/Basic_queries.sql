
-- 1. Display all customers
SELECT * FROM CUSTOMERS;


-- 2. Display all products costing above Rs.5000
SELECT *
FROM PRODUCTS
WHERE price > 5000;


-- 3. Display products with stock less than 10
SELECT *
FROM PRODUCTS
WHERE stock_quantity < 10;


-- 4. Display all suppliers
SELECT * FROM SUPPLIERS;


-- 5. Display all completed orders
SELECT *
FROM ORDERS
WHERE order_status = 'Completed';


-- 6. Display orders placed this month
SELECT *
FROM ORDERS
WHERE EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM CURRENT_DATE)
AND EXTRACT(YEAR FROM order_date) = EXTRACT(YEAR FROM CURRENT_DATE);


-- 7. Display customers registered in the last 30 days
SELECT *
FROM CUSTOMERS
WHERE registration_date >= CURRENT_DATE - INTERVAL '30 days'
AND registration_date <= CURRENT_DATE;


-- 8. Display products sorted by price descending
SELECT *
FROM PRODUCTS
ORDER BY price DESC;


-- 9. Display top 10 expensive products
SELECT *
FROM PRODUCTS
ORDER BY price DESC
LIMIT 10;


-- 10. Display all active shipments
SELECT *
FROM SHIPMENTS
WHERE shipment_status = 'Active';
