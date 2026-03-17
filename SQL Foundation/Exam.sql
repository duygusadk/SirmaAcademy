CREATE DATABASE SchoolDB

USE SchoolDB

------------1----------------

CREATE TABLE Students(
StudentID INT PRIMARY KEY,
Name VARCHAR(100),
Age INT
)

CREATE TABLE Courses(
CourseID INT PRIMARY KEY,
CourseName VARCHAR(100)
)

CREATE TABLE Enrollments(
EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
CONSTRAINT FK_Students_Enrollments FOREIGN KEY(StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
CONSTRAINT FK_Courses_Enrollments FOREIGN KEY(CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
)


----------2----------

INSERT INTO Students
VALUES(1,'Alice',20),(2,'Bob',22),(3,'Charlie',21)

INSERT INTO Courses
VALUES(101,'Mathematics'),(102,'Physics'),(103,'Computer Science')

INSERT INTO Enrollments
VALUES(1,1,101),(2,1,103),(3,2,103),(4,3,101),(5,3,102),(6,3,103)


----------3---------

SELECT S.Name AS 'Student Name',C.CourseName
FROM Students S
JOIN Enrollments E ON E.StudentID=S.StudentID
JOIN Courses C ON C.CourseID=E.CourseID

--------------4---------------
SELECT C.CourseName,Count(E.StudentID) as 'StudentCount'
FROM Students S
JOIN Enrollments E ON E.StudentID=S.StudentID
JOIN Courses C ON C.CourseID=E.CourseID
GROUP BY C.CourseName

--------5-----
SELECT S.Name AS 'StudentName'
FROM Students S
LEFT JOIN Enrollments E ON E.StudentID=S.StudentID
WHERE E.CourseID IS NULL

------------------------

CREATE DATABASE CompanySirmaDB

CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
Name VARCHAR(100),
Department VARCHAR(50),
Salary DECIMAL(10,2)
);
CREATE TABLE Projects ( 
ProjectID INT PRIMARY KEY,
ProjectName VARCHAR(100),
Budget DECIMAL(10,2)
);

CREATE TABLE EmployeeProjects (
EmployeeID INT,
ProjectID INT,
Role VARCHAR(50),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE,
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE,
PRIMARY KEY (EmployeeID, ProjectID)
);
INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (1, 'John Doe', 'IT', 5000),
(2, 'Jane Smith', 'HR', 4000),
(3, 'Alice Johnson', 'IT', 5500),
(4, 'Bob Brown', 'Finance', 4500);

INSERT INTO Projects (ProjectID, ProjectName, Budget)
VALUES (101, 'Website Redesign', 20000),
(102, 'Database Migration', 30000),
(103, 'Security Audit', 15000);

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role) 
VALUES (1, 101, 'Developer'),
(1, 102, 'Database Admin'),
(2, 103, 'HR Specialist'),
(3, 101, 'Lead Developer'),
(4, 102, 'Finance Analyst');

-----------6---------
SELECT E.EmployeeID,Name,Department,Salary,Role,P.ProjectID,ProjectName,Budget         
FROM Employees E
JOIN EmployeeProjects EP ON E.EmployeeID=EP.EmployeeID
JOIN Projects P ON EP.ProjectID=P.ProjectID

-----------7----------

SELECT TOP 1 Department,SUM(Salary) as 'TotalSalary'
FROM Employees
GROUP BY Department
ORDER BY 2 DESC

-------8-----------------
SELECT E.EmployeeID,COUNT(EP.ProjectID) AS 'ProjectsCount'
FROM Employees E
JOIN EmployeeProjects EP ON E.EmployeeID=EP.EmployeeID
GROUP BY E.EmployeeID
HAVING COUNT(EP.ProjectID)>1

-----9------
SELECT P.ProjectName,SUM(Salary) as 'SpentBudget'
FROM Employees E
JOIN EmployeeProjects EP ON E.EmployeeID=EP.EmployeeID
JOIN Projects P ON EP.ProjectID=P.ProjectID
GROUP BY P.ProjectName

----------10--------

--INSERT INTO Employees(E.EmployeeID,Name,Department,Salary)
--VALUES(6, 'Jake Anderson','IT',5000)

SELECT E.EmployeeID,Name,Department,Salary
FROM Employees E
LEFT JOIN EmployeeProjects EP ON E.EmployeeID=EP.EmployeeID
WHERE ProjectID IS NULL

---------11--------------
CREATE PROC dbo.sp_GetEmployeesByDepartment(@DepartmentName VARCHAR(50))
AS
SELECT *
FROM Employees
WHERE Department=@DepartmentName
GO

EXEC dbo.sp_GetEmployeesByDepartment @DepartmentName='IT'

------12------------
CREATE FUNCTION fn_GetProjectBudget(@ProjectID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @Budget DECIMAL(10,2)
SELECT @Budget=Budget
FROM Projects
WHERE ProjectID=@ProjectID

RETURN @Budget 
END

SELECT  dbo.fn_GetProjectBudget(101) as 'Budget'

-----------13-------------

BEGIN TRANSACTION
BEGIN TRY

INSERT INTO Employees(EmployeeID,Name,Department,Salary)
VALUES(5,'Duygu Sadak','IT',2000)

INSERT INTO EmployeeProjects(EmployeeID,ProjectID,Role)
VALUES(5,102,'Developer')
 COMMIT
 END TRY
 BEGIN CATCH
ROLLBACK
END CATCH

------14-------

DECLARE @AvgBudget DECIMAL(10,2);
SELECT @AvgBudget = AVG(Budget) FROM Projects;  

SELECT e.Name, p.ProjectName, p.Budget
FROM Employees e
JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects p ON ep.ProjectID = p.ProjectID
WHERE p.Budget > @AvgBudget

---------------15---------------
--SELECT * FROM Projects
--INSERT INTO Projects(ProjectID,ProjectName,Budget)
--VALUES(104,'Project 4',20000)


CREATE TABLE ArchivedProjects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    Budget DECIMAL(10,2)
);
INSERT INTO ArchivedProjects (ProjectID, ProjectName, Budget)
SELECT P.ProjectID, P.ProjectName, P.Budget
FROM Projects P
LEFT JOIN EmployeeProjects EP ON P.ProjectID = EP.ProjectID
WHERE EP.EmployeeID IS NULL

DELETE FROM Projects
WHERE ProjectID IN (
    SELECT P.ProjectID
    FROM Projects P
    LEFT JOIN EmployeeProjects EP ON P.ProjectID = EP.ProjectID
    WHERE EP.EmployeeID IS NULL
)