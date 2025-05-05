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

--Revenue per Category--
SELECT
    products.category,
    SUM(products.price * order_items.quantity) AS total_revenue
FROM
    order_items
LEFT JOIN
    products ON products.product_id = order_items.product_id
GROUP BY
    products.category
ORDER BY
    total_revenue DESC;

--Order Volume per Category--
SELECT
    category,
    SUM(order_items.quantity) AS average_quantity
FROM
    order_items
INNER JOIN
    products ON products.product_id = order_items.product_id
GROUP BY
    category
ORDER BY
    average_quantity DESC;

--Top 10 Best Selling Products by Volume--
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
    10; 

--Average Order Quantity per Product--
SELECT
    products.product_name,
    AVG(order_items.quantity) AS average_quantity
FROM
    order_items
INNER JOIN
    products ON products.product_id = order_items.product_id
GROUP BY
    products.product_name
ORDER BY
    average_quantity DESC;