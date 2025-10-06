# Ecommerce Sales Analytics

A PostgreSQL database project to track **customers, orders, products, payments, and returns**. Built to analyze sales trends, customer behavior, and product performance.

---

## Tables

- **Customers** – Customer info (name, email, city, signup date)  
- **Products** – Product details (name, category, price, stock)  
- **Orders** – Orders with status  
- **OrderDetails** – Products in each order  
- **Payments** – Payment info  
- **Returns** – Returned orders

---

## Features

- Import data from CSV files  
- Query total sales, top products, revenue lost, repeat customers  
- Analytics: monthly sales, average order value, customer lifetime value (CLV)  
- Identify customers with no orders or returns  

---

## Usage

1. Clone the repo  
2. Create database: `CREATE DATABASE Ecommerce_Sales_Analytics;`  
3. Run SQL scripts to create tables and import CSV data  
4. Run queries to get insights  

---

## Files

customers.csv
products.csv
orders.csv
orderdetails.csv
payments.csv
returns.csv
database_setup.sql
