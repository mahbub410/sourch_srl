

SELECT BANK_CODE,BANK_NAME FROM  EPAY_BANKS 
    WHERE BANK_CODE IN (
    SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
    WHERE ORG_CODE=:P_Org_Code 
    AND USER_NAME=:P_User_Id)
    ORDER BY BANK_CODE;


    SELECT ZONE_CODE,DESCR ZONE_NAME FROM EPAY_ZONE_MASTER   
    WHERE ZONE_CODE IN (
    SELECT ZONE_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
    WHERE V.LOCATION_CODE=D.LOCATION_CODE
    AND D.USER_NAME=:P_User_Id
    AND ORG_CODE=:P_Org_Code 
    AND D.BANK_CODE=:P_Bank_Code)
    ORDER BY ZONE_CODE;
    
    
    SELECT PAY_DATE FROM EPAY_PAYMENT_MST
    WHERE STATUS='N'
    AND (PAY_BANK_CODE,PAY_BRANCH_CODE,LOCATION_CODE) IN  (    
     SELECT D.BANK_CODE,D.BRANCH_CODE,D.LOCATION_CODE FROM VW_EPAY_USER_ACCESS_DATA D,V_Z_C_C_L V
    WHERE V.LOCATION_CODE=D.LOCATION_CODE
    AND D.USER_NAME=:P_User_Id
    AND ORG_CODE=:P_Org_Code 
    AND D.BANK_CODE=:P_Bank_Code
    AND V.ZONE_CODE=:P_Zone_Code )
    ORDER BY PAY_DATE;
    
    
    
    SELECT B.BANK_CODE||'-'||B.BANK_NAME BANK_NAME,Z.LOCATION_CODE,TO_CHAR(M.PAY_DATE,'dd-Mon-yyyy') PAY_DATE ,
            NVL(REVENUE_STAMP_AMOUNT,0) REVENUE_AMOUNT, NVL(NET_PDB_AMOUNT,0) NET_AMOUNT,NVL(TOTAL_GOVT_DUTY,0) AS VAT_AMOUNT, NVL(TOTAL_PDB_AMOUNT,0) AS TOT_AMOUNT, 
            NVL(TOTAL_GOVT_DUTY,0)+NVL(TOTAL_PDB_AMOUNT,0) AS TOT_BPDB_AMOUNT,
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
        AND (B.BANK_CODE,M.PAY_BRANCH_CODE) IN ( SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                                    WHERE USER_NAME=:P_User_Id
                                                                                    AND ORG_CODE=:P_Org_Code
                                                                                    AND BANK_CODE=:P_Bank_Code)
        AND (ZONE_CODE,M.LOCATION_CODE) IN (SELECT ZONE_CODE,V.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                                        WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                                        AND D.USER_NAME=:P_User_Id
                                                                        AND ORG_CODE=:P_Org_Code
                                                                        AND D.BANK_CODE=:P_Bank_Code
                                                                        AND V.LOCATION_CODE LIKE NVL (:P_Location_Code,'%'))      
        AND COMP_CNTR_CODE IN (SELECT COMP_CNTR_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                 WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                 AND D.USER_NAME=:P_User_Id
                                                 AND D.BANK_CODE=:P_Bank_Code
                                                 AND ORG_CODE=:P_Org_Code
                                                 AND V.ZONE_CODE LIKE NVL(:P_Zone_Code,'%')
                                                 AND V.COMP_CNTR_CODE LIKE NVL(:P_Comp_Cntr_Code,'%'))      
        AND M.PAY_DATE=TO_DATE(:P_Pay_Date,'DD-MM-YYYY')                                                                                                                                                                         
        ORDER BY DECODE(M.STATUS,'N',2,'P',3,'E',1)