--Create Tables--

--customers--
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address TEXT,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

--order_items--
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price_at_purchase DECIMAL(10, 2)
);

--orders--
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    total_price DECIMAL(10, 2)
);

--payment--
CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(20),
    amount DECIMAL(10, 2),
    transaction_status VARCHAR(20)
);

--products--
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    supplier_id INT
);

--reviews--
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT,
    review_text TEXT,
    review_date DATE
);

--shipments--
CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY,
    order_id INT,
    shipment_date DATE,
    carrier VARCHAR(20),
    tracking_number VARCHAR(20),
    delivery_date DATE,
    shipment_status VARCHAR (20)
);

--suppliers--
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact_name VARCHAR(100),
    address TEXT,
    phone_number VARCHAR(20),
    email VARCHAR(100)
);

--Populate Tables--
    --Paste the following into `PSQL Tool`(no need to run here):

\copy table_name FROM '[Path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy customers FROM '[local customers.csv path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy order_items FROM '[local order_items.csv path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy orders FROM '[local orders.csv path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy payment FROM '[local payment.csv path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy products FROM '[local products.csv path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy reviews FROM '[local reviews.csv path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy shipments FROM '[local shipments.csv path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy suppliers FROM '[local suppliers.csv path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

--Tests--
SELECT 
    * 
FROM
    table_name
LIMIT
    10;
