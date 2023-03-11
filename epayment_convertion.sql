
SELECT BANK_CODE,BANK_NAME FROM  EPAY_BANKS 
WHERE BANK_CODE IN (
SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
WHERE USER_ID=:P_User_Id)
ORDER BY BANK_CODE;

 
    
    
   SELECT ZONE_CODE,DESCR FROM EPAY_ZONE_MASTER   
    WHERE ZONE_CODE IN (
    SELECT ZONE_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
    WHERE V.LOCATION_CODE=D.LOCATION_CODE
    AND D.USER_ID=:P_User_Id
    AND D.BANK_CODE=:P_Bank_Code)
    ORDER BY ZONE_CODE;
   

select USER_ID, LOCATION_CODE, BANK_CODE, BRANCH_CODE, STATUS, EFF_DATE, EXP_DATE, CREATE_BY, CREATE_DATE
from 

insert into ADMIN_USER_ACCESS_DATA
(USER_ID, LOCATION_CODE, BANK_CODE, BRANCH_CODE,  EFF_DATE, EXP_DATE)
select 1 ,LOCATION_CODE, BANK_CODE, BRANCH_CODE,sysdate,sysdate+4000 from epay_bank_branches
where bank_code='97'
   
/*ZONE_WISE_COLLECTION_REPORT*/

SELECT Z.ZONE_NAME AS ZONE_NAME,
IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,TO_CHAR(IM.PAY_DATE,'RRRRMM') AS PAY_DATE,
SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOTAL_AMOUNT,
SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT,COUNT(1) AS NO_OF_CON 
FROM EPAY_PAYMENT_MST IM,
         EPAY_PAYMENT_DTL ID,
         EPAY_LOCATION_MASTER L,
         EPAY_BANKS B,
         EPAY_BANK_BRANCHES BR,
         V_Z_C_C_L Z
WHERE IM.BATCH_NO=ID.BATCH_NO
AND IM.LOCATION_CODE=L.LOCATION_CODE
AND IM.LOCATION_CODE=Z.LOCATION_CODE
AND L.LOCATION_CODE=Z.LOCATION_CODE
AND IM.LOCATION_CODE=BR.LOCATION_CODE
AND IM.PAY_BANK_CODE=B.BANK_CODE
AND IM.STATUS IN ('P','T')
AND L.STATUS='A'
AND B.BANK_CODE=BR.BANK_CODE
AND IM.PAY_BANK_CODE=BR.BANK_CODE
AND B.BANK_CODE= :P_BANK_CODE
AND Z.ZONE_CODE =:P_ZONE_CODE
AND B.BANK_CODE IN ( SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                    WHERE USER_ID=:P_USER_ID)
AND ZONE_CODE IN (SELECT ZONE_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                AND D.USER_ID=:P_USER_ID
                                AND D.BANK_CODE=:P_BANK_CODE )
AND TO_CHAR(IM.PAY_DATE,'RRRRMM')>=:P_START_PAY_MONTH
AND TO_CHAR(IM.PAY_DATE,'RRRRMM')<=:P_END_PAY_MONTH
GROUP BY Z.ZONE_NAME ,IM.PAY_BANK_CODE||'-'||B.BANK_NAME,TO_CHAR(IM.PAY_DATE,'RRRRMM')
UNION
SELECT Z.ZONE_NAME AS ZONE_NAME,
IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,TO_CHAR(IM.PAY_DATE,'RRRRMM') AS PAY_DATE,
SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOTAL_AMOUNT,
SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT,COUNT(1) AS NO_OF_CON 
FROM EPAY_PAYMENT_MST_HSTR IM,
         EPAY_PAYMENT_DTL_HSTR ID,
         EPAY_LOCATION_MASTER L,
         EPAY_BANKS B,
         EPAY_BANK_BRANCHES BR,
         V_Z_C_C_L Z
WHERE IM.BATCH_NO=ID.BATCH_NO
AND IM.LOCATION_CODE=L.LOCATION_CODE
AND IM.LOCATION_CODE=Z.LOCATION_CODE
AND L.LOCATION_CODE=Z.LOCATION_CODE
AND IM.LOCATION_CODE=BR.LOCATION_CODE
AND IM.PAY_BANK_CODE=B.BANK_CODE
AND IM.STATUS IN ('P','T')
AND L.STATUS='A'
AND B.BANK_CODE=BR.BANK_CODE
AND IM.PAY_BANK_CODE=BR.BANK_CODE
AND B.BANK_CODE= :P_BANK_CODE
AND Z.ZONE_CODE =:P_ZONE_CODE
AND B.BANK_CODE IN ( SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                    WHERE USER_ID=:P_USER_ID)
AND ZONE_CODE IN (SELECT ZONE_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                AND D.USER_ID=:P_USER_ID
                                AND D.BANK_CODE=:P_BANK_CODE )
