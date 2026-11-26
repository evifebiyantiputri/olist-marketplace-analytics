# **1. Introduction**
## **1.1. Business Background**
In e-commerce, the customer experience does not stop when an order is placed. The shipping and delivery process is an equally important part of the purchasing journey, as customers depend on sellers and logistics providers to get their orders delivered on schedule.

Delivery performance can influence customer satisfaction, as delays may affect customers' overall shopping experience and perceptions of service reliability. However, delivery performance is not determined by a single factor. It may vary across product categories, sellers, and customer's location.

Understanding these variations is important for identifying potential operational challenges and finding room for improvement. Therefore, analyzing delivery performance from multiple perspectives gives businesses clearer insights into what causes delays and shows where operations need to be strengthened.

## **1.2. Main Business Question**
What can an analysis of delivery performance across different operational dimensions reveal about the Olist Marketplace?

## **1.3. Research Questions**
This project addresses the main business question through five research questions:
1. How does the Olist Marketplace perform in terms of delivery reliability and timeliness?
2. How does delivery performance relate to customer satisfaction?
3. How does delivery performance vary across different product categories?
4. How does delivery performance vary across different sellers?
5. How does delivery performance vary across different customer locations?

## **1.4. Project Objectives**
Olist Marketplace across different operational dimensions and understand its relationship with customer satisfaction. Specifically, this project aims to:
1. Evaluate overall delivery performance in terms of delivery reliability and timeliness.
2. Examine the relationship between delivery performance and customer satisfaction.
3. Identify variations in delivery performance across product categories.
4. Assess differences in delivery performance among sellers.
5. Analyze geographic variations in delivery performance across customer locations.

# **2. Dataset & Scope**
## **2.1. Dataset Sources**
## **2.2. Dataset Description**
## **2.3. Overall Project Scope**
## **2.4. Analysis Period**

# **3. Methodology**
## **3.1. Tools Used**
## **3.2. Data Preparation & Quality Assessment**
## **3.3. Analytical Approach**

# **4. Research Questions & Analysis**
## **4.1. RQ1 - Delivery Performance Analysis**
### **4.1.1. Business Question & Objectives**
#### **A. Business Question**
How well is Olist Marketplace performing in terms of delivery?

To address this question, the analysis examines three aspects of delivery performance:
1. The proportion of orders delivered on time versus late.
2. The distribution and duration of late deliveries.
3. Changes in delivery performance over time.

#### **B. Objectives**
The objectives of this analysis are to:
1. Evaluate delivery reliability by measuring the proportion of on-time and late deliveries.
2. Examine the distribution of delivery delays to understand how severe late deliveries are.
3. Examine monthly delivery performance by tracking changes in both the number and proportion of late deliveries over time.
### **4.1.2. Metrics & Definitions**
This analysis uses several metrics to evaluate delivery performance and examine delivery delays.
#### **A. Delivery Status**
Orders are classified into two categories based on the comparison between the actual delivery date and the estimated delivery date:

**- On Time:** Orders delivered on or before the estimated delivery date.

**- Late:** Orders delivered after the estimated delivery date.

#### **B. On-time Delivery Rate**
The proportion of eligible orders delivered on or before the estimated delivery date, calculated as:

On-time Delivery Rate = (On-time Orders/Eligible Orders) x 100%

#### **C. Late Delivery Rate**
The proportion of eligible orders delivered after the estimated delivery date, calculated as:

Late Delivery Rate = (Late Orders/Eligible Orders) x 100%

#### **D. Late Delivery Duration**
The number of days an order is delayed beyond its estimated delivery date, calculated as:

Delay Days = Actual Delivery Date - Estimated Delivery Date

Only order with a positive delay duration are included in the late delivery duration analysis.

#### **E. Monthly Late Delivery Frequency**
The number of late orders grouped by their purchase month, using the order purchase timestamp as the reference.

#### **F. Monthly Late Delivery Rate**
The proportion of late orders relative to all eligible orders within the same purchase month, calculated as:

Monthly Late Delivery Rate = (Monthly Late Orders/Monthly Eligible Orders) x 100%

### **4.1.3. Data Preparation & Quality Assessment**
#### **A. Duplicate Check**
Duplication were checked to ensure that each order was appropriately represented at order level, as duplicates could affect the accuracy of delivery performance calculations. The `order_id` column was examined to identify potential duplicate records. The result showed that **no duplicate `order_id` values were found**, indicating that each row represents a unique order.

#### **B. Logical Consistency Check**
Logical consistency check was performed on `order_purchase_timestamp` column and `order_delivered_cust_date` column. The check verified that the purchase timestamp occured before the time an order arrived at customers. The result showed that all orders with available timestamps followed this expected chronological sequence, indicating **no logical inconsistencies were found** between the two columns.

#### **C. Null Value Check & Data Filtering**
NULL value were checked to ensure that all columns that will be used have all the information needed. The columns that were checked consist of `order_id`, `order_purchase_timestamp`, `order_delivered_cust_date`, and `order_estimated_delivery_date`. The result showed in table below:
| Total Order | NULL order_id | NULL purchase | NULL delivered_cust | NULL estimated_delivery |
| :---: | :---: | :---: | :---: | :---: |
| 99441 | 0 | 0 | 2,965 | 0 |

