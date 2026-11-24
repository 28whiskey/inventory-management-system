- =
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(30),
    email VARCHAR(150),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    stock_keeping_unit VARCHAR(50) NOT NULL UNIQUE,
    barcode VARCHAR(100) UNIQUE,
    category_id INTEGER NOT NULL,
    description TEXT,
    unit_of_measure VARCHAR(30) DEFAULT 'piece',
    purchase_price NUMERIC(12, 2) NOT NULL CHECK (purchase_price >= 0),
    selling_price NUMERIC(12, 2) NOT NULL CHECK (selling_price >= 0),
    quantity_in_stock INTEGER NOT NULL DEFAULT 0 CHECK (quantity_in_stock >= 0),
    reorder_level INTEGER NOT NULL DEFAULT 5 CHECK (reorder_level >= 0),
    is_activve BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE RESTRICT
);

CREATE TABLE purchases (
    purchase_id SERIAL PRIMARY KEY,
    supplier_id INTEGER NOT NULL,
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'draft',
    CHECK (
        status IN (
            'draft',
            'received',
            'cancelled'
        )
    ),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_purchase_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id) ON DELETE RESTRICT
);

CREATE TABLE purchase_items (
    purchase_item_id SERIAL PRIMARY KEY,
    purchase_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_cost NUMERIC(12, 2) NOT NULL CHECK (unit_cost >= 0),
    CONSTRAINT fk_purchase_item_purchase FOREIGN KEY (purchase_id) REFERENCES purchases (purchase_id) ON DELETE CASCADE,
    CONSTRAINT fk_purchase_item_product FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE RESTRICT,
    CONSTRAINT unique_purchase_product UNIQUE (purchase_id, product_id)
);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer_name VARCHAR(150),
    status VARCHAR(20) NOT NULL DEFAULT 'draft' CHECK (
        status IN ('draft', 'completed', 'void')
    ),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sale_items (
    sale_item_id SERIAL PRIMARY KEY,
    sale_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12, 2) NOT NULL CHECK (unit_price >= 0),
    CONSTRAINT fk_sale_item_sale FOREIGN KEY (sale_id) REFERENCES sales (sale_id) ON DELETE CASCADE,
    CONSTRAINT fk_sale_item_product FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE RESTRICT,
    CONSTRAINT unique_sale_product UNIQUE (sale_id, product_id)
);

CREATE TABLE stock_movements (
    movement_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    movement_type VARCHAR(20) NOT NULL CHECK (
        movement_type IN (
            'purchase',
            'sale',
            'adjustment_in',
            'adjustment_out'
        )
    ),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    purchase_item_id INTEGER UNIQUE,
    sale_item_id INTEGER UNIQUE,
    notes TEXT,
    movement_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_movement_product FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE RESTRICT,
    CONSTRAINT fk_movement_purchase_item FOREIGN KEY (purchase_item_id) REFERENCES purchase_items (purchase_item_id) ON DELETE RESTRICT,
    CONSTRAINT valid_movement_reference CHECK (
        (
            movement_type = 'purchase'
            AND purchase_item_id IS NOT NULL
            AND sale_item_id IS NULL
        )
        OR (
            movement_type = 'sale'
            AND sale_item_id IS NOT NULL
            AND purchase_item_id IS NULL
        )
        OR (
            movement_type IN (
                'adjustment_in',
                'adjustment_out'
            )
            AND purchase_item_id IS NULL
            AND sale_item_id IS NULL
            AND notes IS NOT NULL
        )
    )
);

CREATE INDEX idx_products_category ON products (category_id);

CREATE INDEX idx_products_name ON products (product_name);

CREATE INDEX idx_purchases_supplier ON purchases (supplier_id);

CREATE INDEX idx_purchases_date ON purchases (purchase_date);

CREATE INDEX idx_sales_date ON sales (sale_date);

CREATE INDEX idx_purchase_items_product ON purchase_items (product_id);

CREATE INDEX idx_sale_items_product ON sale_items (product_id);

CREATE INDEX idx_stock_movements_product ON stock_movements (product_id);

CREATE INDEX idx_stock_movements_date ON stock_movements (movement_date);

CREATE OR REPLACE FUNCTION update_modified_timestamp()
RETURNS TRIGGER AS $$
BEGIN
      NEW.updated_at = CURRENT_TIMESTAMP;
      RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_products_updated_at
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION update_modified_timestamp();

SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column
FROM
    information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
    AND tc.constraint_schema = kcu.constraint_schema
    JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
    AND ccu.constraint_schema = tc.constraint_schema
WHERE
    tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema = 'public'
ORDER BY tc.table_name;