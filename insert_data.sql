BEGIN;

INSERT INTO
    categories (category_name, description)
VALUES (
        'Groceries',
        'Food and everyday grocery products'
    ),
    (
        'Beverages',
        'Drinks and bottled beverages'
    ),
    (
        'Personal Care',
        'Personal hygiene and grooming products'
    ),
    (
        'Household',
        'Household cleaning and maintenance products'
    ),
    (
        'Electronics',
        'Electronic devices and accessories'
    ),
    (
        'Stationery',
        'Office and writing materials'
    ),
    (
        'Clothing',
        'Fashion and clothing products'
    ),
    (
        'Snacks',
        'Packaged snacks and confectionery'
    ) ON CONFLICT (category_name) DO NOTHING;

INSERT INTO
    suppliers (
        supplier_name,
        contact_person,
        phone,
        email,
        address
    )
VALUES (
        'FoodForge Distributors',
        'Angela Adeniyi',
        '08012345678',
        'foodforge@example.com',
        'Akure, Nigeria'
    ),
    (
        'Famex Distrbutors',
        'Stella Famileyin',
        '09012345678',
        'famexbeverages@example.com',
        'Akure, Nigeria'
    ),
    (
        'Lookesector',
        'Ajayi Oluwatimilehin',
        '02112345678',
        'looksector123@example.com',
        'Lagos, Nigeria'
    ),
    (
        'Cleanhome ltd',
        'Grace James',
        '09112345678',
        'cleanhomes@example.com',
        'Abuja, Nigeria'
    ),
    (
        'Rayray Inc',
        'Deborah Adeniyi',
        '07012345678',
        'msrayray@examples.com',
        'Lagos, Nigeria'
    ) ON CONFLICT DO NOTHING;

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
        'Rice 5kg',
        'SKU001',
        '10000000001',
        1,
        '5kg bag of rice',
        'bag',
        8500.00,
        10500.00,
        27,
        5
    ),
    (
        'Cooking oil 1L',
        'SKU002',
        '10000000002',
        1,
        '1 litre of cooking oil',
        'bottle',
        2500.00,
        3700.00,
        18,
        5
    ),
    (
        'Mineral Water Pack',
        'SKU003',
        '10000000003',
        2,
        'Pack of bottled water',
        'pack',
        1200.00,
        2000.00,
        21,
        5
    ),
    (
        'Soft Drinks',
        'SKU004',
        '10000000004',
        2,
        'Can of soft drinks',
        'can',
        600.00,
        1000.00,
        14,
        5
    ),
    (
        'Bathing Soap',
        'SKU005',
        '10000000005',
        3,
        'Standard bathing soap',
        'piece',
        500.00,
        900.00,
        8,
        5
    ),
    (
        'Toothpaste',
        'SKU006',
        '10000000006',
        3,
        'Toothpase tube',
        'tube',
        700.00,
        1100.00,
        9,
        5
    ),
    (
        'Detergent',
        'SKU007',
        '10000000007',
        4,
        'Laundry detergent',
        'pack',
        1500.00,
        2000.00,
        0,
        5
    ),
    (
        'Bleach',
        'SKU008',
        '10000000008',
        4,
        'Household bleach',
        'bottle',
        900.00,
        1500.00,
        0,
        5
    ),
    (
        'USB cable',
        'SKU009',
        '10000000009',
        5,
        'USB charging cable',
        'piece',
        1300.00,
        1800.00,
        0,
        5
    ),
    (
        'Phone Charger',
        'SKU010',
        '10000000010',
        5,
        'Phone charging adapter',
        'piece',
        3500.00,
        4500.00,
        0,
        5
    ),
    (
        'Exercise book',
        'SKU011',
        '10000000011',
        6,
        'A4 size exercise book',
        'piece',
        300.00,
        500.00,
        0,
        5
    ),
    (
        'Ballpoint Pen',
        'SKU012',
        '10000000012',
        6,
        'Blue ink ballpoint pen',
        'piece',
        150.00,
        300.00,
        0,
        5
    ),
    (
        'T-shirt',
        'SKU013',
        '10000000013',
        7,
        'Cotton T-shirt',
        'piece',
        2000.00,
        3500.00,
        0,
        5
    ),
    (
        'Jeans',
        'SKU014',
        '10000000014',
        7,
        'Denim jeans',
        'piece',
        4000.00,
        6000.00,
        0,
        5
    ),
    (
        'Chips Pack',
        'SKU015',
        '10000000015',
        8,
        'Pack of potato chips',
        'pack',
        500.00,
        800.00,
        0,
        5
    ),
    (
        'Chocolate Bar',
        'SKU016',
        '10000000016',
        8,
        'Milk chocolate bar',
        'piece',
        300.00,
        500.00,
        0,
        5
    ),
    (
        'Milk powder',
        'SKU017',
        '10000000017',
        8,
        'Tin of milk powder',
        'tin',
        1200.00,
        1800.00,
        0,
        5
    ),
    (
        'Coffee Beans',
        'SKU018',
        '10000000018',
        2,
        'Pack of coffee beans',
        'pack',
        1500.00,
        2500.00,
        0,
        5
    ),
    (
        'Shampoo',
        'SKU019',
        '10000000019',
        3,
        'Hair shampoo bottle',
        'bottle',
        1200.00,
        2000.00,
        0,
        5
    ),
    (
        'Conditioner',
        'SKU020',
        '10000000020',
        3,
        'Hair conditioner bottle',
        'bottle',
        1300.00,
        2100.00,
        0,
        5
    ) ON CONFLICT (barcode) DO NOTHING;

