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
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\customers.csv' 
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

-- Queries 

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

-- Show customer names along with their order IDs.
select c.name,o.order_id
from customers c
join orders o
on c.customer_id =o.customer_id;

-- Show orders along with the product details purchased.
select o.order_id,p.product_name,od.price,od.quantity
from orders o
join orderdetails od on o.order_id=od.order_id
join products p on p.product_id=od.product_id;

-- Find the payment status of each order.
select o.order_id, 
case when p.payment_id is not null then 'Paid' 
else 'Not Paid' end as payment_status
from orders o
left join payments p on o.order_id = p.order_id;

-- Show customers and their total payments.
select c.name, sum(p.amount) as total_payment
from customers c
join orders o on c.customer_id = o.customer_id
join payments p on o.order_id = p.order_id
group by c.name;

-- Show customers who have returned an order.
select distinct c.name
from customers c
join orders o on c.customer_id = o.customer_id
join returns r on o.order_id = r.order_id;

-- Find all orders with multiple products.
select o.order_id
from orderdetails od
join orders o on o.order_id = od.order_id
group by o.order_id
having count(od.product_id) > 1;

-- Find the city with the most orders.
select c.city, count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.city
order by total_orders desc
limit 1;

-- Show customers with more than 3 orders.
select c.name, count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.name
having count(o.order_id) > 3;

-- Find orders that have no payment yet.
select o.order_id
from orders o
left join payments p on o.order_id = p.order_id
where p.payment_id is null;

-- Find total sales revenue.
select sum(od.price * od.quantity) as total_sales_revenue
from orderdetails od;

-- Find average order value.
select avg(total_amount) as avg_order_value
from (
    select o.order_id, sum(od.price * od.quantity) as total_amount
    from orders o
    join orderdetails od on o.order_id = od.order_id
    group by o.order_id
) sub;

-- Show number of orders per customer.
select c.name, count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.name;

-- Show product-wise total sales.
select category, avg(price) as avg_price
from products
group by category;

-- Count how many orders were returned.
select count(distinct r.order_id) as total_returns
from returns r;

-- Find minimum, maximum, average payment amounts.
select min(amount) as min_payment,
       max(amount) as max_payment,
       avg(amount) as avg_payment
from payments;

-- Show daily sales trend in the last 7 days.
select o.order_date, sum(od.price * od.quantity) as daily_sales
from orders o
join orderdetails od on o.order_id = od.order_id
where o.order_date >= current_date - interval '7 days'
group by o.order_date
order by o.order_date;

-- Find the month with highest revenue.
select date_trunc('month', o.order_date) as month, sum(od.price * od.quantity) as monthly_revenue
from orders o
join orderdetails od on o.order_id = od.order_id
group by month
order by monthly_revenue desc
limit 1;

-- Find products priced higher than the average product price.
select *
from products
where price > (select avg(price) from products);

-- Find top 5 products by revenue using a subquery.
select p.product_name, sum(od.price * od.quantity) as revenue
from products p
join orderdetails od on p.product_id = od.product_id
group by p.product_name
order by revenue desc
limit 5;

-- Find customers who placed exactly 1 order.
select c.name
from customers c
join orders o on c.customer_id = o.customer_id
group by c.name
having count(o.order_id) = 1;

-- Rank customers by spending.
select c.name, sum(od.price * od.quantity) as total_spent,
       rank() over(order by sum(od.price * od.quantity) desc) as spending_rank
from customers c
join orders o on c.customer_id = o.customer_id
join orderdetails od on o.order_id = od.order_id
group by c.name;

-- Show lag in payment dates for each order.
select order_id, payment_date,
       payment_date - lag(payment_date) over(partition by order_id order by payment_date) as days_since_last_payment
from payments;

-- Find first and last order date per customer.
select customer_id,
       min(order_date) over(partition by customer_id) as first_order,
       max(order_date) over(partition by customer_id) as last_order
from orders;

-- Find orders placed on weekends.
select *
from orders
where extract(dow from order_date) in (0,6);  -- 0 = Sunday, 6 = Saturday

-- Show sales by day of week.
select extract(dow from o.order_date) as day_of_week, sum(od.price * od.quantity) as total_sales
from orders o
join orderdetails od on o.order_id = od.order_id
group by day_of_week
order by day_of_week;

-- Find average order value per month.
select date_trunc('month', o.order_date) as month,
       avg(od.price * od.quantity) as avg_order_value
from orders o
join orderdetails od on o.order_id = od.order_id
group by month
order by month;

-- Show customers who signed up in 2024.
select *
from customers
where extract(year from signup_date) = 2024;

-- Show orders placed in Q1 (Jan–Mar).
select *
from orders
where extract(month from order_date) between 1 and 3;

-- Calculate average delivery time (order vs return date difference).
select avg(r.return_date - o.order_date) as avg_delivery_days
from orders o
join returns r on o.order_id = r.order_id;

-- Calculate Customer Lifetime Value (CLV).
select c.customer_id, c.name,
     sum(od.price * od.quantity) as lifetime_value
from customers c
join orders o on c.customer_id = o.customer_id
join orderdetails od on o.order_id = od.order_id
group by c.customer_id, c.name;

-- Find Customer Retention Rate.

-- Find Repeat Purchase Rate (RPR).
select (count(distinct customer_id)::decimal / (select count(*) from customers)) * 100 as repeat_purchase_rate
from orders
group by customer_id
having count(order_id) > 1;

-- Find Average Revenue Per User (ARPU).
select sum(od.price * od.quantity)/count(distinct o.customer_id) as arpu
from orders o
join orderdetails od on o.order_id = od.order_id;

-- Find Customer Acquisition per month.
select date_trunc('month', signup_date) as month, count(*) as new_customers
from customers
group by month
order by month;

-- Find revenue lost due to returns.
select sum(od.price * od.quantity) as revenue_lost
from returns r
join orderdetails od on r.order_id = od.order_id;

-- Compare Electronics vs Clothing revenue growth.
select category, sum(od.price * od.quantity) as total_revenue
from products p
join orderdetails od on p.product_id = od.product_id
where category in ('Electronics','Clothing')
group by category;

