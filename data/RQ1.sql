-- RQ 1
-- total order recieved
SELECT order_status,
count(order_status) as total
FROM orders_dataset
GROUP BY order_status

-- total and percentage of on time and late delivery
WITH delivery_summary as(
SELECT 
CASE 
WHEN julianday(order_estimated_delivery_date) - julianday(order_delivered_customer_date) >= 0 THEN 'On time'
WHEN julianday(order_estimated_delivery_date) - julianday(order_delivered_customer_date) < 0 THEN 'Late'
END as Delivery_Status,
count(*) as Total
FROM orders_dataset
WHERE order_delivered_customer_date IS NOT NULL and order_estimated_delivery_date IS NOT NULL
GROUP BY Delivery_Status)
SELECT Delivery_Status, Total, round(Total*100.0/(SELECT sum(Total) FROM delivery_summary), 2) as Percentage
FROM delivery_summary

-- late delivery distribution
SELECT round(julianday(order_delivered_customer_date)- julianday(order_estimated_delivery_date))  as total_date,
COUNT(*) as total_order
FROM orders_dataset
WHERE order_estimated_delivery_date IS NOT NULL and order_delivered_customer_date IS NOT NULL and total_date > 0
GROUP BY total_date