AND TO_CHAR(IM.PAY_DATE,'RRRRMM')>=:P_START_PAY_MONTH
AND TO_CHAR(IM.PAY_DATE,'RRRRMM')<=:P_END_PAY_MONTH
GROUP BY Z.ZONE_NAME ,IM.PAY_BANK_CODE||'-'||B.BANK_NAME,TO_CHAR(IM.PAY_DATE,'RRRRMM')
ORDER BY 3 DESC


    SELECT COMP_CNTR_CODE,DESCR FROM EPAY_COMP_CNTR_MASTER
    WHERE COMP_CNTR_CODE IN(
    SELECT COMP_CNTR_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
    WHERE V.LOCATION_CODE=D.LOCATION_CODE
    AND D.USER_ID=:P_USER_ID
    AND D.BANK_CODE=:P_BANK_CODE
    AND V.ZONE_CODE=:P_ZONE_CODE)
    
        SELECT LOCATION_CODE,LOCATION_NAME FROM EPAY_LOCATION_MASTER
    WHERE LOCATION_CODE IN(
    SELECT v.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
    WHERE V.LOCATION_CODE=D.LOCATION_CODE
    AND D.USER_ID=:P_USER_ID
    AND D.BANK_CODE=:P_BANK_CODE
    AND V.ZONE_CODE=:P_ZONE_CODE
    and V.COMP_CNTR_CODE LIKE NVL (:p_COMP_CNTR_CODE, '%'))
    
    
    /*DIVISION_WISE_REPORT*/
    
                SELECT  Z.ZONE_CODE||'-'||Z.ZONE_NAME AS ZONE_NAME,
                    IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,L.LOCATION_CODE||'-'||INITCAP(L.LOCATION_NAME) AS LOCATION_NAME,TO_CHAR(IM.PAY_DATE,'DD-MON-YY') AS PAY_DATE,
                    NVL(NET_PDB_AMOUNT,0) NET_PDB_AMT,NVL(REVENUE_STAMP_AMOUNT,0) AS REV_STAMP_AMT,
                    SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOTAL_AMOUNT,
                    SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT_AMOUNT,COUNT(1) AS NO_OF_CON 
                FROM EPAY_PAYMENT_MST IM,
                         EPAY_PAYMENT_DTL ID,
                         EPAY_LOCATION_MASTER L,
                         EPAY_BANKS B,
                         V_Z_C_C_L Z
                WHERE IM.BATCH_NO=ID.BATCH_NO
                AND IM.LOCATION_CODE=L.LOCATION_CODE
                AND IM.LOCATION_CODE=Z.LOCATION_CODE
                AND L.LOCATION_CODE=Z.LOCATION_CODE
                AND IM.PAY_BANK_CODE=B.BANK_CODE
                 AND IM.STATUS IN ('P','T')
                AND L.STATUS='A'
                AND BANK_CODE IN (SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                WHERE USER_ID=:P_USER_ID
                                                AND BANK_CODE=:P_BANK_CODE)
                AND Z.ZONE_CODE IN (SELECT ZONE_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                    WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                    AND D.USER_ID=:P_USER_ID
                                                    AND D.BANK_CODE=:P_BANK_CODE
                                                    AND V.ZONE_CODE=:P_ZONE_CODE)
                AND Z.COMP_CNTR_CODE IN(SELECT COMP_CNTR_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                            WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                            AND D.USER_ID=:P_USER_ID
                                                            AND D.BANK_CODE=:P_BANK_CODE
                                                            AND V.ZONE_CODE=:P_ZONE_CODE
                                                            AND V.COMP_CNTR_CODE=:P_COMP_CNTR_CODE)
                AND IM.LOCATION_CODE LIKE NVL(:P_LOCATION_CODE,'%')
                AND IM.PAY_DATE>=:P_START_PAY_DATE
                AND IM.PAY_DATE<=:P_END_PAY_DATE
                GROUP BY  Z.ZONE_CODE||'-'||Z.ZONE_NAME ,IM.PAY_BANK_CODE||'-'||B.BANK_NAME,
                L.LOCATION_CODE||'-'||INITCAP(L.LOCATION_NAME),TO_CHAR(IM.PAY_DATE,'DD-MON-YY'),NVL(NET_PDB_AMOUNT,0),NVL(REVENUE_STAMP_AMOUNT,0)
                ORDER BY 4 ASC,3 ASC  
                
         //* BANK_WISE_MONTHLY_REPORT */       
                
                SELECT IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,TO_CHAR(im.PAY_DATE,'RRRRMM') AS PAY_DATE,
                SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOTAL_AMOUNT,
                SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT_AMOUNT,COUNT(1) AS NO_OF_CON 
                FROM EPAY_PAYMENT_MST IM,
                          EPAY_PAYMENT_DTL ID,
                          EPAY_LOCATION_MASTER L,
                          EPAY_BANKS B,
                          V_Z_C_C_L Z
                WHERE IM.BATCH_NO=ID.BATCH_NO
                AND IM.LOCATION_CODE=L.LOCATION_CODE
                AND IM.LOCATION_CODE=Z.LOCATION_CODE
                AND L.LOCATION_CODE=Z.LOCATION_CODE
                AND IM.PAY_BANK_CODE=B.BANK_CODE
                 AND IM.STATUS IN ('P','T')
                AND L.STATUS='A'
                AND B.BANK_CODE IN ( SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                    WHERE USER_ID=:P_User_Id
                                                    AND BANK_CODE=:P_Bank_Code)
                AND TO_CHAR(im.PAY_DATE,'RRRRMM')>=:P_START_PAY_MONTH
                AND TO_CHAR(im.PAY_DATE,'RRRRMM')<=:P_END_PAY_MONTH
                GROUP BY  IM.PAY_BANK_CODE||'-'||B.BANK_NAME,TO_CHAR(im.PAY_DATE,'RRRRMM')
                ORDER BY 3
                
        //* CIRCLE_WISE_REPORT */
                
                SELECT  IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,Z.CIRCLE_CODE||'-'||Z.CIRCLE_NAME AS CIRCLE_NAME,
                L.LOCATION_CODE||'-'||INITCAP(L.LOCATION_NAME) AS LOCATION_NAME,TO_CHAR(IM.PAY_DATE,'DD-MON-YYYY')  PAY_date,
                SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS UTILITY_AMOUNT,
                SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT_AMOUNT,COUNT(1) AS NO_OF_CON 
                FROM EPAY_PAYMENT_MST IM,
                EPAY_PAYMENT_DTL ID,
                EPAY_LOCATION_MASTER L,
                EPAY_BANKS B,
                V_Z_C_C_L Z
                WHERE IM.BATCH_NO=ID.BATCH_NO
                AND IM.LOCATION_CODE=L.LOCATION_CODE
                AND IM.LOCATION_CODE=Z.LOCATION_CODE
                AND L.LOCATION_CODE=Z.LOCATION_CODE
                AND IM.PAY_BANK_CODE=B.BANK_CODE
                AND IM.STATUS IN ('P','T')
                AND L.STATUS='A'
                AND B.BANK_CODE IN ( SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                    WHERE USER_ID=:P_User_Id
                                                    AND BANK_CODE=:P_Bank_Code)
                AND CIRCLE_CODE IN (SELECT V. CIRCLE_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                    WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                    AND D.USER_ID=:P_User_Id
                                                    AND D.BANK_CODE=:P_Bank_Code
                                                    AND V.CIRCLE_CODE=:P_CIRCLE_CODE) 
                AND im.PAY_DATE>=:P_START_PAY_DATE
                AND im.PAY_DATE<=:P_END_PAY_DATE
                GROUP BY IM.PAY_BANK_CODE||'-'||B.BANK_NAME,Z.CIRCLE_CODE||'-'||Z.CIRCLE_NAME,
                L.LOCATION_CODE||'-'||INITCAP(L.LOCATION_NAME),TO_CHAR(IM.PAY_DATE,'DD-MON-YYYY')
                ORDER BY 4 ASC,3 ASC 
                
                
                
                
                    SELECT  CIRCLE_CODE,DESCR FROM EPAY_CIRCLE_MASTER
    WHERE CIRCLE_CODE IN (SELECT V. CIRCLE_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                            WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                            AND D.USER_ID=:P_USER_ID
                                            AND D.BANK_CODE=:P_BANK_CODE)
    ORDER BY CIRCLE_CODE;
    
    
    //* CENTER_WISE_REPORT */
    
    
  
                
                
                SELECT  IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,Z.COMP_CNTR_CODE||'-'||Z.COMP_CNTR_NAME AS COMP_CENTER_NAME,
                L.LOCATION_CODE||'-'||INITCAP(L.LOCATION_NAME) AS LOCATION_NAME,TO_CHAR(IM.PAY_DATE,'DD-MON-YYYY') AS PAY_date,
                SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOTAL_AMOUNT,
                SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT_AMOUNT,COUNT(1) AS NO_OF_CON 
                FROM EPAY_PAYMENT_MST IM,
                EPAY_PAYMENT_DTL ID,
                EPAY_LOCATION_MASTER L,
                EPAY_BANKS B,
                V_Z_C_C_L Z
                WHERE IM.BATCH_NO=ID.BATCH_NO
                AND IM.LOCATION_CODE=L.LOCATION_CODE
                AND IM.LOCATION_CODE=Z.LOCATION_CODE
                AND L.LOCATION_CODE=Z.LOCATION_CODE
                AND IM.PAY_BANK_CODE=B.BANK_CODE
                 AND IM.STATUS IN ('P','T')
                AND L.STATUS='A'
                AND BANK_CODE IN (SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                WHERE USER_ID=:P_User_Id
                                                AND BANK_CODE=:P_bank_code)
                AND Z.COMP_CNTR_CODE IN(SELECT COMP_CNTR_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                            WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                            AND D.USER_ID=:P_User_Id
                                                            AND D.BANK_CODE=:P_Bank_Code
                                                            AND V.COMP_CNTR_CODE=:P_Comp_Cntr_Code)
                AND im.PAY_DATE>=:P_START_PAY_DATE
                AND im.PAY_DATE<=:P_END_PAY_DATE
                GROUP BY IM.PAY_BANK_CODE||'-'||B.BANK_NAME,Z.COMP_CNTR_CODE||'-'||Z.COMP_CNTR_NAME,
                L.LOCATION_CODE||'-'||INITCAP(L.LOCATION_NAME),TO_CHAR(IM.PAY_DATE,'DD-MON-YYYY')
                ORDER BY 4 ASC,3 ASC
                
            //*  BANK_WISE_REPORT */ 
               
