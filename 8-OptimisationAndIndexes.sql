-- Q1. Create a query to find the number of male and female employees in the database and order by the highest to lowest number of employees.

SELECT gender, COUNT(*) AS total_count
FROM employees
GROUP BY gender
ORDER BY total_count DESC;

-- Q2: Execute the query, what were the results and how long did it take to complete?

-- Q3: Create an index to optimise the query

CREATE INDEX gender
ON employees (gender);

-- Q4: Execute the query from Q1 again, how long did it take to complete?

-- Q5: Create a query to display the first name, last name, and salary of the highest paid employee.

SELECT e.first_name, e.last_name, s.salary
FROM employees e JOIN salaries s
ON e.emp_no = s.emp_no
WHERE s.salary = (SELECT MAX(salary) FROM salaries);

-- Q6: Execute the query, what were the results and how long did it take to complete?

-- Q7: Create an index to optimise the query from Q5

CREATE INDEX salary
ON salaries (salary);

-- Q8: Execute the query from Q5 again, how long did it take to complete?

-- Q9: Create a query to display employees first name, last name, and salary between 1995 and 2000 ordered by the highest paid employee to the lowest.

SELECT e.first_name, e.last_name, s.salary
FROM employees e JOIN salaries s
ON e.emp_no = s.emp_no
WHERE year(s.from_date) >= 1995 AND Year(s.to_date) <= 2000
ORDER BY s.salary DESC;

-- Q10: Execute the query, how long did it take to complete?

-- Q11: Create an index to optimise the query from Q9

CREATE INDEX salary_from_date_to_date
ON salaries (salary, from_date, to_date);

-- Q12: Execute the query from Q9 again, how long did it take to complete?