

SELECT BR.BRANCH_CODE,BR.BRANCH_NAME FROM  EPAY_BANKS B,EPAY_BANK_BRANCHES BR
WHERE B.BANK_CODE=BR.BANK_CODE
AND (B.BANK_CODE,BR.BRANCH_CODE) IN (SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                  WHERE USER_ID=:P_User_Id
                                                                  AND BANK_CODE=:P_Bank_Code)
ORDER BY BRANCH_CODE;



SELECT LOCATION_CODE,LOCATION_NAME FROM EPAY_LOCATION_MASTER
WHERE LOCATION_CODE IN (SELECT LOCATION_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                  WHERE USER_ID=:P_User_Id
                                                                  AND BANK_CODE=:P_Bank_Code
                                                                  AND BRANCH_CODE LIKE NVL(:P_Branch_Code,'%'))
ORDER BY LOCATION_CODE;


--------SUMMERY----

SELECT   BR.BILLING_BANK_CODE||' (New-'||IM.PAY_BANK_CODE||')' as BANK_CODE,
L.LOCATION_CODE||' ('||L.LOCATION_NAME||')' AS LOCATION_NAME ,IM.BATCH_NO AS BATCH_NO, IM.PAY_BANK_CODE AS NEW_BANK_CODE,
BR.BILLING_BRANCH_CODE||' (New-'||IM.PAY_BRANCH_CODE||')' AS BRANCH_CODE,
B.BANK_NAME,BR.BRANCH_NAME,IM.PAY_DATE,SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOT_AMOUNT,SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT_AMONUT,COUNT(1) AS NO_OF_CON 
            FROM (SELECT * FROM EPAY_PAYMENT_MST_INT WHERE  STATUS<>'T' UNION SELECT * FROM EPAY_PAYMENT_MST) IM,
                     (SELECT * FROM EPAY_PAYMENT_DTL_INT UNION SELECT * FROM EPAY_PAYMENT_DTL) ID,
                     EPAY_LOCATION_MASTER L,
                     EPAY_BANKS B,
                     EPAY_BANK_BRANCHES BR
WHERE IM.BATCH_NO=ID.BATCH_NO
AND IM.LOCATION_CODE=L.LOCATION_CODE
AND IM.LOCATION_CODE=BR.LOCATION_CODE
AND IM.PAY_BANK_CODE=B.BANK_CODE
AND IM.PAY_BRANCH_CODE=BR.BRANCH_CODE
AND B.BANK_CODE=BR.BANK_CODE
AND (IM.PAY_BANK_CODE,IM.PAY_BRANCH_CODE) IN (SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                                    WHERE USER_ID=:P_User_Id
                                                                                    AND BANK_CODE=:P_Bank_Code
                                                                                    AND BRANCH_CODE LIKE NVL (:P_Branch_Code,'%'))
AND IM.LOCATION_CODE IN(SELECT v.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                            WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                            AND D.USER_ID=:P_User_Id
                                            AND BANK_CODE=:P_Bank_Code
                                            AND D.LOCATION_CODE LIKE NVL (:P_Location_Code,'%'))
--AND IM.STATUS<>'T'
AND im.PAY_DATE>=:P_START_PAY_DATE
AND im.PAY_DATE<=:P_END_PAY_DATE
GROUP BY BR.BILLING_BANK_CODE||' (New-'||IM.PAY_BANK_CODE||')',
L.LOCATION_CODE||' ('||L.LOCATION_NAME||')',IM.BATCH_NO, IM.PAY_BANK_CODE,
B.BANK_NAME,BR.BRANCH_NAME,
BR.BILLING_BRANCH_CODE||' (New-'||IM.PAY_BRANCH_CODE||')',IM.PAY_DATE
UNION

SELECT   BR.BILLING_BANK_CODE||' (New-'||IM.PAY_BANK_CODE||')' as BANK_CODE,
L.LOCATION_CODE||' ('||L.LOCATION_NAME||')' AS LOCATION_NAME ,IM.REF_BATCH_NO AS BATCH_NO, IM.PAY_BANK_CODE AS NEW_BANK_CODE,
BR.BILLING_BRANCH_CODE||' (New-'||IM.PAY_BRANCH_CODE||')' AS BRANCH_CODE,
B.BANK_NAME,BR.BRANCH_NAME,IM.PAY_DATE,SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOT_AMOUNT,SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT_AMOUNT,COUNT(1) AS NO_OF_CON 
        FROM EPAY_PAYMENT_MST IM,
                 EPAY_PAYMENT_DTL ID,
                 EPAY_LOCATION_MASTER L,
                 EPAY_BANKS B,
                 EPAY_BANK_BRANCHES BR