SELECT    IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,TO_CHAR(im.PAY_DATE,'RRRRMM') AS PAY_DATE,
    SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOTAL_AMOUNT,
    SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT,COUNT(1) AS NO_OF_CON 
    FROM EPAY_PAYMENT_MST IM,
              EPAY_PAYMENT_DTL ID,
              EPAY_LOCATION_MASTER L,
              EPAY_BANKS B,
              V_Z_C_C_L Z
    WHERE IM.BATCH_NO=ID.BATCH_NO
    AND IM.LOCATION_CODE=L.LOCATION_CODE
    AND IM.LOCATION_CODE=Z.LOCATION_CODE
    AND L.LOCATION_CODE=Z.LOCATION_CODE
    AND IM.PAY_BANK_CODE=B.BANK_CODE
     AND IM.STATUS IN ('P','T')
    AND L.STATUS='A'
    AND B. BANK_CODE IN (SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                        WHERE USER_ID=:P_User_Id
                                        AND BANK_CODE=:P_bank_code)
    AND TO_CHAR(im.PAY_DATE,'RRRRMM')>=:P_Start_Month
    AND TO_CHAR(im.PAY_DATE,'RRRRMM')<=:P_End_Month
    GROUP BY  IM.PAY_BANK_CODE||'-'||B.BANK_NAME,TO_CHAR(im.PAY_DATE,'RRRRMM')
    
    97-Axiata Bangladesh Ltd    201801    572235974.64    545387441.29    26848533.35    676082
                
                
                //* DATE_WISE_REPORT */
                
                
                SELECT  Z.ZONE_CODE||'-'||Z.ZONE_NAME AS ZONE_NAME,
                IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,IM.PAY_DATE AS PAY_DATE,
                SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS UTILITY_AMOUNT,
                SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT,COUNT(1) AS NO_OF_CON 
                FROM EPAY_PAYMENT_MST IM,
                EPAY_PAYMENT_DTL ID,
                EPAY_LOCATION_MASTER L,
                EPAY_BANKS B,
                V_Z_C_C_L Z
                 WHERE IM.BATCH_NO=ID.BATCH_NO
                AND IM.LOCATION_CODE=L.LOCATION_CODE
                AND IM.LOCATION_CODE=Z.LOCATION_CODE
                AND L.LOCATION_CODE=Z.LOCATION_CODE
                AND IM.PAY_BANK_CODE=B.BANK_CODE
                 AND IM.STATUS IN ('P','T')
                AND L.STATUS='A'
                 AND B. BANK_CODE IN (SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                        WHERE USER_ID=:P_User_Id
                                        AND BANK_CODE=:P_bank_code)
                AND Z.ZONE_CODE IN (SELECT ZONE_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                    WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                    AND D.USER_ID=:P_User_Id
                                                    AND D.BANK_CODE=:P_Bank_Code
                                                    AND V.ZONE_CODE=:P_Zone_code)                        
                AND IM.PAY_DATE>=:P_START_PAY_DATE
                AND IM.PAY_DATE<=:P_END_PAY_DATE
                GROUP BY  Z.ZONE_CODE||'-'||Z.ZONE_NAME ,IM.PAY_BANK_CODE||'-'||B.BANK_NAME,IM.PAY_DATE
                order by 3
                
                
                UNION
                   SELECT  Z.ZONE_CODE||'-'||Z.ZONE_NAME AS ZONE_NAME,
                IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,IM.PAY_DATE AS PAY_DATE,
                SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS UTILITY_AMOUNT,
                SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT,COUNT(1) AS NO_OF_CON 
                FROM EPAY_PAYMENT_MST_HSTR IM,
                EPAY_PAYMENT_DTL_HSTR ID,
                EPAY_LOCATION_MASTER L,
                EPAY_BANKS B,
                EPAY_BANK_BRANCHES BR,
                V_Z_C_C_L Z,
                EPAY_USER_MST U,
                 EPAY_ACCESS_ALLOW_MAP M
                WHERE IM.BATCH_NO=ID.BATCH_NO
                AND IM.LOCATION_CODE=L.LOCATION_CODE
                AND IM.LOCATION_CODE=Z.LOCATION_CODE
                AND L.LOCATION_CODE=Z.LOCATION_CODE
            AND IM.LOCATION_CODE=BR.LOCATION_CODE
                AND IM.PAY_BANK_CODE=B.BANK_CODE
                 AND IM.STATUS IN ('P','T')
                AND L.STATUS='A'
                AND M.STATUS='A'
                AND B.BANK_CODE=BR.BANK_CODE
                AND IM.PAY_BANK_CODE=BR.BANK_CODE
                AND B.BANK_CODE=M.BANK_CODE
                AND M.BANK_CODE=BR.BANK_CODE
                --AND B.BANK_CODE=U.BANK_CODE
                --AND IM.PAY_BANK_CODE=U.BANK_CODE
                AND B.BANK_CODE=:P_BANK_CODE
                AND UPPER(U.USER_NAME)=UPPER(M.USER_DESC)
                AND U.USER_NAME=UPPER(:APP_USER)
                AND Z.ZONE_CODE=M.ZONE_CODE
                AND Z.ZONE_CODE LIKE DECODE(:P_ZONE_CODE,'ALL','%',:P_ZONE_CODE)
                AND IM.PAY_DATE>=:P_START_PAY_DATE
                AND IM.PAY_DATE<=:P_END_PAY_DATE
                GROUP BY  Z.ZONE_CODE||'-'||Z.ZONE_NAME ,IM.PAY_BANK_CODE||'-'||B.BANK_NAME,IM.PAY_DATE
          
                
                
                
                SELECT IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,TO_CHAR(im.PAY_DATE,'RRRRMM') AS PAY_DATE,
        SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOTAL_AMOUNT,
        SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT_AMOUNT,COUNT(1) AS NO_OF_CON 
        FROM EPAY_PAYMENT_MST IM,
                  EPAY_PAYMENT_DTL ID,
                  EPAY_LOCATION_MASTER L,
                  EPAY_BANKS B,
                  V_Z_C_C_L Z
        WHERE IM.BATCH_NO=ID.BATCH_NO
        AND IM.LOCATION_CODE=L.LOCATION_CODE
        AND IM.LOCATION_CODE=Z.LOCATION_CODE
        AND L.LOCATION_CODE=Z.LOCATION_CODE
        AND IM.PAY_BANK_CODE=B.BANK_CODE
        AND IM.STATUS IN ('P','T')
        AND L.STATUS='A'
        AND B.BANK_CODE IN ( SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                            WHERE USER_ID=:P_User_Id
                                            AND BANK_CODE=:P_Bank_Code)
        AND TO_CHAR(im.PAY_DATE,'RRRRMM')>=:P_Start_Month
        AND TO_CHAR(im.PAY_DATE,'RRRRMM')<=:P_End_Month
        GROUP BY  IM.PAY_BANK_CODE||'-'||B.BANK_NAME,TO_CHAR(im.PAY_DATE,'RRRRMM')
        
        
        
          SELECT Z.ZONE_NAME AS ZONE_NAME,COMP_CNTR_NAME,
        IM.PAY_BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,TO_CHAR(IM.PAY_DATE,'RRRRMM') AS PAY_DATE,
        SUM(NVL(ID.PDB_AMOUNT,0)+NVL(ID.GOVT_DUTY,0)) AS TOTAL_AMOUNT,
        SUM(NVL(ID.PDB_AMOUNT,0)) AS PDB_AMOUNT,SUM(NVL(ID.GOVT_DUTY,0)) VAT_AMOUNT,COUNT(1) AS NO_OF_CON 
        FROM EPAY_PAYMENT_MST IM,
                 EPAY_PAYMENT_DTL ID,
                 EPAY_LOCATION_MASTER L,
                 EPAY_BANKS B,
                 V_Z_C_C_L Z
        WHERE IM.BATCH_NO=ID.BATCH_NO
        AND IM.LOCATION_CODE=L.LOCATION_CODE
        AND IM.LOCATION_CODE=Z.LOCATION_CODE
        AND L.LOCATION_CODE=Z.LOCATION_CODE
        AND IM.PAY_BANK_CODE=B.BANK_CODE
        AND L.STATUS='A'
        AND B.BANK_CODE IN ( SELECT BANK_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                            WHERE USER_ID=:P_User_Id
                                            AND BANK_CODE=:P_Bank_Code)
        AND TO_CHAR(IM.PAY_DATE,'RRRRMM')=:P_Start_Month
        GROUP BY Z.ZONE_NAME ,COMP_CNTR_NAME,IM.PAY_BANK_CODE||'-'||B.BANK_NAME,TO_CHAR(IM.PAY_DATE,'RRRRMM')
        ORDER BY 1,2;
        
        
        -------RECONCILED SUCESS-----------
        
