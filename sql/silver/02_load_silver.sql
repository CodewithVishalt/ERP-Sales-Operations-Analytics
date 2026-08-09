
CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Start_time DATETIME, @End_time DATETIME, @Layer_Start DATETIME, @Layer_End DATETIME;
    BEGIN TRY

      SET @Layer_Start = GETDATE();
      ---------------------------------------------------
      PRINT 'Load Silver CRM Customers'
      ---------------------------------------------------
    
        SET @Start_time = GETDATE()
        PRINT '>> Truncating Table; silver.crm_customers';
        TRUNCATE TABLE silver.crm_customers;

        PRINT '>> Inserting Data Into: silver.crm_customers';
        INSERT INTO silver.crm_customers
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
            TRIM(Customer_Name) AS Customer_Name,
            TRIM(Company_Name) AS Company_Name,
            TRIM(City) AS City,
            TRIM(State) AS State,
            TRIM(Country) AS Country,
        CASE
            WHEN Industry IS NULL OR TRIM(Industry) = '' THEN 'Unknown'
            WHEN TRIM(Industry) = 'Ceramics' THEN 'Ceramics Industry'
            WHEN TRIM(Industry) = 'Chemical' THEN 'Chemical Industry'
            WHEN TRIM(Industry) = 'Dairy' THEN 'Dairy Industry'
            WHEN TRIM(Industry) = 'Mining' THEN 'Mining Industry'
            WHEN TRIM(Industry) = 'Paper' THEN 'Paper Industry'
            WHEN TRIM(Industry) = 'Textile' THEN 'Textile Industry'
            ELSE TRIM(Industry)
        END AS Industry,
            TRIM(Customer_Segment) AS Customer_Segment,
            CASE
                WHEN TRY_CONVERT(DATE, Join_Date, 105) > GETDATE()
                    THEN CAST(GETDATE() AS DATE)
                ELSE TRY_CONVERT(DATE, Join_Date, 105)
            END,
            TRIM(Customer_Status) AS Customer_Status
        FROM bronze.crm_customers;

        PRINT 'Customers Loaded: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR ) + 'seconds';
    
        PRINT '>>---------------';

        ---------------------------------------------------
        PRINT 'Load ERP Employees'
        ---------------------------------------------------

        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table: silver.erp_employees';
        TRUNCATE TABLE silver.erp_employees;

        PRINT '>> Inserting Table Into: silver.erp_employees';
        INSERT INTO silver.erp_employees 
        (
            Employee_ID,
               Employee_Name,
               Department,
               Job_Title,
               Region,
               Hire_Date)
        SELECT Employee_ID,
               TRIM(Employee_Name) AS Employee_Name,
               TRIM(Department) AS Department,
               TRIM(Job_Title) AS Job_Title,
               TRIM(Region) AS Region,
               TRY_CONVERT(DATE, LEFT(Hire_Date, 10), 105) AS Hire_Date
        FROM bronze.erp_employees;

        PRINT 'Employees Loaded: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

        SET @End_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second, @Start_time, @End_time) AS NVARCHAR ) + 'seconds';
        PRINT '>>---------------';

        ---------------------------------------------------
        PRINT 'Load ERP Inventory Transactions'
        ---------------------------------------------------
    
        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table: silver.erp_inventory_transactions';
        TRUNCATE TABLE silver.erp_inventory_transactions;

        PRINT '>> Inserting Data Into: silver.erp_inventory_transactions';
        INSERT INTO silver.erp_inventory_transactions
        (   Inventory_Transaction_Id,
            Product_ID,
            Warehouse_ID,
            Transaction_Date,
            Transaction_Type,
            Quantity,
            Supplier_ID
         )
        SELECT 
            Inventory_Transaction_Id,
            Product_ID,
            Warehouse_ID,
            TRY_CONVERT(DATE, LEFT(Transaction_Date, 10), 105) AS Transaction_Date,
            Transaction_Type,
            Quantity,
            TRIM(REPLACE(Supplier_ID, CHAR(13), '')) AS Supplier_ID
        FROM bronze.erp_inventory_transactions;

        PRINT 'Inventory Transaction Loaded: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF (second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';
    
        PRINT '>>---------------';


        ---------------------------------------------------
        PRINT 'Load ERP Order Details'
        ---------------------------------------------------

        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table: silver.erp_order_details';
        TRUNCATE TABLE silver.erp_order_details;

        PRINT '>> Inserting Data Into: silver.erp_order_details';
        INSERT INTO silver.erp_order_details
        (
            Order_Details_ID,
            Order_ID,
            Product_ID,
            Quantity,
            Unit_Price,
            Gross_Sales,
            Discount_Amount,
            Discount_Percent,
            Net_Sales
         )

        SELECT
            Order_Details_ID,
            Order_ID,
            Product_ID,
            Quantity,
            Unit_Price,
            Gross_Sales,
            Discount_Amount,
            Discount_Percent,
            Net_Sales  
        FROM bronze.erp_order_details;

        PRINT 'Order Details Loaded: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

        SET @End_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF (second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';
    
        PRINT '>>---------------';

        ---------------------------------------------------
        PRINT 'Load ERP Orders'
        ---------------------------------------------------

        SET @Start_time = GETDATE();
        PRINT '>> Truncating Data: silver.erp_orders';
        TRUNCATE TABLE silver.erp_orders;

        PRINT '>> Inserting Data Into: silver.erp_orders';
        INSERT INTO silver.erp_orders
        (
            Order_ID,
            Customer_ID,
            Employee_ID,
            Order_Date,
            Required_Date,
            Order_Status,
            Payment_Status,
            Shipping_City,
            Ship_Date)

        SELECT 
            Order_ID,
            Customer_ID,
            Employee_ID,
            TRY_CONVERT(DATE, LEFT(Order_Date, 10), 105) AS Order_Date,
            TRY_CONVERT(DATE, LEFT(Required_Date, 10), 105) AS Required_Date,
            TRIM(Order_Status) AS Order_Status,
            TRIM(Payment_Status) AS Payment_Status,
            TRIM(Shipping_City) AS Shipping_City,
            TRY_CONVERT(DATE, LEFT(Ship_Date, 10), 105) AS Ship_Date
        FROM bronze.erp_orders;

        PRINT 'Orders Loaded: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST (DATEDIFF (second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';
    
        PRINT '>>---------------';

        ---------------------------------------------------
        PRINT 'Load ERP Products'
        ---------------------------------------------------

        SET @Start_time = GETDATE();
        PRINT 'Truncating Table: silver.erp_products';
        TRUNCATE TABLE silver.erp_products;

        PRINT 'Inserting Data Into: silver.erp_products';
        INSERT INTO silver.erp_products
        (   Product_ID,
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
            TRIM(Product_Name) AS Product_Name,
            TRIM (Category) AS Category,
            TRIM (Model_No) AS Model_No,
         CASE WHEN Capacity  NOT LIKE '%m3/hr%'
                THEN CONCAT (TRIM(Capacity), ' m3/hr')
                ELSE TRIM(Capacity) 
         END AS Capacity,
            CASE
            WHEN TRIM(Pressure) NOT LIKE '%Bar%'
                THEN CONCAT(TRIM(Pressure), ' Bar')
            ELSE TRIM(Pressure)
        END AS Pressure,
            Unit_Cost,
            Unit_Price
        FROM bronze.erp_products;

        PRINT 'Products Loaded: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF (second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';

        PRINT '>>---------------';

        ---------------------------------------------------
        PRINT 'Load ERP Suppliers'
        ---------------------------------------------------

        SET @Start_time = GETDATE();
        PRINT 'Truncating Table: silver.erp_suppliers';
        TRUNCATE TABLE silver.erp_suppliers;

        PRINT 'Inserting Data Into: silver.erp_suppliers';
        INSERT INTO silver.erp_suppliers
        (
            Supplier_Id,
            Supplier_Name,
            City,
            State,
            Supplier_Category,
            Supplier_Status
        )

        SELECT
            Supplier_ID,
            CASE TRIM(Supplier_Name)
                WHEN 'FlowTech Industries pvt ltd'
                    THEN 'Flowtech Industries Pvt Ltd'
                WHEN 'APEX INDUSTRIAL SOLUTIONS Pvt Ltd'
                    THEN 'Apex Industrial Solutions Pvt Ltd'
                WHEN 'bharat metal components Pvt Ltd'
                    THEN 'Bharat Metal Components Pvt Ltd'
                WHEN 'SHAKTI industrial products Pvt Ltd'
                    THEN 'Shakti Industrial Products Pvt Ltd'
                WHEN 'Industrial Components india Pvt Ltd'
                    THEN 'Industrial Components India Pvt Ltd'
                WHEN 'SUPREME INDUSTRIAL PRODUCTS Pvt Ltd'
                    THEN 'Supreme Industrial Products Pvt Ltd'
                WHEN 'EVEREST INDUSTRIAL SOLUTIONS'
                    THEN 'Everest Industrial Solutions'
                ELSE TRIM(Supplier_Name)
            END AS Supplier_Name,
            TRIM(City) AS City,
            TRIM(State) AS State,
            TRIM(Supplier_Category) AS Supplier_Category,
            TRIM(Supplier_Status) AS Supplier_Status
        FROM bronze.erp_suppliers;

        PRINT 'Suppliers Loaded: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF (second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';

        PRINT '>>---------------';

        ---------------------------------------------------
        PRINT 'Load ERP Warehouses'
        ---------------------------------------------------

        SET @Start_time = GETDATE();
        PRINT 'Truncating Table: silver.erp_warehouses';
        TRUNCATE TABLE silver.erp_warehouses;

        PRINT ' Inserting Data Into: silver.erp_warehouses';
        INSERT INTO silver.erp_warehouses
        ( 
            Warehouse_ID,
            Warehouse_Name,
            City,
            State,
            Capacity_Units
        )

        SELECT 
            Warehouse_ID,
            TRIM(Warehouse_Name) AS Warehouse_Name,
            TRIM(City) AS City,
            TRIM(State) AS State,
            Capacity_Units
        FROM bronze.erp_warehouses;

        PRINT 'Warehouses Loaded: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

        SET @End_time = GETDATE();
        PRINT '>> Load Duration;' + CAST(DATEDIFF (second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';

        PRINT '>>---------------';

    SET @Layer_End = GETDATE();

    PRINT '=============================================================='
    PRINT ' Silver Layer Load Successfully '
    PRINT ' Batch Time: '
        + CAST(DATEDIFF(SECOND, @Layer_Start, @Layer_End) AS NVARCHAR(10))
        + ' seconds'
    PRINT '=============================================================='

    END TRY

    BEGIN CATCH
        PRINT 'Error while loading the Silver layer';
        PRINT ERROR_MESSAGE();
    END CATCH

END;
GO

EXEC silver.load_silver;






