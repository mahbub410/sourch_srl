

INSERT INTO EPAY_UTILITY_BILL_GPR_x
SELECT 'BPDB' AS COMPANY_CODE,CUSTOMER_NUM||CONS_CHK_DIGIT AS ACCOUNT_NUMBER, 
INVOICE_NUM||INVOICE_CHK_DGT BILL_NUMBER,INVOICE_DATE GENERATED_DATE, 
'N' BILL_STATUS,INVOICE_DUE_DATE BILL_DUE_DATE, 
  NULL BILLAMT_AFTERDUEDATE,INVOICE_DUE_DATE BILLENDDATE_FORPAYMENT,  SYSDATE CREATED_ON    , 
  'SYSADMIN' CREATED_BY   ,   NULL  MODIFIED_ON ,  NULL MODIFIED_BY, 
  'N' NOTIFICATION_SENT_STATUS,  (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0) 
  +NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+ 
   NVL(DEMAND_CHRG,0)    +NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)+ 
  NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)) CURRENT_PRINCIPLE, 
  CURRENT_VAT CURRENT_GOVT_DUTY,  ARR_ADV_ADJ_PRN  ARREAR_PRINCIPLE,  ARR_ADV_ADJ_VAT ARREAR_GOVT_DUTY, 
  0 LATE_PAYMENT_SURCHARGE,   TOTAL_BILL TOTAL_BILL_AMOUNT, LOCATION_CODE, BILL_CYCLE_CODE BILL_MONTH, 
 TARIFF,  CUST_STATUS CUSTOMER_TYPE, CURRENT_LPS CURRENT_SURCHARGE, 
 ARR_ADV_ADJ_LPS ARREAR_SURCHARGE,  NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0) ADJUSTED_PRINCIPLE, 
 ADJUSTED_VAT ADJUSTED_GOVT_DUTY, 
 0 ADVANCE_AMOUNT,0 
 FROM BC_BILL_IMAGE@BILLING_mymen
 WHERE BILL_CYCLE_CODE=:P_BILL_CYCLE_CODE
AND INVOICE_NUM IS NOT NULL
AND  LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER
                                       WHERE CENTER_NAME LIKE '%MYMENSING%');
                                       
                                       commit;
                                       
INSERT INTO EPAY_CUST_MASTER_DATA_GPR_X
(COMPANY_CODE,ACCOUNT_NO,NAME,LOCATION_CODE,AREAR_CODE,ACTIVATION_DATE,STATUS,CREATED_ON ,DUMPING_FOR, CREATED_BY)
SELECT 'BPDB', CUSTOMER_NUM||CHECK_DIGIT,CUSTOMER_NAME,LOCATION_CODE,AREA_CODE,  TO_DATE(START_BILL_CYCLE,'rrrrmm'),
DECODE (CUSTOMER_STATUS_CODE,'C','A','S','A','I') STATUS,  SYSDATE,    'U','ROBIBPDB' 
FROM BC_CUSTOMERS@BILLING_JAM
WHERE (CUSTOMER_NUM,LOCATION_CODE) IN (SELECT SUBSTR(ACCOUNT_NUMBER,1,7),LOCATION_CODE FROM EPAY_UTILITY_BILL_GPR_X);

commit;

INSERT INTO EPAY_UTILITY_BILL_GPR_x
SELECT 'BPDB' AS COMPANY_CODE,CUSTOMER_NUM||CONS_CHK_DIGIT AS ACCOUNT_NUMBER, 
INVOICE_NUM||INVOICE_CHK_DGT BILL_NUMBER,INVOICE_DATE GENERATED_DATE, 
'N' BILL_STATUS,INVOICE_DUE_DATE BILL_DUE_DATE, 
  NULL BILLAMT_AFTERDUEDATE,INVOICE_DUE_DATE BILLENDDATE_FORPAYMENT,  SYSDATE CREATED_ON    , 
  'SYSADMIN' CREATED_BY   ,   NULL  MODIFIED_ON ,  NULL MODIFIED_BY, 
  'N' NOTIFICATION_SENT_STATUS,  (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0) 
  +NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+ 
   NVL(DEMAND_CHRG,0)    +NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)+ 
  NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)) CURRENT_PRINCIPLE, 
  CURRENT_VAT CURRENT_GOVT_DUTY,  ARR_ADV_ADJ_PRN  ARREAR_PRINCIPLE,  ARR_ADV_ADJ_VAT ARREAR_GOVT_DUTY, 
  0 LATE_PAYMENT_SURCHARGE,   TOTAL_BILL TOTAL_BILL_AMOUNT, LOCATION_CODE, BILL_CYCLE_CODE BILL_MONTH, 
 TARIFF,  CUST_STATUS CUSTOMER_TYPE, CURRENT_LPS CURRENT_SURCHARGE, 
 ARR_ADV_ADJ_LPS ARREAR_SURCHARGE,  NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0) ADJUSTED_PRINCIPLE, 
 ADJUSTED_VAT ADJUSTED_GOVT_DUTY, 
 0 ADVANCE_AMOUNT,0 
 FROM BC_BILL_IMAGE@BILLING_KISHOR
 WHERE BILL_CYCLE_CODE='201608'
