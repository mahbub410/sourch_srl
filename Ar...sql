
DBLINK                    CENTER NAME
------------------------------------------
BILLING_CTG         CHITTAGONG

BILLING_COM         COMILLA

BILLING_RAJ         RAJSHAHI
BILLING_BOG         BOGRA
BILLING_NAO         NAOGAON
BILLING_PAB         PABNA

BILLING_SYL         SYLHET
BILLING_MOU         MOULAVIBAZAR

BILLING_RONG        RANGPUR
BILLING_DIN             DINAJPUR

BILLING_MYMEN           MYMENSING
BILLING_JAM                 JAMALPUR
BILLING_KISHOR              KISORGONG
BILLING_TANG            TANGAIL


INSERT INTO EPAY_UTILITY_BILL_INT
SELECT A.*,'T' DATA_TRNS_LOG FROM EPAY_UTILITY_BILL_GPR A


SELECT * FROM EPAY_UTILITY_BILL_INT A
WHERE ACCOUNT_NUMBER='62223570'



DELETE EPAY_UTILITY_BILL_INT


INSERT INTO EPAY_UTILITY_BILL
SELECT 'BPDB' AS COMPANY_CODE, 
CUSTOMER_NUM||CONS_CHK_DIGIT AS ACCOUNT_NUMBER, 
INVOICE_NUM||INVOICE_CHK_DGT BILL_NUMBER, 
INVOICE_DATE GENERATED_DATE, 
'N' BILL_STATUS, 
 INVOICE_DUE_DATE BILL_DUE_DATE, 
  NULL BILLAMT_AFTERDUEDATE, 
  INVOICE_DUE_DATE BILLENDDATE_FORPAYMENT, 
  SYSDATE CREATED_ON    , 
  'SYSADMIN' CREATED_BY   , 
  NULL  MODIFIED_ON , 
  NULL MODIFIED_BY, 
  'N' NOTIFICATION_SENT_STATUS, 
 (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0) 
  +NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+ 
   NVL(DEMAND_CHRG,0) 
   +NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)+ 
  NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)) CURRENT_PRINCIPLE, 
  CURRENT_VAT CURRENT_GOVT_DUTY, 
  ARR_ADV_ADJ_PRN  ARREAR_PRINCIPLE, 
  ARR_ADV_ADJ_VAT ARREAR_GOVT_DUTY, 
  0 LATE_PAYMENT_SURCHARGE, 
  TOTAL_BILL TOTAL_BILL_AMOUNT, 
 LOCATION_CODE, 
 BILL_CYCLE_CODE BILL_MONTH, 
 TARIFF, 
 CUST_STATUS CUSTOMER_TYPE, 
 CURRENT_LPS CURRENT_SURCHARGE, 
 ARR_ADV_ADJ_LPS ARREAR_SURCHARGE, 
 NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0) ADJUSTED_PRINCIPLE, 
 ADJUSTED_VAT ADJUSTED_GOVT_DUTY, 
 0 /*NVL(UNADJUSTED_PRN,0)+NVL(UNADJUSTED_VAT,0)*/ ADVANCE_AMOUNT,0,DATA_TRANS_LOG 
 FROM EBC.BC_BILL_IMAGE@BILLING_NAO
 WHERE TARIFF IN ('A','C','B','D','E','J')
AND INVOICE_NUM IN (
SELECT SUBSTR(BILL_NUMBER,1,8) FROM VW_ONLINE_PYMT_VALED_ERR
WHERE ( BILL_NUMBER,LOCATION_CODE) IN (
SELECT BILL_NUMBER,LOCATION_CODE FROM VW_ONLINE_PYMT_VALED_ERR
where ERROR_TXT like '%This bill no does not exist%' 
and CENTER_NAME='NAOGAON'
MINUS
SELECT BILL_NUMBER,LOCATION_CODE FROM EPAY_UTILITY_BILL
WHERE LOCATION_CODE IN (
SELECT DISTINCT(LOCATION_CODE) FROM VW_ONLINE_PYMT_VALED_ERR
where ERROR_TXT like '%This bill no does not exist%' 
and CENTER_NAME='NAOGAON')))




AND (NVL(ARR_ADV_ADJ_PRN,0)<> 0 OR NVL(ARR_ADV_ADJ_VAT,0)<>0)
AND (CUSTOMER_NUM,BILL_CYCLE_CODE) IN (
SELECT SUBSTR(ACCOUNT_NUMBER,1,7),BILL_MONTH FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='201507'
AND (NVL(ARREAR_PRINCIPLE,0)<>0 OR NVL(ARREAR_GOVT_DUTY,0)<>0) 
AND BILL_DUE_DATE>=TRUNC(SYSDATE)
AND ACCOUNT_NUMBER IN (
SELECT B.ACCOUNT_NUMBER  FROM EPAY_PAYMENT_MST M,EPAY_PAYMENT_DTL D,EPAY_UTILITY_BILL B,EPAY_RECEIPT_BATCH_HDR_PDB R
WHERE M.BATCH_NO =D.BATCH_NO
AND M.BATCH_NO =R.BATCH_NUM_EPAY
AND M.PAY_DATE=R.RECEIPT_DATE
AND D.BATCH_NO =R.BATCH_NUM_EPAY
AND M.LOCATION_CODE=B.LOCATION_CODE
AND M.LOCATION_CODE=R.LOCATION_CODE
AND B.LOCATION_CODE=R.LOCATION_CODE
AND D.BILL_NUMBER=B.BILL_NUMBER
AND B.BILL_MONTH='201506'
AND M.STATUS IN ('P','T')
AND R.REC_STATUS='C'
AND M.LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER 
WHERE STATUS ='A'
AND CENTER_NAME='COMILLA'
)));

