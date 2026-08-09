/*====================================================
DDL Script : Silver Layer
Description: Creates all Silver tables
Author      : Vishal Tiwari
====================================================*/
PRINT '>>> Creating Silver Table---------------------';
IF OBJECT_ID('silver.crm_customers', 'U') IS NOT NULL
    DROP TABLE silver.crm_customers;
GO

CREATE TABLE silver.crm_customers
(
    Customer_ID       NVARCHAR(20),
    Customer_Name     NVARCHAR(200),
    Company_Name      NVARCHAR(200),
    City              NVARCHAR(100),
    State             NVARCHAR(100),
    Country           NVARCHAR(100),
    Industry          NVARCHAR(100),
    Customer_Segment  NVARCHAR(100),
    Join_Date         DATE,
    Customer_Status   NVARCHAR(50)
);
GO

IF OBJECT_ID('silver.erp_employees', 'U') IS NOT NULL
    DROP TABLE silver.erp_employees;
GO

CREATE TABLE silver.erp_employees
 (
    Employee_ID   NVARCHAR (50),
    Employee_Name NVARCHAR (50),
    Department    NVARCHAR (50),
    Job_Title     NVARCHAR (50),
    Region        NVARCHAR (50),
    Hire_Date     DATE

 );

GO

IF OBJECT_ID('silver.erp_inventory_transactions', 'U') IS NOT NULL
    DROP TABLE silver.erp_inventory_transactions;
GO

CREATE TABLE silver.erp_inventory_transactions
 (
    Inventory_Transaction_Id NVARCHAR (50),
    Product_ID               NVARCHAR (50),
    Warehouse_ID             NVARCHAR (50),
    Transaction_Date         DATE,
    Transaction_Type         NVARCHAR (50),
    Quantity                 INT,
    Supplier_ID              NVARCHAR (50)
);

GO

IF OBJECT_ID('silver.erp_order_details', 'U') IS NOT NULL
    DROP TABLE silver.erp_order_details;
GO

CREATE TABLE silver.erp_order_details
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

IF OBJECT_ID('silver.erp_orders', 'U') IS NOT NULL
    DROP TABLE silver.erp_orders
GO

CREATE TABLE silver.erp_orders
(
    Order_ID        NVARCHAR (50),
    Customer_ID     NVARCHAR (50),
    Employee_ID     NVARCHAR (50),
    Order_Date      DATE,
    Required_Date   DATE,
    Order_Status    NVARCHAR (50),
    Payment_Status  NVARCHAR (50),
    Shipping_City   NVARCHAR (50),
    Ship_Date       DATE
);

GO

IF OBJECT_ID('silver.erp_products', 'U') IS NOT NULL
    DROP TABLE silver.erp_products;
GO


CREATE TABLE silver.erp_products
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

IF OBJECT_ID('silver.erp_suppliers', 'U') IS NOT NULL
    DROP TABLE silver.erp_suppliers;
GO

CREATE TABLE silver.erp_suppliers
(
    Supplier_ID     NVARCHAR (50),
    Supplier_Name   NVARCHAR (50),
    City            NVARCHAR (50),
    State           NVARCHAR (50),
    Supplier_Category NVARCHAR (50),
    Supplier_Status   NVARCHAR (50)
);
GO

IF OBJECT_ID('silver.erp_warehouses', 'U') IS NOT NULL
    DROP TABLE silver.erp_warehouses;
GO

CREATE TABLE silver.erp_warehouses
(
    Warehouse_ID    NVARCHAR (50),
    Warehouse_Name  NVARCHAR (50),
    City            NVARCHAR (50),
    State           NVARCHAR (50),
    Capacity_Units  INT
);
GO