The table above showed that there were 2,965 orders with NULL value in `order_delivered_cust_date`. This result could indicate several possibilities, such as packages had not yet been delivered to customer, orders that were still in transit, or canceled order. Therefore, the `order_satus` column was examined to investigate these missing values. The result are shown below:

| Order Status | Total Orders | NULL delivered_cust |
| :---: | :---: | :---: |
| approved | 2 | 2 |
| canceled | 625 | 619 |
| created | 5 | 5 |
| delivered | 96,478 | 8 |
| invoiced | 314 | 314 |
| processing | 301 | 301 |
| shipped | 1,107 | 1,107 |
| unavailable | 609 | 609 |

The table above revealed two types of inconsistencies between `order_status` and `order_delivered_cust_date`. First, 8 orders with `delivered` status had missing delivery timestamps. Second, 6 orders with a `canceled` status had recorded delivery timestamps, which should not be expected for canceled orders. These records were considered anomalous due to the inconsistency between their order statuses and delivery timestamps. Therefore, they were excluded from the analysis. Other records with NULL values in `order_delivered_cust_date` were also excluded, as their actual delivery dates were unavailable. 

This filtering ensured that only order with valid delivery timestamps were included in the delivery performance analysis. As a result, a total of **96,470 orders** with valid delivery timestamps were retained for further analysis 

### **4.1.4. Analysis & Findings**
#### **A. Delivery Performance Classification**
| Delivery Status | Total Orders | Percentage |
| :---: | :---: | :---: |
| On-time | 88,644 | 91.89% |
| Late | 7,826 | 8.11% |
| Total | 96,470 | 100% |

The delivery performance analysis classified 96,470 orders into two categories: late and on-time deliveries. The results showed that 88,644 orders (91.89%) were delivered on time, while 7,826 orders (8.11%) were delivered late. This indicates that the majority of orders were successfully delivered within the estimated delivery date. However, approximately 8 out of every 100 orders experienced delivery delays.

#### **B. Late Delivery Distribution Analysis**
**Descriptive Statistics**

| Total | Mean | Standar Dev | Min | Q1 | Q2 | Q3 | Max |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 7,826 | 9.55 | 13.95 | 0.003 | 1.87 | 5.81 | 11.82 | 188.98 |

Descriptive statistics were used to examine the duration of late deliveries across 7,826 orders. The results showed that the average delivery delay was approximately 10 days, while the median delay was approximately 6 days. This indicates that half of the late orders experienced delays of approximately 6 days or less.

The minimum delay was approximately 0.003 days, indicating that the order was delivered jus a few minutes after the estimated delivery date, while the maximum delay reached 199 days. The first quartile (Q1) was 1.87 days, meaning that 25% of late orders experienced delays of up to approximately 2 days. Meanwhile, the third quartile (Q3) was 11.82 days, indicating that 75% of late orders experienced delays of up to approximately 12 days.

**Delay Distribution**

The histogram below illustrates the distribution of late delivery durations.

![Late Delivery Duration Histogram](figures/RQ1/late_delivery_hist.png)

The histogram shows a highly right-skewed distribution of late delivery durations. Most late orders experienced relatively short delays, while the frequency decreased sharply as the delay duration increased. However, a small number of orders experienced considerably longer delays, with some extending to nearly 190 days. This pattern indicates that while the majority of late deliveries were delayed for relatively short periods, a few orders experienced extremely long delays.

**Outlier Detections**

To detect potential outliers in late delivery durations, the Interquartile Range (IQR) method was applied. The upper bound was approximately 27 days, categorizing any deliveriy exceeding this limit as an outlier. In total of 505 orders, representing 6.45% of all late orders were identifed as outliers. This indicates that only a small proportion of late orders experienced exceptionally long delays, while the remaining 93.55% had delays within the IQR-based upper boundary.

![Late Delivery Boxplot](figures/RQ1/boxplot.png)

The boxplot also shows several extreme values past the upper whisker, reflecting the small proportion of orders with considerably longer delivery delays.

#### **C. Monthly Delivery Performance Analysis**

Monthly delivery performance was evaluated by grouping orders according to their purchase month. Two metrics were used in this analysis are the monthly number of late deliveries and the monthly late delivery rate. Evaluating both metrics together provide different perspectives on delivery performance over time.

**Monthly Late Delivery Count**

This metric shows the number of orders delivered later than their estimated delivery dates in each purchase month.

![Monthly Late Delivery Count](figures/RQ1/monthly_late_deliveries.png)

The chart shows that the number of late deliveries generally increased throughout 2017 and reached a significant peak of 1,496 late orders in March 2018. Another notable spike occurred in November 2017, at 1,043 late orders. Following the peak in March 2018, the number of late deliveries decreased considerably in April 2018 to 361 orders.

**Monthly Late Delivery Rate**

