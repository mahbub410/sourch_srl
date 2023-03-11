SELECT C.ZONE_NAME,C.COMP_CNTR_NAME,C.LOCATION_CODE||' - '||C.LOCATION_NAME LOCATION_NAME, TO_CHAR(M.PAY_DATE,'RRRRMM')  MONTH, 
SUM(DECODE(M.PAY_BANK_CODE,'96',1,M.PAY_BANK_CODE,0)) NO_OF_CONSUMER_GP,SUM(DECODE(M.PAY_BANK_CODE,'96',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))  BPDB_AMOUNT_GP,
SUM(DECODE(M.PAY_BANK_CODE,'97',1,M.PAY_BANK_CODE,0)) NO_OF_CONSUMER_ROBI,SUM(DECODE(M.PAY_BANK_CODE,'97',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))  BPDB_AMOUNT_ROBI,
SUM(DECODE(M.PAY_BANK_CODE,'94',1,M.PAY_BANK_CODE,0)) NO_OF_CONSUMER_bKash,SUM(DECODE(M.PAY_BANK_CODE,'94',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))  BPDB_AMOUNT_bKash,
SUM(DECODE(M.PAY_BANK_CODE,'96',1,M.PAY_BANK_CODE,0))+SUM(DECODE(M.PAY_BANK_CODE,'97',1,M.PAY_BANK_CODE,0))+SUM(DECODE(M.PAY_BANK_CODE,'94',1,M.PAY_BANK_CODE,0)) TOTAL_CUSTOMER,
SUM(DECODE(M.PAY_BANK_CODE,'96',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))+SUM(DECODE(M.PAY_BANK_CODE,'97',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))+SUM(DECODE(M.PAY_BANK_CODE,'94',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0)) TOTAL_AMOUNT_BPDB
FROM EPAY_PAYMENT_MST M,EPAY_PAYMENT_DTL D,V_Z_C_C_L C
WHERE M.BATCH_NO=D.BATCH_NO
AND M.LOCATION_CODE=C.LOCATION_CODE
AND C.ZONE_CODE=:P_ZONE_CODE
AND C.COMP_CNTR_CODE=:P_COMP_CNTR_CODE
AND TO_CHAR(M.PAY_DATE,'RRRRMM')=:P_START_MONTH
--AND TO_CHAR(M.PAY_DATE,'RRRRMM')<=:P_END_MONTH
AND M.PAY_BANK_CODE IN ('96','97','94')
GROUP BY  C.ZONE_NAME,C.COMP_CNTR_NAME,C.LOCATION_NAME,C.LOCATION_CODE,TO_CHAR(M.PAY_DATE,'RRRRMM')
UNION
SELECT C.ZONE_NAME,C.COMP_CNTR_NAME,C.LOCATION_CODE||' - '||C.LOCATION_NAME LOCATION_NAME, TO_CHAR(M.PAY_DATE,'RRRRMM')  MONTH, 
SUM(DECODE(M.PAY_BANK_CODE,'96',1,M.PAY_BANK_CODE,0)) NO_OF_CONSUMER_GP,SUM(DECODE(M.PAY_BANK_CODE,'96',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))  BPDB_AMOUNT_GP,
SUM(DECODE(M.PAY_BANK_CODE,'97',1,M.PAY_BANK_CODE,0)) NO_OF_CONSUMER_ROBI,SUM(DECODE(M.PAY_BANK_CODE,'97',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))  BPDB_AMOUNT_ROBI,
SUM(DECODE(M.PAY_BANK_CODE,'94',1,M.PAY_BANK_CODE,0)) NO_OF_CONSUMER_bKash,SUM(DECODE(M.PAY_BANK_CODE,'94',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))  BPDB_AMOUNT_bKash,
SUM(DECODE(M.PAY_BANK_CODE,'96',1,M.PAY_BANK_CODE,0))+SUM(DECODE(M.PAY_BANK_CODE,'97',1,M.PAY_BANK_CODE,0))+SUM(DECODE(M.PAY_BANK_CODE,'94',1,M.PAY_BANK_CODE,0)) TOTAL_CUSTOMER,
SUM(DECODE(M.PAY_BANK_CODE,'96',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))+SUM(DECODE(M.PAY_BANK_CODE,'97',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0))+SUM(DECODE(M.PAY_BANK_CODE,'94',NVL(D.PDB_AMOUNT,0),M.PAY_BANK_CODE,0)) TOTAL_AMOUNT_BPDB
FROM EPAYMENT.EPAY_PAYMENT_MST_HSTR M,EPAYMENT.EPAY_PAYMENT_DTL_HSTR D,V_Z_C_C_L C
WHERE M.BATCH_NO=D.BATCH_NO
AND M.LOCATION_CODE=C.LOCATION_CODE
AND C.ZONE_CODE=:P_ZONE_CODE
AND C.COMP_CNTR_CODE=:P_COMP_CNTR_CODE
AND TO_CHAR(M.PAY_DATE,'RRRRMM')=:P_START_MONTH
--AND TO_CHAR(M.PAY_DATE,'RRRRMM')<=:P_END_MONTH
AND M.PAY_BANK_CODE IN ('96','97','94')
GROUP BY  C.ZONE_NAME,C.COMP_CNTR_NAME,C.LOCATION_NAME,C.LOCATION_CODE,TO_CHAR(M.PAY_DATE,'RRRRMM')
ORDER BY LOCATION_NAME ASC