COMMIT;

SELECT 
'INSERT INTO DBERSICE.UTILITY_BILL_PDB@EPAY_GP
SELECT COMPANY_CODE,ACCOUNT_NUMBER,BILL_NUMBER,
GENERATED_DATE,BILL_STATUS,BILL_DUE_DATE,
BILLAMT_AFTERDUEDATE,BILLENDDATE_FORPAYMENT,
SYSDATE AS CREATED_ON,CREATED_BY,MODIFIED_ON,MODIFIED_BY,
NOTIFICATION_SENT_STATUS,CURRENT_PRINCIPLE,
CURRENT_GOVT_DUTY,ARREAR_PRINCIPLE,
ARREAR_GOVT_DUTY,LATE_PAYMENT_SURCHARGE,
TOTAL_BILL_AMOUNT,LOCATION_CODE,BILL_MONTH,
TARIFF,CUSTOMER_TYPE,CURRENT_SURCHARGE,
ARREAR_SURCHARGE,ADJUSTED_PRINCIPLE,ADJUSTED_GOVT_DUTY,
ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='''||P_BILL_MONTH||'''
AND BILL_DUE_DATE>=TRUNC(SYSDATE)
AND LOCATION_CODE='''||LOCATION_CODE||''';'||CHR(10)||CHR(10)||'COMMIT;'||CHR(10)
FROM (
SELECT LOCATION_CODE,'201508' AS P_BILL_MONTH FROM EPAY_LOCATION_master
where CENTER_NAME IN ('RANGPUR','DINAJPUR')) oRder by location_code

SELECT 
'UPDATE DBERSICE.UTILITY_BILL_PDB@EPAY_GP
SET CREATED_ON=SYSDATE
WHERE BILL_MONTH ='''||P_BILL_MONTH||'''
AND LOCATION_CODE='''||LOCATION_CODE||''';'||CHR(10)||CHR(10)||'COMMIT;'||CHR(10)
FROM (
SELECT LOCATION_CODE,'201508' AS P_BILL_MONTH,'201508' AS P_BILL_MONTH1 FROM EPAY_LOCATION_master
where CENTER_NAME IN ('RANGPUR','DINAJPUR')) oRder by location_code


 SELECT LOCATION_CODE,INVOICE_DUE_DATE,BILL_GROUP,REC_STATUS,COUNT(1) NO_OF_CONS FROM EBC.BC_BILL_IMAGE@BILLING_DIN
 WHERE TARIFF IN ('A','C','B','D','E','J')
AND INVOICE_NUM IS NOT NULL
AND (NVL(ARR_ADV_ADJ_PRN,0)<> 0 OR NVL(ARR_ADV_ADJ_VAT,0)<>0)
AND (CUSTOMER_NUM,BILL_CYCLE_CODE) IN (
SELECT SUBSTR(ACCOUNT_NUMBER,1,7),BILL_MONTH FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='201507'
AND (NVL(ARREAR_PRINCIPLE,0)<>0 OR NVL(ARREAR_GOVT_DUTY,0)<>0) 
AND BILL_DUE_DATE>=TRUNC(SYSDATE)
AND ACCOUNT_NUMBER IN (
SELECT B.ACCOUNT_NUMBER  FROM EPAY_PAYMENT_MST M,EPAY_PAYMENT_DTL D,EPAY_UTILITY_BILL B,EPAY_RECEIPT_BATCH_HDR_PDB R
WHERE M.BATCH_NO =D.BATCH_NO
AND M.BATCH_NO =R.BATCH_NUM_EPAY
AND M.PAY_DATE=R.RECEIPT_DATE
AND D.BATCH_NO =R.BATCH_NUM_EPAY
AND M.LOCATION_CODE=B.LOCATION_CODE
AND M.LOCATION_CODE=R.LOCATION_CODE
AND B.LOCATION_CODE=R.LOCATION_CODE
AND D.BILL_NUMBER=B.BILL_NUMBER
AND B.BILL_MONTH='201506'
AND M.STATUS IN ('P','T')
AND R.REC_STATUS='C'
AND M.LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER 
WHERE STATUS ='A'
AND CENTER_NAME='DINAJPUR'
)))
 GROUP BY LOCATION_CODE,INVOICE_DUE_DATE,BILL_GROUP,REC_STATUS
 
 
 

