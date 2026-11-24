SELECT p.product_id, p.product_name, p.stock_keeping_unit, p.barcode, c.category_name, p.purchase_price, p.selling_price, p.quantity_in_stock, p.reorder_level
FROM products AS p
    JOIN categories AS c ON p.category_id = c.category_id
WHERE
    p.is_activve = TRUE
ORDER BY p.product_id;

-- Search by product name
-- Type: %Rice% for all products containing the word "Rice", or % for ALL products
\prompt 'Enter product name (or % for ALL products): ' search_product_name

SELECT p.product_id, p.product_name, p.stock_keeping_unit, c.category_name, p.selling_price, p.quantity_in_stock
FROM products AS p
    JOIN categories AS c ON p.category_id = c.category_id
WHERE
    p.product_name ILIKE :'search_product_name'
    AND p.is_activve = TRUE;

-- Search by stock keeping unit
-- Type: SKU001 for a specific product, or % for ALL products
\prompt 'Enter stock keeping unit number: ' search_sku

SELECT
    p.*, c.category_name
FROM products AS p
    JOIN categories AS c ON p.category_id = c.category_id
WHERE
    p.stock_keeping_unit = :'search_sku'
    AND p.is_activve = TRUE;

-- Search by Barcode
-- Type: 10000000001 for a specific product, or % for ALL products
\prompt 'Enter barcode: ' search_barcode
SELECT
    p.*, c.category_name
FROM products AS p
    JOIN categories AS c ON p.category_id = c.category_id
WHERE
    p.barcode = :'search_barcode'
    AND p.is_activve = TRUE;

-- Search by category_name
-- Type: Groceries, Beverages, Snacks, Personal Care, Household, Clothing, Stationery, Electronics
-- Type: % for ALL categories
\prompt 'Enter category name (or % for ALL categories): ' search_category_name
SELECT
    p.product_id,
    p.product_name,
    p.stock_keeping_unit,
    c.category_name,
    p.selling_price,
    p.quantity_in_stock
FROM products AS p
JOIN categories AS c
ON p.category_id = c.category_id
WHERE c.category_name ILIKE :'search_category_name'
AND p.is_activve = TRUE
ORDER BY c.category_name, p.product_name;

INSERT INTO
    products (
        product_name,
        stock_keeping_unit,
        barcode,
        category_id,
        description,
        unit_of_measure,
        purchase_price,
        selling_price,
        quantity_in_stock,
        reorder_level
    )
VALUES (
        'Sugar 1kg',
        'SKU021',
        '100000000021',
        1,
        '1kg bag of granulated sugar',
        'bag',
        1800.00,
        2300.00,
        15,
        5
    ) RETURNING product_id,
    product_name,
    stock_keeping_unit;

-- Update stock quantities (manual adjustment)
BEGIN;

UPDATE products
SET
    quantity_in_stock = 25
WHERE
    stock_keeping_unit = 'SKU001' RETURNING product_id,
    product_name,
    stock_keeping_unit,
    quantity_in_stock;
-- Record stock adjustment
INSERT INTO
    stock_movements (
        product_id,
        movement_type,
        quantity,
        notes
    )
VALUES (
        1,
        'adjustment_out',
        2,
        'Physical stock count adjustment: 2 bags missing'
    ) RETURNING *;

COMMIT;

SELECT p.product_name, p.quantity_in_stock, sm.movement_type, sm.quantity, sm.notes
FROM
    products AS p
    JOIN stock_movements AS sm ON p.product_id = sm.product_id
WHERE
    p.stock_keeping_unit = 'SKU001'
ORDER BY sm.movement_id DESC;

-- Deactivating a product (soft delete)
UPDATE products
SET
    is_active = FALSE
WHERE
    stock_keeping_unit = 'SKU016';

-- Verifying the deactivation
SELECT
    product_name,
    stock_keeping_unit,
    is_active
FROM products
WHERE
    stock_keeping_unit = 'SKU016';

-- Deleting a product (hard delete)
SELECT
    p.product_id,
    p.product_name,
    p.stock_keeping_unit,
    EXISTS (
        SELECT 1
        FROM purchase_items AS pi
        WHERE
            pi.product_id = p.product_id
    ) AS has_purchases,
    EXISTS (
        SELECT 1
        FROM sale_items AS si
        WHERE
            si.product_id = p.product_id
    ) AS has_sales,
    EXISTS (
        SELECT 1
        FROM stock_movements AS sm
        WHERE
            sm.product_id = p.product_id
    ) AS has_movements
FROM products AS p
WHERE
    p.stock_keeping_unit = 'SKU021';

DELETE FROM products WHERE stock_keeping_unit = 'SKU021';