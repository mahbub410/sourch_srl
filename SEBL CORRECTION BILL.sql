
--P_BILL_TYPE--R-------Date Change

--P_BILL_TYPE--C---Amount Change

EXECUTE EPAY.DPD_EPAY_SEBL_CORT_BILL(:P_BILL_MONTH,:P_ACCOUNT_NUMBER,:P_BILL_NUMBER,:P_PDB_AMT,:P_VAT,:P_BILL_TYPE);
 
  SELECT COUNT(*) --INTO rec_COUNT 
  FROM EPAY_UTILITY_BILL
                WHERE (ACCOUNT_NUMBER=:P_ACCOUNT_NUMBER OR BILL_NUMBER=:P_BILL_NUMBER)
                AND BILL_MONTH=:P_BILL_MONTH;
                
SELECT B.LOCATION_CODE LOC,BILL_MONTH,C.NAME AS CUSTOMER_NAME, ACCOUNT_NUMBER,BILL_NUMBER, BILL_DUE_DATE,
BILL_STATUS,DECODE(BILL_STATUS,'N','Not Payment','P','Paymed') PAYMENT_STATUS,NVL (  NVL (TOTAL_BILL_AMOUNT, 0)- NVL (  NVL (CURRENT_GOVT_DUTY, 0)+ NVL (ARREAR_GOVT_DUTY, 0)+ NVL (ADJUSTED_GOVT_DUTY, 0),0),0) PDB_AMOUNT,
NVL (  NVL (CURRENT_GOVT_DUTY, 0)+ NVL (ARREAR_GOVT_DUTY, 0)+ NVL (ADJUSTED_GOVT_DUTY, 0),0) VAT_AMOUNT,TOTAL_BILL_AMOUNT
FROM EPAY_UTILITY_BILL B,EPAY_CUSTOMER_MASTER_DATA C
WHERE B.ACCOUNT_NUMBER=C.ACCOUNT_NO
AND B.COMPANY_CODE=C.COMPANY_CODE
AND B.LOCATION_CODE=C.LOCATION_CODE
AND (B.ACCOUNT_NUMBER =:P_ACCOUNT_NUMBER OR BILL_NUMBER=:P_BILL_NUMBER)
AND B.BILL_MONTH =:P_BILL_MONTH
AND B.LOCATION_CODE=:P_LOC
--AND BILL_DUE_DATE>=TRUNC(SYSDATE)
AND B.COMPANY_CODE=UPPER('BPDB');


SELECT * FROM EPAY_UTILITY_BILL@EPAY_SRL_DCC
WHERE BILL_MONTH='201607'
AND ACCOUNT_NUMBER='23020886'