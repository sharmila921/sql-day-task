-- // Day 28: DDL Commands//
-- Q1: CREATE Table//
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(50),
    Age INT,
    Gender CHAR(1),
    AdmissionDate DATE
);

-- //Q2: ALTER – Add Column//
ALTER TABLE Patients
ADD DoctorAssigned VARCHAR(50);

-- //Q3: ALTER – Modify Column//
ALTER TABLE Patients
MODIFY PatientName VARCHAR(100);
-- //Q4: RENAME Table//
RENAME TABLE Patients TO Patient_Info;
-- //Q5: TRUNCATE vs DROP--
TRUNCATE TABLE Patient_Info;

DROP TABLE Patient_Info;

-- // Day 29: Constraints
-- Q1: PRIMARY KEY & FOREIGN KEY//--
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    BookName VARCHAR(100),
    ISBN VARCHAR(20)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    BookID INT,
    OrderDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
-- //Q2: UNIQUE Constraint//
ALTER TABLE Books
ADD CONSTRAINT unique_isbn UNIQUE (ISBN);
-- //Q3: DELETE vs TRUNCATE--
DELETE FROM Orders
WHERE OrderDate < '2024-01-01';

TRUNCATE TABLE Orders;

-- //Day 30: Clauses & Operators
-- Q1: DISTINCT & WHERE//--
SELECT DISTINCT Department
FROM Students;
-- //Q2: IS NULL & NOT NULL//
SELECT * FROM Students
WHERE Email IS NULL;

SELECT * FROM Students
WHERE Email IS NOT NULL;
-- //Q3: IN, BETWEEN, NOT BETWEEN//

SELECT * FROM Students
WHERE Course IN ('Maths', 'Physics');

SELECT * FROM Students
WHERE GPA BETWEEN 3.0 AND 4.0;

SELECT * FROM Students
WHERE GPA NOT BETWEEN 2.0 AND 3.0;

-- // Day 31: Sorting & Aggregates
-- Q1: ORDER BY & LIMIT//--
SELECT * FROM Products
ORDER BY Price DESC
LIMIT 3;
-- //Q2: Aggregate Functions//
SELECT COUNT(*) FROM Sales;

SELECT SUM(Amount) FROM Sales;

SELECT AVG(Amount) FROM Sales;

SELECT MAX(Amount) FROM Sales;

SELECT MIN(Amount) FROM Sales;

TRUNCATE TABLE Orders;
-- //Day 30: Clauses & Operators//
-- //Q1: DISTINCT & WHERE//
SELECT DISTINCT Department
FROM Students;
-- //Q2: IS NULL & NOT NULL//
SELECT * FROM Students
WHERE Email IS NULL;

SELECT * FROM Students
WHERE Email IS NOT NULL;
-- //Q3: IN, BETWEEN, NOT BETWEEN//
SELECT * FROM Students
WHERE Course IN ('Maths', 'Physics');

SELECT * FROM Students
WHERE GPA BETWEEN 3.0 AND 4.0;

SELECT * FROM Students
WHERE GPA NOT BETWEEN 2.0 AND 3.0;
-- //Day 31: Sorting & Aggregates
-- Q1: ORDER BY & LIMIT//--
SELECT * FROM Products
ORDER BY Price DESC
LIMIT 3;
-- //Q2: Aggregate Functions//
SELECT COUNT(*) FROM Sales;

SELECT SUM(Amount) FROM Sales;

SELECT AVG(Amount) FROM Sales;

SELECT MAX(Amount) FROM Sales;

SELECT MIN(Amount) FROM Sales;
-- //Q3: GROUP BY & HAVING//
SELECT Department, COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 10;
-- //Day 32: Joins & Union//
-- //Q1: INNER JOIN//

SELECT s.StudentName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;
-- //Q2: LEFT & RIGHT JOIN//
SELECT s.StudentName, e.CourseID
FROM Students s
LEFT JOIN Enrollments e
ON s.StudentID = e.StudentID;

SELECT e.StudentID, c.CourseName
FROM Enrollments e
RIGHT JOIN Courses c
ON e.CourseID = c.CourseID;

-- //Q3: UNION vs UNION ALL//
SELECT Name FROM Current_Employees
UNION
SELECT Name FROM Past_Employees;

SELECT Name FROM Current_Employees
UNION ALL
SELECT Name FROM Past_Employees;
-- // Day 33: Functions//
-- //Q1: String Functions//
SELECT UPPER(EmployeeName) FROM Employees;

SELECT LOWER(EmployeeName) FROM Employees;

SELECT SUBSTRING(EmployeeName, 1, 4) FROM Employees;

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;

-- //Q2: Date Functions//
SELECT EmployeeName,
DATEDIFF(NOW(), HireDate) / 365 AS Tenure_Years
FROM Employees;

-- //Q3: User-defined Function//
DELIMITER $$

CREATE FUNCTION GetFullName(fname VARCHAR(50), lname VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(fname, ' ', lname);
END $$

DELIMITER ;

SELECT GetFullName('Sharmila', 'Ravi');
-- //Day 34: Procedures & Views//
-- //Q1: Stored Procedure//
DELIMITER $$

CREATE PROCEDURE GetEmployeeByID(IN emp_id INT)
BEGIN
    SELECT * FROM Employees
    WHERE EmployeeID = emp_id;
END $$

DELIMITER ;

CALL GetEmployeeByID(101);

-- //Q2: Simple View//
CREATE VIEW Employee_Department_View AS
SELECT EmployeeName, Department
FROM Employees;
-- //Q3: Complex View//
CREATE VIEW Employee_Full_Details AS
SELECT e.EmployeeName, d.DepartmentName, s.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Salaries s ON e.EmployeeID = s.EmployeeID;

-- //Day 35: Triggers & Transactions//
-- //Q1: Trigger--
DELIMITER $$

CREATE TRIGGER after_order_delete
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_History
    VALUES (OLD.OrderID, OLD.BookID, OLD.OrderDate);
END $$

DELIMITER ;

-- //Q2: DCL Commands//

GRANT SELECT ON employee_db.* TO 'junior_analyst'@'localhost';

REVOKE SELECT ON employee_db.* FROM 'junior_analyst'@'localhost';

-- //Q3: TCL Commands//
START TRANSACTION;

UPDATE Accounts SET Balance = Balance - 500
WHERE AccountID = 1;

SAVEPOINT before_credit;

UPDATE Accounts SET Balance = Balance + 500
WHERE AccountID = 2;

COMMIT;
-- or
ROLLBACK TO before_credit;

