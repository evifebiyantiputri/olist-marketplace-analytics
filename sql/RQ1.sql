-- check duplicates (no duplicate)
SELECT order_id, count(*) as frequency
FROM orders_dataset
GROUP BY order_id
HAVING count(*) > 1

-- check consistency unique values (yes)
SELECT count(*) as total_all, count(DISTINCT order_id) as total_unique
FROM orders_dataset

-- check logical consistency on date (yes)
SELECT *
FROM orders_dataset
WHERE julianday(order_delivered_customer_date) < julianday(order_purchase_timestamp)

-- check NULL
SELECT 
count(*) as total_order,
count(*) - count(order_id) as null_order_id,
count(*) - count(order_purchase_timestamp) as null_purchase,
count(*) - count(order_delivered_customer_date) as null_delivered_cust,
count(*) - count(order_estimated_delivery_date) as null_estimated_delivery
FROM orders_dataset

-- check NULL logic (yes, 8 orders delivered with no actual cust date and 6 orders cancelled with actual cust date)
SELECT
order_status,
count(*) as total_orders,
sum(CASE WHEN order_delivered_customer_date is NULL THEN 1 ELSE 0 END) as null_delivery_date
FROM orders_dataset
GROUP BY order_status

CREATE VIEW delivery_performance as
SELECT *
FROM orders_dataset
WHERE order_status = 'delivered' and order_delivered_customer_date is not null

-- count clean rows
SELECT count(*) as total_clean
FROM delivery_performance

-- earliest and latest purchase
SELECT min(order_purchase_timestamp) as earliest_purchase,
max(order_purchase_timestamp) as latest_purchase
FROM delivery_performance

-- ANALYSIS

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






