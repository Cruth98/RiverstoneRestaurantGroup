/*
Project: Restaurant Operations Intelligence Platform
Database: RRG_Database
Purpose: Validate loaded source data before adding foreign keys
*/

USE RRG_Database;
GO

/* =====================================================
   1. Row Count Checks
===================================================== */
SELECT 'concepts' AS table_name, COUNT(*) AS row_count FROM dbo.concepts
UNION ALL
SELECT 'restaurants', COUNT(*) FROM dbo.restaurants
UNION ALL
SELECT 'menu_categories', COUNT(*) FROM dbo.menu_categories
UNION ALL
SELECT 'ingredients', COUNT(*) FROM dbo.ingredients
UNION ALL
SELECT 'menu_items', COUNT(*) FROM dbo.menu_items
UNION ALL
SELECT 'customers', COUNT(*) FROM dbo.customers
UNION ALL
SELECT 'employees', COUNT(*) FROM dbo.employees
UNION ALL
SELECT 'menu_item_ingredients', COUNT(*) FROM dbo.menu_item_ingredients
UNION ALL
SELECT 'orders', COUNT(*) FROM dbo.orders
UNION ALL
SELECT 'employee_shifts', COUNT(*) FROM dbo.employee_shifts
UNION ALL
SELECT 'inventory_transactions', COUNT(*) FROM dbo.inventory_transactions
UNION ALL
SELECT 'order_items', COUNT(*) FROM dbo.order_items;
GO

/* =====================================================
   2. Duplicate Primary Key Checks
   Expected result: zero rows returned
===================================================== */

SELECT concept_id, COUNT(*) AS duplicate_count
FROM dbo.concepts
GROUP BY concept_id
HAVING COUNT(*) > 1;
GO

SELECT restaurant_id, COUNT(*) AS duplicate_count
FROM dbo.restaurants
GROUP BY restaurant_id
HAVING COUNT(*) > 1;
GO

SELECT menu_category_id, COUNT(*) AS duplicate_count
FROM dbo.menu_categories
GROUP BY menu_category_id
HAVING COUNT(*) > 1;
GO

SELECT ingredient_id, COUNT(*) AS duplicate_count
FROM dbo.ingredients
GROUP BY ingredient_id
HAVING COUNT(*) > 1;
GO

SELECT menu_item_id, COUNT(*) AS duplicate_count
FROM dbo.menu_items
GROUP BY menu_item_id
HAVING COUNT(*) > 1;
GO

SELECT customer_id, COUNT(*) AS duplicate_count
FROM dbo.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
GO

SELECT employee_id, COUNT(*) AS duplicate_count
FROM dbo.employees
GROUP BY employee_id
HAVING COUNT(*) > 1;
GO

SELECT menu_item_id, ingredient_id, COUNT(*) AS duplicate_count
FROM dbo.menu_item_ingredients
GROUP BY menu_item_id, ingredient_id
HAVING COUNT(*) > 1;
GO

SELECT order_id, COUNT(*) AS duplicate_count
FROM dbo.orders
GROUP BY order_id
HAVING COUNT(*) > 1;
GO

SELECT shift_id, COUNT(*) AS duplicate_count
FROM dbo.employee_shifts
GROUP BY shift_id
HAVING COUNT(*) > 1;
GO

SELECT inventory_txn_id, COUNT(*) AS duplicate_count
FROM dbo.inventory_transactions
GROUP BY inventory_txn_id
HAVING COUNT(*) > 1;
GO

SELECT order_item_id, COUNT(*) AS duplicate_count
FROM dbo.order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;
GO

/* =====================================================
   3. Orphan Checks
   Expected result: zero rows returned
===================================================== */

-- restaurants -> concepts
SELECT r.*
FROM dbo.restaurants r
LEFT JOIN dbo.concepts c
    ON r.concept_id = c.concept_id
WHERE c.concept_id IS NULL;
GO

-- menu_categories -> concepts
SELECT mc.*
FROM dbo.menu_categories mc
LEFT JOIN dbo.concepts c
    ON mc.concept_id = c.concept_id
WHERE c.concept_id IS NULL;
GO

-- menu_items -> concepts
SELECT mi.*
FROM dbo.menu_items mi
LEFT JOIN dbo.concepts c
    ON mi.concept_id = c.concept_id
WHERE c.concept_id IS NULL;
GO

-- menu_items -> menu_categories
SELECT mi.*
FROM dbo.menu_items mi
LEFT JOIN dbo.menu_categories mc
    ON mi.menu_category_id = mc.menu_category_id
WHERE mc.menu_category_id IS NULL;
GO

-- employees -> restaurants
SELECT e.*
FROM dbo.employees e
LEFT JOIN dbo.restaurants r
    ON e.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;
GO

