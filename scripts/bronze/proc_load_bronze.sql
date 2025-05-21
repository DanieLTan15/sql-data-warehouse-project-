/*
=====================
Stored Procedure: Load Bronze Layer (Source-> Bronze)
====================
Script Purpose: 
  This stored procedure loads data into 'bronze' schema from external CSV files.
  It performs the following actions:
  - Truuncates the bronze tables before loading data.
  - Uses the 'BULK INSERT' commadn to load data from csv Files to bronze tables.

Parmeters:
  NONE.
  This stored procedure does not accept any paremeters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @total_start_time DATETIME, @total_end_time DATETIME;;
	BEGIN TRY
		SET @total_start_time = GETDATE();

		PRINT '====================================='
		PRINT 'LOADING BRONZE LAYER'
		PRINT '====================================='

	
		PRINT '-------------------------------------'
		PRINT ' Loading CRM Tables'
		PRINT '-------------------------------------'
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT '>> Inserting Data Into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-----------------------------------------'


		SET @start_time = GETDATE();
		PRINT '>>Truncateing Table:  broze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info
	
		PRINT '>> Inserting Data Into: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-----------------------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncateing Table:  broze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT '>> Inserting Data Into: bronze.crm_sals_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-----------------------------------------'
	
		PRINT '-------------------------------------'
		PRINT ' Loading ERP Tables'
		PRINT '-------------------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncateing Table:  broze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-----------------------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncateing Table: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_loc_a101
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-----------------------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-----------------------------------------'

		SET @total_end_time = GETDATE();
		PRINT '>> Total Load Duration:' + CAST(DATEDIFF(second, @total_start_time,@total_end_time) AS NVARCHAR) + 'seconds';
		PRINT '-----------------------------------------'

	END TRY
	BEGIN CATCH
		PRINT '============================'
		PRINT 'ERROR OCCURED DURING LOADIN BRONZE LAYER'
		PRINT 'Error Message' +CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' +CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '============================'

	END CATCH
END
