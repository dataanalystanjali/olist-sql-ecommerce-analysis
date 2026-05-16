drop table if exists customers;
CREATE TABLE customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT
);
select * from customers;

drop table if exists orders;
CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);
select * from orders;

drop table if exists order_items;
CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2)
);
select * from order_items;

drop table if exists products;
CREATE TABLE products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
select * from products;

drop table if exists payments;
CREATE TABLE payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value NUMERIC(10,2)
);
select * from payments;

drop table if exists sellers;
CREATE TABLE sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(5)
);
select * from sellers;

--KEYS AND RELATIONSHIOPS--

ALTER TABLE customers
ADD PRIMARY KEY (customer_id);
ALTER TABLE orders
ADD PRIMARY KEY (order_id);
ALTER TABLE products
ADD PRIMARY KEY (product_id);
ALTER TABLE sellers
ADD PRIMARY KEY (seller_id);
ALTER TABLE order_items
ADD PRIMARY KEY (order_id, order_item_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);
ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);
ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);
ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_sellers
FOREIGN KEY (seller_id)
REFERENCES sellers(seller_id);
alter table order_items drop constraint fk_orderitems_sellers;

--BASIC QUERIES--

--1.Find total number of customers--
select count (*)
from customers;

--2.Find total number of orders--
select count(*)
from orders;

--3.Find total number of sellers--
select count(*)
from sellers;

--4.Find total revenue generated--
select sum (payment_value) as total_revenue
from payments;

--5.Find average of payment value--
select avg(payment_value) as average_revenue
from payments;

--6.Find all unique order statuses--
select distinct order_status as unique_order_status
from orders;

--7.Find total number of products--
select count(*) from products;

--8.Find top 10 most expensive products--
select * from order_items 
order by price desc limit 10;

--9.Count orders by status--
select order_status,count(*)  from orders 
group by order_status;

--10.Find the number of customers from each state--
select customer_state,count (*) from customers
group by customer_state;









