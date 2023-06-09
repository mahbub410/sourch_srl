

 SELECT ''''||BILL_NUMBER||''''||',' FROM EPAY_PAYMENT_DTL
WHERE BATCH_NO ='EON36857'
MINUS
SELECT ''''||BILL_NUMBER||''''||',' FROM EPAY_UTILITY_BILL
WHERE BILL_NUMBER IN (
SELECT BILL_NUMBER FROM EPAY_PAYMENT_DTL
WHERE BATCH_NO ='EON36857'
)
AND LOCATION_CODE='T5'

----------------

DELETE EPAY_UTILITY_BILL_SUP;

COMMIT;

INSERT INTO EPAY_UTILITY_BILL_SUP
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
 0 /*NVL(UNADJUSTED_PRN,0)+NVL(UNADJUSTED_VAT,0)*/ ADVANCE_AMOUNT,0,'N' AS DATA_TRANS_LOG
 FROM BC_BILL_IMAGE@BILLING_MYMEN
 WHERE location_code='M3'
 AND BILL_CYCLE_CODE=:P_BILL_CYCLE_CODE
 and INVOICE_NUM||INVOICE_CHK_DGT in (
'498613195'
)

INSERT INTO EPAY_UTILITY_BILL
SELECT * FROM EPAY_UTILITY_BILL_SUP


------------------------------------------------
ERROR THEN BELOW SQL EXEXUTE

DELETE FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH=:BILL_MONTH
AND  (ACCOUNT_NUMBER) IN (
SELECT ACCOUNT_NUMBER FROM EPAY_UTILITY_BILL_SUP)

COMMIT; 