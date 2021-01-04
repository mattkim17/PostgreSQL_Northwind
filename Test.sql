SELECT orders.order_id AS order_id, customers.contact_name, products.product_name AS Product_Name, order_details.quantity, orders.order_date
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id 
INNER JOIN customers ON customers.customer_id = orders.customer_id
INNER JOIN products on order_details.product_id = products.product_id
