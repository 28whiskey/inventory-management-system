SELECT pu.purchase_id, s.supplier_name, p.product_name, pi.quantity, pi.unit_cost, pi.quantity * pi.unit_cost AS line_total
FROM
    purchases AS pu
    JOIN suppliers AS s ON pu.supplier_id = s.supplier_id
    JOIN purchase_items AS pi ON pu.purchase_id = pi.purchase_id
    JOIN products AS p ON pi.product_id = p.product_id
ORDER BY pu.purchase_id;