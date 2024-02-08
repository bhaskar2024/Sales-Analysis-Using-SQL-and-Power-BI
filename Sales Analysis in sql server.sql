-- Database - Pizza Sales DB
-- Table - pizza_sales

-- Overview of Pizza Sales Table
select * from pizza_sales;
-- The Pizza Sales dataset includes 48,620 rows and 12 columns, offering a detailed perspective on sales dynamics.

-- KPI's - Key Performance Indicators
-- 1. Total Revenue

Select sum(total_price) as Total_Revenue from pizza_sales;
-- Total Revenue of pizza sold is $817860.05.

-- 2. Average Order Value
Select round(sum(total_price) / count(distinct order_id), 2) AS Average_Order_Value from pizza_sales;
Select sum(total_price) / count(distinct order_id) AS Average_Order_Value from pizza_sales;
-- Average Order Value is 38.31.

-- 3. Total Pizza Sold

Select sum(quantity) AS Total_Pizza_Sold from pizza_sales;

-- Number of Total Pizza Sold is 49574.

-- 4. Total Order

Select count(Distinct order_id) AS Total_Orders from pizza_sales

-- total orders are 21350

-- 5. Average Pizzas per Order

Select CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(Distinct order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Average_Pizzas_Per_Order 
from pizza_sales;

-- Average Pizzas per Order are 2.32.

--	Charts Requirements

-- 1. Daily Trend for Total Orders
Select datename(DW, order_date) AS Order_Day, count(Distinct order_id) AS Total_Orders 
from pizza_sales
group by datename(DW, order_date);

--2. Monthly trend for total Orders
Select DATENAME(MONTH, order_date) AS Order_Month, count(Distinct order_id) AS Total_Orders
from pizza_sales
Group BY DATENAME(MONTH, order_date)
Order BY Total_Orders DESC;

-- 3. Percentage Of Sales by Pizza Category
Select pizza_category, round(SUM(total_price),2) AS Total_Sales,
Cast(SUM(total_price) * 100/(Select sum(total_price) from pizza_sales) AS decimal(10,2)) AS Sales_Percentage
from pizza_sales
Group BY pizza_category
Order BY Sales_Percentage DESC;

-- Applying Filter Month
Select pizza_category, round(SUM(total_price),2) AS Total_Sales,
Cast(SUM(total_price) * 100/(Select sum(total_price) from pizza_sales Where MONTH(order_date)=1) AS decimal(10,2)) 
AS Sales_Percentage
from pizza_sales
Where MONTH(order_date) = 1
Group BY pizza_category
Order BY Sales_Percentage DESC;
-- Month(order_date) = 1 means january, we can write 1-12 for month January to December.

-- 4. Percentage of Sals by Pizza Size
Select pizza_size, ROUND(SUM(total_price),2) AS Total_Sales,
ROUND(SUM(total_price)*100 / (Select SUM(total_price) from pizza_sales), 2) AS Sales_PCT
from pizza_sales
Group BY pizza_size
Order BY Sales_PCT DESC;

-- Applyong Filter Month
Select pizza_size, ROUND(SUM(total_price),2) AS Total_Sales,
ROUND(SUM(total_price)*100 / (Select SUM(total_price) from pizza_sales Where Month(order_date)=3), 2) AS Sales_PCT
from pizza_sales
Where MONTH(order_date) = 3
Group BY pizza_size
Order BY Sales_PCT DESC;
-- Month(order_date) = 3 means March Month

-- Applying Filter by Pizza Category
Select pizza_size, ROUND(SUM(total_price),2) AS Total_Sales,
ROUND(SUM(total_price)*100 / (Select SUM(total_price) from pizza_sales Where pizza_category = 'Classic'), 2) AS Sales_PCT
from pizza_sales
Where pizza_category = 'Classic'
Group BY pizza_size
Order BY Sales_PCT DESC;

-- Applying filter by Quarter there are 4 quarter in a year
Select pizza_size, ROUND(SUM(total_price),2) AS Total_Sales,
ROUND(SUM(total_price)*100 / (Select SUM(total_price) from pizza_sales Where DATEPART(Quarter, order_date) = 1), 2) AS Sales_PCT
from pizza_sales
Where DATEPART(Quarter, order_date) = 1
Group BY pizza_size
Order BY Sales_PCT DESC
-- this result is fot first quarter (3 months)

-- 5. Total Pizza Sold by Pizza Category
Select pizza_category, sum(quantity) AS Total_Pizza_Sold
from pizza_sales
Group BY pizza_category;

-- 6. TOP 5 Best Sellers Pizza by Revenue, Total Quantity, Total Orders
-- Revenue
Select top 5 pizza_name, SUM(total_price) AS Total_Revenue
from pizza_sales
Group by pizza_name
Order by Total_Revenue DESC;

-- Total Quantity
Select TOP 5 pizza_name, SUM(Quantity) AS Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity DESC;

-- Total_Orders
Select TOP 5 pizza_name, COUNT(Distinct order_id) AS Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders DESC;

-- 7. Bottom 5 Pizza By Revenue
Select TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
from pizza_sales
Group BY pizza_name
Order BY Total_Revenue ASC;

-- Quantity
Select TOP 5 pizza_name, SUM(Quantity) AS Total_Quantity
from pizza_sales
Group BY pizza_name
Order BY Total_Quantity ASC;

-- Total Orders
Select TOP 5 pizza_name, COUNT(Quantity) AS Total_Orders
from pizza_sales
Group BY pizza_name
Order BY Total_Orders ASC;




Select datename(DW, order_date) AS Order_Day, count(Distinct order_id) AS Total_Orders from pizza_sales
Where pizza_category = 'Classic'
group by datename(DW, order_date);




Select top 5 pizza_name, SUM(total_price) AS Total_Revenue, SUM(Quantity) AS Total_Quantity, COUNT(order_id) AS Total_Orders
from pizza_sales
Group by pizza_name
Order by Total_Revenue DESC;
