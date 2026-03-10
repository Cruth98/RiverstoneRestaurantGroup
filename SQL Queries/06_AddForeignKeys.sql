/*
Project: Restaurant Operations Intelligence Platform
Database: RRG_Database
Purpose: Add referential integrity constraints
*/

USE RRG_Database;
GO

/* Restaurants -> Concepts */
ALTER TABLE dbo.restaurants
ADD CONSTRAINT FK_restaurants_concepts
FOREIGN KEY (concept_id)
REFERENCES dbo.concepts(concept_id);
GO

/* Menu Categories -> Concepts */
ALTER TABLE dbo.menu_categories
ADD CONSTRAINT FK_menu_categories_concepts
FOREIGN KEY (concept_id)
REFERENCES dbo.concepts(concept_id);
GO

/* Menu Items -> Concepts */
ALTER TABLE dbo.menu_items
ADD CONSTRAINT FK_menu_items_concepts
FOREIGN KEY (concept_id)
REFERENCES dbo.concepts(concept_id);
GO

/* Menu Items -> Menu Categories */
ALTER TABLE dbo.menu_items
ADD CONSTRAINT FK_menu_items_categories
FOREIGN KEY (menu_category_id)
REFERENCES dbo.menu_categories(menu_category_id);
GO

/* Employees -> Restaurants */
ALTER TABLE dbo.employees
ADD CONSTRAINT FK_employees_restaurants
FOREIGN KEY (restaurant_id)
REFERENCES dbo.restaurants(restaurant_id);
GO

/* Employees -> Concepts */
ALTER TABLE dbo.employees
ADD CONSTRAINT FK_employees_concepts
FOREIGN KEY (concept_id)
REFERENCES dbo.concepts(concept_id);
GO

/* Menu Item Ingredients -> Menu Items */
ALTER TABLE dbo.menu_item_ingredients
ADD CONSTRAINT FK_menu_item_ingredients_menu_items
FOREIGN KEY (menu_item_id)
REFERENCES dbo.menu_items(menu_item_id);
GO

/* Menu Item Ingredients -> Ingredients */
ALTER TABLE dbo.menu_item_ingredients
ADD CONSTRAINT FK_menu_item_ingredients_ingredients
FOREIGN KEY (ingredient_id)
REFERENCES dbo.ingredients(ingredient_id);
GO

/* Orders -> Restaurants */
ALTER TABLE dbo.orders
ADD CONSTRAINT FK_orders_restaurants
FOREIGN KEY (restaurant_id)
REFERENCES dbo.restaurants(restaurant_id);
GO

/* Orders -> Concepts */
ALTER TABLE dbo.orders
ADD CONSTRAINT FK_orders_concepts
FOREIGN KEY (concept_id)
REFERENCES dbo.concepts(concept_id);
GO

/* Orders -> Customers */
ALTER TABLE dbo.orders
ADD CONSTRAINT FK_orders_customers
FOREIGN KEY (customer_id)
REFERENCES dbo.customers(customer_id);
GO

/* Employee Shifts -> Employees */
ALTER TABLE dbo.employee_shifts
ADD CONSTRAINT FK_employee_shifts_employees
FOREIGN KEY (employee_id)
REFERENCES dbo.employees(employee_id);
GO

/* Employee Shifts -> Restaurants */
ALTER TABLE dbo.employee_shifts
ADD CONSTRAINT FK_employee_shifts_restaurants
FOREIGN KEY (restaurant_id)
REFERENCES dbo.restaurants(restaurant_id);
GO

/* Inventory Transactions -> Restaurants */
ALTER TABLE dbo.inventory_transactions
ADD CONSTRAINT FK_inventory_transactions_restaurants
FOREIGN KEY (restaurant_id)
REFERENCES dbo.restaurants(restaurant_id);
GO

/* Inventory Transactions -> Ingredients */
ALTER TABLE dbo.inventory_transactions
ADD CONSTRAINT FK_inventory_transactions_ingredients
FOREIGN KEY (ingredient_id)
REFERENCES dbo.ingredients(ingredient_id);
GO

/* Order Items -> Orders */
ALTER TABLE dbo.order_items
ADD CONSTRAINT FK_order_items_orders
FOREIGN KEY (order_id)
REFERENCES dbo.orders(order_id);
GO

/* Order Items -> Menu Items */
ALTER TABLE dbo.order_items
ADD CONSTRAINT FK_order_items_menu_items
FOREIGN KEY (menu_item_id)
REFERENCES dbo.menu_items(menu_item_id);
GO