SELECT Z.COMP_CNTR_CODE ZONE_CODE,' '||Z.COMP_CNTR_CODE||'-'||Z.COMP_CNTR_NAME AS DESCR,B.BANK_CODE,' '||B.BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,
' '||Z.LOCATION_CODE||'-'||Z.LOCATION_NAME AS LOCATION_NAME,V.PAY_DATE
,SUM(NVL(V.PDB_AMOUNT,0)) TOTAL_PAYMENT,SUM(NVL(V.GOVT_DUTY,0)) VAT_AMOUNT,SUM(NVL(V.PDB_AMOUNT,0)+NVL(V.GOVT_DUTY,0)) BPDB_AMOUNT,COUNT(*) TOTAL_CONSUMER,V.STATUS
            FROM VW_EPAY_PAYMENT_MST_DTL V,
                      EPAY_BANKS B,
                      EPAY_USER_MST U,
                      EPAY_USER_COMP_CENTR_MAP M,
                      V_Z_C_C_L Z
WHERE V.PAY_BANK_CODE=B.BANK_CODE
AND Z.COMP_CNTR_CODE=M.COMP_CNTR_CODE
--AND B.BANK_CODE=U.BANK_CODE(+)
AND U.USER_ID=M.USER_ID
AND UPPER(U.USER_NAME)=:APP_USER
AND V.LOCATION_CODE=Z.LOCATION_CODE
AND B.STATUS='A'
AND Z.COMP_CNTR_CODE=:P_COMP_CNTR_CODE
AND B.BANK_CODE=:P_BANK_CODE
AND TO_CHAR(V.PAY_DATE,'RRRRMM')=:P_PAY_MONTH
AND V.STATUS IN ('P','T')
AND Z.LOCATION_CODE =:P_LOCATION_CODE
GROUP BY ' '||Z.LOCATION_CODE||'-'||Z.LOCATION_NAME,Z.COMP_CNTR_CODE,' '||Z.COMP_CNTR_CODE||'-'||Z.COMP_CNTR_NAME,B.BANK_CODE,' '||B.BANK_CODE||'-'||B.BANK_NAME ,V.PAY_DATE,V.STATUS
ORDER BY V.PAY_DATE ASC

