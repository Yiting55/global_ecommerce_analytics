-- dataset overview: how large is the business and dataset?
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_name) AS total_customers,
    COUNT(DISTINCT country) AS total_countries,
    COUNT(DISTINCT product_name) AS total_products,
    ROUND(SUM(total_sales),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit
FROM clean_ecommerce_orders;
-- 1534 customers, 20 total countries, 40 products, ~500m total revenue, ~160m total profit


-- time coverage: what period does the dataset cover?
SELECT
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order
FROM clean_ecommerce_orders;
-- 20230102 - 20251231


-- orders by year: is the business growing over time?
SELECT
    order_year,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM clean_ecommerce_orders
GROUP BY order_year
ORDER BY order_year;
-- drop from 23 to 24, but increase back from 24 to 25


-- monthly trend: are there seasonality or demand pattern?
SELECT
    order_month_year,
    COUNT(*) AS orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM clean_ecommerce_orders
GROUP BY order_month_year
ORDER BY order_month_year;
-- no clear trend, there seems a cycle of 2-4 months with higher revenue then drop, then repeat this cycle


-- region distribution: which region drives business performance?
SELECT
    region,
    COUNT(*) AS orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM clean_ecommerce_orders
GROUP BY region
ORDER BY revenue DESC;
-- top 3 are north america, asia pacific, and europe


-- product category overview: which product categories perform best?
SELECT
    product_category,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(AVG(profit_margin)*100,2) AS avg_margin_percent
FROM clean_ecommerce_orders
GROUP BY product_category
ORDER BY revenue DESC;
-- highest profit comes from furnitue, followed by technology and clothing & accessories office supplies shows the lowest profit


-- customer segment overview: which customer segment contributes most?
SELECT
    customer_segment,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM clean_ecommerce_orders
GROUP BY customer_segment
ORDER BY revenue DESC;
-- consumer accounts for the highest orders, followed by corporate and home office


-- payment method distribution: how do customers prefer paying?
SELECT
    payment_method,
    COUNT(*) AS orders,
    ROUND(SUM(total_sales),2) AS revenue
FROM clean_ecommerce_orders
GROUP BY payment_method
ORDER BY orders DESC;
-- most frequently used payment methods: credit card, paypal


-- discount behavior: how frequently are discounts used?
SELECT
    discount_percent,
    COUNT(*) AS frequency
FROM clean_ecommerce_orders
GROUP BY discount_percent
ORDER BY discount_percent;
-- besides for 503 orders without discounts, the most frequent discounts are 5% (488 orders), 10% (443 orders), 15% (312 orders)
-- max discount is 30% (18 orders only)


-- shipping cost pattern: is shipping disproportionately expensive in some regions?
SELECT
    region,
    ROUND(AVG(shipping_cost),2) AS avg_shipping,
    ROUND(AVG(shipping_cost_ratio)*100,2) AS shipping_pct_of_sales
FROM clean_ecommerce_orders
GROUP BY region
ORDER BY avg_shipping DESC;
-- shipping cost is most expensive in middle east & africa (16.00) and south america (15.44)
-- highest shipping pct of sales occur in south america (29.62%)