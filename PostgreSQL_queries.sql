--Question 1
SELECT orders.order_id AS order_id, customers.contact_name, products.product_name AS Product_Name, order_details.quantity, orders.order_date
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id 
INNER JOIN customers ON customers.customer_id = orders.customer_id
INNER JOIN products on order_details.product_id = products.product_id

--Question 2
SELECT employees.first_name, employees.last_name, employees.title, hire_date, COUNT(employees.first_name) as num_of_sales
FROM employees 

INNER JOIN orders ON orders.employee_id = employees.employee_id 
GROUP BY employees.first_name, employees.last_name, employees.title, hire_date
ORDER BY COUNT(employees.first_name) DESC

-- Question 3 
SELECT MIN(order_date) AS First_Day_of_Sales, MAX(order_date) AS Last_Day_of_Sales, (DATE_PART('year', MAX(order_date)) - DATE_PART('year', MIN(order_date)))*12 +
(DATE_PART('month', MAX(order_date)) - DATE_PART('month', MIN(order_date))) AS Time_Interval_of_Sales FROM orders

-- Question 4a
SELECT  emp.first_name, emp.last_name, o.employee_id, od.order_id, SUM(unit_price*quantity*(1-discount)) as revenue
FROM order_details AS od

INNER JOIN orders AS o ON o.order_id = od.order_id
INNER JOIN employees as emp ON o.employee_id = emp.employee_id
GROUP BY od.order_id, o.employee_id, emp.employee_id

-- Question 4b 
SELECT emp.first_name, emp.last_name, ROUND(SUM(revenue)::numeric,2) as Total_Revenue
FROM(SELECT od.order_id, SUM(unit_price*quantity*(1-discount)) as revenue, o.employee_id, emp.first_name, emp.last_name
FROM order_details AS od

INNER JOIN orders AS o ON o.order_id = od.order_id
INNER JOIN employees as emp ON o.employee_id = emp.employee_id
GROUP BY od.order_id, o.employee_id, emp.employee_id) AS revenue_table

INNER JOIN employees as emp ON revenue_table.employee_id = emp.employee_id
GROUP BY  emp.employee_id
ORDER BY total_revenue DESC

--Question 5
SELECT DISTINCT ship_city, ship_country, ship_region FROM orders 

-- Question 6
SELECT  products.product_name, COUNT(products.product_name) as number_of_orders, SUM(order_details.quantity) AS Total_Quantity_Sold, order_details.unit_price as Unit_price
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id 
INNER JOIN products on order_details.product_id = products.product_id
GROUP BY products.product_name, order_details.unit_price
ORDER BY total_quantity_sold DESC

-- Question 7
SELECT customers.contact_name as customer_name, 
COUNT(customers.contact_name) as num_of_orders,  
ROUND(SUM(od.unit_price*od.quantity*(1-od.discount))::numeric,2) as total_payment,  ship_country, ship_city
FROM orders
INNER JOIN order_details as od ON orders.order_id = od.order_id 
INNER JOIN customers ON customers.customer_id = orders.customer_id
INNER JOIN products on od.product_id = products.product_id

GROUP BY customers.contact_name, ship_country, ship_city
ORDER BY total_payment DESC

-- Question 8 
SELECT ROUND((discount_value*100)::numeric, 2) as discount_percentage, ROUND((sum_count/2156.0)::numeric, 5)*100 as ratios, sum_count
FROM (SELECT discount as discount_value, COUNT(discount) as sum_count 
	  	FROM order_details
		GROUP BY discount) AS count_table
		GROUP BY discount_value, sum_count

--QUESTION 9a
SELECT order_date, COUNT(order_date) FROM orders
GROUP BY order_date
ORDER BY COUNT(order_date) DESC

--QUESTION 9b 
SELECT o.order_date, ROUND(SUM(od.unit_price*od.quantity*(1-od.discount))::numeric,2) as revenue FROM order_details as od
INNER JOIN orders as o ON o.order_id = od.order_id 
GROUP BY o.order_date
ORDER BY revenue DESC

