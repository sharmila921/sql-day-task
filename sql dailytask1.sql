CREATE database customers;
use customers;


-- //Day 28: DDL Commands (Corrected)

 CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(50),
    Age INT,
    Gender CHAR(1),
    AdmissionDate DATE
);

ALTER TABLE Patients
ADD DoctorAssigned VARCHAR(50);

ALTER TABLE Patients
MODIFY PatientName VARCHAR(100);

RENAME TABLE Patients TO Patient_Info;
-- //Correct INSERT after RENAME

INSERT INTO Patient_Info
(PatientID, PatientName, Age, Gender, AdmissionDate, DoctorAssigned)
VALUES
(1, 'Ramesh Kumar', 45, 'M', '2025-01-10', 'Dr. Mehta'),
(2, 'Anitha Sharma', 32, 'F', '2025-01-12', 'Dr. Rao'),
(3, 'Suresh Patel', 28, 'M', '2025-01-15', NULL);
select * from patient_info; 
 
-- Day 29: Books & Orders

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    BookName VARCHAR(100),
    ISBN VARCHAR(20) UNIQUE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    BookID INT,
    OrderDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

INSERT INTO Books VALUES
(101, 'SQL Basics', 'ISBN001'),
(102, 'Advanced SQL', 'ISBN002'),
(103, 'Data Analytics', 'ISBN003');

INSERT INTO Orders VALUES
(1, 101, '2024-01-01'),
(2, 102, '2025-01-06'),
(3, 103, '2025-01-07');

select * from Books;
select * from orders;
-- //Day 30: Students Module (Fixed)

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Department VARCHAR(50),
    Email VARCHAR(100),
    GPA DECIMAL(2,1)
);

INSERT INTO Students VALUES
(1, 'Amit', 'Computer Science', 'amit@gmail.com', 3.8),
(2, 'Neha', 'Electronics', NULL, 2.9),
(3, 'Rahul', 'Computer Science', 'rahul@gmail.com', 3.2);
select * from Students;
-- Correct WHERE usage

SELECT DISTINCT Department FROM Students;

SELECT * FROM Students WHERE Email IS NULL;
SELECT * FROM Students WHERE Email IS NOT NULL;

SELECT * FROM Students WHERE GPA BETWEEN 3.0 AND 4.0;
SELECT * FROM Students WHERE GPA NOT BETWEEN 2.0 AND 3.0;
-- Day 31: Products & Sales

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price INT
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Amount INT
);

INSERT INTO Products VALUES
(1, 'Laptop', 75000),
(2, 'Mobile', 45000),
(3, 'Tablet', 30000),
(4, 'Headphones', 5000);

INSERT INTO Sales VALUES
(1, 1500),
(2, 2500),
(3, 4000),
(4, 3200);

select * from Products;
select * from Sales;
-- Day 32: Joins

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT
);

INSERT INTO Courses VALUES
(201, 'SQL'),
(202, 'Python'),
(203, 'Data Science');

INSERT INTO Enrollments VALUES
(1, 201),
(1, 202),
(3, 203);
select * from Courses;
select * from enrollments;
-- Day 33–34: Employees Module

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentID INT,
    HireDate DATE
);

CREATE TABLE Salaries (
    EmployeeID INT,
    Salary INT
);

INSERT INTO Departments VALUES
(1, 'IT'),
(2, 'HR');

INSERT INTO Employees VALUES
(101, 'Karthik', 1, '2020-06-10'),
(102, 'Divya', 2, '2019-03-15'),
(103, 'Arun', 1, '2021-01-20');

INSERT INTO Salaries VALUES
(101, 60000),
(102, 50000),
(103, 55000);
select * from Departments;
select * from Employees;
select * from Salaries;
-- Day 35: Trigger & Transaction (Fixed)

CREATE TABLE Order_History (
    OrderID INT,
    BookID INT,
    OrderDate DATE
);

DELIMITER $$

CREATE TRIGGER after_order_delete
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_History
    VALUES (OLD.OrderID, OLD.BookID, OLD.OrderDate);
END $$

DELIMITER ;
-- TCL Example (Correct)

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    Balance INT
);

START TRANSACTION;

UPDATE Accounts SET Balance = Balance - 500 WHERE AccountID = 1;

SAVEPOINT before_credit;

UPDATE Accounts SET Balance = Balance + 500 WHERE AccountID = 2;

ROLLBACK TO before_credit;
-- or 
COMMIT;