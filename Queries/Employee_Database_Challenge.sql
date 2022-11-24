-- * STEPS 1-8 *
-- SELECT * FROM employees;
SELECT ep.emp_no, 
ep.first_name, 
ep.last_name,
ep.birth_date,
tt.title,
tt.from_date,
tt.to_date
INTO retire_title
FROM employees as ep
FULL OUTER JOIN titles as tt
ON (ep.emp_no = tt.emp_no)
WHERE (ep.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY ep.emp_no;
;
-- SELECT * FROM retire_title;
-- DROP TABLE retire_title;
-- ALTER TABLE retire_title
-- DROP birth_date;

-- * STEPS 9-15 *
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_retire_titles
FROM retire_title as rt
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- SELECT * FROM unique_retire_titles;
-- DROP TABLE unique_retire_titles;

-- * STEPS 9-15 *

SELECT COUNT(urt.title), urt.title
INTO title_retire_table
FROM unique_retire_titles as urt
GROUP BY urt.title 
ORDER BY urt.count DESC;

SELECT * FROM title_retire_table;

------- DELIVERABLE 2 --------

SELECT * FROM dept_emp;
SELECT * FROM unique_retire_titles;
--- STEPS 1- 10: ---

SELECT DISTINCT ON (ep.emp_no) ep.emp_no, 
ep.first_name, 
ep.last_name,
ep.birth_date,
de.from_date,
de.to_date,
tt.title
INTO mentorship_elig
FROM employees as ep
INNER JOIN dept_emp as de
ON (ep.emp_no = de.emp_no)
INNER JOIN titles as tt
ON (ep.emp_no = tt.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (ep.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;

-- DROP TABLE mentorship_elig;
SELECT * FROM mentorship_elig;
-- SELECT * FROM unique_retire_titles;
-- SELECT * FROM mentorship_elig;


---- ANALYSIS - SUBMISSION

-- View Table to show retiring employees sum
SELECT SUM(count)
FROM title_retire_table;

-- Create Table to show elibible employees count
SELECT COUNT(me.title), me.title
-- INTO mentor_elig_count
FROM mentorship_elig as me
GROUP BY me.title 
ORDER BY me.count DESC;

-- Create Table to show elibible employees sum
SELECT SUM(count)
FROM mentor_elig_count;

