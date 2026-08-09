/*====================================================
DDL Script : Bronze Layer
Description: Creates all bronze tables
Author      : Vishal Tiwari
====================================================*/

IF OBJECT_ID('bronze.crm_customers', 'U') IS NOT NULL
   DROP TABLE bronze.crm_customers
GO

CREATE TABLE bronze.crm_customers
(
    Customer_ID       NVARCHAR(20),
    Customer_Name     NVARCHAR(200),
    Company_Name      NVARCHAR(200),
    City              NVARCHAR(100),
    State             NVARCHAR(100),
    Country           NVARCHAR(100),
    Industry          NVARCHAR(100),
    Customer_Segment  NVARCHAR(100),
    Join_Date         NVARCHAR(20),
    Customer_Status   NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_employees', 'U') IS NOT NULL
   DROP TABLE bronze.erp_employees
GO

CREATE TABLE bronze.erp_employees
 (
    Employee_ID   NVARCHAR (50),
    Employee_Name NVARCHAR (50),
    Department    NVARCHAR (50),
    Job_Title     NVARCHAR (50),
    Region        NVARCHAR (50),
    Hire_Date     NVARCHAR (50)

 );
 GO

 IF OBJECT_ID('bronze.erp_inventory_transactions', 'U') IS NOT NULL
    DROP TABLE bronze.erp_inventory_transactions
GO

 CREATE TABLE bronze.erp_inventory_transactions
 (
    Inventory_Transaction_Id NVARCHAR (50),
    Product_ID               NVARCHAR (50),
    Warehouse_ID             NVARCHAR (50),
    Transaction_Date         NVARCHAR (50),
    Transaction_Type         NVARCHAR (50),
    Quantity                 INT,
    Supplier_ID              NVARCHAR (50)
);
GO

IF OBJECT_ID('bronze.erp_order_details', 'U') IS NOT NULL
    DROP TABLE bronze.erp_order_details
GO

CREATE TABLE bronze.erp_order_details
(
    Order_Details_ID  NVARCHAR(50),
    Order_ID          NVARCHAR(50),
    Product_ID        NVARCHAR(50),
    Quantity          INT,
    Unit_Price        DECIMAL(18,2),
    Discount_Percent  DECIMAL(5,2),
    Gross_Sales       DECIMAL(18,2),
    Discount_Amount   DECIMAL(18,2),
    Net_Sales         DECIMAL(18,2)
);
GO

IF OBJECT_ID('bronze.erp_orders', 'U') IS NOT NULL
    DROP TABLE bronze.erp_orders
GO

CREATE TABLE bronze.erp_orders
(
    Order_ID        NVARCHAR (50),
    Customer_ID     NVARCHAR (50),
    Employee_ID     NVARCHAR (50),
    Order_Date      NVARCHAR (50),
    Required_Date   NVARCHAR (50),
    Order_Status    NVARCHAR (50),
    Payment_Status  NVARCHAR (50),
    Shipping_City   NVARCHAR (50),
    Ship_Date       NVARCHAR (50)
);
GO

IF OBJECT_ID('bronze.erp_products', 'U') IS NOT NULL
    DROP TABLE bronze.erp_products
GO

CREATE TABLE bronze.erp_products
(
    Product_ID      NVARCHAR (50),
    Product_Name    NVARCHAR (50),
    Category        NVARCHAR (50),
    Model_No        NVARCHAR (50),
    Capacity        NVARCHAR (50),
    Pressure        NVARCHAR (50),
    Unit_Cost       DECIMAL(18,2),
    Unit_Price      DECIMAL(18,2)
);
GO

IF OBJECT_ID('bronze.erp_suppliers', 'U') IS NOT NULL
    DROP TABLE bronze.erp_suppliers
GO

CREATE TABLE bronze.erp_suppliers
(
    Supplier_ID     NVARCHAR (50),
    Supplier_Name   NVARCHAR (50),
    City            NVARCHAR (50),
    State           NVARCHAR (50),
    Supplier_Category NVARCHAR (50),
    Supplier_Status   NVARCHAR (50)
);
GO

IF OBJECT_ID('bronze.erp_warehouses','U') IS NOT NULL
    DROP TABLE bronze.erp_warehouses
GO

CREATE TABLE bronze.erp_warehouses
(
    Warehouse_ID    NVARCHAR (50),
    Warehouse_Name  NVARCHAR (50),
    City            NVARCHAR (50),
    State           NVARCHAR (50),
    Capacity_Units  INT
);
GO
