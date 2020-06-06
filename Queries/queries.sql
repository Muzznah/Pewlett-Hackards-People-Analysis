--Get employees that are retiring soon(Born btw 1952-1955).
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

--Get employees that were born in 1952 and will retire soon.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

--Retirement eligibility (Skill Drill).

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility with hire date variable.
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring.
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--CReating retirement_info table.
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Check the new table made.
SELECT * FROM retirement_info;

--Drop the retirement info table to make a new one.
DROP TABLE retirement_info;

-- Create new table for retiring employees with emp_no.
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables to get current employees to retire soon.
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

--Checking how many retirement-eligible employees are still employed and converting it to a new table. 
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

______________________________
--CReating retirement_info table (1955).
SELECT emp_no,first_name, last_name
INTO retirement_info55
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Checking how many retirement-eligible employees are still employed and converting it to a new table. 
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp55
FROM retirement_info55 as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--count number of employees retiring(55)
SELECT COUNT(first_name)
FROM current_emp55 ;
___________________________________________________
--CReating retirement_info table (1952).
SELECT emp_no,first_name, last_name
INTO retirement_info52
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1952-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Checking how many retirement-eligible employees are still employed and converting it to a new table. 
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp52
FROM retirement_info52 as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--count number of employees retiring(52)
SELECT COUNT(first_name)
FROM current_emp52 ;
__________________________________________________________
--CReating retirement_info table (1954).
SELECT emp_no,first_name, last_name
INTO retirement_info54
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1954-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Checking how many retirement-eligible employees are still employed and converting it to a new table. 
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp54
FROM retirement_info54 as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--count number of employees retiring(54)
SELECT COUNT(first_name)
FROM current_emp54;