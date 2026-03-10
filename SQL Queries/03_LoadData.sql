/*
Project: Restaurant Operations Intelligence Platform
Database: RRG_Database
Purpose: Load CSV source data into core tables

-- concepts.csv was loaded with the import wizard, whereas all other flat files were imported using BULK INSERT method

*/

USE RRG_Database;
GO

/* ==============================================
   Load restaurants
============================================== */

BULK INSERT dbo.restaurants
FROM 'C:\Users\YourName\Documents\restaurant_data\restaurants.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

/* ==============================================
   Load menu_categories
============================================== */

BULK INSERT dbo.menu_categories
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\menu_categories.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

/* ==============================================
   Load ingredients
============================================== */

BULK INSERT dbo.ingredients
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\ingredients.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

/* ==============================================
   Load menu_items
============================================== */

BULK INSERT dbo.menu_items
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\menu_items.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

/* ==============================================
   Load customers
============================================== */

BULK INSERT dbo.customers
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\customers.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

/* ==============================================
   Load employees
============================================== */

BULK INSERT dbo.employees
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\employees.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

/* ==============================================
   Load menu_item_ingredients
   Note: Raw file may contain duplicate
   (menu_item_id, ingredient_id) pairs, so
   data is first loaded to staging and then
   deduplicated into the final table.
============================================== */

IF OBJECT_ID('dbo.menu_item_ingredients_stage', 'U') IS NOT NULL
    DROP TABLE dbo.menu_item_ingredients_stage;
GO

CREATE TABLE dbo.menu_item_ingredients_stage (
    menu_item_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity_per_item DECIMAL(10,2) NOT NULL,
    waste_factor_pct DECIMAL(6,4) NOT NULL
);
GO

BULK INSERT dbo.menu_item_ingredients_stage
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\menu_item_ingredients.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

TRUNCATE TABLE dbo.menu_item_ingredients;
GO

INSERT INTO dbo.menu_item_ingredients
(
    menu_item_id,
    ingredient_id,
    quantity_per_item,
    waste_factor_pct
)
SELECT
    menu_item_id,
    ingredient_id,
    CAST(AVG(quantity_per_item) AS DECIMAL(10,2)) AS quantity_per_item,
    CAST(AVG(waste_factor_pct) AS DECIMAL(6,4)) AS waste_factor_pct
FROM dbo.menu_item_ingredients_stage
GROUP BY
    menu_item_id,
    ingredient_id;
GO

DROP TABLE dbo.menu_item_ingredients_stage;
GO

/* ==============================================
   Load orders
============================================== */

BULK INSERT dbo.orders
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\orders.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

/* ==============================================
   Load employee_shifts
============================================== */

BULK INSERT dbo.employee_shifts
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\employee_shifts.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

/* ==============================================
   Load inventory_transactions
============================================== */

BULK INSERT dbo.employee_shifts
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\inventory_transactions.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

/* ==============================================
   Load order_items
============================================== */

BULK INSERT dbo.employee_shifts
FROM 'C:\Users\YourName\Documents\RRG_Project\data\raw\order_items.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
GO