--------recon suc---

SELECT B.BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,
Z.ZONE_CODE||'-'||Z.ZONE_NAME ZONE_NAME,Z.COMP_CNTR_CODE||'-'||Z.COMP_CNTR_NAME AS COMP_CNTR_NAME,
Z.LOCATION_CODE||'-'||Z.LOCATION_NAME AS LOCATION_NAME,M.PAY_DATE
,SUM(NVL(D.PDB_AMOUNT,0)) BPDB_AMOUNT,SUM(NVL(D.GOVT_DUTY,0)) VAT_AMOUNT,
SUM(NVL(D.PDB_AMOUNT,0)+NVL(D.GOVT_DUTY,0)) TOTAL_AMOUNT,COUNT(*) TOTAL_CONSUMER
            FROM EPAY_PAYMENT_MST M,
                      EPAY_PAYMENT_DTL D,
                      EPAY_BANKS B,
                      V_Z_C_C_L Z
WHERE M.BATCH_NO=D.BATCH_NO 
AND M.PAY_BANK_CODE=B.BANK_CODE
AND M.LOCATION_CODE=Z.LOCATION_CODE
AND B.STATUS='A'
AND M.STATUS IN ('P','T')
AND (B.BANK_CODE,M.PAY_BRANCH_CODE) IN ( SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                            WHERE USER_ID=:P_User_Id
                                                                            AND BANK_CODE=:P_Bank_Code)
