CREATE TABLE "titles" (
    "title_id" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    PRIMARY KEY ( "title_id"
     )
);
 
CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    PRIMARY KEY ( "dept_no"
     )
);
 
 
 
CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "birth_date" VARCHAR(15)   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" DATE  NOT NULL,
     PRIMARY KEY ("emp_no")
);
 
CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
                FOREIGN KEY ("emp_no") 
);
 
CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);
 
CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL
);
 
 
 
SELECT employees.emp_no,
                                employees.last_name,
                                employees.first_name,
                                employees.sex,
                                salaries.salary
FROM employees
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
 
--List the first name, last name, and hire date for the employees who were hired in 1986.
 
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;
 
--List the department number for each employee along with that employee’s employee number,
                --last name, first name, and department name.
 
 
SELECT dept_emp.dept_no,
                                dept_emp.emp_no,
                                employees.first_name,
                                employees.last_name,
                                employees.emp_no,
                                departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no;
 
 
--List the manager of each department along with their department number,
--department name, employee number, last name, and first name.
 
SELECT dept_manager.dept_no,
                                dept_manager.emp_no,
                                employees.first_name,
                                employees.last_name,
                                employees.emp_no,
                                departments.dept_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no;
 
--List first name, last name,
--and sex of each employee whose first name is
--Hercules and whose last name begins with the letter B.
 
 
SELECT  employees.last_name,
                                employees.first_name,
                                employees.sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name Like 'B%'
 
--List each employee in the Sales department,
--including their employee number, last name, and first name.
 
SELECT  employees.first_name,
                                employees.last_name,
                                employees.emp_no,
                                departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
 
--List each employee in the Sales and Development departments, including their employee number,
--last name, first name, and department name.
 
SELECT
                                employees.first_name,
                                employees.last_name,
                                employees.emp_no,
                    departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales'
AND departments.dept_name = 'Development'
 
--List the frequency counts, in descending order, of all the employee last names
--(that is, how many employees share each last name).

SELECT count(last_name) as frequency, last_name
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC