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
============================================== */

BULK INSERT dbo.menu_item_ingredients
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
