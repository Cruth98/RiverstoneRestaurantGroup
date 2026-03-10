/*
Project: Restaurant Operations Intelligence Platform
Database: RRG_Database
Purpose: Correct data quality issues identified during validation
*/

USE RRG_Database;
GO

/* Align menu_items concept_id to the concept_id of the assigned menu category */
UPDATE mi
SET mi.concept_id = mc.concept_id
FROM dbo.menu_items mi
INNER JOIN dbo.menu_categories mc
    ON mi.menu_category_id = mc.menu_category_id
WHERE mi.concept_id <> mc.concept_id;
GO
