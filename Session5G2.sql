CREATE SCHEMA shop1;
SET search_path TO shop1;

Create table customers(
    customer_id SERIAL PRIMARY KEY ,
    customer_name varchar(100),
    city varchar(50)
);

Create table orders(
    order_id SERIAL PRIMARY KEY ,
    customer_id int references customers(customer_id),
    order_date date,
    total_amount NUMERIC(10,2)
);
CREATE TABLE order_items(
    item_id SERIAL PRIMARY KEY ,
    order_id int references orders(order_id),
    product_name varchar(100),
    quantity int,
    price NUMERIC(10,2)
);

--ALIAS
SELECT c.customer_name as Ten_khach,
       o.order_date as Ngay_dat_hang,
       o.total_amount as Tong_tien
    from customers c Join orders o on c.customer_id = o.customer_id
Join order_items oi on o.order_id = oi.order_id;

--Aggregate Functions
SELECT Sum(o.total_amount) as total_revunue,
       AVG(o.total_amount) as avarage_revunue,
       MAX(o.total_amount) as max_revunue,
       MIN(o.total_amount) as min_revunue,
       Count(o.order_id) as count_order
from orders o;
--GROUP/HAVING
SELECT c.city, SUM(o.total_amount) as total_revunue
From customers c join orders o on c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) >10000
--JOIN
SELECT
    c.customer_name,
    o.order_date,
    oi.product_name,
    oi.quantity,
    oi.price
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
         JOIN order_items oi ON o.order_id = oi.order_id;
--Subquery
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(customer_total)
    FROM (
             SELECT SUM(total_amount) AS customer_total
             FROM orders
             GROUP BY customer_id
         ) AS sub
);
--UNION
SELECT city
FROM customers

UNION

SELECT c.city
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id;
--INTERSECT
SELECT city
FROM customers

INTERSECT

SELECT c.city
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id;
