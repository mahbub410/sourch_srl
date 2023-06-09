SELECT  A.PAY_DATE,C.BANK_NAME,B.BRANCH_NAME, COUNT(A.PAY_DATE) TOT_TRANS,SUM(PRN_AMOUNT) PRINCIPAL_AMT,SUM(VAT_AMOUNT) VAT_AMT,SUM(TOTAL_AMOUNT) TOTAL_AMT,SUM(REV_STAMP_AMOUNT) REV_STAMP_AMT,
 SUM(TOTAL_AMOUNT)-SUM(REV_STAMP_AMOUNT) NET_AMT
 FROM EPAYONLINE.EPAY_PAYMENT_DTL_ONLINE_HIST A,EPAYONLINE.EPAY_BANK_BRANCH B,EPAYONLINE.EPAY_BANK_MST C
 WHERE A.PAY_BANK_CODE=B.BANK_CODE
 AND A.PAY_BANK_BR_CODE=B.BRANCH_CODE
 AND A.PAY_BANK_CODE=C.BANK_CODE
 AND A.PAY_DATE BETWEEN :P_START_DATE AND :P_END_DATE
 AND A.PAY_BANK_CODE=:P_PAY_BANK_CODE
--  AND A.PAY_BANK_BR_CODE=:p_BRANCH_CODE
 AND A.ORG_CODE='WZPDCL'
 GROUP BY A.PAY_DATE,C.BANK_NAME,B.BRANCH_NAME
 ORDER BY TO_DATE(A.PAY_DATE)
 
 
---------------NBL-->01---NRB--04----
 
 SELECT  SUM(TOTAL_AMOUNT)-SUM(REV_STAMP_AMOUNT) NET_AMT,SUM(TOTAL_AMOUNT) TOTAL
 FROM EPAYONLINE.EPAY_PAYMENT_DTL_ONLINE_HIST A,EPAYONLINE.EPAY_BANK_BRANCH B,EPAYONLINE.EPAY_BANK_MST C
 WHERE A.PAY_BANK_CODE=B.BANK_CODE
 AND A.PAY_BANK_BR_CODE=B.BRANCH_CODE
 AND A.PAY_BANK_CODE=C.BANK_CODE
 AND A.PAY_DATE BETWEEN :P_START_DATE AND :P_END_DATE
 AND A.PAY_BANK_CODE=:P_PAY_BANK_CODE
 AND A.ORG_CODE='WZPDCL'
 UNION
 SELECT  SUM(TOTAL_AMOUNT)-SUM(REV_STAMP_AMOUNT) NET_AMT,SUM(TOTAL_AMOUNT) TOTAL
 FROM EPAYONLINE.EPAY_PAYMENT_DTL_ONLINE A,EPAYONLINE.EPAY_BANK_BRANCH B,EPAYONLINE.EPAY_BANK_MST C
 WHERE A.PAY_BANK_CODE=B.BANK_CODE
 AND A.PAY_BANK_BR_CODE=B.BRANCH_CODE
 AND A.PAY_BANK_CODE=C.BANK_CODE
 AND A.PAY_DATE BETWEEN :P_START_DATE AND :P_END_DATE
 AND A.PAY_BANK_CODE=:P_PAY_BANK_CODE
 AND A.ORG_CODE='WZPDCL'

 
 
 ------------MYCASH--->O9----ROCKET-->O1----TBL--->28----
 
 SELECT SUM(P.PRIN_AMT+P.VAT_AMT) TOTAL_AMT 
FROM MBP_CUST_PMNT@MBP_23 P,EPAY_LOCATION_MASTER L
WHERE P.ORG_BR_CODE=L.LOCATION_CODE
AND P.ORG_CODE='WZPDCL'
AND P.PC_CODE='01'
AND P.PAY_DATE BETWEEN '01-SEP-2019' AND '30-SEP-2019'
UNION
SELECT SUM(P.PRIN_AMT+P.VAT_AMT) TOTAL_AMT 
FROM MBP_CUST_PMNT_HIST@MBP_23 P,EPAY_LOCATION_MASTER L
WHERE P.ORG_BR_CODE=L.LOCATION_CODE
AND P.ORG_CODE='WZPDCL'
AND P.PC_CODE='01'
AND P.PAY_DATE BETWEEN  '01-SEP-2019' AND '30-SEP-2019'
