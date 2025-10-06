-- first create database
create database Ecommerce_Sales_Analytics;

-- drop table 
drop table if exists customers;

-- create tables
-- table-1
create table customers(
	customer_id serial primary key,
	name varchar(50),
	email varchar(100),
	phone varchar(15),
	city varchar(50),
	state varchar(50),
	signup_date date
);

-- see the table
select*from customers;

-- import table data 
COPY customers(customer_id,name,email,phone,city,state,signup_date) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Books.csv' 
CSV HEADER;

-- drop table 
drop table if exists products;

-- table-2
create table products(
	product_id serial primary key,
	product_name varchar(100),
	category varchar(50),
	price decimal(10,2),
	stock_quantity int 
);

-- see the table
select*from products;

-- import table data 
COPY products(product_id,product_name,category,price,stock_quantity) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\products.csv' 
CSV HEADER;

-- table-3

-- drop table if any mistake to create table 
drop table if exists orders;

create table orders(
	order_id serial primary key,
	customer_id int references customers(customer_id),
	order_date date,
	status varchar(20) check(status in('Delivered', 'Pending', 'Shipped', 'Cancelled'))
);

-- see the table
select*from orders;

-- import table data 
COPY orders(order_id,customer_id,order_date,status) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\orders.csv' 
CSV HEADER;

-- table-4

-- drop table if any mistake to create table 
drop table if exists orderdetails;

create table orderdetails(
	orderdetail_id serial primary key,
	order_id int references orders(order_id),
	product_id int references products(product_id),
	quantity int not null,
	price decimal(10,2) not null
);

-- see the table
select*from orderdetails;

-- import table data 
COPY orderdetails(orderdetail_id,order_id,product_id,quantity,price) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\orderdetails.csv' 
CSV HEADER;


-- drop table
drop table if exists payments;

-- table-5
create table payments(
	payment_id serial primary key,
	order_id int references orders(order_id),
	amount decimal(10,2),
	payment_date date,
	payment_method varchar(50)
);

-- see the table
select*from payments;

-- import table data 
COPY payments(payment_id,order_id,amount,payment_date,payment_method) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\payments.csv' 
CSV HEADER;

-- drop table  
drop table if exists returns;

--table-6
create table returns(
	return_id serial primary key,
	order_id int references orders(order_id),
	return_date	date,
	reason varchar(200)
);

-- see the table
select*from returns;

-- import table data 
COPY returns(return_id,order_id,return_date,reason) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\returns.csv' 
CSV HEADER;

-- 100 SQL Questions for Data Science (E-commerce Dataset)

-- 1️⃣ Basic Queries (15)

-- List all customers.
select*from customers;

-- Show all products in the Electronics category.
select*from products
where category='Electronics';

-- Get all orders placed in the year 2024.
select*from orders
where order_date between'2024-01-01'and'2024-12-31';

-- Find customers from "Delhi".
select name,city from customers
where city='Delhi';

-- Show products with price greater than 5000.
select product_name,price from products
where price>5000;

-- Find products that are out of stock.
select product_name,stock_quantity from products
where stock_quantity=0;
-- Show customers who signed up in the last 30 days.
select name,signup_date from customers
where signup_date>=current_date-interval '30 days';

-- Display all pending orders.
select*from orders
where status='Pending';

-- Show payments greater than 10000.
select*from payments
where amount>10000;

-- Find customers who have never placed an order.
select*from customers c
where not exists(
    select 1 
    from orders o
    where o.customer_id = c.customer_id
);
-- or
select c.*from customers c
left join orders o on c.customer_id = o.customer_id
where o.order_id is null;

-- List the distinct product categories.
select distinct category 
from products;

-- Find the cheapest product.
select *from products
order by price asc
limit 1;

-- Find the most expensive product.
select *from products
order by price desc
limit 1;

-- Show the total number of customers.
select count(*) as total_customers
from customers;

