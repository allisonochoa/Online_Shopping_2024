--AVG Product Rating--
SELECT
    AVG(rating)
FROM
    reviews;

--Top 10 Products by Rating--
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
    10;

--Top 10 Best Selling Products AVG Rating (by volume)--
WITH product_sales AS (
    SELECT
        products.product_name,
        products.product_id,
        SUM(order_items.quantity) AS total_quantity
    FROM
        order_items
    JOIN
        products
        ON products.product_id = order_items.product_id
    GROUP BY
        products.product_id, products.product_name
),
product_reviews AS (
    SELECT
        products.product_name,
        AVG(reviews.rating) AS average_rating
    FROM
        products
    JOIN
        reviews
        ON reviews.product_id = products.product_id
    GROUP BY
        products.product_name
)

SELECT
    product_sales.product_name,
    SUM(product_sales.total_quantity) AS total_quantity,
    ROUND(product_reviews.average_rating, 0) AS average_rating
FROM
    product_sales
LEFT JOIN
    product_reviews
    ON product_sales.product_name = product_reviews.product_name
GROUP BY
    product_sales.product_name, product_reviews.average_rating
ORDER BY
    total_quantity DESC
LIMIT 10;

--Avg Category Rating--
SELECT
    products.category,
    AVG(reviews.rating) AS average_rating
FROM
    reviews
INNER JOIN
    products ON products.product_id = reviews.product_id
GROUP BY
    products.category;