Whereas the previous chart shows the number of late deliveries, the monthly late delivery rate measures the proportion of late orders relative to the total number of orders purchased in each month.

![Monthly Late Delivery Rate](figures/RQ1/monthly_late_deliveries_rate.png)

The monthly late delivery rate shows a similar upward tren to the volume pattern in several months, with noticeable increases in November 2017, February 2018, and March 2018. The highest rate occurred in March 2018, reaching 21.36%, indicating that approximately one in five orders placed that month arrived late. The rate then dropped to 5.31% in April 2018.

**Overall Interpretation**

Taken together, the findings indicate that delivery performance fluctuated over time, with March 2018 showing the weakest performance in both total delayed orders and overal delay date. The sharp drop in the late delivery rate in April 2018 suggests an improvement in delivery performance compared to the previous month. However, further investigation would be needed to identify the factors contributing to these monthly fluctuations.

### **4.1.5. Business Insights & Recommendations**
#### **A. Business Insights**

Based on the delivery performance analysis, four key insight stand out:

**1. Delivery delays remain a concern despite strong on-time performance.**

Although 91.89% of eligible orders were delivered on time, 8.11%, roughly 8 in every 100 orders, still experienced delivery delays. Even though the majority of orders met their estimated delivery dates, late arrivals remain an area that requires attention to maintain a reliable delivery service and customer satisfaction.

**2. Most late deliveries experienced relatively short delays, but some orders faced exceptionally long delays.**

Half of the late orders were delayed by 6 days or less. At the same time, the IQR method identified 505 potential outliers, representing 6.45% of all late orders, with delays exceeding approximately 27 days. These exceptionally long delays may indicate specific delivery issues that require further investigation.

**3. Delivery performance fluctuated significantly over time.**

Monthly trends showed noticeable fluctuations in delivery performance, especially from late 2017 into early 2018. March 2018 recorded the highest late delivery rate at 21.36%, meaning that approximately one in five orders placed that month arrived late. This suggests that delivery performance was not consistent throughout the analysis period.

**4. Late delivery volume and rate provide different perspectives on delivery performance.**

Late delivery count measures total delayed volume, whereas the late delivery rate indicates the proportion of delayed orders relative to total orders. Considering both metrics is important because a high number of late orders does not necessarily indicate poor delivery performance if the total order volume is also high. Monitoring both metrics provides a far more balanced understanding of delivery performance over time.

#### **B. Business Recommendations**

Based on the identified business insights, several recommendations can be proposed to improve delivery performance:

**1. Improve delivery reliability through regular performance monitoring.**

Olist should implement regular monitoring of the proportion of late deliveries to identify whether delivery performance is improving or declining. Evaluating delivery performance consistently can help the business identify potential issues early and take corrective actions before delays become more widespread.

**2. Investigate orders with exceptionally long delivery delays.**

Orders delayed beyond 27 days should be examined further to identify potential recurring issues. Olist could investigate relevant order details, such as seller location, customer location, and delivery partner, to pinpoint whether certain factors are associated with exceptionally long delays.

**3. Pay closer attention to periods with high late delivery rates.**

Olist should monitor monthly delivery performance to identify periods with unusually high late delivery rates, such as March 2018 when the late rate hit 21.36%. Examining operational conditions during such periods could help identify potential factors contributing to the increase in delivery delays and support better planning in the future.

**4. Monitor both late delivery count and late delivery rate.**

Evaluations of monthly delivery performance should consistently feature both total late order counts and the late delivery rate. The late delivery count helps measure the volume of delayed orders, while the late delivery rate provides a clearer view of delivery performance relative to total order volume. Monitoring both metrics can support more accurate performance evaluations and better-informed business decisions.

## **4.2. RQ2 - Delivery Performance & Customer Satisfaction**
### **4.2.1. Business Question & Objectives**
### **4.2.2. Metrics & Definitions**
### **4.2.3. Data Preparation & Quality Assessment**
### **4.2.4. Analysis & Findings**
### **4.2.5. Business Insights & Recommendations**

## **4.3. RQ3 - Delivery Delays by Product Category**
### **4.3.1. Business Question & Objectives**
### **4.3.2. Metrics & Definitions**
### **4.3.3. Data Preparation & Quality Assessment**
### **4.3.4. Analysis & Findings**
### **4.3.5. Business Insights & Recommendations**

## **4.4. RQ4 - Seller Delivery Performance**
### **4.4.1. Business Question & Objectives**
### **4.4.2. Metrics & Definitions**
### **4.4.3. Data Preparation & Quality Assessment**
### **4.2.4. Analysis & Findings**
### **4.2.5. Business Insights & Recommendations**

## **4.5. RQ5 - Delivery Performance Across Customer Locations**
### **4.5.1. Business Question & Objectives**
### **4.5.2. Metrics & Definitions**
### **4.5.3. Data Preparation & Quality Assessment**
### **4.5.4. Analysis & Findings**
### **4.5.5. Business Insights & Recommendations**

# **5. Overall Business Insights & Recommendations**
# **6. Conclusion**