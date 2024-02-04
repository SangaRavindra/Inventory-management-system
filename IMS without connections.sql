create database Inventory_Management_System;
create table Product(
ProductID int Primary Key,
ProductCode varchar(100),
Barcode  varchar(100),
Product_Name varchar(100),
Product_Description varchar(2000),
Product_Category varchar(100),
Reorder_Quantity int,
Packed_Weight float(10,2),
Packed_Height float(10,2),
Packed_Width float(10,2),
Packed_Depth float(10,2),
Refrigerated Boolean); 

create table Location(
Location_ID int Primary Key,
Location_Name varchar(100),
Location_address varchar(100));

create table Ware_House(
warehouse_ID int Primary Key,
warehouse_Name varchar(100),
Is_Refrigerated Boolean);

create table Inventory(
Inventory_ID int Primary Key,
Quantity_available int,
Min_Stock_Level int,
Max_Stock_level int,
Reorder_Point int);

create table Provider(
Provider_ID int Primary Key,
Provider_Name varchar(100),
Provider_Add varchar(100));

create table Orders(
Order_ID int Primary Key,
Order_Date date);

create table Order_Details(
order_detail_ID int Primary Key,
order_quantity int,
Expected_Date date,
Actual_Date date);

create table Customer(
customer_ID int Primary Key,
customer_Name varchar(100),
customer_Add varchar(200));


create table Delivery(
Delivery_ID int Primary Key,
sales_Date date);
create table Delivery_details(
delivery_detail_ID int,
delivery_quantity int,
Expected_Date date,
Actual_Date date);

create table Transfer(
Transfer_ID int primary key,
Transfer_Quantity int,
sent_date date,
received_date date);

drop table transfer;
drop table order_details;
drop table delivery;