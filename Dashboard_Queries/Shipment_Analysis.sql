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

--Order to Shipment Time--
SELECT 
    (shipments.shipment_date - orders.order_date) AS shipment_days,
    COUNT(orders.order_id)
FROM
    shipments
INNER JOIN
    orders
    ON orders.order_id = shipments.order_id
GROUP BY
    shipment_days
ORDER BY
    shipment_days ASC;

--AVG Order to Shipment Time (days)--
SELECT 
    AVG(shipments.shipment_date - orders.order_date)
FROM
    shipments
INNER JOIN
    orders
    ON orders.order_id = shipments.order_id;