SELECT
    p.product_name,
    p.quantity_in_stock AS current_stock,
    COALESCE(
        SUM(
            CASE
                WHEN sm.movement_type IN ('purchase', 'adjustment_in') THEN sm.quantity
                WHEN sm.movement_type IN ('sale', 'adjustment_out') THEN - sm.quantity
            END
        ),
        0
    ) AS net_movement
FROM
    products AS p
    LEFT JOIN stock_movements AS sm ON p.product_id = sm.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.quantity_in_stock
ORDER BY p.product_id;