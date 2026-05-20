/* ==========================================
BUSINESS ANALYSIS
Global E-commerce Analytics Project
========================================== */


/* 1. Which customer segment generates the most value? */

SELECT
    customer_segment,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(AVG(total_sales),2) AS avg_order_value,
    ROUND(AVG(profit_margin)*100,2) AS avg_profit_margin_percent
FROM clean_ecommerce_orders
GROUP BY customer_segment
ORDER BY profit DESC;


/* Business question:
Which customer segment should marketing prioritize?
*/
-- consumer segment should be priotized the most as it involves the highest total orders and greatest revenue and profit
-- it is contributing the highest average profit per order


/* ========================================== */


/* 2. Which regions are underperforming? */

SELECT
    region,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(AVG(profit_margin)*100,2) AS avg_profit_margin_percent
FROM clean_ecommerce_orders
GROUP BY region
ORDER BY profit ASC;


/* Business question:
Which regions have high sales but poor profitability?
*/
-- Asia Pacific has the second highest order but second lowest average profit margin, showing poor profitability



/* ========================================== */


/* 3. Top 10 most profitable products */

SELECT
    product_name,
    product_category,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit_margin)*100,2) AS margin
FROM clean_ecommerce_orders
GROUP BY product_name, product_category
ORDER BY total_profit DESC
LIMIT 10;


/* Business question:
Which products deserve more marketing or inventory investment?
*/
-- Furnitures such as ergonomic office chair and standing desk converter generate the highest reveneu
-- business casual blazer under clothing & accessories shows the highest margin (36.24), which is a sign for more publicity


/* ========================================== */


/* 4. Bottom 10 products */

SELECT
    product_name,
    product_category,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS total_profit
FROM clean_ecommerce_orders
GROUP BY product_name, product_category
ORDER BY total_profit ASC
LIMIT 10;


/* Business question:
Should these products be reviewed or removed?
*/
-- paper clips box 500pc and highlighters neon pack 6 are making loss so we consider removing them
-- sticky notes multicolor 6-pack should be reviewed since the profits made is quite limited
-- generally the bottom 10 products belong to office supplies, which should all be carefully reviewed


/* ========================================== */


/* 5. Does discounting hurt profit? */

SELECT
    CASE
        WHEN discount_percent=0 THEN 'No Discount'
        WHEN discount_percent<=10 THEN 'Low'
        WHEN discount_percent<=20 THEN 'Medium'
        ELSE 'High'
    END AS discount_group,

    COUNT(*) AS total_orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,

    ROUND(AVG(profit_margin)*100,2)
        AS avg_profit_margin_percent

FROM clean_ecommerce_orders
GROUP BY discount_group
ORDER BY avg_profit_margin_percent DESC;


/* Business question:
Are larger discounts sacrificing profitability?
*/
-- larger discounts lead to lower average profit margin
-- while low discount group is linked to greatest total orders, highest revenue and highest profit



/* ========================================== */


/* 6. Which payment method performs best? */

SELECT
    payment_method,
    COUNT(*) AS orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(AVG(total_sales),2) AS avg_order_value
FROM clean_ecommerce_orders
GROUP BY payment_method
ORDER BY revenue DESC;


/* Business question:
Do customers using certain payment methods spend more?
*/
-- people using credit card spend more, leading to highest order count, greatest revenue and profit



/* ========================================== */


/* 7. Shipping cost impact */

SELECT
    region,
    ROUND(AVG(shipping_cost),2)
        AS avg_shipping_cost,

    ROUND(AVG(shipping_cost_ratio)*100,2)
        AS shipping_pct_sales,

    ROUND(SUM(profit),2)
        AS total_profit

FROM clean_ecommerce_orders
GROUP BY region
ORDER BY shipping_pct_sales DESC;


/* Business question:
Is shipping reducing profits in some regions?
*/
-- higher average shipping cost and higher shipping sale ratio is linked to lower total profit
-- it suggests that shipping is reducing profits in regions including south america, middle east & africa



/* ========================================== */


/* 8. Top countries */

SELECT
    country,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM clean_ecommerce_orders
GROUP BY country
ORDER BY revenue DESC
LIMIT 10;


/* Business question:
Which countries should the company prioritize?
*/
-- Top 3 countries with the greatest total orders, highest revenue and profit are Mexico, Canada and US



/* ========================================== */


/* 9. High-value customers */

SELECT
    customer_name,
    COUNT(*) AS order_count,
    ROUND(SUM(total_sales),2) AS lifetime_value,
    ROUND(SUM(profit),2) AS profit_generated
FROM clean_ecommerce_orders
GROUP BY customer_name
ORDER BY lifetime_value DESC
LIMIT 10;


/* Business question:
Who are our most valuable customers?
*/
-- Priya Jackson and Hanna Jones are 2 customers that make the greatest lifetime purchasing value and profit generated



/* ========================================== */


/* 10. Monthly business growth */

SELECT
    order_month_year,

    ROUND(SUM(total_sales),2)
        AS revenue,

    ROUND(SUM(profit),2)
        AS profit

FROM clean_ecommerce_orders
GROUP BY order_month_year
ORDER BY order_month_year;


/* Business question:
Is revenue growing consistently over time?
*/
-- The revenue fluctuates over time, instead of showing a general growing/dropping trend


/* ========================================== */