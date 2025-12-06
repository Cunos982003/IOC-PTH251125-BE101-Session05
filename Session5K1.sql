set search_path to store;
CREATE TABLE products (
                          product_id INT PRIMARY KEY,
                          product_name VARCHAR(100),
                          category VARCHAR(50)
);

CREATE TABLE orders (
                        order_id INT PRIMARY KEY,
                        product_id INT,
                        quantity INT,
                        total_price DECIMAL(10,2),
                        FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO products (product_id, product_name, category) VALUES
                                                              (1, 'Laptop Dell', 'Electronics'),
                                                              (2, 'IPhone 15', 'Electronics'),
                                                              (3, 'Bàn học gỗ', 'Furniture'),
                                                              (4, 'Ghế xoay', 'Furniture');

INSERT INTO orders (order_id, product_id, quantity, total_price) VALUES
                                                                     (101, 1, 2, 2200),
                                                                     (102, 2, 3, 3300),
                                                                     (103, 3, 5, 2500),
                                                                     (104, 4, 4, 1600),
                                                                     (105, 1, 1, 1100);
SELECT p.category,
       SUM(o.total_price) as total_sale,
       SUM(o.quantity) as total_quantity
FROM products p Join orders o on p.product_id = o.product_id
group by p.category
having Sum(o.total_price) > 2000
order by total_sale DESC;
