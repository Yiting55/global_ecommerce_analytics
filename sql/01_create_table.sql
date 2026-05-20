CREATE TABLE ecommerce_orders (
    order_id VARCHAR(20),
    order_date DATE,
    customer_name VARCHAR(100),
    customer_segment VARCHAR(50),
    country VARCHAR(50),
    region VARCHAR(50),
    product_category VARCHAR(100),
    product_name VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    total_sales DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),
    profit DECIMAL(10,2),
    payment_method VARCHAR(50)
);

-- SELECT table_name
-- FROM information_schema.tables
-- WHERE table_schema = 'public';