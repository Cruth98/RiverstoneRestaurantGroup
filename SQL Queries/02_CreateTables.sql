/*
Project: Restaurant Operations Intelligence Platform
Database: RRG_Database
Purpose: Create core relational tables for Riverstone Restaurant Group
*/

USE RRG_Database;
GO

/*========================================================
  1. concepts
========================================================*/
CREATE TABLE dbo.concepts (
    concept_id INT NOT NULL,
    concept_name VARCHAR(100) NOT NULL,
    service_model VARCHAR(50) NOT NULL,
    price_tier VARCHAR(20) NOT NULL,
    avg_ticket_target DECIMAL(10,2) NOT NULL,
    avg_prep_minutes_target INT NOT NULL,
    CONSTRAINT PK_concepts PRIMARY KEY (concept_id)
);
GO

/*========================================================
  2. restaurants
========================================================*/
CREATE TABLE dbo.restaurants (
    restaurant_id INT NOT NULL,
    concept_id INT NOT NULL,
    restaurant_name VARCHAR(150) NOT NULL,
    store_number INT NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(25) NOT NULL,
    region VARCHAR(50) NOT NULL,
    open_date DATE NOT NULL,
    seating_capacity INT NOT NULL,
    drive_thru_flag BIT NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    market_type VARCHAR(25) NOT NULL,
    status VARCHAR(25) NOT NULL,
    CONSTRAINT PK_restaurants PRIMARY KEY (restaurant_id)
);
GO

/*========================================================
  3. menu_categories
========================================================*/
CREATE TABLE dbo.menu_categories (
    menu_category_id INT NOT NULL,
    concept_id INT NOT NULL,
    menu_category_name VARCHAR(100) NOT NULL,
    display_order INT NOT NULL,
    CONSTRAINT PK_menu_categories PRIMARY KEY (menu_category_id)
);
GO

/*========================================================
  4. ingredients
========================================================*/
CREATE TABLE dbo.ingredients (
    ingredient_id INT NOT NULL,
    ingredient_name VARCHAR(100) NOT NULL,
    ingredient_category VARCHAR(50) NOT NULL,
    unit_of_measure VARCHAR(20) NOT NULL,
    standard_unit_cost DECIMAL(10,2) NOT NULL,
    shelf_life_days INT NOT NULL,
    is_perishable BIT NOT NULL,
    CONSTRAINT PK_ingredients PRIMARY KEY (ingredient_id)
);
GO

/*========================================================
  5. menu_items
========================================================*/
CREATE TABLE dbo.menu_items (
    menu_item_id INT NOT NULL,
    concept_id INT NOT NULL,
    menu_category_id INT NOT NULL,
    item_name VARCHAR(150) NOT NULL,
    item_type VARCHAR(25) NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    standard_food_cost DECIMAL(10,2) NOT NULL,
    standard_prep_minutes INT NOT NULL,
    is_active BIT NOT NULL,
    launch_date DATE NOT NULL,
    CONSTRAINT PK_menu_items PRIMARY KEY (menu_item_id)
);
GO

/*========================================================
  6. customers
========================================================*/
CREATE TABLE dbo.customers (
    customer_id INT NOT NULL,
    customer_city VARCHAR(100) NOT NULL,
    customer_state VARCHAR(25) NOT NULL,
    signup_date DATE NOT NULL,
    loyalty_member_flag BIT NOT NULL,
    birth_year_band VARCHAR(25) NOT NULL,
    preferred_order_channel VARCHAR(25) NOT NULL,
    CONSTRAINT PK_customers PRIMARY KEY (customer_id)
);
GO

/*========================================================
  7. employees
========================================================*/
CREATE TABLE dbo.employees (
    employee_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    concept_id INT NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    employment_status VARCHAR(25) NOT NULL,
    hourly_rate DECIMAL(10,2) NOT NULL,
    full_time_flag BIT NOT NULL,
    manager_flag BIT NOT NULL,
    CONSTRAINT PK_employees PRIMARY KEY (employee_id)
);
GO

/*========================================================
  8. menu_item_ingredients
========================================================*/
CREATE TABLE dbo.menu_item_ingredients (
    menu_item_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity_per_item DECIMAL(10,2) NOT NULL,
    waste_factor_pct DECIMAL(6,4) NOT NULL,
    CONSTRAINT PK_menu_item_ingredients PRIMARY KEY (menu_item_id, ingredient_id)
);
GO

/*========================================================
  9. orders
========================================================*/
CREATE TABLE dbo.orders (
    order_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    concept_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_datetime DATETIME2 NOT NULL,
    order_channel VARCHAR(25) NOT NULL,
    party_size INT NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    discount_amount DECIMAL(12,2) NOT NULL,
    tax_amount DECIMAL(12,2) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    payment_type VARCHAR(25) NOT NULL,
    prep_start_datetime DATETIME2 NOT NULL,
    order_ready_datetime DATETIME2 NOT NULL,
    service_mode VARCHAR(25) NOT NULL,
    CONSTRAINT PK_orders PRIMARY KEY (order_id)
);
GO

/*========================================================
  10. employee_shifts
========================================================*/
CREATE TABLE dbo.employee_shifts (
    shift_id INT NOT NULL,
    employee_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    shift_date DATE NOT NULL,
    shift_start_datetime DATETIME2 NOT NULL,
    shift_end_datetime DATETIME2 NOT NULL,
    scheduled_hours DECIMAL(5,2) NOT NULL,
    actual_hours DECIMAL(5,2) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    hourly_rate DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_employee_shifts PRIMARY KEY (shift_id)
);
GO

/*========================================================
  11. inventory_transactions
========================================================*/
CREATE TABLE dbo.inventory_transactions (
    inventory_txn_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    transaction_datetime DATETIME2 NOT NULL,
    transaction_type VARCHAR(25) NOT NULL,
    quantity DECIMAL(12,2) NOT NULL,
    unit_cost DECIMAL(10,2) NOT NULL,
    extended_cost DECIMAL(12,2) NOT NULL,
    reference_note VARCHAR(255) NULL,
    CONSTRAINT PK_inventory_transactions PRIMARY KEY (inventory_txn_id)
);
GO

/*========================================================
  12. order_items
========================================================*/
CREATE TABLE dbo.order_items (
    order_item_id INT NOT NULL,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    extended_price DECIMAL(12,2) NOT NULL,
    CONSTRAINT PK_order_items PRIMARY KEY (order_item_id)
);
GO
