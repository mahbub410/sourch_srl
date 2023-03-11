

select rownum,LOCATION_CODE,LOC_NAME,SUBSTR(AREA_CODE,1,3) BOOK,SUBSTR(AREA_CODE,4) BILL_GROUP,CONS_EXTG_NUM ACCOUNT_NO,WALK_ORDER PAGE,
CUSTOMER_NAME,CUSTOMER_ADDR,CUST_NUM,METER_NUM_KWH METER_NO,tariff,METER_CONNECT_DATE OPENING_READING_DATE,COMP_CNTR_DATE,consumed_unit,total_bill,Total_arr 
from emp.V_NEW_CONN_CONSUMER a,
(select CUST_NUM||CHECK_DIGIT AS CUSTomer_NUM, NVL(INVOICE_AMT +INVOICE_ADJUSTED_AMT-INVOICE_APPLIED_AMT,0) Total_arr
FROM BC_INVOICE_HDR
WHERE CUST_NUM||CHECK_DIGIT IN (
SELECT CUST_NUM from emp.V_NEW_CONN_CONSUMER
where METER_CONNECT_DATE between '01-JAN-2018' and '30-MAR-2019')) b
where a.CUST_NUM=b.CUSTOMER_NUM
and a.METER_CONNECT_DATE between '01-JAN-2018' and '31-MAR-2019'
and a.LOCATION_CODE=:p_loc