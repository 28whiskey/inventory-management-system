SELECT 'categories' AS table_name, COUNT(*)
FROM categories
UNION ALL
SELECT 'suppliers', COUNT(*)
FROM suppliers
UNION ALL
SELECT 'products', COUNT(*)
FROM products
UNION ALL
SELECT 'purchases', COUNT(*)
FROM purchases
UNION ALL
SELECT 'purchase_items', COUNT(*)
FROM purchase_items
UNION ALL
SELECT 'sales', COUNT(*)
FROM sales
UNION ALL
SELECT 'sale_items', COUNT(*)
FROM sale_items
UNION ALL
SELECT 'stock_movements', COUNT(*)
FROM stock_movements;