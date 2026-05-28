/*
===================================================================================
DDL Script: Create Bronze Tables
===================================================================================
Script Purpose:
      This script create tables in the 'bronze' schema, dropping existing tables
      if they already exist.
      Run this script to re-define the DDL structure of 'bronze' Tables
===================================================================================
*/

-- bronze.crm_cust_info

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
  DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE [bronze].[crm_cust_info](
	[cst_id] [int] NULL,
	[cst_key] [nvarchar](50) NULL,
	[cst_firstname] [nvarchar](50) NULL,
	[cst_lastname] [nvarchar](50) NULL,
	[cst_material_status] [nvarchar](50) NULL,
	[cst_gndr] [nvarchar](50) NULL,
	[cst_create_date] [date] NULL
);
GO

-- bronze.crm_prd_info
  
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
  DROP TABLE bronze.crm_prd_info;
GO
  
CREATE TABLE [bronze].[crm_prd_info](
	[prd_id] [int] NULL,
	[prd_key] [nvarchar](50) NULL,
	[prd_nm] [nvarchar](50) NULL,
	[prd_cost] [int] NULL,
	[prd_line] [nvarchar](50) NULL,
	[prd_start_dt] [date] NULL,
	[prd_end_dt] [date] NULL
);
GO

-- bronze.crm_sales_details
  
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
  DROP TABLE bronze.crm_sales_details;
GO
  
CREATE TABLE [bronze].[crm_sales_details](
	[sls_ord_num] [nvarchar](50) NULL,
	[sls_prd_key] [nvarchar](50) NULL,
	[sls_cust_id] [int] NULL,
	[sls_order_dt] [nvarchar](50) NULL,
	[sls_ship_dt] [date] NULL,
	[sls_due_dt] [date] NULL,
	[sls_sales] [int] NULL,
	[sls_quantity] [int] NULL,
	[sls_price] [int] NULL
);
GO

-- bronze.erp_cust_az12
  
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
  DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE [bronze].[erp_cust_az12](
	[CID] [nvarchar](50) NULL,
	[BDATE] [date] NULL,
	[GEN] [nvarchar](50) NULL
);
GO

-- bronze.erp_loc_a101

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
  DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE [bronze].[erp_loc_a101](
	[CID] [nvarchar](50) NULL,
	[CNTRY] [nvarchar](50) NULL
);
GO

-- bronze.erp_px_cat_g1v2
  
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
  DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE [bronze].[erp_px_cat_g1v2](
	[ID] [nvarchar](50) NULL,
	[CAT] [nvarchar](50) NULL,
	[SUBCAT] [nvarchar](50) NULL,
	[MAINTENANCE] [nvarchar](50) NULL
);
GO








