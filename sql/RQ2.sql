-- cek row yang sama -----------------------------------------
SELECT count(*) as total_all, 
count(*) - count(DISTINCT review_id) as 'total row with duplicate review id',
count(*) - count(DISTINCT order_id) as 'total row with duplicate order id'
FROM order_reviews_dataset

-- cek total duplicate review id ------------------------------
SELECT
    COUNT(*) AS total_duplicate_review_ids
FROM (
    SELECT review_id
    FROM order_reviews_dataset
    GROUP BY review_id
    HAVING COUNT(*) > 1
);

-- cek frequency review id yang sama (berapa kali muncul)--------------------------
SELECT
    COUNT(*) AS number_of_review_ids,
    frequency
FROM (
    SELECT
        review_id,
        COUNT(*) AS frequency
    FROM order_reviews_dataset
    GROUP BY review_id
    HAVING COUNT(*) > 1
)
GROUP BY frequency
ORDER BY frequency;

SELECT *
FROM order_reviews_dataset
WHERE review_id IN (
    SELECT review_id
    FROM order_reviews_dataset
    GROUP BY review_id
    HAVING COUNT(*) > 1
)
ORDER BY review_id;

-- cek isi sama
WITH duplicate_reviews AS (
    SELECT
        review_id,
        COUNT(*) AS total_records,
        COUNT(DISTINCT review_score) AS unique_score,
        COUNT(DISTINCT review_comment_title) AS unique_title,
        COUNT(DISTINCT review_comment_message) AS unique_message,
        COUNT(DISTINCT review_creation_date) AS unique_creation_date,
        COUNT(DISTINCT review_answer_timestamp) AS unique_answer_timestamp
    FROM order_reviews_dataset
    GROUP BY review_id
    HAVING COUNT(*) > 1
)

SELECT
    COUNT(*) AS total_duplicate_review_ids,
    SUM(
        CASE
            WHEN unique_score <= 1
             AND unique_title <= 1
             AND unique_message <= 1
             AND unique_creation_date <= 1
             AND unique_answer_timestamp <= 1
            THEN 1 ELSE 0
        END
    ) AS identical_review_ids
FROM duplicate_reviews;

-- cek reviewid ke order id
WITH duplicate_reviews AS (
    SELECT
        review_id,
        COUNT(*) AS total_records,
        COUNT(DISTINCT order_id) AS unique_orders
    FROM order_reviews_dataset
    GROUP BY review_id
    HAVING COUNT(*) > 1
)

SELECT
    unique_orders,
    COUNT(*) AS total_review_ids
FROM duplicate_reviews
GROUP BY unique_orders
ORDER BY unique_orders;

-- CHECK NULL
SELECT 
count(*) as total_order,
count(*) - count(order_id) as null_order_id,
count(*) - count(review_score) as null_score
FROM order_reviews_dataset

-- DATA SELECTION & JOINING
SELECT a.review_id, a.order_id, a.review_score, b.order_status, b.order_purchase_timestamp
FROM order_reviews_dataset a
INNER JOIN orders_dataset b
ON a.order_id = b.order_id
