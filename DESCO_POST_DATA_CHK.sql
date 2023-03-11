
SELECT A.BILL_MONTH,D_CNT,b.P_CNT,SUM(D_CNT-P_CNT) NOT_UPLOD FROM (
SELECT 'x' c,YEAR||MONTH BILL_MONTH,count(*) D_CNT FROM DESCO.BILL_CALCULATION@DESCO_POSTPAID
WHERE YEAR=SUBSTR(:P_Bill_Month,1,4)
AND MONTH=TO_NUMBER(SUBSTR(:P_Bill_Month,5,6))
--AND DEPT_ID=LOC_LIST.LOCATION_CODE
--AND NVL(BATCH_BKASH,'0')<>'1'
AND DUE_DATE IS NOT NULL
AND ACCOUNT_NO IN (SELECT ACCOUNT_NO FROM DESCO.NEW_CONSUMER_INFORMATION@DESCO_POSTPAID 
--WHERE DEPT_ID=LOC_LIST.LOCATION_CODE
)GROUP BY YEAR||MONTH)A,(
select 'x' c,BILL_MONTH,COUNT(*) P_CNT from epay_utility_bill@DESCOPST_SRL
where bill_month=:p_bill_month
and company_code='DESCOPOST'
GROUP BY BILL_MONTH
)B
WHERE a.c=b.c--A.BILL_MONTH=B.BILL_MONTH
GROUP BY A.BILL_MONTH,D_CNT,P_CNT


----------------

SELECT * FROM DESCO.NEW_CONSUMER_INFORMATION@DESCO_POSTPAID
WHERE DEPT_ID=LOC_LIST.LOCATION_CODE
AND NVL(BATCH_BKASH,'0')<>'1'
AND ACCOUNT_NO=P_Acc_No


SELECT DEPT_ID,a.* FROM DESCO.NEW_CONSUMER_INFORMATION@DESCO_POSTPAID a
where ACCOUNT_NO='13158828'

select * from epay_customer_master_data@DESCOPST_SRL
where account_No='13158828'

select bill_month,a.* from epay_utility_bill@DESCOPST_SRL a
where account_Number='13158828'
order by a.bill_month desc

SELECT YEAR,MONTH, COUNT(*) NOT_UPLOAD ,'Data not upload in PSC 100.124' STATUS FROM BILL_CALCULATION
                                           WHERE  NVL(BATCH_BKASH,'0')<>'1'
                                           AND DUE_DATE IS NOT NULL
                                           AND YEAR=2021
                                           AND MONTH IN (                                           
            SELECT TO_NUMBER(BILL_MONTH) M FROM ( 
            SELECT TO_CHAR(SYSDATE,'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-4),'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-3),'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-2),'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MM') AS BILL_MONTH FROM DUAL
             ) )
              GROUP BY YEAR,MONTH
                                           ORDER BY MONTH DESC
                                           
 ----------------------------------------------------------------------------TRAIL-----------------------------------------------------------------------------------                                          
                                           
SELECT YEAR,MONTH, COUNT(*) DATA ,'Data not upload in PSC 100.124' STATUS FROM BILL_CALCULATION
                                           WHERE  NVL(BATCH_BKASH,'0')<>'1'
                                           AND DUE_DATE IS NOT NULL
                                           AND YEAR=2020
                                           AND MONTH IN (                                           
            SELECT TO_NUMBER(BILL_MONTH) M FROM ( 
            SELECT TO_CHAR(SYSDATE,'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-4),'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-3),'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-2),'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MM') AS BILL_MONTH FROM DUAL
             ) )
              GROUP BY YEAR,MONTH
union
SELECT YEAR,MONTH, COUNT(*) DATA ,'Data upload in PSC 100.124' STATUS FROM BILL_CALCULATION
                                           WHERE  NVL(BATCH_BKASH,'0')='1'
                                           AND DUE_DATE IS NOT NULL
                                           AND YEAR=2020
                                           AND MONTH IN (                                           
            SELECT TO_NUMBER(BILL_MONTH) M FROM ( 
            SELECT TO_CHAR(SYSDATE,'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-4),'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-3),'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-2),'MM') AS BILL_MONTH FROM DUAL
            UNION
            SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MM') AS BILL_MONTH FROM DUAL
             ) )
              GROUP BY YEAR,MONTH
                                           ORDER BY MONTH DESC
                                           
                                           
                                           
 