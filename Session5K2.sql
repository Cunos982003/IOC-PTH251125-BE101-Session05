set search_path to store;
-- tìm sản phẩm có doanh thu cao nhất trong bảng orders
SELECT p.product_name,
       (Select SUM(o.total_price)
        from orders o
        WHERE p.product_id = o.product_id) as total_revuenue
From products p
Where p.product_id = (
    Select product_id from orders
                      GROUP BY product_id
                      ORDER BY SUM(total_price) DESC
                      LIMIT 1);
--hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
Select p.category, sum(o.total_price) as total_sale
From products p Join orders o on p.product_id = o.product_id
GROUP BY p.category;
-- Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000
SELECT p.category
FROM products p
WHERE p.product_id = (
    SELECT product_id
    FROM orders
    GROUP BY product_id
    ORDER BY SUM(total_price) DESC
    LIMIT 1
)

INTERSECT

SELECT
    p.category
FROM products p
         JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 3000;