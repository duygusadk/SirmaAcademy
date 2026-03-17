CREATE DATABASE SCHOOL

CREATE TABLE STUDENTS
(
StudentID INT Primary Key Not Null,
FirstName VARCHAR(50) Not Null ,
LastName VARCHAR(50) Not Null,
Age INT ,
Grade VARCHAR(10)
)

INSERT INTO Students (StudentID, FirstName, LastName, Age, Grade) VALUES (1, 'John', 'Doe', 15, '1th');
INSERT INTO Students (StudentID, FirstName, LastName, Age, Grade) VALUES (2, 'Anna', 'John', 17, '10th');
INSERT INTO Students (StudentID, FirstName, LastName, Age, Grade) VALUES (3, 'Lily', 'Stone', 13, '3th');
INSERT INTO Students (StudentID, FirstName, LastName, Age, Grade) VALUES (4, 'Kate', 'Watson', 15, '4th');
INSERT INTO Students (StudentID, FirstName, LastName, Age, Grade) VALUES (6, 'Mike', 'Johnson', 15, '12th');

SELECT * FROM STUDENTS

SELECT FirstName,Grade FROM STUDENTS
WHERE AGE>14

UPDATE Students SET Grade = '11th' WHERE StudentID = 1;

DELETE FROM STUDENTS
WHERE StudentID=3

SELECT * FROM STUDENTS
WHERE Grade='10th'

SELECT * FROM STUDENTS
WHERE Age BETWEEN 14 AND 16

SELECT FirstName+' '+LastName AS FULLNAME, Grade From STUDENTS

CREATE TABLE GRADUATES
(
StudentID INT Primary Key Not Null,
FirstName VARCHAR(50) Not Null ,
LastName VARCHAR(50) Not Null,
Age INT ,
Grade VARCHAR(10)
)
INSERT INTO GRADUATES
SELECT * from STUDENTS
where Grade='12th'

SELECT * FROM GRADUATES

CREATE VIEW v_StudentsByGrade AS
SELECT FirstName+' '+LastName AS FULLNAME, Grade  FROM STUDENTS

SELECT * FROM v_StudentsByGrade

SELECT COUNT(*) FROM STUDENTS
SELECT AVG(AGE) FROM STUDENTS