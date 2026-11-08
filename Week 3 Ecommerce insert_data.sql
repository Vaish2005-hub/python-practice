
-- 1. CUSTOMERS
INSERT INTO CUSTOMERS VALUES
(1, 'Vaishnavi', 'vaish@gmail.com', '9876543210', '2026-10-15'),
(2, 'Priya', 'priya@gmail.com', '9876543211', '2026-10-20'),
(3, 'Rahul', 'rahul@gmail.com', '9876543212', '2026-11-01'),
(4, 'Sneha', 'sneha@gmail.com', '9876543213', '2026-11-05'),
(5, 'Arjun', 'arjun@gmail.com', '9876543214', '2026-09-15');


-- 2. ADDRESSES
INSERT INTO ADDRESSES VALUES
(1, 1, 'Home', 'Hyderabad', 'Telangana', '500072'),
(2, 2, 'Office', 'Hyderabad', 'Telangana', '500081'),
(3, 3, 'Home', 'Warangal', 'Telangana', '506001'),
(4, 4, 'Home', 'Vijayawada', 'Andhra Pradesh', '520001'),
(5, 5, 'Office', 'Guntur', 'Andhra Pradesh', '522001');


-- 3. CATEGORIES
INSERT INTO CATEGORIES VALUES
(1, 'Electronics', NULL),
(2, 'Mobiles', 1),
(3, 'Laptops', 1),
(4, 'Fashion', NULL),
(5, 'Clothing', 4);


-- 4. SUPPLIERS
INSERT INTO SUPPLIERS VALUES
(1, 'Tech Solutions', 'tech@gmail.com', '9000011111'),
(2, 'Mobile World', 'mobile@gmail.com', '9000022222'),
(3, 'Fashion Hub', 'fashion@gmail.com', '9000033333'),
(4, 'Laptop Store', 'laptop@gmail.com', '9000044444'),
(5, 'Smart Gadgets', 'smart@gmail.com', '9000055555');


-- 5. PRODUCTS
INSERT INTO PRODUCTS VALUES
(1, 'HP Laptop', 'HP Core i5 Laptop', 55000, 15, 3, 4),
(2, 'Dell Laptop', 'Dell Core i7 Laptop', 75000, 8, 3, 1),
(3, 'Samsung Mobile', 'Samsung Smartphone', 25000, 20, 2, 2),
(4, 'iPhone', 'Apple Smartphone', 80000, 5, 2, 2),
(5, 'Smart Watch', 'Digital Smart Watch', 4000, 30, 1, 5),
(6, 'T Shirt', 'Cotton T Shirt', 800, 50, 5, 3),
(7, 'Headphones', 'Wireless Headphones', 6000, 7, 1, 5),
(8, 'Keyboard', 'Mechanical Keyboard', 3000, 12, 1, 1),
(9, 'Jeans', 'Denim Jeans', 1800, 25, 5, 3),
(10, 'Tablet', 'Android Tablet', 15000, 9, 1, 2);


-- 6. ORDERS
INSERT INTO ORDERS VALUES
(1, 1, CURRENT_DATE, 'Completed', 55000),
(2, 2, CURRENT_DATE, 'Pending', 25000),
(3, 3, CURRENT_DATE - 5, 'Completed', 80000),
(4, 4, CURRENT_DATE - 10, 'Cancelled', 4000),
(5, 5, CURRENT_DATE - 2, 'Completed', 6000);


-- 7. ORDER_ITEMS
INSERT INTO ORDER_ITEMS VALUES
(1, 1, 1, 1, 55000),
(2, 2, 3, 1, 25000),
(3, 3, 4, 1, 80000),
(4, 4, 5, 1, 4000),
(5, 5, 7, 1, 6000);


-- 8. PAYMENTS
INSERT INTO PAYMENTS VALUES
(1, 1, CURRENT_DATE, 'UPI', 'Success', 55000),
(2, 2, CURRENT_DATE, 'Card', 'Pending', 25000),
(3, 3, CURRENT_DATE, 'UPI', 'Success', 80000),
(4, 4, CURRENT_DATE, 'Cash', 'Failed', 4000),
(5, 5, CURRENT_DATE, 'Card', 'Success', 6000);


-- 9. SHIPMENTS
INSERT INTO SHIPMENTS VALUES
(1, 1, CURRENT_DATE, NULL, 'Active'),
(2, 2, CURRENT_DATE, NULL, 'Active'),
(3, 3, CURRENT_DATE - 3, CURRENT_DATE, 'Delivered'),
(4, 4, NULL, NULL, 'Pending'),
(5, 5, CURRENT_DATE - 1, NULL, 'Active');


-- 10. REVIEWS
INSERT INTO REVIEWS VALUES
(1, 1, 1, 5, 'Excellent laptop'),
(2, 2, 3, 4, 'Good mobile'),
(3, 3, 4, 5, 'Amazing phone'),
(4, 4, 5, 3, 'Average product'),
(5, 5, 7, 4, 'Good headphones');


-- 11. WISHLIST
INSERT INTO WISHLIST VALUES
(1, 1, 4),
(2, 2, 1),
(3, 3, 5),
(4, 4, 7),
(5, 5, 3);


-- 12. CART
INSERT INTO CART VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


-- 13. CART_ITEMS
INSERT INTO CART_ITEMS VALUES
(1, 1, 3, 1),
(2, 2, 4, 2),
(3, 3, 5, 1),
(4, 4, 7, 2),
(5, 5, 8, 1);


-- 14. EMPLOYEES
INSERT INTO EMPLOYEES VALUES
(1, 'Ramesh', NULL, 80000, 'Manager'),
(2, 'Suresh', 1, 40000, 'Developer'),
(3, 'Kiran', 1, 35000, 'Analyst'),
(4, 'Anil', 2, 30000, 'Tester'),
(5, 'Pavan', 2, 28000, 'Developer');
