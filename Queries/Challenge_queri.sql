--Challenge
--Drop and recreate to include birth date till 65.
DROP TABLE title_info;
DROP TABLE current_title_info;
DROP TABLE retiree_countBytitle;
DROP TABLE mentor_list;
--Part 1
-- Number of Retiring Employees by Title
SELECT ce.emp_no,
	   ce.first_name,
       ce.last_name,
       tt.title,
       tt.from_date,
		st.salary
INTO title_info
FROM current_emp AS ce
    INNER JOIN titles AS tt
        ON (ce.emp_no = tt.emp_no)
    INNER JOIN salaries AS st
        ON (ce.emp_no = st.emp_no)
		ORDER BY ce.emp_no;
		
--View and Inspect the title_info table.
SELECT * FROM title_info;

--Check Count.
SELECT COUNT(emp_no), title
FROM title_info
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

--Handle duplication of emp_no through partitioning.
-- Partition the data to show only most recent title per employee
SELECT emp_no,
 	first_name,
 	last_name,
 	title,
 	from_date,
 	salary
INTO current_title_info
FROM
 (SELECT emp_no,
 first_name,
 last_name,
 title,
 from_date,
  salary,
  ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM title_info
 ) tmp WHERE rn = 1
ORDER BY emp_no;

--View and Inspect the current_title_info table.
SELECT * FROM current_title_info;

-- Retiree count by title into a table.
SELECT COUNT(emp_no), title
INTO retiree_countBytitle
FROM current_title_info
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

SELECT * FROM retiree_countBytitle;

--Part 2 Mentorship Eligibility
SELECT cti.emp_no,
	cti.first_name,
	cti.last_name,
	cti.title,
	cti.from_date,
	tt.to_date
INTO mentor_list
FROM current_title_info AS cti
INNER JOIN titles AS tt
ON cti.emp_no=tt.emp_no
INNER JOIN employees AS e
ON cti.emp_no=e.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
;
--View and inspect.
SELECT * FROM mentor_list;
--Remove duplication in mentor_list through partioning.
	SELECT emp_no,
 	first_name,
 	last_name,
 	title,
 	from_date,
 	to_date
INTO mentor_list_final
FROM
 (SELECT emp_no,
 first_name,
 last_name,
 title,
 from_date,
  to_date,
  ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM mentor_list
 ) tmp WHERE rn = 1
ORDER BY emp_no;
--View and inspect.
SELECT * FROM mentor_list_final;

--Count of mentors
SELECT COUNT(emp_no), title
INTO mentor_countBytitle
FROM mentor_list_final
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

--View and inspect.
SELECT * FROM mentor_countBytitle;