AND INVOICE_NUM IS NOT NULL
AND  LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER
                                       WHERE CENTER_NAME LIKE '%KISHOREGANJ%');
                                       
                                       commit;
                                       
INSERT INTO EPAY_CUST_MASTER_DATA_GPR_X
(COMPANY_CODE,ACCOUNT_NO,NAME,LOCATION_CODE,AREAR_CODE,ACTIVATION_DATE,STATUS,CREATED_ON ,DUMPING_FOR, CREATED_BY)
SELECT 'BPDB', CUSTOMER_NUM||CHECK_DIGIT,CUSTOMER_NAME,LOCATION_CODE,AREA_CODE,  TO_DATE(START_BILL_CYCLE,'rrrrmm'),
DECODE (CUSTOMER_STATUS_CODE,'C','A','S','A','I') STATUS,  SYSDATE,    'U','ROBIBPDB' 
FROM BC_CUSTOMERS@BILLING_KISHOR
WHERE (CUSTOMER_NUM,LOCATION_CODE) IN (SELECT SUBSTR(ACCOUNT_NUMBER,1,7),LOCATION_CODE FROM EPAY_UTILITY_BILL_GPR_X);


commit;





INSERT INTO EPAY_UTILITY_BILL_GPR_x
SELECT 'BPDB' AS COMPANY_CODE,CUSTOMER_NUM||CONS_CHK_DIGIT AS ACCOUNT_NUMBER, 
INVOICE_NUM||INVOICE_CHK_DGT BILL_NUMBER,INVOICE_DATE GENERATED_DATE, 
'N' BILL_STATUS,INVOICE_DUE_DATE BILL_DUE_DATE, 
  NULL BILLAMT_AFTERDUEDATE,INVOICE_DUE_DATE BILLENDDATE_FORPAYMENT,  SYSDATE CREATED_ON    , 
  'SYSADMIN' CREATED_BY   ,   NULL  MODIFIED_ON ,  NULL MODIFIED_BY, 
  'N' NOTIFICATION_SENT_STATUS,  (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0) 
  +NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+ 
   NVL(DEMAND_CHRG,0)    +NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)+ 
  NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)) CURRENT_PRINCIPLE, 
  CURRENT_VAT CURRENT_GOVT_DUTY,  ARR_ADV_ADJ_PRN  ARREAR_PRINCIPLE,  ARR_ADV_ADJ_VAT ARREAR_GOVT_DUTY, 
  0 LATE_PAYMENT_SURCHARGE,   TOTAL_BILL TOTAL_BILL_AMOUNT, LOCATION_CODE, BILL_CYCLE_CODE BILL_MONTH, 
 TARIFF,  CUST_STATUS CUSTOMER_TYPE, CURRENT_LPS CURRENT_SURCHARGE, 
 ARR_ADV_ADJ_LPS ARREAR_SURCHARGE,  NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0) ADJUSTED_PRINCIPLE, 
 ADJUSTED_VAT ADJUSTED_GOVT_DUTY, 
 0 ADVANCE_AMOUNT,0 
 FROM BC_BILL_IMAGE@BILLING_TANG
 WHERE BILL_CYCLE_CODE='201608'
AND INVOICE_NUM IS NOT NULL
AND  LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER
                                       WHERE CENTER_NAME LIKE '%TANGAIL%');
                                       
                                       commit;
                                       
INSERT INTO EPAY_CUST_MASTER_DATA_GPR_X
(COMPANY_CODE,ACCOUNT_NO,NAME,LOCATION_CODE,AREAR_CODE,ACTIVATION_DATE,STATUS,CREATED_ON ,DUMPING_FOR, CREATED_BY)
SELECT 'BPDB', CUSTOMER_NUM||CHECK_DIGIT,CUSTOMER_NAME,LOCATION_CODE,AREA_CODE,  TO_DATE(START_BILL_CYCLE,'rrrrmm'),
DECODE (CUSTOMER_STATUS_CODE,'C','A','S','A','I') STATUS,  SYSDATE,    'U','ROBIBPDB' 
FROM BC_CUSTOMERS@BILLING_TANG
WHERE (CUSTOMER_NUM,LOCATION_CODE) IN (SELECT SUBSTR(ACCOUNT_NUMBER,1,7),LOCATION_CODE FROM EPAY_UTILITY_BILL_GPR_X);


commit;


