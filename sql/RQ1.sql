-- RQ 1

-- total and percentage of on time and late delivery
WITH delivery_summary as(
SELECT 
CASE 
WHEN julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date) <= 0 THEN 'On time'
WHEN julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date) > 0 THEN 'Late'
END as Delivery_Status,
count(*) as Total
FROM delivery_performance
WHERE order_delivered_customer_date IS NOT NULL and order_estimated_delivery_date IS NOT NULL
GROUP BY Delivery_Status)
SELECT Delivery_Status, Total, round(Total*100.0/(SELECT sum(Total) FROM delivery_summary), 2) as Percentage
FROM delivery_summary

-- late delivery distribution
SELECT round(julianday(order_delivered_customer_date)- julianday(order_estimated_delivery_date))  as total_date,
COUNT(*) as total_order
FROM delivery_performance
WHERE order_estimated_delivery_date IS NOT NULL and order_delivered_customer_date IS NOT NULL and total_date > 0
GROUP BY total_date
