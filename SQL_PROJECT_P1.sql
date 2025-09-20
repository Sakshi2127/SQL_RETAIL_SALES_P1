DROP TABLE IF EXISTS RETAIL_SALES;
CREATE TABLE RETAIL_SALES (
transactions_id INT PRIMARY KEY,
sale_date DATE,	
sale_time TIME,
customer_id INT,
gender VARCHAR(20),
age INT,
category VARCHAR(15),
quantiy	INT, 
price_per_unit FLOAT,	
cogs FLOAT,
total_sale FLOAT
);

SELECT * FROM RETAIL_SALES;

SELECT * FROM RETAIL_SALES
LIMIT 10;

SELECT COUNT(*) FROM RETAIL_SALES;

--DATA CLEANING
SELECT * FROM RETAIL_SALES
WHERE transactions_id IS NULL;

SELECT * FROM RETAIL_SALES
WHERE sale_date IS NULL;

SELECT * FROM RETAIL_SALES
WHERE
    transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR 
	age IS NULL
	OR
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL;


DELETE FROM RETAIL_SALES
WHERE
 transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR 
	age IS NULL
	OR
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL;

SELECT * FROM RETAIL_SALES;

--HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS total_sale FROM RETAIL_SALES;

--HOW MANY CUSTOMERS UNIQUE CUSTOMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id) AS total_customer FROM RETAIL_SALES;

SELECT DISTINCT category FROM RETAIL_SALES; 

--DATA ANAYLYSIS & BUISNESS KEY PROBLEMS AND ANSWERS

--Q.1 write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM RETAIL_SALES
WHERE sale_date='2022-11-05';

--Q.2 write a SQL query to retrieve all transactions where the category is'clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT * FROM RETAIL_SALES
WHERE category='Clothing'
AND 
TO_CHAR(sale_date,'YYYY-MM')='2022-11';

--Q.3 write a SQL query to calculate the total sales(total_sale) for each category.
SELECT 
category,
SUM(total_sale) AS total_s
FROM RETAIL_SALES
GROUP BY category;

--Q.4 write a SQL query to find the average age of customers who purchased from the 'Beauty' category.
SELECT 
AVG(age) AS AVG_AGE
FROM RETAIL_SALES
WHERE category='Beauty';

--Q.5 write a SQL query to find all transactions where the total_Sale is greater than 1000.
SELECT * FROM RETAIL_SALES
WHERE total_sale > 1000;

--Q.6 write a SQL query to find the total number of transactions(transaction_id) made by each genderin each category.
SELECT 
gender,
category,
COUNT(transactions_id) AS TOTAL_NO_TRANSACTION
FROM RETAIL_SALES
GROUP BY category,gender
ORDER BY category,gender;

--Q.7 write a SQL query to calculate the average sale for each month.find out best selling month in each year
SELECT
     EXTRACT(MONTH FROM sale_date) AS MONTH,
	 EXTRACT(YEAR FROM sale_date) AS YEAR,
	 AVG(total_Sale) AS AVG_SALE
FROM RETAIL_SALES
GROUP BY MONTH,YEAR
ORDER BY YEAR,3 DESC;
	 
--Q.8 write a SQL query to find the top 5 customers based on the highest total sales.
SELECT
customer_id,
MAX(total_sale) AS highest_sales
FROM RETAIL_SALES
GROUP BY total_Sale
ORDER BY highest_sales
DESC 
LIMIT 5;

--Q.9 write a SQL query to find the number of unique customer who purchased items from each category.
SELECT
category,
COUNT(DISTINCT customer_id) AS no_of_cust 
FROM RETAIL_SALES
GROUP BY category;

SELECT * FROM RETAIL_SALES;
--Q. write a SQL query to create each shift and number of orders(example morning <=12, afternoon between 12 & 17, evening > 17 )
WITH HOURLY_SALES AS
(
 SELECT *,
      CASE
	     WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	     WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	     ELSE 'Evening'
	  END AS shift
FROM RETAIL_SALES
)
SELECT 
shift,
COUNT(*) AS TOTAL_ORDERS
FROM HOURLY_SALES
GROUP BY shift;