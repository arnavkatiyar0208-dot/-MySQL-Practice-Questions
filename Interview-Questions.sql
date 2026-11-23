
CREATE DATABASE interview_commands_practice;

USE interview_commands_practice;

SET autocommit = 1;

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(60),
    department VARCHAR(30),
    city VARCHAR(40),
    salary DECIMAL(10, 2),
    employment_status VARCHAR(15),
    phone VARCHAR(15)
) ENGINE = InnoDB;

-- Insert initial 10 employee records
INSERT INTO employees
(employee_id, employee_name, department, city, salary, employment_status, phone)
VALUES
(1, 'Rahul Sharma', 'IT', 'Delhi', 45000.00, 'Active', '9000000001'),
(2, 'Priya Verma', 'HR', 'Mumbai', 42000.00, 'Active', '9000000002'),
(3, 'Amit Patel', 'Sales', 'Ahmedabad', 38000.00, 'Inactive', '9000000003'),
(4, 'Anjali Singh', 'IT', 'Kolkata', 50000.00, 'Active', '9000000004'),
(5, 'Vijay Kumar', 'Finance', 'Bangalore', 55000.00, 'Active', '9000000005'),
(6, 'Sanjay Reddy', 'Sales', 'Hyderabad', 36000.00, 'Active', '9000000006'),
(7, 'Megha Iyer', 'IT', 'Chennai', 48000.00, 'Active', '9000000007'),
(8, 'Neha Gupta', 'HR', 'Delhi', 32000.00, 'Inactive', '9000000008'),
(9, 'Arjun Mehta', 'Finance', 'Pune', 52000.00, 'Active', '9000000009'),
(10, 'Pooja Shah', 'Sales', 'Mumbai', 40000.00, 'Active', '9000000010');

COMMIT;

SELECT * FROM employees;


-- QUESTION 1: INSERT ONE EMPLOYEE

INSERT INTO employees
(employee_id, employee_name, department, city, salary, employment_status, phone)
VALUES
(11, 'Karan Malhotra', 'IT', 'Noida', 41000.00, 'Active', '9000000011');

SELECT * FROM employees;


-- QUESTION 2: INSERT MULTIPLE EMPLOYEES

INSERT INTO employees
(employee_id, employee_name, department, city, salary, employment_status, phone)
VALUES
(12, 'Simran Kaur', 'HR', 'Delhi', 35000.00, 'Active', '9000000012'),
(13, 'Rohan Das', 'Sales', 'Pune', 33000.00, 'Inactive', '9000000013');

SELECT * FROM employees;



-- QUESTION 3: UPDATE TWO VALUES IN ONE ROW

UPDATE employees
SET city = 'Gurgaon',
    salary = 46000.00
WHERE employee_id = 11;

SELECT * FROM employees
WHERE employee_id = 11;


-- QUESTION 4: INCREASE SALARY BY 10%

UPDATE employees
SET salary = salary * 1.10
WHERE employee_id IN (1, 4, 7);

SELECT * FROM employees
WHERE employee_id IN (1, 4, 7);


-- QUESTION 5: DELETE SELECTED EMPLOYEES

DELETE FROM employees
WHERE employee_id IN (3, 8, 13);

SELECT * FROM employees;


-- QUESTION 6: ADD A NEW EMAIL COLUMN

ALTER TABLE employees
ADD COLUMN email VARCHAR(100) NULL;

DESCRIBE employees;


-- QUESTION 7: MODIFY PHONE COLUMN SIZE

ALTER TABLE employees
MODIFY COLUMN phone VARCHAR(20) NULL;

DESCRIBE employees;


-- QUESTION 8: RENAME CITY COLUMN TO WORK_CITY

ALTER TABLE employees
CHANGE COLUMN city work_city VARCHAR(40);

DESCRIBE employees;

SELECT * FROM employees;


-- QUESTION 9: DROP EMAIL COLUMN

ALTER TABLE employees
DROP COLUMN email;

DESCRIBE employees;


-- QUESTION 10: RENAME EMPLOYEES TABLE TO STAFF

RENAME TABLE employees TO staff;

SELECT * FROM staff;

-- QUESTION 11: COMMIT TRANSACTION

START TRANSACTION;

-- Insert employee 14
INSERT INTO staff
(employee_id, employee_name, department, work_city, salary, employment_status, phone)
VALUES
(14, 'Nisha Rao', 'IT', 'Noida', 44000.00, 'Active', '9000000014');

-- Update employee 2 salary
UPDATE staff
SET salary = 45000.00
WHERE employee_id = 2;

-- Save changes permanently
COMMIT;

-- Test rollback after commit
ROLLBACK;

-- Check saved changes
SELECT * FROM staff
WHERE employee_id IN (2, 14);


-- QUESTION 12: ROLLBACK TRANSACTION

START TRANSACTION;

-- Update employee 5 salary
UPDATE staff
SET salary = 60000.00
WHERE employee_id = 5;

-- Delete employee 6
DELETE FROM staff
WHERE employee_id = 6;

-- Undo both changes
ROLLBACK;

-- Check employee 5 and employee 6
SELECT * FROM staff
WHERE employee_id IN (5, 6);


-- QUESTION 13: SAVEPOINT AND ROLLBACK TO SAVEPOINT

START TRANSACTION;

-- Step A: Update employee 14 salary
UPDATE staff
SET salary = 47000.00
WHERE employee_id = 14;

SAVEPOINT salary_saved;

-- Step B: Update employee 14 city
UPDATE staff
SET work_city = 'Jaipur'
WHERE employee_id = 14;

SAVEPOINT city_saved;

-- Step C: Delete employee 14
DELETE FROM staff
WHERE employee_id = 14;

-- Undo deletion
ROLLBACK TO SAVEPOINT city_saved;

-- Undo city update but keep salary update
ROLLBACK TO SAVEPOINT salary_saved;

-- Save remaining salary update
COMMIT;

-- Check final employee 14 record
SELECT * FROM staff
WHERE employee_id = 14;

-- QUESTION 14: TRUNCATE TABLE

START TRANSACTION;

-- Delete all records from staff
TRUNCATE TABLE staff;

-- Try rollback (TRUNCATE cannot be undone)
ROLLBACK;

-- Check whether records exist
SELECT * FROM staff;

-- Check whether table structure still exists
DESCRIBE staff;

-- QUESTION 15: DROP TABLE AND DATABASE
-- Delete staff table

DROP TABLE staff;

-- Delete complete database

DROP DATABASE interview_commands_practice;