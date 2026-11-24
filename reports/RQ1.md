# **RQ1 - Delivery Performance Analysis**
## **1. Business Context**
Delivery is one the most important process of e-commerce transactions because the customer experience does not end when a purchase is made, it continues untill the order reaches the customer's hands. 

After placing an order, customers rely on the estimated delivery date provided by the marketplace to anticipate when their purchases will arrive. Deliveries that arrive later than the promised date may lead to customers complaints, negative reviews, and potentially reduced customer loyalty. 

For this reason, evaluating delivery performance is essential to understanding how effectively a marketplace meets its delivery commitments. This evaluation focuses on the frequency of late deliveries, the duration of delivery delays, and changes in delivery performance over time.

Using the Olist Brazilian E-Commerce Public Dataset, this analysis aims to evaluate Olist's overall delivery performance.

## **2. Business Question & Objective**
### **2.1. Business Question**
How well is Olist Marketplace performing in terms of delivery?

To address this question, the analysis examines three aspects of delivery performance:
1. The proportion of orders delivered on time versus late.
2. The distribution and duration of late deliveries.
3. Changes in delivery performance over time.

### **2.2. Objectives**
The objectives of this analysis are to:
1. Evaluate delivery reliability by measuring the proportion of on-time and late deliveries.
2. Examine the distribution of delivery delays to understand how severe late deliveries are.
3. Examine monthly delivery performance by tracking changes in both the number and proportion of late deliveries over time.

## **3. Dataset & Scope**
### **3.1. Dataset**
This analysis uses the Olist Brazilian E-Commerce Public Dataset, obtained from Kaggle. The dataset contains information about e-commerce transactions, including order details, customer information, seller information, delivery timestamps, and other aspects of marketplace operations.

For this research question, the analysis primarily uses the `olist_orders_dataset` table, which contains order-level information such as purchase timestamp, estimated delivery dates, and actual delivery dates.

The original dataset consists of **99.441 orders**, with each observation representasing an individual order.

### **3.2. Scope of Analysis**
The analysis focuses exclusively on orders with a `delivered` status and non-null actual delivery dates. Orders with other statuses or missing actual delivery dates are excluded because their delivery performance cannot be reliably evaluated by comparing actual and estimated delivery dates.

After applying these criteria, **96.470 orders** are included in the analisis.

The analysis examines overal delivery performance, the distribution of late delivery durations, and monthly changes in late delivery performance.

### **3.3. Analysis Period**
The observation period is based on the order purchase timestamps of the eligible orders, covering September 2016 to August 2018.

## **4. Metrics & Definitions**
This analysis uses several metrics to evaluate delivery performance and examine delivery delays.
### **4.1. Delivery Status**
Orders are classified into two categories based on the comparison between the actual delivery date and the estimated delivery date:
**- On Time:** Orders delivered on or before the estimated delivery date.
**- Late:** Orders delivered after the estimated delivery date.

### **4.2. On-time Delivery Rate**
The proportion of eligible orders delivered on or before the estimated delivery date, calculated as:

On-time Delivery Rate = (On-time Orders/Eligible Orders) x 100%

### **4.3. Late Delivery Rate**
The proportion of eligible orders delivered after the estimated delivery date, calculated as:

Late Delivery Rate = (Late Orders/Eligible Orders) x 100%

### **4.4. Late Delivery Duration**
The number of days an order is delayed beyond its estimated delivery date, calculated as:

Delay Days = Actual Delivery Date - Estimated Delivery Date

Only order with a positive delay duration are included in the late delivery duration analysis.

### **4.5. Monthly Late Delivery Frequency**
The number of late orders grouped by their purchase month, using the order purchase timestamp as the reference.

### **4.6. Monthly Late Delivery Rate**
The proportion of late orders relative to all eligible orders within the same purchase month, calculated as:

Monthly Late Delivery Rate = (Monthly Late Orders/Monthly Eligible Orders) x 100%

## **5. Methodology**
This analysis was conducted using SQL and Python to examine delivery performance from different perpective.

### **5.1. Data Exploration and Quality Assesment**
The dataset was initially examined to undertand its structure, data types, completeness, and consistency. Data quality checks included identifying missing values, duplicate records, and verifying the order-level granularity of the dataset.

### **5.2. Delivery Performance Classification**
SQL was used to classify eligible orders into on-time and deliveries by comparing their estimated delivery dates with their actual delivery dates. The number and proportion of orders in each category were then calculated to evaluate overall delivery performance.

### **5.3. Late Delivery Distribution Anlysis**
Python was used to calculate the delay duration for each late order and examine its distribution. Descriptive statistics, histograms, and boxplots were used to understand the typical delay duration and identify potential outliers using the Interquartile Range (IQR) method.

### **5.4. Monthly Delivery Performance Analysis**
Monthly delivery performance was examined by grouping orders according to their purchase month. The analysis measured both the number and the rate of monthly late deliveriy to observe changes in delivery performance over time.

## **6. Analysis & Findings**
## **7. Business Insight & Recommendations**
## **8. Conclusion**