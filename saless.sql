SELECT * FROM sales.sale;
USE SALES;
SHOW TABLES;
SELECT * FROM `sample - superstore` LIMIT 10;


## TOTAL REVENUE
USE SALES;
SELECT SUM(`Total amount`) AS TOTAL_REVENUE FROM `sample - superstore`;

##City wise sales
SELECT City, SUM(`Total amount`) AS CITY_WISE_SALE
 FROM `sample - superstore`
 GROUP BY CITY
 ORDER BY TOTAL_REVENUE DESC;
 
## Category wise sales
SELECT Category, SUM(`Total amount`) AS CATEGORY_WISE
FROM `sample - superstore`
GROUP BY Category
ORDER BY CATEGORY_WISE DESC;

#CONVERT TO CORRECT DATE FORMATE
SELECT `Order Date`,
       CASE
           WHEN `Order Date` LIKE '%/%' 
               THEN STR_TO_DATE(`Order Date`, '%m/%d/%Y')
           WHEN `Order Date` LIKE '%-%' AND LENGTH(`Order Date`) = 10
               THEN STR_TO_DATE(`Order Date`, '%d-%m-%Y')
           WHEN `Order Date` LIKE '____-__-__'
               THEN STR_TO_DATE(`Order Date`, '%Y-%m-%d')
       END AS Converted
FROM `sample - superstore`
LIMIT 20;

SELECT 
YEAR(`Order Date`) AS Year,
MONTH(`Order Date`) AS Month,
SUM(`Total amount`) AS Monthly_Sales
FROM `sample - superstore`
GROUP BY YEAR, Month
ORDER BY YEAR, Month;

##New vs Returning Customer
WITH first_purchase AS 
(SELECT `Customer ID`, MIN(`Order Date`) AS First_Date
FROM `sample - superstore`
GROUP BY `Customer ID`)

SELECT s.`Customer ID`,
CASE
WHEN S.`Order Date` = f.First_Date THEN 'New CUSTOMER'
ELSE 'Returning Customer'
END AS Customer_Type,
SUM(s.`Total amount`) AS Spending
FROM `sample - superstore` s
JOIN first_purchase f 
ON s.`Customer ID` = f.`Customer ID`
Group by s.`Customer ID`, customer_Type;

 