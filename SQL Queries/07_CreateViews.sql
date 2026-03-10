/*
Project: Restaurant Operations Intelligence Platform
Purpose: Analytics views for reporting
*/

USE RRG_Database;
GO

/* =====================================================
   Order Line Revenue View
===================================================== */

CREATE VIEW vw_order_line_sales AS
SELECT
    o.order_id,
    o.order_datetime,
    o.restaurant_id,
    r.restaurant_name,
    r.city,
    r.state,
    r.region,
    c.concept_name,
    oi.menu_item_id,
    mi.item_name,
    mc.menu_category_name,
    oi.quantity,
    oi.unit_price,
    oi.extended_price
FROM dbo.orders o
JOIN dbo.order_items oi
    ON o.order_id = oi.order_id
JOIN dbo.restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN dbo.concepts c
    ON o.concept_id = c.concept_id
JOIN dbo.menu_items mi
    ON oi.menu_item_id = mi.menu_item_id
JOIN dbo.menu_categories mc
    ON mi.menu_category_id = mc.menu_category_id;
GO

/* ============================================
Daily Restaurant Revenue
============================================ */

CREATE VIEW vw_daily_restaurant_sales AS
SELECT
    CAST(o.order_datetime AS DATE) AS order_date,
    o.restaurant_id,
    r.restaurant_name,
    r.city,
    r.state,
    r.region,
    c.concept_name,
    COUNT(DISTINCT o.order_id) AS orders,
    SUM(o.subtotal) AS subtotal_revenue,
    SUM(o.tax_amount) AS tax,
    SUM(o.discount_amount) AS discounts,
    SUM(o.total_amount) AS total_revenue
FROM dbo.orders o
JOIN dbo.restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN dbo.concepts c
    ON o.concept_id = c.concept_id
GROUP BY
    CAST(o.order_datetime AS DATE),
    o.restaurant_id,
    r.restaurant_name,
    r.city,
    r.state,
    r.region,
    c.concept_name;
