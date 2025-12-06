CREATE DATABASE SalesDB;
create schema sales_schema;
set search_path to sales_schema;

-- Bảng khách hàng
CREATE TABLE Customers
(
    CustomerID   serial PRIMARY KEY,
    CustomerName VARCHAR(100),
    City         VARCHAR(50),
    Country      VARCHAR(50)
);

-- Bảng nhân viên
CREATE TABLE Employees
(
    EmployeeID   serial PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department   VARCHAR(50)
);

-- Bảng sản phẩm
CREATE TABLE Products
(
    ProductID   serial PRIMARY KEY,
    ProductName VARCHAR(100),
    Category    VARCHAR(50),
    Price       DECIMAL(10, 2)
);

-- Bảng đơn hàng
CREATE TABLE Orders
(
    OrderID    serial PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate  DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

-- Bảng chi tiết đơn hàng
CREATE TABLE OrderDetails
(
    OrderDetailID serial PRIMARY KEY,
    OrderID       INT,
    ProductID     INT,
    Quantity      INT,
    FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);

-- Dữ liệu mẫu
INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Nguyen Van A', 'Hanoi', 'Vietnam'),
       ('Tran Thi B', 'HCM', 'Vietnam'),
       ('Le Van C', 'Da Nang', 'Vietnam'),
       ('Pham Thi D', 'Hue', 'Vietnam'),
       ('Hoang Van E', 'Hai Phong', 'Vietnam'),
       ('Do Thi F', 'Can Tho', 'Vietnam'),
       ('Nguyen Van G', 'Hanoi', 'Vietnam'),
       ('Tran Van H', 'HCM', 'Vietnam'),
       ('Le Thi I', 'Da Nang', 'Vietnam'),
       ('Pham Van J', 'Hue', 'Vietnam');

INSERT INTO Employees (EmployeeName, Department)
VALUES ('Nguyen Van K', 'Sales'),
       ('Tran Van L', 'Support'),
       ('Le Thi M', 'Sales'),
       ('Pham Van N', 'IT'),
       ('Hoang Thi O', 'Sales');

INSERT INTO Products (ProductName, Category, Price)
VALUES ('Laptop', 'Electronics', 1200),
       ('Phone', 'Electronics', 800),
       ('Tablet', 'Electronics', 600),
       ('Desktop', 'Electronics', 1500),
       ('Monitor', 'Electronics', 300),
       ('Desk', 'Furniture', 200),
       ('Chair', 'Furniture', 100),
       ('Bookshelf', 'Furniture', 250),
       ('Printer', 'Office', 400),
       ('Scanner', 'Office', 350);

INSERT INTO Orders (CustomerID, EmployeeID, OrderDate)
VALUES (1, 1, '2025-11-01'),
       (2, 1, '2025-11-02'),
       (3, 2, '2025-11-03'),
       (4, 3, '2025-11-04'),
       (5, 4, '2025-11-05'),
       (6, 5, '2025-11-06'),
       (7, 1, '2025-11-07'),
       (8, 2, '2025-11-08'),
       (9, 3, '2025-11-09'),
       (10, 4, '2025-11-10');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES (1, 1, 2),   -- Laptop
       (1, 2, 1),   -- Phone
       (2, 3, 3),   -- Tablet
       (2, 6, 2),   -- Desk
       (3, 4, 1),   -- Desktop
       (3, 7, 5),   -- Chair
       (4, 5, 2),   -- Monitor
       (4, 8, 1),   -- Bookshelf
       (5, 9, 4),   -- Printer
       (5, 10, 2),  -- Scanner
       (6, 2, 5),   -- Phone
       (6, 3, 2),   -- Tablet
       (7, 1, 1),   -- Laptop
       (7, 7, 10),  -- Chair
       (8, 4, 2),   -- Desktop
       (8, 6, 3),   -- Desk
       (9, 5, 4),   -- Monitor
       (9, 9, 1),   -- Printer
       (10, 10, 5), -- Scanner
       (10, 8, 2);
-- Bookshelf
--Liệt kê tất ất cả đơn hàng cùng tên khách hàng.
SELECT o.OrderID, c.CustomerName
FROM Orders o
         JOIN Customers c ON o.CustomerID = c.CustomerID;
--Liệt kê đơn hàng kèm tên nhân viên xử lý.
SELECT o.OrderID,
       e.EmployeeName
FROM Orders o
         JOIN Employees e ON o.EmployeeID = e.EmployeeID;
--Liệt kê chi tiết ết đơn hàng (OrderID, ProductName, Quantity).
SELECT od.OrderID,
       p.ProductName,
       od.Quantity
FROM OrderDetails od
         JOIN Products p ON od.ProductID = od.ProductID;

--Liệt kê khách hàng và sản phẩm họ đã mua.
SELECT c.*,
       p.ProductName,
       od.Quantity,
       p.Price
From Customers c
         JOIN Orders o on c.CustomerID = o.CustomerID
         Join OrderDetails od on o.OrderID = od.OrderID
         Join Products p on od.ProductID = p.ProductID;

--5. Liệt kê nhân viên và khách hàng mà họ phục vụ.

SELECT e.EmployeeName, c.CustomerName
FROM Employees e
         JOIN Orders O on e.EmployeeID = O.EmployeeID
         Join Customers C on O.CustomerID = C.CustomerID;
-- 6. Liệt kê khách hàng ở Hà Nội và sản phẩm họ mua.

SELECT c.*,
       p.ProductName,
       od.Quantity,
       p.Price
From Customers c
         JOIN Orders o on c.CustomerID = o.CustomerID
         Join OrderDetails od on o.OrderID = od.OrderID
         Join Products p on od.ProductID = p.ProductID
Where c.city = 'Hanoi';

-- 7. Liệt kê tất ất cả đơn hàng cùng tên khách hàng và nhân viên.
SELECT o.OrderID,
       c.CustomerName,
       e.EmployeeName,
       o.OrderDate
FROM Orders o
         JOIN Customers c ON o.CustomerID = c.CustomerID
         JOIN Employees e ON o.EmployeeID = e.EmployeeID;

-- 8. Liệt kê sản phẩm và số lượng bán ra trong từng đơn hàng.
SELECT od.OrderID,
       p.ProductName,
       od.quantity
FROM OrderDetails od
         JOIN Products p ON od.ProductID = p.ProductID
ORDER BY od.OrderID;

-- 9. Liệt kê khách hàng và số lượng sản phẩm họ đã mua.
SELECT c.*, od.Quantity
From Customers c
         Join Orders o on c.CustomerID = o.CustomerID
         join OrderDetails od on o.OrderID = od.OrderID;
-- 10. Liệt kê nhân viên và tổng số đơn hàng họ xử lý.
SELECT e.*, count(o.OrderID)
FROM Employees e
         Join Orders o on e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID;

--HAM TO HOP (SUM, COUNT, MIN, MAX)
Select count(ProductID), min(Price), max(price), avg(price), sum(price)
from Products;

SELECT city, count(CustomerID)
From Customers
GROUP BY city;

--Tinh tong so luong san pham da ban ra theo tung san pham
SELECT p.ProductID, p.productname, sum(Quantity)
FROM OrderDetails od
         join Products p on od.ProductID = p.ProductID
GROUP BY p.ProductID
Order by p.ProductID;

--HAVING: Xu li dieu kien tung nhom
--Loc ra 2 thanh pho co tu 2 khach hang tro len
SELECT city, count(CustomerID)
From Customers c
GROUP BY city
HAVING count(CustomerID) >= 2;

--1. Tính tổng số lượng sản phẩm bán ra theo từng sản phẩm.
SELECT p.ProductName, sum(od.Quantity)
From Products p
         JOIN OrderDetails OD on p.ProductID = OD.ProductID
GROUP BY p.ProductName;

-- 2. Tính tổng doanh thu theo từng sản phẩm.
SELECT p.ProductName, sum(od.Quantity * p.Price)
From Products p
         Join OrderDetails OD on p.ProductID = OD.ProductID
GROUP BY p.ProductName;

-- 3. Tính tổng doanh thu theo từng khách hàng.
SELECT c.CustomerName,
       SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Customers c
         JOIN Orders o ON c.CustomerID = o.CustomerID
         JOIN OrderDetails od ON o.OrderID = od.OrderID
         JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;

-- 4. Tính tổng doanh thu theo từng nhân viên.
SELECT e.EmployeeName,
       SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Employees e
         JOIN Orders o ON e.EmployeeID = o.EmployeeID
         JOIN OrderDetails od ON o.OrderID = od.OrderID
         JOIN Products p ON od.ProductID = p.ProductID
GROUP BY e.EmployeeName
ORDER BY TotalRevenue DESC;

-- 5. Liệt kê sản phẩm có doanh thu > 1000.
SELECT p.ProductName,
       sum(od.Quantity * p.Price) As Revunue
From Products p
         LEFT JOIN OrderDetails OD on p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING sum(od.Quantity * p.Price) > 1000
Order by Revunue DESC;

-- 6. Liệt kê khách hàng có tổng số lượng mua > 5.

SELECT c.CustomerName, SUM(od.Quantity) TotalQuantity
From Customers c
         LEFT JOIN Orders O on c.CustomerID = O.CustomerID
         JOIN OrderDetails OD on O.OrderID = OD.OrderID
group by c.CustomerName
HAVING SUM(od.Quantity) > 5
ORDER BY TotalQuantity DESC;

-- 7. Liệt kê nhân viên có doanh thu trung bình > 500.
SELECT e.EmployeeName,
       AVG(order_revenue.total_amount) AS AvgRevenue
FROM Employees e
         JOIN Orders o ON e.EmployeeID = o.EmployeeID
         JOIN (SELECT od.OrderID,
                      SUM(od.Quantity * p.Price) AS total_amount
               FROM OrderDetails od
                        JOIN Products p ON od.ProductID = p.ProductID
               GROUP BY od.OrderID) AS order_revenue
              ON o.OrderID = order_revenue.OrderID
GROUP BY e.EmployeeName
HAVING AVG(order_revenue.total_amount) > 500
ORDER BY AvgRevenue DESC;

-- 8. Liệt kê thành phố có nhiều khách hàng nhất.
SELECT City,
       COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY City
ORDER BY TotalCustomers DESC
LIMIT 1;

--9.Liệt kê loại sản phẩm có tổng doanh thu cao nhất
SELECT p.Category,
       SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Products p
         JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.Category
ORDER BY TotalRevenue DESC
LIMIT 1;

--10. Liệt kê khách hàng có nhiều đơn hàng nhất
SELECT c.CustomerName,
       Count(o.OrderID) AS TotalRevenue
FROM Customers c
         JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC
LIMIT 1;

--Subquery
--1. Liệt kê khách hàng có tổng doanh thu lớn hơn trung bình.
SELECT t.CustomerName,
       t.TotalRevenue
FROM (SELECT c.CustomerName,
             SUM(od.Quantity * p.Price) AS TotalRevenue
      FROM Customers c
               JOIN Orders o ON c.CustomerID = o.CustomerID
               JOIN OrderDetails od ON o.OrderID = od.OrderID
               JOIN Products p ON od.ProductID = p.ProductID
      GROUP BY c.CustomerName) AS t
WHERE t.TotalRevenue > (SELECT AVG(customer_revenue)
                        FROM (SELECT SUM(od.Quantity * p.Price) AS customer_revenue
                              FROM Customers c
                                       JOIN Orders o ON c.CustomerID = o.CustomerID
                                       JOIN OrderDetails od ON o.OrderID = od.OrderID
                                       JOIN Products p ON od.ProductID = p.ProductID
                              GROUP BY c.CustomerID) AS sub)
ORDER BY t.TotalRevenue DESC;

--2. Liệt kê sản phẩm có giá cao hơn giá trung bình.
SELECT p.ProductName,
       p.Price
From Products p
WHERE p.Price > (SELECT Avg(Price) from Products);

--3. Liệt kê nhân viên có số đơn hàng nhiều hơn trung bình.
SELECT e.EmployeeName,
       count(o.OrderId) as TotalOrder
FROM Employees e
         join Orders o on e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeName
having count(o.OrderID) > (Select avg(order_count)
                           FROM (Select count(o.OrderID) as order_count
                                 From Employees e
                                          LEFT JOIN Orders o on e.EmployeeID = o.EmployeeID
                                 GROUP BY e.EmployeeID) as sub)
ORDER BY TotalOrder;

-- 4. Liệt kê khách hàng mua nhiều sản phẩm nhất.
SELECT c.CustomerName,
       (SELECT SUM(od.Quantity)
        FROM Orders o
                 JOIN OrderDetails od ON o.OrderID = od.OrderID
        WHERE o.CustomerID = c.CustomerID) AS TotalQuantity
FROM Customers c
ORDER BY TotalQuantity DESC
LIMIT 1;

-- 5. Liệt kê sản phẩm được mua nhiều nhất
SELECT p.ProductName,
       (SELECT SUM(od.Quantity)
        FROM OrderDetails od
        WHERE od.ProductID = p.ProductID) AS TotalQuantity
FROM Products p
ORDER BY TotalQuantity DESC
LIMIT 1;

-- 6. Liệt kê khách hàng có đơn hàng gần nhất.
SELECT c.CustomerName,
       o.OrderID,
       o.OrderDate
FROM Orders o
         JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate = (SELECT MAX(OrderDate)
                     FROM Orders);
-- 7. Liệt kê nhân viên xử lý đơn hàng gần nhất.
SELECT e.EmployeeID,
       o.OrderID,
       o.OrderDate
FROM Orders o
         JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE o.OrderDate = (SELECT MAX(OrderDate)
                     FROM Orders);
-- 8. Liệt kê sản phẩm có số lượng bán ra nhiều hơn sản phẩm "Phone".
SELECT p.ProductName,
       SUM(od.Quantity) TotalQuantity
FROM Products p
         JOIN OrderDetails OD on p.ProductID = OD.ProductID
GROUP BY p.ProductName
HAVING SUM(od.Quantity) > (SELECT SUM(od2.Quantity)
                           FROM Products p
                                    JOIN OrderDetails OD2 on p.ProductID = OD2.ProductID
                           WHERE p.ProductName = 'Phone');
-- 9. Liệt kê khách hàng có tổng số lượng mua nhiều hơn khách hàng "Tran Thi B".
SELECT c.CustomerName,
       SUM(od.Quantity) TotalQuantity
FROM Customers c
         Join Orders O on c.CustomerID = O.CustomerID
         Join OrderDetails OD on O.OrderID = OD.OrderID
GROUP BY c.CustomerName
HAVING SUM(od.Quantity) > (SELECT SUM(od2.Quantity)
                           FROM Customers c
                                    Join Orders O on c.CustomerID = O.CustomerID
                                    Join OrderDetails OD2 on O.OrderID = OD2.OrderID
                           WHERE c.CustomerName = 'Tran Thi B');
-- 10. Liệt kê sản phẩm có giá cao nhất trong từng loại.
SELECT p.*
FROM Products p
WHERE p.price = (SELECT MAX(p2.price)
                 FROM Products p2
                 WHERE p2.category = p.category);

--JOIN nâng cao
--Liệt kê khách hàng chưa từng mua hàng.
SELECT c.*
FROM Customers c
         LEFT JOIN Orders o
                   ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
--Liệt kê nhân viên chưa từng xử lý đơn hàng
SELECT e.*
FROM Employees e
         LEFT JOIN Orders o
                   ON e.EmployeeID = o.EmployeeID
WHERE o.OrderID IS NULL;
--Liệt kê sản phẩm chưa từng được bán.
SELECT p.*
FROM Products p
         LEFT JOIN OrderDetails od
                   ON p.ProductID = od.ProductID
WHERE od.OrderID IS NULL;

-- Liệt kê khách hàng và tổng số sản phẩm họ mua theo từng loại.
SELECT c.CustomerName, p.Category, Sum(od.ProductID) as TotalQuantity
From Customers c
         Join Orders O on c.CustomerID = O.CustomerID
         JOIN OrderDetails OD on O.OrderID = OD.OrderID
         JOIN Products P on OD.ProductID = P.ProductID
GROUP BY c.CustomerName, p.Category
Order by CustomerName, p.Category;

--Liệt kê nhân viên và tổng doanh thu họ mang lại.
Select e.EmployeeName, Sum(od.Quantity * p.Price) as TotalRevenue
From Employees e
         Join Orders O on e.EmployeeID = O.EmployeeID
         Join OrderDetails OD on O.OrderID = OD.OrderID
         JOin Products P on OD.ProductID = P.ProductID
GROUP BY e.EmployeeName
Order by TotalRevenue DESC;

--Liệt kê khách hàng và số lượng đơn hàng theo tháng.
SELECT c.CustomerName,
       EXTRACT(YEAR FROM o.OrderDate)  AS Year,
       EXTRACT(MONTH FROM o.OrderDate) AS Month,
       COUNT(o.OrderID)                AS TotalOrders
FROM Customers c
         JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName, Year, Month
ORDER BY Year, Month, c.CustomerName;
--Liệt kê sản phẩm bán chạy nhất theo từng tháng.
SELECT p.ProductName,
       EXTRACT(YEAR FROM o.OrderDate)  AS Year,
       EXTRACT(MONTH FROM o.OrderDate) AS Month,
       COUNT(o.OrderID)                AS TotalOrders
FROM Products p
         JOIN OrderDetails OD on p.ProductID = OD.ProductID
         Join Orders O on OD.OrderID = O.OrderID
GROUP BY p.ProductName, Year, Month
ORDER BY Year, Month, p.ProductName;
-- Khách hàng mua nhiều loại sản phẩm nhất
WITH customer_category AS (SELECT c.CustomerID,
                                  c.CustomerName,
                                  COUNT(DISTINCT p.Category) AS CategoryCount
                           FROM Customers c
                                    JOIN Orders o ON c.CustomerID = o.CustomerID
                                    JOIN OrderDetails od ON o.OrderID = od.OrderID
                                    JOIN Products p ON od.ProductID = p.ProductID
                           GROUP BY c.CustomerID, c.CustomerName),
     ranked AS (SELECT *,
                       RANK() OVER (ORDER BY CategoryCount DESC) AS rnk
                FROM customer_category)
SELECT CustomerName, CategoryCount
FROM ranked
WHERE rnk = 1;
--  Nhân viên xử lý nhiều khách hàng khác nhau nhất
SELECT e.EmployeeName,
       COUNT(DISTINCT o.CustomerID) AS UniqueCustomers
FROM Employees e
         JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.EmployeeName
HAVING COUNT(DISTINCT o.CustomerID) >= ALL (SELECT COUNT(DISTINCT o2.CustomerID)
                                            FROM Employees e2
                                                     JOIN Orders o2 ON e2.EmployeeID = o2.EmployeeID
                                            GROUP BY e2.EmployeeID);
-- Sản phẩm bán nhiều nhất theo từng nhân viên
SELECT e.EmployeeName,
       p.ProductName,
       SUM(od.Quantity) AS TotalQty
FROM Employees e
         JOIN Orders o ON e.EmployeeID = o.EmployeeID
         JOIN OrderDetails od ON o.OrderID = od.OrderID
         JOIN Products p ON od.ProductID = p.ProductID
GROUP BY e.EmployeeID, e.EmployeeName, p.ProductID, p.ProductName
HAVING SUM(od.Quantity) >= ALL (SELECT SUM(od2.Quantity)
                                FROM Employees e2
                                         JOIN Orders o2 ON e2.EmployeeID = o2.EmployeeID
                                         JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
                                WHERE e2.EmployeeID = e.EmployeeID
                                GROUP BY od2.ProductID)
ORDER BY e.EmployeeName;
