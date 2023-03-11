         
SELECT COMP_CNTR_CODE,COMP_CNTR_NAME FROM V_Z_C_C_L
WHERE LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOC_ONLINE_OPT_MAP WHERE ONLINE_OPT='GP')
GROUP BY COMP_CNTR_CODE,COMP_CNTR_NAME
ORDER BY COMP_CNTR_CODE ASC         
         
         
SELECT B.COMPANY_CODE SERVER_NAME,V.COMP_CNTR_NAME,B.BILL_MONTH,V.LOCATION_CODE,V.LOCATION_NAME,B.ACCOUNT_NUMBER CONSUMER_NO,C.NAME CONSUMER_NAME,B.BILL_NUMBER,B.BILL_DUE_DATE
     FROM EPAY_UTILITY_BILL B,V_Z_C_C_L V,EPAY_CUSTOMER_MASTER_DATA C
WHERE B.LOCATION_CODE=V.LOCATION_CODE
AND B.BILL_MONTH='201604'
AND V.LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOC_ONLINE_OPT_MAP WHERE ONLINE_OPT='GP')
AND B.LOCATION_CODE=C.LOCATION_CODE
AND V.LOCATION_CODE=C.LOCATION_CODE
AND B.ACCOUNT_NUMBER=C.ACCOUNT_NO
AND V.COMP_CNTR_CODE=:C_CODE
ORDER BY V.LOCATION_CODE,B.BILL_DUE_DATE,B.ACCOUNT_NUMBER


SELECT 'GP' SERVER_NAME,V.COMP_CNTR_NAME,B.BILL_MONTH,V.LOCATION_CODE,V.LOCATION_NAME,B.ACCOUNT_NUMBER CONSUMER_NO,C.NAME CONSUMER_NAME,B.BILL_NUMBER,B.BILL_DUE_DATE
     FROM DBERSICE.UTILITY_BILL_PDB@EPAY_GP B,V_Z_C_C_L V,DBERSICE.CUSTOMER_MASTER_DATA_PDB@EPAY_GP C
WHERE B.LOCATION_CODE=V.LOCATION_CODE
AND B.BILL_MONTH='201604'
AND V.LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOC_ONLINE_OPT_MAP WHERE ONLINE_OPT='GP')
AND B.LOCATION_CODE=C.LOCATION_CODE
AND V.LOCATION_CODE=C.LOCATION_CODE
AND B.ACCOUNT_NUMBER=C.ACCOUNT_NO
AND V.COMP_CNTR_CODE=:C_CODE
ORDER BY V.LOCATION_CODE,B.BILL_DUE_DATE,B.ACCOUNT_NUMBER