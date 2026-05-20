CREATE OR REPLACE VIEW clean_ecommerce_orders AS
SELECT
    order_id,
    order_date,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    TO_CHAR(order_date, 'YYYY-MM') AS order_month_year,

    customer_name,
    customer_segment,
    country,
    region,

    product_category,
    product_name,

    quantity,
    unit_price,
    discount_percent,
    total_sales,
    shipping_cost,
    profit,

    ROUND((profit / NULLIF(total_sales, 0))::numeric, 4) AS profit_margin,
    ROUND((shipping_cost / NULLIF(total_sales, 0))::numeric, 4) AS shipping_cost_ratio,

    payment_method
FROM ecommerce_orders;

-- SELECT *
-- FROM clean_ecommerce_orders
-- LIMIT 10;