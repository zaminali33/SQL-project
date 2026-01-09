# University Management Database

This project is a **MySQL database** for managing a simple university system. It includes tables for **Departments, Students, Courses, and Enrollment**, along with sample data, queries, and a stored procedure for backing up student data.

## Features
- Create and manage university database
- Tables:
  - `Dept` → Departments
  - `Students` → Student records
  - `Courses` → Courses offered
  - `Enrollment` → Tracks student course enrollments and marks
- Sample data insertion for testing
- Stored procedure to backup student records (`Students_backup`)
- Queries demonstrating:
  - Data selection, filtering, and sorting
  - String and numeric functions
  - Joins across multiple tables

## Usage
1. Open **MySQL Workbench** or any MySQL client.
2. Run the SQL script `university.sql`.
3. The script will:
   - Create the database and tables
   - Insert sample data
   - Create a backup procedure
   - Run example queries

## Example Queries
- Select all students: `SELECT * FROM Students;`
- Students with age between 19-21: `SELECT name FROM Students WHERE age BETWEEN 19 AND 21;`
- Students in a department with marks: 
```sql
SELECT S.name, D.dept_name, E.marks
FROM Students S
JOIN Dept D ON S.dept_id = D.dept_id
JOIN Enrollment E ON S.student_id = E.student_id;
