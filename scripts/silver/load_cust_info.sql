
-- Quality check from bronze 
SELECT 
cst_id,
count(*)
FROM bronze.crm_cust_info
group by cst_id
having count(*) > 1 or cst_id is null

SELECT 
cst_firstname
FROM bronze.crm_cust_info
where cst_firstname != TRIM(cst_firstname) 

select distinct cst_gndr
from bronze.crm_cust_info


-- Insert data from bronze to silver (Cleaned Version)

INSERT INTO silver.crm_cust_info(cst_id, cst_key, cst_firstname, cst_lastname, cst_material_status, cst_gndr, cst_create_date)
select 
	cst_id, 
	cst_key, 
	TRIM(cst_firstname) AS cst_firstname, 
	TRIM(cst_lastname) AS cst_lastname, 
	CASE
		WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
		WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
		ELSE 'N/A'
	END AS cst_material_status, -- Normalize martial status values to readable format
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'N/A'
	END AS cst_gndr, -- Normalize gender values to readable format
	cst_create_date
from (
	select *,
	row_number() over(partition by cst_id order by cst_create_date desc) as flag_last
	from bronze.crm_cust_info
	where cst_id is not null) t 
where flag_last = 1; -- Select the most recent record per customer

