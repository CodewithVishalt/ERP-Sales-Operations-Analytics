---BULK INSERT INTO THE BRONZE LAYER FROM THE DB----
EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    SET NOCOUNT ON
    DECLARE @Start_time DATETIME, @End_time DATETIME, @Layer_Start DATETIME;
    BEGIN TRY
        
        SET @Layer_Start = GETDATE();
        PRINT '======================================================'
        PRINT 'Loading Bronze Layer'
        PRINT 'Start Time : ' + CONVERT(VARCHAR(19), GETDATE(), 120);
        PRINT '======================================================'
        
        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table; bronze.crm_customers'
        TRUNCATE TABLE bronze.crm_customers;

        PRINT '>> Inserting Table; bronze.crm_customers'
        BULK INSERT bronze.crm_customers
        FROM 'C:\Users\highf\OneDrive\Desktop - Copy\ERP_Sales_Operations_Analytics\customers.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR ) + 'seconds';
        PRINT '>>---------------';


        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table; bronze.erp_employees'
        TRUNCATE TABLE bronze.erp_employees;

        PRINT '>> Inserting Table; bronze.erp_employees'
        BULK INSERT bronze.erp_employees
        FROM 'C:\Users\highf\OneDrive\Desktop - Copy\ERP_Sales_Operations_Analytics\employees.csv'
        WITH 
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';
        PRINT '>>>--------------';


        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table; bronze.erp_inventory_transactions'
        TRUNCATE TABLE bronze.erp_inventory_transactions;

        PRINT '>> Inserting Table; bronze.erp_inventory_transactions'
        BULK INSERT bronze.erp_inventory_transactions
        FROM 'C:\Users\highf\OneDrive\Desktop - Copy\ERP_Sales_Operations_Analytics\inventory_transactions.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';
        PRINT '>>-----------';

        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table; bronze.erp_order_details'
        TRUNCATE TABLE bronze.erp_order_details;

        PRINT '>> Inserting Table; bronze.erp_order_details'
        BULK INSERT bronze.erp_order_details
        FROM 'C:\Users\highf\OneDrive\Desktop - Copy\ERP_Sales_Operations_Analytics/order_details.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';
        PRINT '>>>------------';


        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table; bronze.erp_orders'
        TRUNCATE TABLE bronze.erp_orders;

        PRINT '>> Inserting Table; bronze.erp_orders'
        BULK INSERT bronze.erp_orders
        FROM 'C:\Users\highf\OneDrive\Desktop - Copy\ERP_Sales_Operations_Analytics/orders.csv'
        WITH
        (   FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';
        PRINT '>>-------------';


        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table; bronze.erp_products'
        TRUNCATE TABLE bronze.erp_products;

        PRINT '>> Inserting Table; bronze.erp_products'
        BULK INSERT bronze.erp_products
        FROM 'C:\Users\highf\OneDrive\Desktop - Copy\ERP_Sales_Operations_Analytics\products.csv'
        WITH
        (   FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @End_time = GETDATE()
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';
        PRINT '>>>---------------';

        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table; bronze.erp_suppliers'
        TRUNCATE TABLE bronze.erp_suppliers;

        PRINT '>> Inserting Table; bronze.erp_suppliers'
        BULK INSERT bronze.erp_suppliers
        FROM 'C:\Users\highf\OneDrive\Desktop - Copy\ERP_Sales_Operations_Analytics\suppliers.csv'
        WITH
        (   
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );  

        SET @End_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR ) + 'seconds';
        PRINT '>>>------------';


        SET @Start_time = GETDATE();
        PRINT '>> Truncating Table; bronze.erp_warehouses'
        TRUNCATE TABLE bronze.erp_warehouses;

        PRINT '>> Inserting Table; bronze.erp_warehouses'
        BULK INSERT bronze.erp_warehouses
        FROM 'C:\Users\highf\OneDrive\Desktop - Copy\ERP_Sales_Operations_Analytics\warehouses.csv'
        WITH
        (   
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        ); 

        SET @End_time = GETDATE()
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + 'seconds';
        PRINT '>>>------------';
   

    PRINT '======================================================';
    PRINT 'Bronze Layer Loaded Successfully';
    PRINT 'End Time   : ' + CONVERT(VARCHAR(19), @End_time, 120);
    
    PRINT '======================================================'; 
    END TRY
    BEGIN CATCH
        PRINT 'Error while loading the bronze layer';
        PRINT ERROR_MESSAGE();
    END CATCH
END


SELECT * FROM bronze.erp_suppliers
