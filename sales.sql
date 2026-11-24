SELECT sa.sale_id, sa.customer_name, p.product_name, si.quantity, si.unit_price, si.quantity * si.unit_price AS line_total
FROM
    sales AS sa
    JOIN sale_items AS si ON sa.sale_id = si.sale_id
    JOIN products AS p ON si.product_id = p.product_id
ORDER BY sa.sale_id;