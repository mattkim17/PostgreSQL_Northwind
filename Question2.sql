-- Question 2

SELECT employees.first_name, employees.last_name, employees.title, hire_date, COUNT(employees.first_name) as num
FROM employees 

INNER JOIN orders ON orders.employee_id = employees.employee_id 
GROUP BY employees.first_name, employees.last_name, employees.title, hire_date
ORDER BY COUNT(employees.first_name) DESC
