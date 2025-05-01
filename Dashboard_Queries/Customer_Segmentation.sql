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

--AVG Orders per Customer--
WITH orders_per_customer AS (
    SELECT
        customer_id,
        COUNT (order_id) AS orders_count
    FROM
        orders
    GROUP BY
        customer_id
)

SELECT
    AVG(orders_count)
FROM
    orders_per_customer;

--Top 3 Spending Customers--
SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    SUM(orders.total_price) AS lifetime_order_value
FROM
    customers
INNER JOIN
    orders ON orders.customer_id = customers.customer_id
GROUP BY
    customers.customer_id,
    customers.first_name,
    customers.last_name
ORDER BY
    lifetime_order_value DESC
LIMIT
    3;