WHERE IM.BATCH_NO=ID.BATCH_NO
AND IM.LOCATION_CODE=L.LOCATION_CODE
AND IM.LOCATION_CODE=BR.LOCATION_CODE
AND IM.PAY_BANK_CODE=B.BANK_CODE
AND B.BANK_CODE=BR.BANK_CODE
AND IM.PAY_BRANCH_CODE=BR.BRANCH_CODE
AND (IM.PAY_BANK_CODE,IM.PAY_BRANCH_CODE) IN (SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                                    WHERE USER_ID=:P_User_Id
                                                                                    AND BANK_CODE=:P_Bank_Code 
                                                                                    AND BRANCH_CODE LIKE NVL (:P_Branch_Code,'%'))
 AND IM.LOCATION_CODE IN(SELECT v.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                            WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                            AND D.USER_ID=:P_User_Id
                                            AND BANK_CODE=:P_Bank_Code
                                            AND D.LOCATION_CODE LIKE NVL (:P_Location_Code,'%'))
AND im.PAY_DATE>=:P_START_PAY_DATE
AND im.PAY_DATE<=:P_END_PAY_DATE
GROUP BY BR.BILLING_BANK_CODE||' (New-'||IM.PAY_BANK_CODE||')',
L.LOCATION_CODE||' ('||L.LOCATION_NAME||')',IM.REF_BATCH_NO, IM.PAY_BANK_CODE,
B.BANK_NAME,BR.BRANCH_NAME,
BR.BILLING_BRANCH_CODE||' (New-'||IM.PAY_BRANCH_CODE||')',IM.PAY_DATE
ORDER BY 8

-------DETELS--------------

SELECT  ID.SCROLL_NO, BR.BILLING_BANK_CODE||' (New-'||IM.PAY_BANK_CODE||')' AS BANK_CODE,
L.LOCATION_CODE||' ('||L.LOCATION_NAME||')' AS LOCATION_NAME ,IM.BATCH_NO AS BATCH_NO, IM.PAY_BANK_CODE AS NEW_BANK_CODE,
BR.BILLING_BRANCH_CODE||' (New-'||IM.PAY_BRANCH_CODE||')' AS BRANCH_CODE,B.BANK_NAME,BR.BRANCH_NAME,
IM.REVENUE_STAMP_AMOUNT||' TK.' AS STAMP_AMOUNT,IM.PAY_DATE,NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0) AS TOT_AMOUNT,NVL(ID.PDB_AMOUNT,0) AS PDB_AMOUNT,NVL(ID.GOVT_DUTY,0) VAT_AMOUNT,
SUBSTR(ID.BILL_NUMBER,1,length(ID.BILL_NUMBER)-2) AS NO_OF_CON,SUBSTR(ID.BILL_NUMBER,-2) AS CD,
CASE  WHEN NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)>=500 THEN   10
          WHEN NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)<500   THEN   0
  END AS STAMP
FROM EPAY_PAYMENT_MST_INT IM,
EPAY_PAYMENT_DTL_INT ID,
EPAY_LOCATION_MASTER L,
EPAY_BANKS B,
EPAY_BANK_BRANCHES BR
WHERE IM.BATCH_NO=ID.BATCH_NO
AND IM.LOCATION_CODE=L.LOCATION_CODE
AND IM.LOCATION_CODE=BR.LOCATION_CODE
AND IM.PAY_BANK_CODE=B.BANK_CODE
AND IM.PAY_BRANCH_CODE=BR.BRANCH_CODE
AND IM.STATUS<>'T'
 AND (IM.PAY_BANK_CODE,IM.PAY_BRANCH_CODE) IN (SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                                    WHERE USER_ID=:P_User_Id
                                                                                    AND BANK_CODE=:P_Bank_Code
                                                                                    AND BRANCH_CODE=:P_Branch_Code)
     AND IM.LOCATION_CODE IN(SELECT v.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                AND D.USER_ID=:P_User_Id
                                                AND BANK_CODE=:P_Bank_Code
                                                AND D.LOCATION_CODE LIKE NVL (:P_Location_Code,'%'))
AND IM.PAY_DATE=:P_Start_Pay_Date
UNION
SELECT  ID.SCROLL_NO, BR.BILLING_BANK_CODE||' (New-'||IM.PAY_BANK_CODE||')' AS BANK_CODE,
L.LOCATION_CODE||' ('||L.LOCATION_NAME||')' AS LOCATION_NAME ,IM.REF_BATCH_NO AS BATCH_NO, IM.PAY_BANK_CODE AS NEW_BANK_CODE,
BR.BILLING_BRANCH_CODE||' (New-'||IM.PAY_BRANCH_CODE||')' AS BRANCH_CODE,B.BANK_NAME,BR.BRANCH_NAME,
IM.REVENUE_STAMP_AMOUNT||' TK.' AS STAMP_AMOUNT,IM.PAY_DATE,NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0) AS TOT_AMOUNT,NVL(ID.PDB_AMOUNT,0) AS PDB_AMOUNT,NVL(ID.GOVT_DUTY,0) VAT,
SUBSTR(ID.BILL_NUMBER,1,length(ID.BILL_NUMBER)-2) AS NO_OF_CON,SUBSTR(ID.BILL_NUMBER,-2) AS CD,
CASE  WHEN NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)>=500 THEN   10
          WHEN NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)<500   THEN   0
  END AS STAMP 
                FROM EPAY_PAYMENT_MST IM,
                EPAY_PAYMENT_DTL ID,
                EPAY_LOCATION_MASTER L,
                EPAY_BANKS B,
                EPAY_BANK_BRANCHES BR