AND (ZONE_CODE,M.LOCATION_CODE) IN (SELECT ZONE_CODE,V.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                                WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                                AND D.USER_ID=:P_User_Id
                                                                AND D.BANK_CODE=:P_Bank_Code
                                                                AND V.LOCATION_CODE LIKE NVL (:LOCATION_CODE,'%'))      
AND COMP_CNTR_CODE IN (SELECT COMP_CNTR_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                         WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                         AND D.USER_ID=:P_User_Id
                                         AND D.BANK_CODE=:P_Bank_Code
                                         AND V.ZONE_CODE=:P_Zone_Code
                                         AND V.COMP_CNTR_CODE LIKE NVL(:P_COMP_CNTR_CODE,'%'))      
AND M.PAY_DATE=:P_PAY_DATE                                                                                                                                                                         
GROUP BY Z.ZONE_CODE||'-'||Z.ZONE_NAME ,Z.COMP_CNTR_CODE||'-'||Z.COMP_CNTR_NAME,B.BANK_CODE,B.BANK_CODE||'-'||B.BANK_NAME ,
Z.LOCATION_CODE||'-'||Z.LOCATION_NAME,M.PAY_DATE
ORDER BY Z.COMP_CNTR_CODE||'-'||Z.COMP_CNTR_NAME,Z.LOCATION_CODE||'-'||Z.LOCATION_NAME


