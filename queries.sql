SET DateStyle = "ISO, MDY";

-- Creating the 'departments' table
CREATE TABLE IF NOT EXISTS departments (
    dept_no VARCHAR(255) PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL UNIQUE
);

-- Creating the 'titles' table
CREATE TABLE IF NOT EXISTS titles (
    title_id VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255) NOT NULL UNIQUE
);

-- Creating the 'employees' table
CREATE TABLE IF NOT EXISTS employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(255) REFERENCES titles(title_id),
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL
);

-- Creating the 'salaries' table
CREATE TABLE IF NOT EXISTS salaries (
    emp_no INT PRIMARY KEY REFERENCES employees(emp_no),
    salary INT NOT NULL
);

-- Creating the 'dept_emp' table
CREATE TABLE IF NOT EXISTS dept_emp (
    emp_no INT REFERENCES employees(emp_no),
    dept_no VARCHAR(255) REFERENCES departments(dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- Creating the 'dept_manager' table
CREATE TABLE dept_manager (
    dept_no VARCHAR NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Importing data into 'departments'
COPY departments(dept_no, dept_name) 
FROM 'c:/data/departments.csv' 
DELIMITER ',' 
CSV HEADER;

-- Importing data into 'titles'
COPY titles(title_id, title) 
FROM 'c:/data/titles.csv' 
DELIMITER ',' 
CSV HEADER;

-- Importing data into 'employees'
COPY employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date) 
FROM 'c:/data/employees.csv' 
DELIMITER ',' 
CSV HEADER;

-- Importing data into 'salaries'
COPY salaries(emp_no, salary) 
FROM 'c:/data/salaries.csv' 
DELIMITER ',' 
CSV HEADER;

-- Importing data into 'dept_emp'
COPY dept_emp(emp_no, dept_no) 
FROM 'c:/data/dept_emp.csv' 
DELIMITER ',' 
CSV HEADER;

-- Importing data into 'dept_manager'
COPY dept_manager(dept_no, emp_no) 
FROM 'c:/data/dept_manager.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',');


-- 1. Retrieve employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no;

-- 2. Retrieve first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3. Retrieve the department number, department name, and manager's employee number, last name, and first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name 
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- 4. Retrieve the department number, employee number, last name, first name, and department name for each employee.
SELECT dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM dept_emp
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no;

-- 5. Retrieve first name, last name, and sex of employees named Hercules with last names starting with 'B'.
SELECT first_name, last_name, sex 
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. Retrieve each employee's number, last name, and first name in the Sales department.
SELECT employees.emp_no, employees.last_name, employees.first_name 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7. Retrieve each employee's number, last name, first name, and department name in the Sales and Development departments.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name IN ('Sales', 'Development');

-- 8. Count the frequency of each last name among employees, ordered from most to least common.
SELECT last_name, COUNT(*) AS frequency 
FROM employees 
GROUP BY last_name 
ORDER BY frequency DESC;




