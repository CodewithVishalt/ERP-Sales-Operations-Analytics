--------------- Inserting the Gold Layer -----------------

TRUNCATE TABLE gold.dim_customers;

INSERT INTO gold.dim_customers
(
    Customer_ID,
    Customer_Name,
    Company_Name,
    City,
    State,
    Country,
    Industry,
    Customer_Segment,
    Join_Date,
    Customer_Status
)
SELECT
    Customer_ID,
    Customer_Name,
    Company_Name,
    City,
    State,
    Country,
    Industry,
    Customer_Segment,
    Join_Date,
    Customer_Status
FROM silver.crm_customers;

TRUNCATE TABLE gold.dim_employees;

INSERT INTO gold.dim_employees
(
    Employee_ID,
    Employee_Name,
    Department,
    Job_Title,
    Region,
    Hire_Date
)
SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Job_Title,
    Region,
    Hire_Date
FROM silver.erp_employees;


TRUNCATE TABLE gold.dim_products;

INSERT INTO gold.dim_products
(
    Product_ID,
    Product_Name,
    Category,
    Model_No,
    Capacity,
    Pressure,
    Unit_Cost,
    Unit_Price
)
SELECT
    Product_ID,
    Product_Name,
    Category,
    Model_No,
    Capacity,
    Pressure,
    Unit_Cost,
    Unit_Price
FROM silver.erp_products;

TRUNCATE TABLE gold.dim_suppliers;

INSERT INTO gold.dim_suppliers
(
    Supplier_ID,
    Supplier_Name,
    City,
    State,
    Supplier_Category,
    Supplier_Status
)
SELECT
    Supplier_ID,
    Supplier_Name,
    City,
    State,
    Supplier_Category,
    Supplier_Status
FROM silver.erp_suppliers;

TRUNCATE TABLE gold.dim_warehouses;

INSERT INTO gold.dim_warehouses
(
    Warehouse_ID,
    Warehouse_Name,
    City,
    State,
    Capacity_Units
)
SELECT
    Warehouse_ID,
    Warehouse_Name,
    City,
    State,
    Capacity_Units
FROM silver.erp_warehouses;

INSERT INTO gold.fact_sales
(
    Order_Details_ID,
    Order_ID,
    Customer_Key,
    Employee_Key,
    Product_Key,
    Order_Date,
    Required_Date,
    Ship_Date,
    Quantity,
    Unit_Price,
    Gross_Sales,
    Discount_Amount,
    Discount_Percent,
    Net_Sales
)


SELECT
    od.Order_Details_ID,
    od.Order_ID,

    c.Customer_Key,
    e.Employee_Key,
    p.Product_Key,

    o.Order_Date,
    o.Required_Date,
    o.Ship_Date,

    od.Quantity,
    od.Unit_Price,
    od.Gross_Sales,
    od.Discount_Amount,
    od.Discount_Percent,
    od.Net_Sales

FROM silver.erp_order_details od

INNER JOIN silver.erp_orders o
    ON od.Order_ID = o.Order_ID

LEFT JOIN gold.dim_customers c
    ON o.Customer_ID = c.Customer_ID

LEFT JOIN gold.dim_employees e
    ON o.Employee_ID = e.Employee_ID

LEFT JOIN gold.dim_products p
    ON od.Product_ID = p.Product_ID;


TRUNCATE TABLE gold.fact_inventory;

INSERT INTO gold.fact_inventory
(
    Inventory_Transaction_ID,
    Product_Key,
    Warehouse_Key,
    Supplier_Key,
    Transaction_Date,
    Transaction_Type,
    Quantity
)
SELECT
    i.Inventory_Transaction_ID,
    p.Product_Key,
    w.Warehouse_Key,
    s.Supplier_Key,
    i.Transaction_Date,
    i.Transaction_Type,
    i.Quantity
FROM silver.erp_inventory_transactions i
LEFT JOIN gold.dim_products p
    ON TRIM(i.Product_ID) = TRIM(p.Product_ID)
LEFT JOIN gold.dim_warehouses w
    ON TRIM(i.Warehouse_ID) = TRIM(w.Warehouse_ID)
LEFT JOIN gold.dim_suppliers s
    ON TRIM(i.Supplier_ID) = TRIM(s.Supplier_ID);


SELECT
    COUNT(*) AS Total_Rows,
    SUM(Quantity) AS Total_Quantity,
    SUM(Gross_Sales) AS Total_Gross_Sales,
    SUM(Discount_Amount) AS Total_Discount,
    SUM(Net_Sales) AS Total_Net_Sales
FROM gold.fact_sales;
