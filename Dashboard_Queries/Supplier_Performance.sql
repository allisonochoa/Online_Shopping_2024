--Top 10 Suppliers by Volume--
SELECT
    suppliers.supplier_name,
    COUNT(DISTINCT products.product_id) AS number_of_products_per_supplier
FROM
    suppliers
INNER JOIN
    products ON products.supplier_id = suppliers.supplier_id
GROUP BY
    suppliers.supplier_name
ORDER BY
    number_of_products_per_supplier DESC
LIMIT
    10;

--Best Supplier per Category by Volume--
WITH supplier_category_counts AS (
    SELECT
        products.category,
        suppliers.supplier_name,
        COUNT(products.product_id) AS product_count,
        ROW_NUMBER() OVER (
            PARTITION BY products.category
            ORDER BY COUNT(products.product_id) DESC
        ) AS rank
    FROM
        products
    INNER JOIN
        suppliers ON suppliers.supplier_id = products.supplier_id
    GROUP BY
        products.category,
        suppliers.supplier_name
)

SELECT
    category,
    supplier_name,
    product_count
FROM    
    supplier_category_counts
WHERE
    rank = 1;

--Best Supplier per Category by Revenue--
WITH revenue_per_supplier AS (
    SELECT
        products.category,
        suppliers.supplier_name,
        SUM(products.price * order_items.quantity) AS revenue,
        ROW_NUMBER() OVER (
            PARTITION BY products.category
            ORDER BY SUM(products.price * order_items.quantity) DESC
        ) AS rank
    FROM
        order_items
    INNER JOIN products ON order_items.product_id = products.product_id
    INNER JOIN suppliers ON products.supplier_id = suppliers.supplier_id
    GROUP BY
        products.category,
        suppliers.supplier_name
)
SELECT
    category,
    supplier_name,
    revenue
FROM
    revenue_per_supplier
WHERE
    rank = 1;

--Best Suppliers by Revenue--
SELECT
    suppliers.supplier_name,
    SUM(products.price * order_items.quantity) AS Revenue
FROM
    products
INNER JOIN
    order_items ON order_items.product_id = products.product_id
INNER JOIN
    suppliers ON suppliers.supplier_id = products.supplier_id
GROUP BY
    suppliers.supplier_name
ORDER BY
    Revenue DESC;
