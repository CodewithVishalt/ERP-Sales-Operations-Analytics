/*====================================================
DDL Script : Gold Layer
Description: Creates all Gold tables
Author      : Vishal Tiwari
====================================================*/

IF OBJECT_ID('gold.dim_customers', 'U') IS NOT NULL
	DROP TABLE gold.dim_customers

CREATE TABLE gold.dim_customers
(	
	Customer_Key INT IDENTITY(1,1) PRIMARY KEY,
	Customer_ID NVARCHAR(50),
	Customer_Name NVARCHAR(100),
	Company_Name NVARCHAR (100),
	City         NVARCHAR (50),
	State        NVARCHAR (50),
	Country      NVARCHAR (50),
	Industry     NVARCHAR (50),
	Customer_Segment NVARCHAR (50),
	Join_Date    DATE,
	Customer_Status  NVARCHAR (50)
)

IF OBJECT_ID('gold.dim_employees', 'U') IS NOT NULL
	DROP TABLE gold.dim_employees

CREATE TABLE gold.dim_employees
(
	Employee_Key   INT IDENTITY(1,1) PRIMARY KEY, 
	Employee_ID		NVARCHAR (15),
	Employee_Name	NVARCHAR (50),
	Department		NVARCHAR (30),
	Job_Title		NVARCHAR (100),
	Region			NVARCHAR (20),
	Hire_Date		DATE
)

IF OBJECT_ID('gold.dim_products', 'U') IS NOT NULL
    DROP TABLE gold.dim_products;

CREATE TABLE gold.dim_products
(
	Product_key  INT IDENTITY(1,1) PRIMARY KEY,
	Product_Id   NVARCHAR (50),
	Product_Name NVARCHAR (1000),
	Category     NVARCHAR (50),
	Model_No     NVARCHAR (55),
	Capacity     NVARCHAR (30),
	Pressure     NVARCHAR (30),
	Unit_Cost  DECIMAL(18,2),
	Unit_Price DECIMAL(18,2)

)

IF OBJECT_ID('gold.dim_suppliers', 'U') IS NOT NULL
    DROP TABLE gold.dim_suppliers;

CREATE TABLE gold.dim_suppliers
(
	Supplier_Key  INT IDENTITY(1,1) PRIMARY KEY,
	Supplier_ID   NVARCHAR (20),
	Supplier_Name NVARCHAR (100),
	City          NVARCHAR (50),
	State         NVARCHAR (50),
	Supplier_Category  NVARCHAR (50),
	Supplier_Status  NVARCHAR (20)
)

IF OBJECT_ID('gold.dim_warehouses', 'U') IS NOT NULL
    DROP TABLE gold.dim_warehouses;

CREATE TABLE gold.dim_warehouses
(
	Warehouse_Key   INT IDENTITY(1,1) PRIMARY KEY,
	Warehouse_ID    NVARCHAR (20),
	Warehouse_Name  NVARCHAR (50),
	City            NVARCHAR (20),
	State           NVARCHAR (20),
	Capacity_Units  INT
)

IF OBJECT_ID('gold.dim_date', 'U') IS NOT NULL
    DROP TABLE gold.dim_date

CREATE TABLE gold.dim_date
(
    Date_Key      INT PRIMARY KEY,
    Date          DATE,
    Year          INT,
    Quarter       INT,
    Month         INT,
    Month_Name    NVARCHAR(20),
    Day           INT,
    Day_Name      NVARCHAR(20)
);

IF OBJECT_ID('gold.fact_sales', 'U') IS NOT NULL
    DROP TABLE gold.fact_sales;

CREATE TABLE gold.fact_sales
(
    Sales_Key INT IDENTITY(1,1) PRIMARY KEY,

    Order_Details_ID NVARCHAR(50),
    Order_ID          NVARCHAR(50),

    Customer_Key      INT,
    Employee_Key      INT,
    Product_Key       INT,

    Order_Date        DATE,
    Required_Date     DATE,
    Ship_Date         DATE,

    Quantity          INT,
    Unit_Price        DECIMAL(18,2),
    Gross_Sales       DECIMAL(18,2),
    Discount_Amount   DECIMAL(18,2),
    Discount_Percent  DECIMAL(10,2),
    Net_Sales         DECIMAL(18,2)
);

IF OBJECT_ID('gold.fact_inventory', 'U') IS NOT NULL
    DROP TABLE gold.fact_inventory;

CREATE TABLE gold.fact_inventory
(
    Inventory_Key INT IDENTITY(1,1) PRIMARY KEY,

    Inventory_Transaction_ID NVARCHAR(50),

    Product_Key   INT,
    Warehouse_Key INT,
    Supplier_Key  INT,

    Transaction_Date DATE,
    Transaction_Type NVARCHAR(30),

    Quantity INT
);
