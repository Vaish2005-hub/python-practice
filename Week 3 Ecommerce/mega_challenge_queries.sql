-- 101. Generate Amazon-style Sales Dashboard

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    SUM(oi.quantity) AS total_items_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS average_order_value,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'Completed' THEN o.order_id
    END) AS completed_orders,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'Pending' THEN o.order_id
    END) AS pending_orders,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'Cancelled' THEN o.order_id
    END) AS cancelled_orders
FROM ORDERS o
LEFT JOIN ORDER_ITEMS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed';


-- 102. Generate Top 10 Products Report

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM PRODUCTS p
JOIN ORDER_ITEMS oi
    ON p.product_id = oi.product_id
JOIN ORDERS o
    ON oi.order_id = o.order_id
LEFT JOIN CATEGORIES c
    ON p.category_id = c.category_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name, c.category_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 103. Generate Customer Lifetime Value Report

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS lifetime_value,
    COALESCE(ROUND(AVG(o.total_amount), 2), 0) AS average_order_value,
    MAX(o.order_date) AS last_order_date
FROM CUSTOMERS c
LEFT JOIN ORDERS o
    ON c.customer_id = o.customer_id
    AND o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY lifetime_value DESC;


-- 104. Generate Product Recommendation Query


WITH customer_products AS (
    SELECT DISTINCT product_id
    FROM ORDERS o
    JOIN ORDER_ITEMS oi
        ON o.order_id = oi.order_id
    WHERE o.customer_id = 1
      AND o.order_status = 'Completed'
),
recommended_products AS (
    SELECT
        oi.product_id,
        COUNT(DISTINCT o.customer_id) AS interested_customers
    FROM ORDERS o
    JOIN ORDER_ITEMS oi
        ON o.order_id = oi.order_id
    JOIN customer_products cp
        ON oi.product_id IN (
            SELECT product_id FROM customer_products
        )
    WHERE o.order_status = 'Completed'
      AND o.customer_id <> 1
      AND oi.product_id NOT IN (
          SELECT product_id FROM customer_products
      )
    GROUP BY oi.product_id
)
SELECT
    p.product_id,
    p.product_name,
    p.price,
    rp.interested_customers
FROM recommended_products rp
JOIN PRODUCTS p
    ON rp.product_id = p.product_id
ORDER BY rp.interested_customers DESC
LIMIT 10;


-- 105. Generate Repeat Customer Analysis

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spending,
    CASE
        WHEN COUNT(o.order_id) > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS customer_type
FROM CUSTOMERS c
JOIN ORDERS o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;


-- 106. Generate Inventory Aging Report

-- Add stock_received_date if it does not already exist.
ALTER TABLE PRODUCTS
ADD COLUMN IF NOT EXISTS stock_received_date DATE;

SELECT
    product_id,
    product_name,
    stock_quantity,
    stock_received_date,
    CURRENT_DATE - stock_received_date AS inventory_age_days,
    CASE
        WHEN stock_received_date IS NULL THEN 'Date Not Available'
        WHEN CURRENT_DATE - stock_received_date <= 30 THEN '0-30 Days'
        WHEN CURRENT_DATE - stock_received_date <= 60 THEN '31-60 Days'
        WHEN CURRENT_DATE - stock_received_date <= 90 THEN '61-90 Days'
        ELSE 'Above 90 Days'
    END AS aging_category
FROM PRODUCTS
ORDER BY stock_received_date NULLS LAST;


-- 107. Generate Supplier Performance Dashboard

SELECT
    s.supplier_id,
    s.supplier_name,
    COUNT(DISTINCT p.product_id) AS total_products,
    COALESCE(SUM(
        CASE WHEN o.order_status = 'Completed'
        THEN oi.quantity ELSE 0 END
    ), 0) AS total_units_sold,
    COALESCE(SUM(
        CASE WHEN o.order_status = 'Completed'
        THEN oi.quantity * oi.unit_price ELSE 0 END
    ), 0) AS total_revenue
FROM SUPPLIERS s
LEFT JOIN PRODUCTS p
    ON s.supplier_id = p.supplier_id
LEFT JOIN ORDER_ITEMS oi
    ON p.product_id = oi.product_id
