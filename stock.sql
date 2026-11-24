SELECT p.product_name, sm.movement_type, sm.quantity, sm.notes, sm.movement_date
FROM
    stock_movements AS sm
    JOIN products AS p ON sm.product_id = p.product_id
ORDER BY sm.movement_id;