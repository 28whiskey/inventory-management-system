-- This SQL query calculates the value of each product's stock based on purchase cost
SELECT
    product_name,
    quantity_in_stock,
    purchase_price,
    quantity_in_stock * purchase_price AS stock_value
FROM products
WHERE
    is_activve = TRUE
ORDER BY stock_value DESC;

-- Calculate total inventory value
SELECT SUM(
        quantity_in_stock * purchase_price
    ) AS total_inventory_value
FROM products
WHERE
    is_activve = TRUE;

-- Calculate potential sales value
SELECT SUM(
        quantity_in_stock * selling_price
    ) AS potential_sales_value
FROM products
WHERE
    is_activve = TRUE;