-- Create the DEPT table first, as PERSON depends on it
CREATE TABLE DEPT (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE,
    DepartmentCode VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(50) NOT NULL
);

-- Create the PERSON table with a Foreign Key
CREATE TABLE PERSON (
    PersonID INT PRIMARY KEY,
    PersonName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(8, 2) NOT NULL,
    JoiningDate DATE NOT NULL,
    City VARCHAR(100) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES DEPT(DepartmentID)
);

-- Insert data into the DEPT table
INSERT INTO DEPT (DepartmentID, DepartmentName, DepartmentCode, Location)
VALUES
(1, 'Admin', 'Adm', 'A-Block'),
(2, 'Computer', 'CE', 'C-Block'),
(3, 'Civil', 'CI', 'G-Block'),
(4, 'Electrical', 'EE', 'E-Block'),
(5, 'Mechanical', 'ME', 'B-Block'),
(6, 'Marketing', 'Mkt', 'F-Block'),
(7, 'Accounts', 'Acc', 'A-Block');

-- Insert data into the PERSON table
INSERT INTO PERSON (PersonID, PersonName, DepartmentID, Salary, JoiningDate, City)
VALUES
(101, 'Rahul Tripathi', 2, 56000.00, '2000-01-01', 'Rajkot'),
(102, 'Hardik Pandya', 3, 18000.00, '2001-09-25', 'Ahmedabad'),
(103, 'Bhavin Kanani', 4, 25000.00, '2000-05-14', 'Baroda'),
(104, 'Bhoomi Vaishnav', 1, 39000.00, '2005-02-08', 'Rajkot'),
(105, 'Rohit Topiya', 2, 17000.00, '2001-07-23', 'Jamnagar'),
(106, 'Priya Menpara', NULL, 9000.00, '2000-10-18', 'Ahmedabad'),
(107, 'Neha Sharma', 2, 34000.00, '2002-12-25', 'Rajkot'),
(108, 'Nayan Goswami', 3, 25000.00, '2001-07-01', 'Rajkot'),
(109, 'Mehul Bhundiya', 4, 13500.00, '2005-01-09', 'Baroda'),
(110, 'Mohit Maru', 5, 14000.00, '2000-05-25', 'Jamnagar'),
(111, 'Alok Nath', 2, 36000.00, '2003-03-15', 'Ahmedabad'),
(112, 'Seema Jain', 3, 28000.00, '2002-06-18', 'Baroda'),
(113, 'Karan Singh', 1, 41000.00, '2004-11-30', 'Rajkot'),
(114, 'Riya Gupta', 5, 16000.00, '2001-02-12', 'Ahmedabad'),
(115, 'Suresh Patel', 7, 32000.00, '2003-08-20', 'Jamnagar'),
(116, 'Meena Kumari', 7, 30000.00, '2004-01-01', 'Rajkot'),
(117, 'Vikram Batra', NULL, 11000.00, '2005-04-05', 'Baroda');

-----------------------------------------------------------------------

-------PART A===

--1  Combine information from Person and Department table using cross join or Cartesian product.

SELECT p.PersonName,d.DepartmentName
FROM PERSON p cross join DEPT d

-- 2. Find all persons with their department name.

SELECT p.PersonName,d.DepartmentName
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID

--3. Find all persons with their department name & code.

SELECT p.PersonName,d.DepartmentName,d.DepartmentCode
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID

--4. Find all persons with their department code and location.

SELECT p.PersonName,d.Location,d.DepartmentCode
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID

--5. Find the detail of the person who belongs to Mechanical department

SELECT p.PersonID,p.PersonName,d.DepartmentID,p.Salary,p.JoiningDate,p.City
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID
where d.DepartmentName='Mechanical'


---6. Final person’s name, department code and salary who lives in Ahmedabad city
SELECT p.PersonID,p.PersonName,d.DepartmentCode,p.Salary,p.City
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID
where p.City='Ahmedabad'

--7. Find the person's name whose department is in C-Block.
SELECT p.PersonName
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID
where d.Location='C-Block'

--8.  Retrieve person name, salary & department name who belongs to Jamnagar city. 
SELECT p.PersonName,p.Salary,d.DepartmentName
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID
where p.City='Jamnagar'


---9.  Retrieve person’s detail who joined the Civil department after 1-Aug-2001.
SELECT p.PersonID,p.PersonName,p.Salary,d.DepartmentName,d.DepartmentID,p.City
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID
where D.DepartmentName='Civil' and p.JoiningDate >'2001-08-01'

--10. Display all the person's name with the department whose joining date difference with the current date is more than 365 days.
SELECT p.PersonName
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID
where DATEDIFF(DAY,P.JoiningDate,GETDATE())>365
 

----11. Find department wise person counts.
SELECT D.DepartmentName,count(p.personID) as personCounts
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID
GROUP BY d.DepartmentName


-----12.. Give department wise maximum & minimum salary with department name. 
SELECT D.DepartmentName,MAX(p.Salary) as MaxSalary,MIN(p.Salary) as MinSalary 
FROM PERSON p join DEPT d 
on p.DepartmentID=d.DepartmentID
GROUP BY d.DepartmentName


----13. Find city wise total, average, maximum and minimum salary. 
SELECT p.City,sum(p.Salary) as Total ,avg(p.Salary) as avg ,MAX(p.Salary) as MaxSalary,MIN(p.Salary) as MinSalary 
FROM PERSON p

GROUP BY p.City


---14.  Find the average salary of a person who belongs to Ahmedabad city.
SELECT avg(p.Salary) as avg 
FROM PERSON p
where p.city='Ahmedabad';


---15.  Produce Output Like: <PersonName> lives in <City> and works in <DepartmentName> Department. (In single column).

SELECT CONCAT(P.PersonName, ' lives in ', P.City, ' and works in ',
              COALESCE(D.DepartmentName, 'No Department'), ' Department.') AS PersonDetails
FROM PERSON P
LEFT JOIN DEPT D ON P.DepartmentID = D.DepartmentID;


--Part-b--
--1. Produce Output Like: <PersonName> earns <Salary> from <DepartmentName> department monthly. (In single column)

--2. Find city & department wise total, average & maximum salaries. 
SELECT P.City, D.DepartmentName,
       SUM(P.Salary) AS TotalSalary,
       AVG(P.Salary) AS AvgSalary,
       MAX(P.Salary) AS MaxSalary
FROM PERSON P
JOIN DEPT D ON P.DepartmentID = D.DepartmentID
GROUP BY P.City, D.DepartmentName
ORDER BY P.City, D.DepartmentName;


--3. Find all persons who do not belong to any department.
SELECT PersonID, PersonName, DepartmentID, Salary, JoiningDate, City
FROM PERSON
WHERE DepartmentID IS NULL;

--4 Find all departments whose total salary is exceeding 100000.
SELECT D.DepartmentName, SUM(P.Salary) AS TotalSalary
FROM DEPT D
JOIN PERSON P ON P.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName
HAVING SUM(P.Salary) > 100000;

----part-c---
--1. List all departments who have no person.
SELECT D.DepartmentName
FROM DEPT D
LEFT JOIN PERSON P ON P.DepartmentID = D.DepartmentID
WHERE P.PersonID IS NULL;

--2. List out department names in which more than two persons are working. 
SELECT D.DepartmentName, COUNT(P.PersonID) AS PersonCount
FROM DEPT D
JOIN PERSON P ON P.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName
HAVING COUNT(P.PersonID) > 2;






