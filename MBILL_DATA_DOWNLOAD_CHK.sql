SELECT COUNT(*) FROM MBILL_DATA_LOG@MBILL_SVR
WHERE BILL_CYCLE_CODE='202202'
AND CUST_ID IN (SELECT CUST_ID FROM MBILL_CUSTOMERS@MBILL_SVR WHERE LOCATION_CODE='K5'  )
 AND  DATA_DOWNLOAD_DATE IS NULL
 
 AND SUBSTR(AREA_CODE,4)='05'
 
SELECT 'Total',COUNT(*) FROM MBILL_DATA_LOG@MBILL_SVR A,MBILL_CUSTOMERS@MBILL_SVR  B
WHERE A.CUST_ID=B.CUST_ID
AND A.BILL_CYCLE_CODE='202202'
AND LOCATION_CODE='K5'
AND  DATA_DOWNLOAD_DATE IS NULL
UNION
SELECT SUBSTR(B.AREA_CODE,4),COUNT(*) FROM MBILL_DATA_LOG@MBILL_SVR A,MBILL_CUSTOMERS@MBILL_SVR  B
WHERE A.CUST_ID=B.CUST_ID
AND A.BILL_CYCLE_CODE='202202'
AND LOCATION_CODE='K5'
AND  DATA_DOWNLOAD_DATE IS NULL
GROUP BY SUBSTR(B.AREA_CODE,4)
order by 1


