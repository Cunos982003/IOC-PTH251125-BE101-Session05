CREATE SCHEMA shop;
SET search_path TO shop;

CREATE TABLE shop.customers (
                                customer_id INT PRIMARY KEY,
                                customer_name VARCHAR(100),
                                city VARCHAR(100)
);

CREATE TABLE shop.orders (
                             order_id INT PRIMARY KEY,
                             customer_id INT,
                             order_date DATE,
                             total_price NUMERIC(10,2),
                             FOREIGN KEY (customer_id) REFERENCES shop.customers(customer_id)
);

CREATE TABLE shop.order_items (
                                  item_id INT PRIMARY KEY,
                                  order_id INT,
                                  product_id INT,
                                  quantity INT,
                                  price NUMERIC(10,2),
                                  FOREIGN KEY (order_id) REFERENCES shop.orders(order_id)
);

INSERT INTO shop.customers VALUES
                               (1, 'Nguyễn Văn A', 'Hà Nội'),
                               (2, 'Trần Thị B', 'Đà Nẵng'),
                               (3, 'Lê Văn C', 'Hồ Chí Minh'),
                               (4, 'Phạm Thị D', 'Hà Nội');

INSERT INTO shop.orders VALUES
                            (101, 1, '2024-12-20', 3000),
                            (102, 2, '2025-01-05', 1500),
                            (103, 1, '2025-02-10', 2500),
                            (104, 3, '2025-02-15', 4000),
                            (105, 4, '2025-03-01', 800);

INSERT INTO shop.order_items VALUES
                                 (1, 101, 1, 2, 1500),
                                 (2, 102, 2, 1, 1500),
                                 (3, 103, 3, 5, 500),
                                 (4, 104, 2, 4, 1000);
--Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng
SELECT c.customer_id, c.customer_name,
       SUM(o.total_price) as total_revunue,
       count(o.order_id) as order_count
    From customers c join Orders o on c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > 2000;
--Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng
SELECT c.customer_id, c.customer_name, SUM(o.total_price) as total_revunue
From customers c join orders o on c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > (SELECT AVG(total_price) from orders)
--Tìm thành phố có tổng doanh thu cao nhất
SELECT
    c.city,
    SUM(o.total_price) AS city_revenue
FROM shop.customers c
         JOIN shop.orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) = (
    SELECT MAX(city_total)
    FROM (
             SELECT SUM(o2.total_price) AS city_total
             FROM shop.customers c2
                      JOIN shop.orders o2 ON c2.customer_id = o2.customer_id
             GROUP BY c2.city
         ) AS sub
);
--Hãy dùng INNER JOIN giữa customers, orders, order_items để hiển thị chi tiết
SELECT c.customer_name, c.city,
       SUM(oi.quantity) as total_product,
      SUM(oi.quantity * oi.price) as total_spent
    From customers c inner join Orders o on c.customer_id=o.customer_id
inner join order_items oi on o.order_id = oi.order_id
GROUP BY c.customer_name, c.city