-- Show the total number of orders.
select count(*)as total_order
from orders;

-- 2️⃣ Joins & Relationships (15)

-- Show customer names along with their order IDs.

-- Show orders along with the product details purchased.

-- Find the payment status of each order.

-- Show customers and their total payments.

-- Show customers who have returned an order.

-- Find all orders with multiple products.

-- Find the city with the most orders.

-- Show the top 5 most sold products.

-- Show customers with more than 3 orders.

-- Find orders that have no payment yet.

-- List products that have never been ordered.

-- Show customer details for returned orders.

-- Find average payment per order.

-- Show product categories with total sales amount.

-- Find customers who bought products from more than 1 category.

-- 3️⃣ Aggregation & Group By (15)

-- Find total sales revenue.

-- Calculate monthly sales revenue.

-- Find average order value.

-- Show number of orders per customer.

-- Find top 3 customers by total spending.

-- Show product-wise total sales.

-- Find category-wise average product price.

-- Count how many orders were returned.

-- Find % of returned orders vs total orders.

-- Find city-wise sales distribution.

-- Show top 3 categories by sales amount.

-- Find minimum, maximum, average payment amounts.

-- Show daily sales trend in the last 7 days.

-- Calculate revenue contribution of each category.

-- Find the month with highest revenue.

-- 4️⃣ Subqueries & CTE (15)

-- Find customers who spent more than the average spending.

-- Find products priced higher than the average product price.

-- Show orders above the overall average order value.

-- Find customers who ordered the most expensive product.

-- Find top 5 products by revenue using a subquery.

-- Find the 2nd highest spending customer.

-- Show products that were never returned.

-- Find customers who placed orders in every month of 2024.

-- Show repeat customers (more than 1 order).

-- Find customers who placed exactly 1 order.

-- Find orders where payment > 2 times the average payment.

-- Show the most returned product using CTE.

-- Find monthly revenue growth using CTE.

-- Show customer with highest lifetime value using subquery.

-- Show category-wise rank of products by sales using CTE.

-- 5️⃣ Window Functions (15)

-- Rank customers by spending.

-- Rank products by sales within each category.

-- Show the top order of each customer.

-- Calculate running total of sales by month.

-- Calculate moving average of sales (last 3 months).

-- Show difference in spending between current and previous order (per customer).

-- Find customers who improved their spending month over month.

-- Show best-selling product in each month.

-- Rank customers by number of returns.

-- Find top 2 products in each category.

-- Show rank of cities by sales.

-- Calculate cumulative revenue till date.

-- Compare this month vs last month revenue per customer.

-- Show lag in payment dates for each order.

-- Find first and last order date per customer.

-- 6️⃣ Date & Time Analysis (10)

-- Find orders placed on weekends.

-- Show sales by day of week.

-- Find average order value per month.

-- Find revenue for the last 3 months.

-- Show customers who signed up in 2024.

-- Show orders placed in Q1 (Jan–Mar).

-- Find peak order hour of the day.

-- Calculate average delivery time (order vs return date difference).

-- Find customers who haven’t ordered in last 90 days.

-- Show year-over-year revenue growth.

-- 7️⃣ Advanced Business Metrics (15)

-- Calculate Customer Lifetime Value (CLV).

-- Find Customer Retention Rate.

-- Find Repeat Purchase Rate (RPR).

-- Find Average Revenue Per User (ARPU).

-- Find Customer Acquisition per month.

-- Find Churned Customers (no order in last 6 months).

-- Calculate Return Rate % per category.

-- Find contribution of top 20% customers (Pareto principle).

-- Find product cross-selling opportunities (customers who buy X also buy Y).

-- Find average basket size (products per order).

-- Calculate Gross Merchandise Value (GMV).

-- Find revenue lost due to returns.

-- Find city with highest average revenue per customer.

-- Compare Electronics vs Clothing revenue growth.

-- Create customer segmentation: High, Medium, Low spenders.