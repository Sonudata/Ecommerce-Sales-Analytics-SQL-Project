## Ecommerce Sales Analytics Database (SQL Project)

- A complete Ecommerce Sales Analytics project built with PostgreSQL, designed to manage and analyze sales, customers, orders, products, payments, and returns.

- This project demonstrates real-world database design, data import, and advanced SQL queries for analytics.

## Database Schema

- The database contains 6 main tables:

1.customers – Customer details like name, email, phone, city, state, and signup date.

2.products – Product information including name, category, price, and stock quantity.

3.orders – Order details linked to customers with status tracking.

4.orderdetails – Products purchased in each order with quantity and price.

5.payments – Payment records for orders, including method and amount.

6.returns – Returned orders and reasons.

## Data Import

CSV files for each table are included. Data is imported using the COPY command in PostgreSQL.

Example:

COPY customers(customer_id,name,email,phone,city,state,signup_date)
FROM 'path_to_csv/customers.csv'
CSV HEADER;

Make sure CSV paths are correct before importing.

 ## SQL Queries

- List all customers and products by category.

- Orders placed in a specific year or quarter.

- Customers who never placed an order.

- Products out of stock or priced above average.

- Total sales revenue, average order value, and daily/monthly sales trends.

- Customer analytics: Lifetime Value (CLV), Repeat Purchase Rate, ARPU, and retention metrics.

- Compare revenue growth across product categories.

These queries help simulate real-world business analytics for an ecommerce platform.

## How to Run

- Open PostgreSQL and create the database:

- CREATE DATABASE Ecommerce_Sales_Analytics;


- Create tables using the provided SQL script.

- Import CSV data using COPY commands.

- Run queries to explore sales and customer insights.

## 🔗 GitHub

Project is hosted here: 
