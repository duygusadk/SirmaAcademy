CREATE DATABASE PracticeDB; 
GO
USE PracticeDB;
GO
CREATE TABLE Employees ( 
EmployeeId INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(50),
DateOfBirth DATE,
DepartmentId INT,
Salary DECIMAL(10,2)
);
CREATE TABLE Departments (
DepartmentId INT PRIMARY KEY IDENTITY(1,1), 
DepartmentName NVARCHAR(50)
);
CREATE TABLE Products (
ProductId INT PRIMARY KEY IDENTITY(1,1),
ProductName NVARCHAR(50), 
CategoryId INT,
Price DECIMAL(10,2), 
Stock INT
);
CREATE TABLE Categories ( 
CategoryId INT PRIMARY KEY IDENTITY(1,1), 
CategoryName NVARCHAR(50)
);
 INSERT INTO Departments (DepartmentName) VALUES ('HR'), ('IT'), ('Sales'), ('Marketing');
INSERT INTO Employees (Name, DateOfBirth, DepartmentId, Salary)
VALUES ('John Doe', '1990-06-15', 1, 50000), 
('Jane Smith', '1985-12-22', 2, 70000),
('Alice Brown', '1992-03-10', 3, 45000),
('Bob Johnson', '1988-09-05', 4, 55000);
INSERT INTO Categories (CategoryName)
VALUES ('Electronics'), ( 'Clothing'), ('Home Appliances');
INSERT INTO Products (ProductName, CategoryId, Price, Stock)
VALUES ('Smartphone', 1, 699.99, 50),
('Laptop', 1, 1299.99, 30), 
('T-Shirt', 2, 19.99, 100),
('Vacuum Cleaner', 3, 149.99, 20);

---1----
CREATE FUNCTION GetFullYear(@inputDate DATE)
RETURNS INT
AS
BEGIN
RETURN YEAR(@inputDate)
END

SELECT dbo.GetFullYear(GETDATE());
------------------------------------
CREATE FUNCTION GetAnnualSalary(@INPUT DECIMAL)
RETURNS DECIMAL
BEGIN
RETURN @INPUT* 12
END
SELECT dbo.GetAnnualSalary(5000);
----------------------------
ALTER FUNCTION IsInStock(@INPUT INT)
RETURNS VARCHAR(5)
AS
BEGIN
DECLARE @Stock INT;
 select @Stock=Stock from Products where ProductId=@INPUT;

 RETURN CASE WHEN @Stock > 0 THEN 'TRUE' ELSE 'FALSE' end;
END
SELECT dbo.IsInStock(1);
------------------------------------
alter FUNCTION GetDiscountPrice(@inputPrice decimal(5,2),@percent decimal(5,2))
returns decimal(5,2)
begin
return @inputprice-@inputprice*@percent/100

end
SELECT dbo.GetDiscountPrice(699.99, 10);
-----3-----
Alter FUNCTION GetEmployeesByDepartment(@DeptID INT)
returns table
as
RETURN(
SELECT * FROM Employees
WHERE DepartmentId=@DeptID
)
SELECT * FROM dbo. GetEmployeesByDepartment(2);
---------------------------
CREATE FUNCTION GetProductsByCategory(@CatID int)
returns TABLE
AS
RETURN(
SELECT * FROM Products
WHERE CategoryId=@CatID
)
SELECT * FROM dbo. GetProductsByCategory(1);
----------------------------
CREATE FUNCTION GetAffordableProducts(@MaxPrice DECIMAL)
RETURNS TABLE
AS
RETURN(
SELECT * FROM Products
WHERE Price<@MaxPrice
)
SELECT * FROM dbo.GetAffordableProducts(100);
--------------------------
CREATE FUNCTION GetDepartmentsWithEmployees()
RETURNS TABLE
AS
RETURN(
SELECT DepartmentId FROM Employees
group by DepartmentID
HAVING COUNT(EmployeeID)>0
)
SELECT * FROM dbo.GetDepartmentsWithEmployees ();
--SELECT D.DepartmentId, D.DepartmentName
--    FROM Departments D
--    WHERE EXISTS (
--        SELECT 1 FROM Employees E WHERE D.DepartmentId = E.DepartmentId
--    )

-------4---------------
ALTER FUNCTION GetTopPaidEmployees(@departmentID INT)
RETURNS @Top3 Table(EmployeeId INT, Name NVARCHAR(50),Salary DECIMAL(10,2))
as
BEGIN
INSERT INTO @Top3
SELECT TOP 3 EmployeeId,Name,Salary FROM Employees
WHERE DepartmentId=@departmentID
ORDER BY Salary DESC;
RETURN
END
SELECT * FROM dbo.GetTopPaidEmployees(3);

----------------------------------
