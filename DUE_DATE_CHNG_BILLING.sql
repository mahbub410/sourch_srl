
update bc_bill_image
SET INVOICE_DUE_DATE='17-APR-2022',DATA_TRANS_LOG='N'
WHERE BILL_CYCLE_CODE=:P_Bill_cycle
AND SUBSTR(AREA_CODE,4)=:P_Group
AND LOCATION_CODE=:P_Location 


update bc_invoice_hdr
SET INVOICE_DUE_DATE='17-APR-2022'
WHERE BILL_CYCLE_CODE=:P_Bill_cycle
AND CUST_ID IN(SELECT CUST_ID FROM BC_CUSTOMERS 
WHERE SUBSTR(AREA_CODE,4,2)=:P_Group
and LOCATION_CODE=:P_Location  
)


update bc_bill_cycle_code
set  BILL_DUE_DATE='17-APR-2022'
WHERE BILL_CYCLE_CODE=:P_Bill_cycle 
AND SUBSTR(AREA_CODE,4)=:P_Group 
AND LOCATION_CODE=:P_Location 



COMMIT;

/*====================================cheek===================================================*/
12/May/21	2184

select INVOICE_DUE_DATE,COUNT(*) from bc_bill_image
WHERE  BILL_CYCLE_CODE=:P_Bill_cycle
AND SUBSTR(AREA_CODE,4)=:P_Group
AND LOCATION_CODE=:P_Location
GROUP BY INVOICE_DUE_DATE

select * from bc_bill_image
WHERE  BILL_CYCLE_CODE=:P_Bill_cycle
AND SUBSTR(AREA_CODE,4)=:P_Group
AND LOCATION_CODE=:P_Location


select * from bc_bill_cycle_code
--set  BILL_DUE_DATE='16-JUN-2015' 
WHERE LOCATION_CODE=:P_Location 
AND SUBSTR(AREA_CODE,4)=:P_Group 
AND BILL_CYCLE_CODE=:P_Bill_cycle


select * from bc_invoice_hdr
--SET INVOICE_DUE_DATE='16-JUN-2015' 
WHERE BILL_CYCLE_CODE=:P_Bill_cycle
AND CUST_ID IN(SELECT CUST_ID FROM BC_CUSTOMERS WHERE LOCATION_CODE=:P_Location 
AND SUBSTR(AREA_CODE,4,2)=:P_Group)



------------------BILL GROUP WISE--------

update bc_bill_image
SET INVOICE_DUE_DATE='24-APR-2019',DATA_TRANS_LOG='N'
WHERE BILL_CYCLE_CODE=:P_Bill_cycle
AND SUBSTR(AREA_CODE,4)=:P_Group
--AND  LOCATION_CODE=:P_Location 


update bc_bill_cycle_code
set  BILL_DUE_DATE='24-APR-2019'
WHERE BILL_CYCLE_CODE=:P_Bill_cycle 
AND SUBSTR(AREA_CODE,4)=:P_Group 
--AND LOCATION_CODE=:P_Location 


update bc_invoice_hdr
SET INVOICE_DUE_DATE='24-APR-2019'
WHERE BILL_CYCLE_CODE=:P_Bill_cycle
AND CUST_ID IN(SELECT CUST_ID FROM BC_CUSTOMERS WHERE --LOCATION_CODE=:P_Location 
 SUBSTR(AREA_CODE,4,2)=:P_Group)


COMMIT;