------------recon unsec------

SELECT Z.COMP_CNTR_CODE ZONE_CODE,Z.COMP_CNTR_CODE||'-'||Z.COMP_CNTR_NAME AS DESCR,B.BANK_CODE,B.BANK_CODE||'-'||B.BANK_NAME AS BANK_NAME,
Z.LOCATION_CODE||'-'||Z.LOCATION_NAME AS LOCATION_NAME,M.PAY_DATE
,SUM(NVL(D.PDB_AMOUNT,0)) TOTAL_PAYMENT,SUM(NVL(D.GOVT_DUTY,0)) VAT_AMOUNT,SUM(NVL(D.PDB_AMOUNT,0)+NVL(D.GOVT_DUTY,0)) BPDB_AMOUNT,COUNT(*) TOTAL_CONSUMER,M.STATUS
            FROM EPAY_PAYMENT_MST M,
                      EPAY_PAYMENT_DTL D,
                      EPAY_BANKS B,
                      V_Z_C_C_L Z
WHERE M.BATCH_NO=D.BATCH_NO 
AND M.PAY_BANK_CODE=B.BANK_CODE
AND M.LOCATION_CODE=Z.LOCATION_CODE
AND B.STATUS='A'
AND M.STATUS NOT IN ('P','T')
AND (B.BANK_CODE,M.PAY_BRANCH_CODE) IN ( SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                            WHERE USER_ID=:P_User_Id
                                                                            AND BANK_CODE=:P_Bank_Code)
AND (ZONE_CODE,M.LOCATION_CODE) IN (SELECT ZONE_CODE,V.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                                WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                                AND D.USER_ID=:P_User_Id
                                                                AND D.BANK_CODE=:P_Bank_Code)      
AND COMP_CNTR_CODE IN (SELECT COMP_CNTR_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                         WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                         AND D.USER_ID=:P_User_Id
                                         AND D.BANK_CODE=:P_Bank_Code
                                         AND V.ZONE_CODE=:P_Zone_Code
                                         AND V.COMP_CNTR_CODE LIKE NVL(:P_COMP_CNTR_CODE,'%'))      
AND TO_CHAR(M.PAY_DATE,'RRRRMM')=:P_PAY_DATE                                                                                                                                                                         
GROUP BY Z.LOCATION_CODE||'-'||Z.LOCATION_NAME,Z.COMP_CNTR_CODE,Z.COMP_CNTR_CODE||'-'||Z.COMP_CNTR_NAME,B.BANK_CODE,B.BANK_CODE||'-'||B.BANK_NAME ,M.PAY_DATE,M.STATUS
ORDER BY M.PAY_DATE desc










