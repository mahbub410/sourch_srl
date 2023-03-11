


create table emp.bc_customer_name_14112019 as
select * from bc_customer_name

create table emp.bc_customers_14112019 as
select * from bc_customers

create table emp.BC_CUSTOMER_ADDR_14112019 as
select * from BC_CUSTOMER_ADDR


------------------------------------

UPDATE BANGLALINK_CONSUMER
SET POWER_OFFICE=REPLACE(POWER_OFFICE,chr(13)||CHR(10),' '),REGION=REPLACE(REGION,chr(13)||chr(10),' '),EXISTING_BILL_NAME=REPLACE(EXISTING_BILL_NAME,chr(13)||CHR(10),' ')

commit;

----------------------------------------

EXECUTE DPD_BANGLALINK_CUST_UPDATE


select CONSUMER_NUMBER,a.REGION,b.cust_id,B.CUSTOMER_NUM  from BANGLALINK_CONSUMER a,bc_customers b where substr(a.CONSUMER_NUMBER,1,7)=B.CUSTOMER_NUM 


SELECT * FROM BC_CUSTOMERS
WHERE CUST_ID=103390

SELECT * FROM BC_CUSTOMER_NAME
WHERE CUST_ID=103390

SELECT * FROM BC_CUSTOMER_ADDR
WHERE CUST_ID=103390

