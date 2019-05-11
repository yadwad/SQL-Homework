-- Exported from QuickDBD: https://www.quickdatatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" integer   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "gender" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);
drop table "dept_emp";
CREATE TABLE "dept_emp" (
    "emp_no" integer   NOT NULL,
    "dept_no" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no", "dept_no"
     )
);
drop table "dept_manager";
CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no", "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" integer   NOT NULL,
    "salary" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "title" (
    "emp_no" integer   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "title" ADD CONSTRAINT "fk_title_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- 1. List the following details of each employee: 
--employee number, last name, first name, gender, and salary.

select e.emp_no, first_name, last_name, gender, salary from employees as e inner join salaries
as s on e.emp_no = s.emp_no; 

-- 2. List employees who were hired in 1986.

select * from employees;

select hire_date, emp_no, first_name, last_name
from employees 
where extract (year from hire_date) = 1986

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.
select e.emp_no, d.dept_no, dept_name, first_name, last_name from departments 
as d inner join dept_manager as dept on d.dept_no = dept.dept_no 
inner join employees as e on e.emp_no = dept.emp_no;
 

-- 4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

select e.emp_no, first_name, last_name, dept_name from 
employees as e join dept_emp as d on e.emp_no = d.emp_no
join departments as dept on dept.dept_no = d.dept_no; 

--5. List all employees whose first name is "Hercules" and last names begin with "B."

(select first_name from employees where first_name = 'Hercules') union 
(select last_name from employees where last_name like 'B%');

--6. List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT  e.emp_no,
        last_name,
        first_name,
		d.dept_no
		
FROM employees AS e
    INNER JOIN dept_emp AS de
        ON (e.emp_no = de.emp_no)
    INNER JOIN departments AS d
        ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales'
ORDER BY e.emp_no;



-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select * from departments;

select * from dept_emp;

SELECT  e.emp_no,
        last_name,
        first_name
		
FROM employees AS e
    INNER JOIN dept_emp AS de
        ON (e.emp_no = de.emp_no)
    INNER JOIN departments AS d
        ON (de.dept_no = d.dept_no)
WHERE d.dept_name in ('Sales', 'Development')
ORDER BY e.emp_no;

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select
count(*),
last_name
from employees
group by last_name
order by count desc;