LEFT JOIN ORDERS o
    ON oi.order_id = o.order_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_revenue DESC;


-- 108. Generate Monthly Growth Report

WITH monthly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS sales_year,
        EXTRACT(MONTH FROM order_date) AS sales_month,
        SUM(total_amount) AS monthly_revenue
    FROM ORDERS
    WHERE order_status = 'Completed'
    GROUP BY
        EXTRACT(YEAR FROM order_date),
        EXTRACT(MONTH FROM order_date)
),
growth_report AS (
    SELECT
        sales_year,
        sales_month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (
            ORDER BY sales_year, sales_month
        ) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    sales_year,
    sales_month,
    monthly_revenue,
    previous_month_revenue,
    ROUND(
        (monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0) * 100,
        2
    ) AS growth_percentage
FROM growth_report
ORDER BY sales_year, sales_month;


-- 109. Generate Revenue Forecast Dataset Query

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS sales_month,
        SUM(total_amount) AS monthly_revenue
    FROM ORDERS
    WHERE order_status = 'Completed'
    GROUP BY DATE_TRUNC('month', order_date)
),
forecast_data AS (
    SELECT
        sales_month,
        monthly_revenue,
        ROW_NUMBER() OVER (
            ORDER BY sales_month
        ) AS month_number
    FROM monthly_sales
),
forecast_model AS (
    SELECT
        REGR_SLOPE(monthly_revenue, month_number) AS slope,
        REGR_INTERCEPT(monthly_revenue, month_number) AS intercept,
        MAX(month_number) AS last_month_number,
        MAX(sales_month) AS last_sales_month
    FROM forecast_data
)
SELECT
    fd.sales_month,
    fd.monthly_revenue AS actual_revenue,
    ROUND(
        fm.intercept + fm.slope * fd.month_number,
        2
    ) AS estimated_revenue,
    ROUND(
        fm.intercept + fm.slope * (fm.last_month_number + 1),
        2
    ) AS next_month_forecast
FROM forecast_data fd
CROSS JOIN forecast_model fm
ORDER BY fd.sales_month;


-- 110. Generate Complete Business KPI Dashboard

WITH sales_summary AS (
    SELECT
        COUNT(*) AS total_orders,
        COUNT(DISTINCT customer_id) AS total_customers,
        SUM(total_amount) AS total_revenue,
        AVG(total_amount) AS average_order_value
    FROM ORDERS
    WHERE order_status = 'Completed'
),
product_summary AS (
    SELECT
        COUNT(*) AS total_products,
        SUM(stock_quantity) AS total_stock
    FROM PRODUCTS
),
customer_summary AS (
    SELECT
        COUNT(*) AS repeat_customers
    FROM (
        SELECT customer_id
        FROM ORDERS
        WHERE order_status = 'Completed'
        GROUP BY customer_id
        HAVING COUNT(*) > 1
    ) repeat_list
),
payment_summary AS (
    SELECT
        COALESCE(SUM(amount), 0) AS successful_payments
    FROM PAYMENTS
    WHERE payment_status = 'Success'
),
category_summary AS (
    SELECT
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS category_revenue
    FROM CATEGORIES c
    JOIN PRODUCTS p
        ON c.category_id = p.category_id
    JOIN ORDER_ITEMS oi
        ON p.product_id = oi.product_id
    JOIN ORDERS o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.category_name
),
ranked_categories AS (
    SELECT
        category_name,
        category_revenue,
        RANK() OVER (
            ORDER BY category_revenue DESC
        ) AS category_rank
    FROM category_summary
)
SELECT
    ss.total_orders,
    ss.total_customers,
    ROUND(ss.total_revenue, 2) AS total_revenue,
    ROUND(ss.average_order_value, 2) AS average_order_value,
    ps.total_products,
    ps.total_stock,
    cs.repeat_customers,
    pms.successful_payments,
    rc.category_name AS top_category,
    rc.category_revenue AS top_category_revenue
FROM sales_summary ss
CROSS JOIN product_summary ps
CROSS JOIN customer_summary cs
CROSS JOIN payment_summary pms
LEFT JOIN ranked_categories rc
    ON rc.category_rank = 1;
