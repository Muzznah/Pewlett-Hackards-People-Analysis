--Table of people retiring from sales dept.
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
INTO sales_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';


--Table of people retiring from sales  and development dept.
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
INTO salesdev_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN('Sales', 'Development');

--Inspect and view
SELECT * FROM salesdev_info;

--Create list of sales and dev dept retiree.
SELECT COUNT (first_name), dept_name
INTO salesdev_info_count
FROM salesdev_info
GROUP BY dept_name
ORDER BY COUNT(first_name) DESC;

--Inspect and view
SELECT * FROM salesdev_info_count;