WHERE IM.BATCH_NO=ID.BATCH_NO
AND IM.LOCATION_CODE=L.LOCATION_CODE
AND IM.LOCATION_CODE=BR.LOCATION_CODE
AND IM.PAY_BANK_CODE=B.BANK_CODE
AND B.BANK_CODE=BR.BANK_CODE
AND IM.PAY_BRANCH_CODE=BR.BRANCH_CODE
 AND (IM.PAY_BANK_CODE,IM.PAY_BRANCH_CODE) IN (SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                                    WHERE USER_ID=:P_User_Id
                                                                                    AND BANK_CODE=:P_Bank_Code
                                                                                    AND BRANCH_CODE LIKE NVL (:P_Branch_Code,'%'))
AND IM.LOCATION_CODE IN (SELECT v.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                            WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                            AND D.USER_ID=:P_User_Id
                                            AND BANK_CODE=:P_Bank_Code
                                            AND D.LOCATION_CODE=:P_Location_Code)
AND IM.PAY_DATE=:P_Start_Pay_Date
ORDER BY  PAY_DATE ASC


SELECT B.BANK_NAME ,Z.LOCATION_CODE,M.PAY_DATE,
            REVENUE_STAMP_AMOUNT REVENUE_AMOUNT, NET_PDB_AMOUNT NET_AMOUNT,TOTAL_GOVT_DUTY AS VAT_AMOUNT, TOTAL_PDB_AMOUNT AS TOT_AMOUNT, 
            TOTAL_GOVT_DUTY+TOTAL_PDB_AMOUNT AS TOT_BPDB_AMOUNT,
            TOT_CONSUMER,DECODE(M.STATUS,'N','Not Reconciled','P','Reconciled','E','Error') STATUS
        FROM  EPAY_PAYMENT_MST M,
                  (SELECT BATCH_NO AS BATCH_NO,COUNT(1) TOT_CONSUMER FROM EPAY_PAYMENT_DTL
                   GROUP BY BATCH_NO) D,
                  EPAY_BANKS B,
                  V_Z_C_C_L Z
        WHERE M.BATCH_NO=D.BATCH_NO 
        AND M.PAY_BANK_CODE=B.BANK_CODE
        AND M.LOCATION_CODE=Z.LOCATION_CODE
        AND B.STATUS='A'
        AND M.STATUS IN ('P','N','E')
AND COMP_CNTR_CODE IN (SELECT COMP_CNTR_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                 WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                 AND D.USER_ID=:P_User_Id
                                                 AND D.BANK_CODE=:P_Bank_Code
                                                 AND V.ZONE_CODE=:P_Zone_Code
                                                 AND V.COMP_CNTR_CODE LIKE NVL(:P_Comp_Cntr_Code,'%'))      
 AND (B.BANK_CODE,M.PAY_BRANCH_CODE) IN ( SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                                    WHERE USER_ID=:P_User_Id
                                                                                    AND BANK_CODE=:P_Bank_Code
                                                                                    AND BRANCH_CODE=:P_Branch_Code)
                                                                                            
        AND (ZONE_CODE,M.LOCATION_CODE) IN (SELECT ZONE_CODE,V.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                                        WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                                        AND D.USER_ID=:P_User_Id
                                                                        AND D.BANK_CODE=:P_Bank_Code
                                                                        AND V.LOCATION_CODE LIKE NVL (:P_Location_Code,'%')) 
        --AND M.PAY_DATE=P_Pay_Date                                                                                                                                                                         
        ORDER BY DECODE(M.STATUS,'N',2,'P',3,'E',1)
        
   -----------------------------------------------------------------------------
   
      SELECT COMP_CNTR_CODE,DESCR FROM EPAY_COMP_CNTR_MASTER
    WHERE COMP_CNTR_CODE IN(
    SELECT COMP_CNTR_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
    WHERE V.LOCATION_CODE=D.LOCATION_CODE
    AND D.USER_ID=:P_User_Id)
    ORDER BY COMP_CNTR_CODE     
    
     SELECT BANK_CODE,BANK_NAME FROM  EPAY_BANKS 
    WHERE BANK_CODE IN (
    SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
    WHERE USER_ID=:P_User_Id
    AND COMP_CNTR_CODE=:P_Comp_Cntr_Code)
    ORDER BY BANK_CODE
