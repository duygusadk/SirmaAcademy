

ALTER TABLE PRODUCTS
ADD CONSTRAINT FK_PRODUCTS_CATEGORIES FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)


---1-----
SELECT OrderId,OrderDate, CustomerName, Country 
FROM Orders O 
JOIN Customers C ON C.CustomerID=O.CustomerID

---2---
SELECT OrderID, ProductName, Price, Quantity
FROM OrderDetails OD
JOIN Products P ON OD.ProductID=P.ProductID

---3----
SELECT OrderID, OrderDate,ShipperName
FROM Orders O
JOIN Shippers S ON O.ShipperID=S.ShipperID

---4---
SELECT ProductName, CategoryName, Price
FROM Products P
JOIN Categories C ON P.CategoryID=C.CategoryID

---5---
SELECT SupplierName, ProductName, Price
FROM Products P
JOIN Suppliers S ON P.SupplierID=S.SupplierID

---6----

SELECT OD.OrderID, CustomerName,SUM(Quantity) AS 'Total quantity',Sum(Price*Quantity) AS 'Total price'
from Orders O
JOIN OrderDetails OD ON O.OrderID=OD.OrderID
JOIN Customers C ON C.CustomerID=O.CustomerID
Join Products P ON P.ProductID=OD.ProductID
GROUP BY OD.OrderID,CustomerName

---7---
SELECT CustomerName, ProductName, Quantity
from Orders O
JOIN OrderDetails OD ON O.OrderID=OD.OrderID
JOIN Customers C ON C.CustomerID=O.CustomerID
Join Products P ON P.ProductID=OD.ProductID

--8---
SELECT OrderID, OrderDate, ShipperName,  FirstName, LastName
FROM ORDERS O
JOIN Employees E ON E.EmployeeID=O.EmployeeID
JOIN Shippers S ON S.ShipperID=O.ShipperID

--9---
SELECT OrderID, CategoryName, SUM(QUANTITY) AS 'total Quantity'
FROM OrderDetails OD
JOIN Products P ON OD.ProductID=P.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY CategoryName,OrderID

--10---
SELECT CustomerName, OD.OrderID
FROM Orders O
JOIN Customers C ON O.CustomerID=C.CustomerID
JOIN OrderDetails OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE ProductName='Tofu'

--11--
SELECT CategoryName, SupplierName, ProductName
FROM Suppliers S
JOIN Products P ON P.SupplierID=S.SupplierID
JOIN Categories C ON C.CategoryID=P.CategoryID

---12---
SELECT FirstName,LastName, Sum(Price) as 'total sales'
from Orders O
JOIN OrderDetails OD ON O.OrderID=OD.OrderID
JOIN Employees E ON e.EmployeeID=O.EmployeeID
Join Products P ON P.ProductID=OD.ProductID
GROUP BY FirstName,LastName

----13----
SELECT ProductName
FROM Products P
WHERE NOT EXISTS(SELECT ProductID FROM OrderDetails OD WHERE P.ProductID=OD.ProductID )

--14----
SELECT OrderID, OrderDate, CustomerName
FROM Orders O
JOIN Customers C ON C.CustomerID=O.CustomerID
JOIN Shippers S ON S.ShipperID=O.ShipperID
WHERE ShipperName='Speedy Express'

----15----
SELECT CustomerName , OrderID
FROM Orders O
JOIN Customers C ON C.CustomerID=O.CustomerID
WHERE MONTH(OrderDate)=9

---16----
SELECT ProductName, Price
FROM Products P
JOIN Categories C ON P.CategoryID=C.CategoryID
WHERE Price>(SELECT AVG(PRICE) FROM Products WHERE Products.CategoryID=P.CategoryID)


----17---
SELECT O.OrderID
from Orders O
JOIN OrderDetails OD ON O.OrderID=OD.OrderID
Join Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY O.OrderID 
HAVING COUNT(C.CategoryID)>1

---18---
SELECT CustomerName, FirstName+' '+LastName as EmployeeName,OrderID
FROM Employees E
JOIN Orders O ON O.EmployeeID=E.EmployeeID
JOIN Customers C ON C.CustomerID=O.CustomerID

---19---
SELECT SupplierName, ProductName
FROM Suppliers S
JOIN Products P ON P.SupplierID=S.SupplierID
JOIN OrderDetails OD ON OD.ProductID=P.ProductID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Customers C ON C.CustomerID=O.CustomerID
ORDER BY CustomerName