INSERT INTO
    purchases (supplier_id, status, notes)
VALUES (
        1,
        'received',
        'First purchase from FoodForge Distributors'
    ),
    (
        2,
        'received',
        'First purchase from Famex Distributors'
    ),
    (
        3,
        'received',
        'First purchase from Lookesector'
    ),
    (
        4,
        'received',
        'First purchase from Cleanhome ltd'
    ),
    (
        5,
        'received',
        'First purchase from Rayray Inc'
    ) ON CONFLICT DO NOTHING;

INSERT INTO
    purchase_items (
        purchase_id,
        product_id,
        quantity,
        unit_cost
    )
VALUES (1, 1, 30, 8500.00),
    (1, 2, 20, 2200.00),
    (2, 3, 25, 1200.00),
    (2, 4, 15, 350.00),
    (3, 5, 10, 450.00),
    (3, 6, 12, 800.00),
    (4, 7, 20, 1500.00),
    (4, 8, 15, 2500.00),
    (5, 9, 10, 1200.00),
    (5, 10, 12, 2000.00) ON CONFLICT DO NOTHING;

INSERT INTO
    sales (customer_name, status, notes)
VALUES (
        'Walk-in Customer',
        'completed',
        'Initial sample sale'
    ),
    (
        'John Doe',
        'completed',
        'First sale to John Doe'
    ),
    (
        'Jane Smith',
        'completed',
        'First sale to Jane Smith'
    ),
    (
        'Michael Johnson',
        'completed',
        'First sale to Michael Johnson'
    ),
    (
        'Emily Davis',
        'completed',
        'First sale to Emily Davis'
    ) ON CONFLICT DO NOTHING;

INSERT INTO
    sale_items (
        sale_id,
        product_id,
        quantity,
        unit_price
    )
VALUES (1, 1, 3, 10500.00),
    (1, 2, 2, 2800.00),
    (2, 3, 4, 1500.00),
    (2, 4, 1, 500.00),
    (3, 5, 2, 650.00),
    (3, 6, 3, 1100.00) ON CONFLICT DO NOTHING;

INSERT INTO
    stock_movements (
        product_id,
        movement_type,
        quantity,
        purchase_item_id,
        notes
    )
VALUES (
        1,
        'purchase',
        30,
        1,
        'Received 30 bags of Rice'
    ),
    (
        2,
        'purchase',
        20,
        2,
        'Received 20 bottles of cooking oil'
    ),
    (
        3,
        'purchase',
        25,
        3,
        'Received 25 packs of water'
    ),
    (
        4,
        'purchase',
        15,
        4,
        'Received 15 bottles of soft drink'
    ),
    (
        5,
        'purchase',
        10,
        5,
        'Received 10 bathing soaps'
    ),
    (
        6,
        'purchase',
        12,
        6,
        'Received 12 tubes of toothpaste'
    ) ON CONFLICT DO NOTHING;

INSERT INTO
    stock_movements (
        product_id,
        movement_type,
        quantity,
        sale_item_id,
        notes
    )
VALUES (
        1,
        'sale',
        3,
        1,
        'Sold 3 bags of rice'
    ),
    (
        2,
        'sale',
        2,
        2,
        'Sold 2 bottles of cooking oil'
    ),
    (
        3,
        'sale',
        4,
        3,
        'Sold 4 packs of water'
    ),
    (
        4,
        'sale',
        1,
        4,
        'Sold 1 bottle of soft drink'
    ),
    (
        5,
        'sale',
        2,
        5,
        'Sold 2 bathing soaps'
    ),
    (
        6,
        'sale',
        3,
        6,
        'Sold 3 tubes of toothpaste'
    ) ON CONFLICT DO NOTHING;

COMMIT;