
SELECT 83+242+42 FROM DUAL

367

SELECT C.LOCATION_CODE,C.CUSTOMER_NUM,C.CONS_EXTG_NUM account_num, C.CUSTOMER_NAME,CA.ADDR_DESCR1||', '||CA.ADDR_DESCR2 ADDRES,SUBSTR(C.AREA_CODE,1,3) BOOK,
SUBSTR(C.AREA_CODE,4) BILL_GROUP,C.WALKING_SEQUENCE PAGE,CM.METER_CONNECT_DATE 
FROM EBC.BC_CUSTOMERS C,EBC.BC_CUSTOMER_ADDR CA,EBC.BC_CUSTOMER_METER CM
WHERE C.CUST_ID=CA.CUST_ID
AND C.CUST_ID = CM.CUST_ID
AND C.START_BILL_CYCLE BETWEEN '201906' AND '201908'
AND CA.ADDR_TYPE='M'
AND CA.ADDR_EXP_DATE IS NULL
ORDER BY 1