update EPAY_UTILITY_BILL_INT
set ARREAR_PRINCIPLE=0, ARREAR_GOVT_DUTY=0, CURRENT_SURCHARGE=0, ARREAR_SURCHARGE=0


COMMIT;


/*
UPDATE UTILITY_BILL_PDB_DMP_X
SET total_bill_amount=ROUND(NVL(CURRENT_PRINCIPLE,0)+NVL(CURRENT_GOVT_DUTY,0)
+NVL(ARREAR_PRINCIPLE,0)+NVL(ARREAR_GOVT_DUTY,0)+NVL(CURRENT_SURCHARGE,0)
+NVL(ARREAR_SURCHARGE,0)+NVL(ADJUSTED_PRINCIPLE,0)+NVL(ADJUSTED_GOVT_DUTY,0)
-NVL(ADVANCE_AMOUNT,0)+NVL(ADJ_ADV_GOVT_DUTY,0))
*/

UPDATE EPAY_UTILITY_BILL_INT
SET total_bill_amount=ROUND(NVL(CURRENT_PRINCIPLE,0)+NVL(CURRENT_GOVT_DUTY,0)
+NVL(ARREAR_PRINCIPLE,0)+NVL(ARREAR_GOVT_DUTY,0)+NVL(CURRENT_SURCHARGE,0)
+NVL(ARREAR_SURCHARGE,0)+NVL(ADJUSTED_PRINCIPLE,0)+NVL(ADJUSTED_GOVT_DUTY,0)
-NVL(ADVANCE_AMOUNT,0)+NVL(ADJ_ADV_GOVT_DUTY,0)),
adjusted_principle=NVL(adjusted_principle,0)
+ROUND(NVL(CURRENT_PRINCIPLE,0)+NVL(CURRENT_GOVT_DUTY,0)
+NVL(ARREAR_PRINCIPLE,0)+NVL(ARREAR_GOVT_DUTY,0)+NVL(CURRENT_SURCHARGE,0)
+NVL(ARREAR_SURCHARGE,0)+NVL(ADJUSTED_PRINCIPLE,0)+NVL(ADJUSTED_GOVT_DUTY,0)
-NVL(ADVANCE_AMOUNT,0)+NVL(ADJ_ADV_GOVT_DUTY,0))-(NVL(CURRENT_PRINCIPLE,0)
+NVL(CURRENT_GOVT_DUTY,0)+NVL(ARREAR_PRINCIPLE,0)+NVL(ARREAR_GOVT_DUTY,0)
+NVL(CURRENT_SURCHARGE,0)+NVL(ARREAR_SURCHARGE,0)+NVL(ADJUSTED_PRINCIPLE,0)
+NVL(ADJUSTED_GOVT_DUTY,0)-NVL(ADVANCE_AMOUNT,0)+NVL(ADJ_ADV_GOVT_DUTY,0))


COMMIT;



DELETE EPAY_UTILITY_BILL
WHERE (ACCOUNT_NUMBER,BILL_MONTH) IN (SELECT ACCOUNT_NUMBER,BILL_MONTH FROM EPAY_UTILITY_BILL_INT);

DELETE EPAY_UTILITY_BILL_DMP
WHERE (ACCOUNT_NUMBER,BILL_MONTH) IN (SELECT ACCOUNT_NUMBER,BILL_MONTH FROM EPAY_UTILITY_BILL_INT);

DELETE UTILITY_BILL_PDB@EPAY_ROBI
WHERE (ACCOUNT_NUMBER,BILL_MONTH) IN (SELECT ACCOUNT_NUMBER,BILL_MONTH FROM EPAY_UTILITY_BILL_INT);

COMMIT;

INSERT INTO UTILITY_BILL_PDB@EPAY_ROBI
SELECT COMPANY_CODE,ACCOUNT_NUMBER,BILL_NUMBER,
GENERATED_DATE,BILL_STATUS,BILL_DUE_DATE,
BILLAMT_AFTERDUEDATE,BILLENDDATE_FORPAYMENT,
CREATED_ON,CREATED_BY,MODIFIED_ON,MODIFIED_BY,
NOTIFICATION_SENT_STATUS,CURRENT_PRINCIPLE,
CURRENT_GOVT_DUTY,ARREAR_PRINCIPLE,
ARREAR_GOVT_DUTY,LATE_PAYMENT_SURCHARGE,
TOTAL_BILL_AMOUNT,LOCATION_CODE,BILL_MONTH,
TARIFF,CUSTOMER_TYPE,CURRENT_SURCHARGE,
ARREAR_SURCHARGE,ADJUSTED_PRINCIPLE,ADJUSTED_GOVT_DUTY,
ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY
 FROM EPAY_UTILITY_BILL_INT


INSERT INTO EPAY_UTILITY_BILL
SELECT * FROM EPAY_UTILITY_BILL_INT

COMMIT;
