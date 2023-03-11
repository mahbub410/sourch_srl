
SELECT DISTINCT TO_CHAR(BILL_DATE,'RRRRMM') DOWNLOAD_MONTH FROM (
WITH A AS(
SELECT TRUNC(SYSDATE) R, TRUNC(SYSDATE)-TO_DATE('1-jan-2018','dd/mm/yyyy') DAY_N FROM DUAL) 
SELECT R-LEVEL BILL_DATE FROM A CONNECT BY LEVEL<= DAY_N)
ORDER BY DOWNLOAD_MONTH DESC


SELECT DISTINCT ZONE_CODE,ZONE_NAME FROM EPAY.V_Z_C_C_L
ORDER BY ZONE_CODE ASC


SELECT DISTINCT LOCATION_CODE,LOCATION_NAME FROM EPAY.V_Z_C_C_L
WHERE ZONE_CODE=P_ZONE_CODE
ORDER BY LOCATION_CODE ASC


SELECT ZONE_NAME,CI.LOCATION_CODE,LOCATION_NAME,TRACKING_NUMBER,APPLICATION_SERIAL_NO,CONS_SRL_NO OLD_ACC_NO,CUSTOMER_NAME,
SERV_ADDR_DESCR1||', '||SERV_ADDR_DESCR2||', '||SERV_ADDR_DESCR3 AS ADDRESS,METER_NUM,AREA_CODE,CI.CREATE_DATE DOWNLOAD_DATE
    FROM NEWCONS.BC_CONSUMER_INTERFACE CI,
         EPAY.V_Z_C_C_L L,
          NEWCONS.BC_METER_INTERFACE MI
WHERE CI.LOCATION_CODE=L.LOCATION_CODE
AND CI.CUST_INT_ID= MI.REF_ID
AND VALIDATION_STATUS='P'
AND CALL_BACK_STATUS='Y'
AND DATA_TRANS_STATUS='Y'
AND CUST_INT_ID_PDB IS NOT NULL
AND TO_CHAR(CI.CREATE_DATE,'RRRRMM')=:P_DOWNLOAD_MONTH
AND L.ZONE_CODE  LIKE NVL(:P_ZONE_CODE,'%')
AND CI.LOCATION_CODE LIKE NVL(:P_LOCATION_CODE,'%')
ORDER BY L.ZONE_CODE,CI.LOCATION_CODE,CI.CREATE_DATE