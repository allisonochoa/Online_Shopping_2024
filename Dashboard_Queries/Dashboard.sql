--KPIS--
--Total Orders--
SELECT
    COUNT (order_id) AS Total_Orders
FROM
    orders;

--Total Revenue--
SELECT
    SUM(orders.total_price) AS Total_Revenue
FROM
    orders
INNER JOIN
    payment ON payment.order_id = orders.order_id
WHERE
    payment.transaction_status = 'Completed';

--Total Shipments--
SELECT
    COUNT(orders.order_id) AS Shipped_Orders
FROM
    orders
INNER JOIN
    shipments ON shipments.order_id = orders.order_id
WHERE
    shipment_status = 'Delivered'
    OR shipment_status = 'Shipped';

--Average Shipping Time--
SELECT
    AVG (shipments.delivery_date - orders.order_date)
FROM
    shipments
INNER JOIN
    orders
    ON orders.order_id = shipments.order_id
WHERE
    shipments.shipment_status = 'Delivered';

--Average Order Value (AOV)--
SELECT
    AVG (total_price)
FROM
    orders;

--Sales and Revenue--
--Revenue Growth--
SELECT
    order_date,
    SUM(total_price)
FROM
    orders
GROUP BY
    order_date
ORDER BY
    order_date ASC;

--Top 5 Best Selling Products per Quantity--
SELECT
    products.product_name,
    SUM(order_items.quantity) AS total_quantity
FROM
    order_items
INNER JOIN
    products ON products.product_id = order_items.product_id
GROUP BY
    products.product_name
ORDER BY
    total_quantity DESC
LIMIT
    5; 

--Shipment Analysis--
--Order Fullfilment Rate--
SELECT
    CAST(SUM(CASE WHEN shipment_status = 'Delivered' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(order_id) AS order_fulfillment_rate
FROM
    shipments;

--Order Unfullfilment Rate--
SELECT
    CAST(SUM(CASE WHEN shipment_status <> 'Delivered' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(order_id) AS order_unfulfillment_rate
FROM
    shipments;

--Customer Segmentation--
--Customers by State (code)--
SELECT
    RIGHT(address, 2) AS state_code,
    COUNT(DISTINCT customer_id) AS total_customers
FROM
    customers
GROUP BY
    RIGHT(address, 2)
ORDER BY
    total_customers DESC;

--Supplier Performance--
--Top 3 Suppliers by Volume--
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
    3;

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

--Reviews and Ratings--
--AVG Product Rating per Category--
SELECT
    products.category,
    AVG(rating) AS average_rating 
FROM
    reviews
INNER JOIN
    products
    ON products.product_id = reviews.product_id
GROUP BY
    products.category
ORDER BY
    average_rating DESC;

--Top 3 Products by Rating--
SELECT
    products.product_name,
    AVG(reviews.rating) AS average_rating
FROM
    products
INNER JOIN
    reviews ON reviews.product_id = products.product_id
GROUP BY
    products.product_name
ORDER BY
    average_rating DESC
LIMIT
    4; --Since there are 4 products with 5 stars rating--