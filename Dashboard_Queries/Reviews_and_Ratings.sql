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

--**Top 10 Best Selling Products AVG Rating (by volume)--
WITH top_selling_products AS (
    SELECT
        products.product_id,
        products.product_name,
        SUM(order_items.quantity) AS total_quantity
    FROM
        products
    INNER JOIN
        order_items ON products.product_id = order_items.product_id
    GROUP BY
        products.product_id, products.product_name
    ORDER BY
        total_quantity DESC
    LIMIT 10
)

SELECT
    top_selling_products.product_name,
    top_selling_products.total_quantity,
    AVG(reviews.rating) AS average_rating
FROM
    top_selling_products
LEFT JOIN
    reviews ON top_selling_products.product_id = reviews.product_id
GROUP BY
    top_selling_products.product_name, top_selling_products.total_quantity
ORDER BY
    top_selling_products.total_quantity DESC;

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