SELECT * FROM (
SELECT ROWID,REF_BATCH_NO,LOCATION_CODE,PAY_DATE,
PAY_BANK_CODE||'-'||DECODE(PAY_BANK_CODE,'97','Axiata Bangladesh Ltd','96','Grameen Phone Ltd','77','Banklalink',PAY_BANK_CODE) AS OPERATOR_NAME,
REVENUE_STAMP_AMOUNT,NET_PDB_AMOUNT,TOTAL_GOVT_DUTY AS TOTAL_VAT,TOTAL_PDB_AMOUNT AS TOT_AMOUNT ,
TOTAL_GOVT_DUTY+TOTAL_PDB_AMOUNT AS TOT_BPDB_AMOUNT,
--apex_item.checkbox(1,BATCH_NO,'UNCHECKED' ) AS Reconcile Status,
DECODE(STATUS,'N','Not Reconciled','P','Reconciled','E','Error',STATUS) FLAG_DESC
FROM EPAY_PAYMENT_MST
WHERE LOCATION_CODE IN(SELECT LOCATION_CODE FROM EPAY_ZONE_COMP_CNTR_LOC
                                                          --WHERE ZONE_CODE=:P3_X_ZONE
                                                          )
AND PAY_BANK_CODE IN(SELECT BANK_CODE FROM EPAY_ONLINE_OPERATOR
                           --WHERE ONLINE_OPT=:P3_X_ONLINE_OPT
                           )
--AND PAY_DATE=:P3_X_PAY_DATE
AND STATUS IN ('P','N','E')
--AND STATUS='N'
) M,
(SELECT REF_BATCH_NO AS BATCH_NO,COUNT(1) TOT_TRNS FROM EPAY_PAYMENT_DTL
 GROUP BY REF_BATCH_NO) D
 WHERE D.BATCH_NO=M.REF_BATCH_NO
ORDER BY FLAG_DESC ASC,LOCATION_CODE ASC

REF_BATCH_NO, LOCATION_CODE, PAY_DATE, OPERATOR_NAME, 

        SELECT M.BATCH_NO ,Z.COMP_CNTR_NAME,Z.LOCATION_CODE,Z.LOCATION_NAME,M.PAY_DATE,
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
        AND (B.BANK_CODE,M.PAY_BRANCH_CODE) IN ( SELECT BANK_CODE,BRANCH_CODE FROM VW_EPAY_USER_ACCESS_DATA
                                                                                    WHERE USER_ID=:P_User_Id
                                                                                    AND BANK_CODE=:P_Bank_Code)
        AND (ZONE_CODE,M.LOCATION_CODE) IN (SELECT ZONE_CODE,V.LOCATION_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                                        WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                                        AND D.USER_ID=:P_User_Id
                                                                        AND D.BANK_CODE=:P_Bank_Code
                                                                        AND V.LOCATION_CODE LIKE NVL (:P_Location_Code,'%'))      
        AND COMP_CNTR_CODE IN (SELECT COMP_CNTR_CODE FROM V_Z_C_C_L V,VW_EPAY_USER_ACCESS_DATA D
                                                 WHERE V.LOCATION_CODE=D.LOCATION_CODE
                                                 AND D.USER_ID=:P_User_Id
                                                 AND D.BANK_CODE=:P_Bank_Code
                                                 AND V.ZONE_CODE=:P_Zone_Code
                                                 AND V.COMP_CNTR_CODE LIKE NVL(:P_Comp_Cntr_Code,'%'))      
        AND M.PAY_DATE=:P_Pay_Date                                                                                                                                                                         
        ORDER BY DECODE(M.STATUS,'N',2,'P',3,'E',1);


----------------------------------------------------------





declare

pymt_count number;
bill_count number;

BEGIN

FOR I in 1..APEX_APPLICATION.G_F01.COUNT LOOP

pymt_count:=0;
bill_count:=0;

select count(d.bill_number) into pymt_count from epay_payment_mst m,epay_payment_dtl d
where m.batch_no=d.batch_no
and m.BATCH_NO=APEX_APPLICATION.G_F01(i)
AND m.STATUS NOT IN ('P','T','M');

select count(d.bill_number) into bill_count from epay_payment_mst m,epay_payment_dtl d,epay_utility_bill b
where m.batch_no=d.batch_no
and d.bill_number=b.bill_number
and m.location_code=b.location_code
and m.BATCH_NO=APEX_APPLICATION.G_F01(i)
AND m.STATUS NOT IN ('P','T','M');

if pymt_count=bill_count then

 update epay_payment_mst
 set status='P',USER_NAME=:APP_USER
 where BATCH_NO=APEX_APPLICATION.G_F01(i)
 AND STATUS NOT IN ('P','T','M');

elsif pymt_count<>bill_count then

 update epay_payment_mst
 set status='E'
 where BATCH_NO=APEX_APPLICATION.G_F01(i)
 AND STATUS NOT IN ('P','T','M');

end if;
END LOOP;
 commit;

END;