## menu_item_ingredients load note

The raw `menu_item_ingredients.csv` file contained duplicate `(menu_item_id, ingredient_id)` pairs.

Because the production table uses a composite primary key on:
- `menu_item_id`
- `ingredient_id`

the file could not be loaded directly into the final table.

To resolve this, the file was loaded into a staging table and then deduplicated by key pair using `GROUP BY`, with averaged values for:
- `quantity_per_item`
- `waste_factor_pct`

This preserves relational integrity in the final production table.
