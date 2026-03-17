-----1-----
SELECT O.OrderID, CustomerName, FirstName +' '+ LastName AS 'EmployeeName' , ShipperName,SUM(Price)--*QUANTITY--
FROM Orders O
JOIN Customers C ON C.CustomerID=O.CustomerID
JOIN Employees E ON E.EmployeeID=O.EmployeeID
JOIN OrderDetails OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Shippers S ON S.ShipperID= O.ShipperID
GROUP BY O.OrderID,CustomerName,FirstName,LastName,ShipperName

----2----
SELECT SupplierName, ProductName, CustomerName,SUM(QUANTITY) AS 'TOTAL QUANTITY'
FROM ORDERS O
JOIN Customers C ON C.CustomerID=O.CustomerID
JOIN OrderDetails OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Suppliers S ON S.SupplierID=P.SupplierID
GROUP BY SupplierName, ProductName, CustomerName
ORDER BY CustomerName

---3----
SELECT FirstName +' '+ LastName AS 'EmployeeName'
FROM Employees E
JOIN Orders O ON O.EmployeeID=E.EmployeeID
JOIN OrderDetails OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY FirstName,LastName
HAVING COUNT(DISTINCT C.CategoryID)>2 ---------------------------------------------------

----4----
SELECT CategoryName,SupplierName, SUM(Quantity*Price) AS 'TOTAL'
from Categories C
JOIN Products P ON P.CategoryID=C.CategoryID
JOIN OrderDetails OD ON P.ProductID=OD.ProductID
JOIN Suppliers S ON S.SupplierID=P.SupplierID
GROUP BY CategoryName,SupplierName

----5----
SELECT O.OrderID, OrderDate, CustomerName, ProductName
FROM Orders O
JOIN Customers C ON C.CustomerID=O.CustomerID
JOIN OrderDetails OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE SupplierName=''
---6---

SELECT CustomerName, O.OrderID, ProductName
FROM Customers C
JOIN Orders O ON O.CustomerID=C.CustomerID
JOIN OrderDetails OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE Price> (SELECT AVG(PRICE) FROM Products )----------------------------

----7---
SELECT DISTINCT O.OrderID, COUNT(CategoryName) as 'number of distinct product categories',CustomerName ,FirstName +' '+ LastName AS 'EmployeeName'
from OrderDetails OD
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Customers CU ON CU.CustomerID=O.CustomerID
JOIN Employees E ON E.EmployeeID=O.EmployeeID
GROUP BY O.OrderID,CustomerName,FirstName,LastName
ORDER BY 2 DESC;

---8----
SELECT ShipperName, ProductName, SUM(QUANTITY) as 'total quantity'
FROM Products P
JOIN OrderDetails OD ON OD.ProductID=P.ProductID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Shippers S ON S.ShipperID=O.ShipperID
JOIN Categories C ON C.CategoryID=P.CategoryID
WHERE CategoryName='Beverages'
GROUP BY ShipperName,ProductName

--9---
SELECT CustomerName, CategoryName, SUM(QUANTITY*PRICE) AS 'total amount spent'
FROM Products P
JOIN Categories C ON C.CategoryID=P.CategoryID
JOIN OrderDetails OD ON OD.ProductID=P.ProductID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Customers CU ON CU.CustomerID=O.CustomerID
GROUP BY CustomerName, CategoryName

---10----
SELECT SupplierName, FirstName +' '+ LastName AS 'EmployeeName',SUM(PRICE*QUANTITY) AS 'total revenue'
FROM Suppliers S
JOIN Products P ON P.SupplierID=S.SupplierID
JOIN OrderDetails OD ON OD.ProductID=P.ProductID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Employees E ON E.EmployeeID=O.EmployeeID
GROUP BY SupplierName,FirstName,LastName

--11--
SELECT DISTINCT ProductName, COUNT(DISTINCT CustomerName) AS 'number of unique CustomerName'
FROM Products P
JOIN OrderDetails OD ON OD.ProductID=P.ProductID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Customers C ON C.CustomerID=O.CustomerID
GROUP BY ProductName

---12---
SELECT ShipperName,SUM(Quantity * Price)/COUNT(O.ORDERID) AS 'average order value'
FROM Shippers S
JOIN Orders O ON O.ShipperID=S.ShipperID
JOIN OrderDetails OD ON OD.OrderID= O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
GROUP BY ShipperName

----13----
SELECT FirstName +' '+ LastName AS 'EmployeeName',SUM(Quantity) AS 'total quantity of products'
FROM Employees E
JOIN Orders O ON O.EmployeeID=E.EmployeeID
JOIN OrderDetails OD ON OD.OrderID= O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
GROUP BY FirstName,LastName

-----14----
SELECT CategoryName, SupplierName,SUM(OD.Quantity * Price) as 'revenue'
FROM OrderDetails OD
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
JOIN Suppliers S ON S.SupplierID=P.SupplierID
GROUP BY CategoryName, SupplierName
order by 3 DESC

-----15-----
CREATE TABLE COUNTRY(
CountryID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL
)

ALTER TABLE Employees
ADD CONSTRAINT FK_COUNTRY_EMPLOYEE FOREIGN KEY (CountryID) REFERENCES COUNTRY (CountryID)
ALTER TABLE Customers
ADD CONSTRAINT FK_COUNTRY_Customers FOREIGN KEY (CountryID) REFERENCES COUNTRY (CountryID)

UPDATE Employees
SET CountryID=3
WHERE EmployeeID=4
SELECT* FROM Employees
SELECT FirstName +' '+ LastName AS 'EmployeeName',CustomerName
From Employees E
JOIN COUNTRY C ON C.CountryID=E.CountryID
JOIN Customers CU on CU.CountryID=C.CountryID

----16----
SELECT ProductName
FROM Shippers S
JOIN Orders O ON O.ShipperID=S.ShipperID
JOIN OrderDetails OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
GROUP BY P.ProductName
HAVING COUNT(DISTINCT S.ShipperID) = (SELECT COUNT(*) FROM Shippers);--------------------------------------

-----17----
SELECT CustomerName, ShipperName,SUM(Quantity*Price) AS 'TOTAL'
FROM Shippers S
JOIN Orders O ON O.ShipperID=S.ShipperID
JOIN OrderDetails OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Customers C ON C.CustomerID=O.CustomerID
GROUP BY CustomerName, ShipperName

---18---
SELECT FirstName +' '+ LastName AS 'EmployeeName',CategoryName,COUNT(O.ORDERID) AS 'number of orders'
FROM Employees E
JOIN Orders O ON O.EmployeeID=E.EmployeeID
JOIN OrderDetails OD ON OD.OrderID= O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY FirstName,LastName,CategoryName

---19---
SELECT P1.ProductName AS ProductName1, P2.ProductName AS ProductName2, COUNT(*) AS TimesOrderedTogether------------
FROM OrderDetails OD1-------------------------------------------
JOIN OrderDetails OD2 ON OD1.OrderID = OD2.OrderID AND OD1.ProductID < OD2.ProductID-------------------------
JOIN Products P1 ON OD1.ProductID = P1.ProductID-----------------------------------------
JOIN Products P2 ON OD2.ProductID = P2.ProductID--------------------------
GROUP BY P1.ProductName, P2.ProductName;-------------------

---20--
SELECT S.SupplierName, P.ProductName-----------------------
FROM Products P------------------------
JOIN Suppliers S ON P.SupplierID = S.SupplierID----------------
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID----------------
WHERE OD.ProductID IS NULL;----------------------