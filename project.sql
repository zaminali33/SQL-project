CREATE DATABASE IF NOT EXISTS University;
USE University;

-- Departments Table
CREATE TABLE IF NOT EXISTS Dept (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Students Table
CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT CHECK(age>0),
    dob DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Dept(dept_id)
);

-- Courses Table
CREATE TABLE IF NOT EXISTS Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credit_hours INT
);

-- Enrollment Table
CREATE TABLE IF NOT EXISTS Enrollment (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks DECIMAL(5,2),
    FOREIGN KEY(student_id) REFERENCES Students(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id)
);
-- Departments
INSERT ignore INTO Dept (dept_id, dept_name) VALUES
(1, 'CS'),
(2, 'BBA');

-- Students
INSERT ignore INTO Students (student_id, name, age, dob, dept_id) VALUES
(1, 'Ali', 20, '2000-05-01', 1),
(2, 'Sara', 19, '2001-03-15', 2),
(3, 'Ahmed', 21, '1999-12-20', 1),
(4, 'Ayesha', 20, '2000-07-10', 2);

-- Courses
INSERT ignore INTO Courses (course_id, course_name, credit_hours) VALUES
(101, 'Database', 3),
(102, 'Math', 4),
(103, 'Programming', 3);

-- Enrollment
INSERT ignore INTO Enrollment (enroll_id, student_id, course_id, marks) VALUES
(1, 1, 101, 85.5),
(2, 2, 102, 78.0),
(3, 3, 103, 92.0),
(4, 4, 101, 88.0),
(5, 1, 103, 90.0);

-- Procedure to copy Students to a backup table
CREATE TABLE IF NOT EXISTS Students_backup (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    dob DATE,
    dept_id INT
);

DELIMITER $$

DROP PROCEDURE IF EXISTS CopyStudents;

CREATE PROCEDURE CopyStudents()
BEGIN
    TRUNCATE TABLE Students_backup;
    INSERT ignore INTO Students_backup (student_id, name, age, dob, dept_id)
    SELECT student_id, name, age, dob, dept_id FROM Students;
END $$

DELIMITER ;

-- Call procedure
CALL CopyStudents();
SELECT UPPER(name) AS UpperName FROM Students;
SELECT CONCAT(name, ' from ', dept_id) AS Info FROM Students;
SELECT SUBSTR(name, 2, 3) AS SubName FROM Students;
SELECT name, LENGTH(name) AS NameLength, INSTR(name, 'a') AS PositionA FROM Students;
SELECT marks, ROUND(marks) AS RoundedMarks, TRUNCATE(marks,1) AS TruncMarks, MOD(marks, 10) AS Remainder
FROM Enrollment;
SELECT name, dob, CURDATE() AS TodayDate, NOW() AS CurrentDateTime
FROM Students;
SELECT name FROM Students WHERE age BETWEEN 19 AND 21;
SELECT name FROM Students WHERE name LIKE 'A%';
SELECT name FROM Students WHERE dept_id IN (1,2);
SELECT name FROM Students WHERE age>19 AND dept_id=1;
SELECT name, age FROM Students ORDER BY age ASC;

SELECT S.name, D.dept_name, E.marks
FROM Students S
JOIN Dept D ON S.dept_id = D.dept_id
JOIN Enrollment E ON S.student_id = E.student_id
ORDER BY D.dept_name ASC, E.marks DESC;
SELECT * FROM Students;
SELECT * FROM Students_backup;
SELECT * FROM Dept;
SELECT * FROM Courses;
SELECT * FROM Enrollment;
