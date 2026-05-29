-- Quality Checks

-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Results
select 
prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*) >1 or prd_id is null

-- Check for unwanted Spaces 
-- Expectation: No Results
select prd_nm 
from silver.crm_prd_info
where prd_nm != trim(prd_nm)

-- Check for NULLs or Negaive Numbers
-- Expectation: No Results
select prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is null

-- Data Standardization & Consistency
select distinct prd_line from silver.crm_prd_info

-- Check for Invalid Date Orders
select * from silver.crm_prd_info where prd_end_dt < prd_start_dt

-- Load bronze to silver for crm_prd_info
insert into silver.crm_prd_info (prd_id,cat_id, prd_key,  prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt)
select 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id, -- Extract category ID
SUBSTRING(prd_key,7,len(prd_key)) AS prd_key, -- Extract product key
prd_nm,
isnull(prd_cost,0) as prd_cost,
case upper(trim(prd_line))
	when 'M' then 'Mountain'
	when 'R' then 'Road'
	when 'S' then 'other Sales'
	when 'T' then 'Touring'
	else 'N/A'
end as prd_line, -- Map product line codes to desciptive values
prd_start_dt,
dateadd(day,-1,lead(prd_start_dt) over(partition by prd_key order by prd_start_dt asc)) as prd_end_dt_test -- Calculate end date as one day before the next start date 
from bronze.crm_prd_info 
