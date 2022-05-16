-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
WHERE _______
ORDER BY _____, _____ DESC;
--START
--

-- DELIVERABLE 1
SELECT employees.emp_no,
	   employees.first_name,
	   employees.last_name, --from employees
 	   titles.title,
	   titles.from_date,
	   titles.to_date -- from titles
INTO retirement_titles
FROM employees 
JOIN titles 
ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;
-- Check TABLE
SELECT * FROM retirement_titles;
--Create table that contains most recent job title
SELECT DISTINCT ON (rt.emp_no)rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt

WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

--Check TABLE
SELECT * FROM unique_titles;


--number of employees by most recent job title about to retire
SELECT COUNT (ut.title), 
ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY ut.count DESC;
--CHECK TABLE
SELECT * FROM retiring_titles;

--Deliverable 2
-- Mentorship Eligibility Table

SELECT DISTINCT ON (employees.emp_no)
	employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees
	LEFT JOIN dept_emp AS de
	ON (employees.emp_no = de.emp_no)
	LEFT JOIN titles AS ti
	ON (employees.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') 
AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY (emp_no)
-- TEST TABLE
SELECT * FROM mentorship_eligibility

-- CSV TABLE IMPORTS
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);


DROP TABLE titles CASCADE;

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM titles;






