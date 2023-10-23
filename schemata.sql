-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


-- The 'departments' table holds all departments within the company. Each department has a unique number and a name.
CREATE TABLE "departments" (
    -- Unique identifier for each department
    "dept_no" varchar   NOT NULL,
    -- Name of the department
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

-- The 'employees' table contains all employee data, including their number, title, birth date, name, sex, and hire date.
CREATE TABLE "employees" (
    -- Unique identifier for each employee
    "emp_no" int   NOT NULL,
    -- Reference to the title held by the employee
    "emp_title_id" varchar   NOT NULL,
    -- Birth date of the employee
    "birth_date" date   NOT NULL,
    -- First name of the employee
    "first_name" varchar   NOT NULL,
    -- Last name of the employee
    "last_name" varchar   NOT NULL,
    -- Sex of the employee
    "sex" varchar   NOT NULL,
    -- Date the employee was hired
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

-- The 'dept_emp' table links employees to departments, indicating the department each employee is part of.
CREATE TABLE "dept_emp" (
    -- The employee's number, foreign key linked to 'employees' table
    "emp_no" int   NOT NULL,
    -- The department's number, foreign key linked to 'departments' table
    "dept_no" varchar   NOT NULL,
    -- The start date of the employee's assignment to the department
    "from_date" date   NOT NULL,
    -- The end date of the employee's assignment to the department (if applicable)
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

-- The 'dept_manager' table identifies the relationship between departments and employees, specifying which employees are managers for each department.
CREATE TABLE "dept_manager" (
    -- Employee number, linked to the 'employees' table
    "emp_no" int   NOT NULL,
    -- Department number, linked to the 'departments' table
    "dept_no" varchar   NOT NULL,
    -- Start date of the employee's manager role
    "from_date" date   NOT NULL,
    -- End date of the employee's manager role
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

-- The 'salaries' table stores the salary information for each employee.
CREATE TABLE "salaries" (
    -- The employee's number, foreign key linked to 'employees' table
    "emp_no" int   NOT NULL,
    -- The employee's salary
    "salary" int   NOT NULL,
    -- The start date for this salary
    "from_date" date   NOT NULL,
    -- The end date for this salary
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

-- The 'titles' table contains the various titles that employees can hold within the company.
CREATE TABLE "titles" (
    -- Unique identifier for each title
    "title_id" varchar   NOT NULL,
    -- Description of the title
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

