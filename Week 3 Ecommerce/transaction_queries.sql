-- 91. Place an order with payment and shipment inside one transaction

BEGIN;

INSERT INTO ORDERS
(customer_id, order_date, order_status, total_amount)
VALUES
(1, CURRENT_DATE, 'Completed', 5000);

INSERT INTO PAYMENTS
(order_id, payment_date, payment_method, payment_status, amount)
VALUES
((SELECT MAX(order_id) FROM ORDERS),
 CURRENT_DATE, 'UPI', 'Success', 5000);

INSERT INTO SHIPMENTS
(order_id, shipment_date, delivery_date, shipment_status)
VALUES
((SELECT MAX(order_id) FROM ORDERS),
 CURRENT_DATE, NULL, 'Pending');

COMMIT;


-- 92. Rollback failed payment transaction

BEGIN;

INSERT INTO ORDERS
(customer_id, order_date, order_status, total_amount)
VALUES
(2, CURRENT_DATE, 'Pending', 3000);

INSERT INTO PAYMENTS
(order_id, payment_date, payment_method, payment_status, amount)
VALUES
((SELECT MAX(order_id) FROM ORDERS),
 CURRENT_DATE, 'UPI', 'Failed', 3000);

ROLLBACK;


-- 93. Use SAVEPOINT during checkout process

BEGIN;

INSERT INTO ORDERS
(customer_id, order_date, order_status, total_amount)
VALUES
(3, CURRENT_DATE, 'Pending', 2500);

SAVEPOINT order_created;

INSERT INTO PAYMENTS
(order_id, payment_date, payment_method, payment_status, amount)
VALUES
((SELECT MAX(order_id) FROM ORDERS),
 CURRENT_DATE, 'Card', 'Success', 2500);

SAVEPOINT payment_completed;

INSERT INTO SHIPMENTS
(order_id, shipment_date, delivery_date, shipment_status)
VALUES
((SELECT MAX(order_id) FROM ORDERS),
 CURRENT_DATE, NULL, 'Pending');

COMMIT;


-- 94. Demonstrate COMMIT after successful order

BEGIN;

INSERT INTO ORDERS
(customer_id, order_date, order_status, total_amount)
VALUES
(4, CURRENT_DATE, 'Completed', 1500);

INSERT INTO PAYMENTS
(order_id, payment_date, payment_method, payment_status, amount)
VALUES
((SELECT MAX(order_id) FROM ORDERS),
 CURRENT_DATE, 'Cash', 'Success', 1500);

COMMIT;


-- 95. Handle stock deduction transaction

BEGIN;

UPDATE PRODUCTS
SET stock_quantity = stock_quantity - 2
WHERE product_id = 1
AND stock_quantity >= 2;

COMMIT;
