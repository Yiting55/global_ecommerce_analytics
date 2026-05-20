-- row count
SELECT COUNT(*) AS total_rows
FROM ecommerce_orders;


-- preview data
SELECT *
FROM ecommerce_orders
LIMIT 10;


-- check duplicates
SELECT order_id, COUNT(*) AS count
FROM ecommerce_orders
GROUP BY order_id
HAVING COUNT(*) > 1;
-- since no rows show up, there is no duplicates


-- check missing values
SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id_count,
    COUNT(order_date) AS order_date_count,
    COUNT(customer_name) AS customer_name_count,
    COUNT(customer_segment) AS customer_segment_count,
    COUNT(country) AS country_count,
    COUNT(region) AS region_count,
    COUNT(product_category) AS product_category_count,
    COUNT(product_name) AS product_name_count,
    COUNT(quantity) AS quantity_count,
    COUNT(unit_price) AS unit_price_count,
    COUNT(discount_percent) AS discount_percent_count,
    COUNT(total_sales) AS total_sales_count,
    COUNT(shipping_cost) AS shipping_cost_count,
    COUNT(profit) AS profit_count,
    COUNT(payment_method) AS payment_method_count
FROM ecommerce_orders;
-- since every column shows 2000, there is no missing values


-- check invalid numeric values
SELECT *
FROM ecommerce_orders
WHERE quantity <= 0
   OR unit_price < 0
   OR discount_percent < 0
   OR discount_percent > 30
   OR total_sales < 0
   OR shipping_cost < 0;
-- no invalid data


-- check date range
SELECT 
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date
FROM ecommerce_orders;
-- range: 2023-01-02 to 2025-12-31


-- check categories
SELECT DISTINCT customer_segment
FROM ecommerce_orders;
-- Consumer, Corporate, Home Office

SELECT DISTINCT product_category
FROM ecommerce_orders;
-- Clothing & Accessories, Furniture, Office Supplies, Technology

SELECT DISTINCT payment_method
FROM ecommerce_orders;
-- PayPal, Cash on Delivery, Credit Card, Bank Transfer

SELECT DISTINCT region
FROM ecommerce_orders;
-- Middle East & Africa, South America, Europe, North America, Asia Pacific


-- checks sales calculation: whether Total_sales = Quantity * Unit_Price * (1 - Discount%)
SELECT
    order_id,
    quantity,
    unit_price,
    discount_percent,
    total_sales,
    ROUND((quantity * unit_price * (1 - discount_percent / 100.0))::numeric, 2) AS calculated_sales
FROM ecommerce_orders
WHERE ROUND(total_sales::numeric, 2) 
   <> ROUND((quantity * unit_price * (1 - discount_percent / 100.0))::numeric, 2)
   AND ROUND(total_sales::numeric, 2) - ROUND((quantity * unit_price * (1 - discount_percent / 100.0))::numeric, 2) <> 0.01
   AND ROUND(total_sales::numeric, 2) - ROUND((quantity * unit_price * (1 - discount_percent / 100.0))::numeric, 2) <> -0.01;
-- no data means all calculation of total sales is correct
