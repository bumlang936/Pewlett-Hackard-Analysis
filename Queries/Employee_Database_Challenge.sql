--Retreive emp_no, first_name, last_name columns from Employees table
--Retreive title, from_date, to_date columns from Titles table

SELECT e.emp_no,
	e.first_name, 
	e.last_name,
	title.title,
	title.from_date,
	title.to_date
INTO retirement_titles
FROM titles AS title
LEFT JOIN employees AS e
ON (title.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retire.emp_no) retire.emp_no, retire.first_name, retire.last_name, retire.title
INTO unique_titles 
FROM retirement_titles AS retire
ORDER BY retire.emp_no, retire.to_date DESC;

-- Count the number of employees about to retire and group by title
SELECT COUNT (DISTINCT uniqe.emp_no), uniqe.title
INTO retiring_titles
FROM unique_titles AS uniqe
GROUP BY uniqe.title
ORDER BY count DESC;



SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	title.title
INTO retirement_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as title
ON (e.emp_no = title.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND title.to_date = ('9999-01-01')
ORDER BY e.emp_no;
