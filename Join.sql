SELECT p.product_id, p.product_name, p.stock_keeping_unit, c.category_name, p.purchase_price, p.selling_price, p.quantity_in_stock
FROM products AS p
    JOIN categories AS c ON p.category_id = c.category_id
ORDER BY p.product_id;