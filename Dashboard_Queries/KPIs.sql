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