-- employees -> concepts
SELECT e.*
FROM dbo.employees e
LEFT JOIN dbo.concepts c
    ON e.concept_id = c.concept_id
WHERE c.concept_id IS NULL;
GO

-- menu_item_ingredients -> menu_items
SELECT mii.*
FROM dbo.menu_item_ingredients mii
LEFT JOIN dbo.menu_items mi
    ON mii.menu_item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NULL;
GO

-- menu_item_ingredients -> ingredients
SELECT mii.*
FROM dbo.menu_item_ingredients mii
LEFT JOIN dbo.ingredients i
    ON mii.ingredient_id = i.ingredient_id
WHERE i.ingredient_id IS NULL;
GO

-- orders -> restaurants
SELECT o.*
FROM dbo.orders o
LEFT JOIN dbo.restaurants r
    ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;
GO

-- orders -> concepts
SELECT o.*
FROM dbo.orders o
LEFT JOIN dbo.concepts c
    ON o.concept_id = c.concept_id
WHERE c.concept_id IS NULL;
GO

-- orders -> customers
SELECT o.*
FROM dbo.orders o
LEFT JOIN dbo.customers cu
    ON o.customer_id = cu.customer_id
WHERE cu.customer_id IS NULL;
GO

-- employee_shifts -> employees
SELECT es.*
FROM dbo.employee_shifts es
LEFT JOIN dbo.employees e
    ON es.employee_id = e.employee_id
WHERE e.employee_id IS NULL;
GO

-- employee_shifts -> restaurants
SELECT es.*
FROM dbo.employee_shifts es
LEFT JOIN dbo.restaurants r
    ON es.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;
GO

-- inventory_transactions -> restaurants
SELECT it.*
FROM dbo.inventory_transactions it
LEFT JOIN dbo.restaurants r
    ON it.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;
GO

-- inventory_transactions -> ingredients
SELECT it.*
FROM dbo.inventory_transactions it
LEFT JOIN dbo.ingredients i
    ON it.ingredient_id = i.ingredient_id
WHERE i.ingredient_id IS NULL;
GO

-- order_items -> orders
SELECT oi.*
FROM dbo.order_items oi
LEFT JOIN dbo.orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
GO

-- order_items -> menu_items
SELECT oi.*
FROM dbo.order_items oi
LEFT JOIN dbo.menu_items mi
    ON oi.menu_item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NULL;
GO

/* =====================================================
   4. Basic Sanity Checks
===================================================== */

-- negative or zero monetary values where suspicious
SELECT *
FROM dbo.orders
WHERE subtotal < 0
   OR discount_amount < 0
   OR tax_amount < 0
   OR total_amount < 0;
GO

SELECT *
FROM dbo.order_items
WHERE quantity <= 0
   OR unit_price < 0
   OR extended_price < 0;
GO

SELECT *
FROM dbo.inventory_transactions
WHERE quantity < 0
   OR unit_cost < 0
   OR extended_cost < 0;
GO

-- order timing issues
SELECT *
FROM dbo.orders
WHERE prep_start_datetime < order_datetime
   OR order_ready_datetime < prep_start_datetime
   OR order_ready_datetime < order_datetime;
GO

-- shift timing issues
SELECT *
FROM dbo.employee_shifts
WHERE shift_end_datetime < shift_start_datetime
   OR actual_hours < 0
   OR scheduled_hours < 0;
GO

-- implausible prep durations
SELECT TOP 100 *
FROM dbo.orders
WHERE DATEDIFF(MINUTE, order_datetime, order_ready_datetime) > 180;
GO

/* =====================================================
   5. Relationship Consistency Checks
===================================================== */

-- employees should align restaurant concept to employee concept
SELECT TOP 100
    e.employee_id,
    e.restaurant_id,
    e.concept_id AS employee_concept_id,
    r.concept_id AS restaurant_concept_id
FROM dbo.employees e
INNER JOIN dbo.restaurants r
    ON e.restaurant_id = r.restaurant_id
WHERE e.concept_id <> r.concept_id;
GO

-- orders should align restaurant concept to order concept
SELECT TOP 100
    o.order_id,
    o.restaurant_id,
    o.concept_id AS order_concept_id,
    r.concept_id AS restaurant_concept_id
FROM dbo.orders o
INNER JOIN dbo.restaurants r
    ON o.restaurant_id = r.restaurant_id
WHERE o.concept_id <> r.concept_id;
GO

SELECT TOP 100
    mi.menu_item_id,
    mi.concept_id AS menu_item_concept_id,
    mc.concept_id AS category_concept_id
FROM dbo.menu_items mi
INNER JOIN dbo.menu_categories mc
    ON mi.menu_category_id = mc.menu_category_id
WHERE mi.concept_id <> mc.concept_id;
