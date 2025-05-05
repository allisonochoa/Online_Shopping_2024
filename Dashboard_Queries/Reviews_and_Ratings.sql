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
        p.product_name,
        p.product_id,
        SUM(oi.quantity) AS total_quantity
    FROM
        order_items oi
    JOIN
        products p ON p.product_id = oi.product_id
    GROUP BY
        p.product_id, p.product_name
),
product_reviews AS (
    SELECT
        p.product_name,
        AVG(r.rating) AS average_rating
    FROM
        products p
    JOIN
        reviews r ON r.product_id = p.product_id
    GROUP BY
        p.product_name
)

SELECT
    ps.product_name,
    SUM(ps.total_quantity) AS total_quantity,
    ROUND(pr.average_rating, 0) AS average_rating
FROM
    product_sales ps
LEFT JOIN
    product_reviews pr ON ps.product_name = pr.product_name
GROUP BY
    ps.product_name, pr.average_rating
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