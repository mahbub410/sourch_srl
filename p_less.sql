==============================Payment Data Less Then Bill Data===============================

----------------------------------------------------------------------------------------------------------- ROBI----------------------------------------------------------------


UPDATE EPAY_UTILITY_BILL X
SET (CURRENT_PRINCIPLE,CURRENT_GOVT_DUTY,TOTAL_BILL_AMOUNT)=(SELECT PDB_AMOUNT,GOVT_DUTY,PDB_AMOUNT+GOVT_DUTY 
                                                                                                                        FROM PAYMENT_MST@EPAY_ROBI M,PAYMENT_DTL@EPAY_ROBI D
                                                                                                            WHERE M.BATCH_NO=D.BATCH_NO
                                                                                                            AND X.BILL_NUMBER=D.BILL_NUMBER
                                                                                                            AND M.LOCATION_CODE=X.LOCATION_CODE
                                                                                                            AND (D.BILL_NUMBER,M.LOCATION_CODE) IN (
                                                                                                            SELECT DISTINCT BILL_NUMBER,LOCATION_CODE FROM VW_EPAY_RECON_UNSUC_OPT_ERR
                                                                                                            WHERE ERROR_TXT LIKE '%Payment data is less than bill data%'
                                                                                                            AND BANK_CODE=:P_BANK_CODE      ))
WHERE (BILL_NUMBER,LOCATION_CODE) IN (
SELECT DISTINCT BILL_NUMBER,LOCATION_CODE FROM VW_EPAY_RECON_UNSUC_OPT_ERR
WHERE ERROR_TXT LIKE '%Payment data is less than bill data%'
AND BANK_CODE=:P_BANK_CODE  )
AND BILL_MONTH=:P_BILL_MONTH
--AND LOCATION_CODE=:P_LOCATION_CODE


COMMIT;

---------------------------------------------------------------------------------------------------- GP ----------------------------------------------------------------------------------------------



UPDATE EPAY_UTILITY_BILL X
SET (CURRENT_PRINCIPLE,CURRENT_GOVT_DUTY,TOTAL_BILL_AMOUNT)=(SELECT PDB_AMOUNT,GOVT_DUTY,PDB_AMOUNT+GOVT_DUTY 
                                                                                                                        FROM DBERSICE.PAYMENT_MST@EPAY_GP M,DBERSICE.PAYMENT_DTL@EPAY_GP D
                                                                                                            WHERE M.BATCH_NO=D.BATCH_NO
                                                                                                            AND X.BILL_NUMBER=D.BILL_NUMBER
                                                                                                            AND M.LOCATION_CODE=X.LOCATION_CODE
                                                                                                            AND (D.BILL_NUMBER,M.LOCATION_CODE) IN (
                                                                                                            SELECT DISTINCT BILL_NUMBER,LOCATION_CODE FROM VW_EPAY_RECON_UNSUC_OPT_ERR
                                                                                                            WHERE ERROR_TXT LIKE '%Payment data is less than bill data%'
                                                                                                            AND BANK_CODE=:P_BANK_CODE      ))
WHERE (BILL_NUMBER,LOCATION_CODE) IN (
SELECT DISTINCT BILL_NUMBER,LOCATION_CODE FROM VW_EPAY_RECON_UNSUC_OPT_ERR
WHERE ERROR_TXT LIKE '%Payment data is less than bill data%'
AND BANK_CODE=:P_BANK_CODE  )
AND BILL_MONTH=:P_BILL_MONTH
--AND LOCATION_CODE=:P_LOCATION_CODE


COMMIT;


====================================This bill does not exist ====================================

select distinct location_code,ERROR_NO,STATUS,ONLINE_OPT from EPAY_ERR_LOG
WHERE ERROR_TXT LIKE '%This bill no does not exist on BPDB%'




SELECT distinct location_code,center_name,bank_code,online_opt_descr FROM VW_EPAY_RECON_UNSUC_OPT_ERR
WHERE ERROR_TXT LIKE '%This bill no does not exist on BPDB%'

/*
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
USER CREATED_BY   , 
NULL  MODIFIED_ON , 
NULL MODIFIED_BY, 
'N' NOTIFICATION_SENT_STATUS, 
    (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+ 
    NVL(DEMAND_CHRG,0)+NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)+NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+
    NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)) CURRENT_PRINCIPLE, 
NVL(CURRENT_VAT,0) CURRENT_GOVT_DUTY, 
NVL(ARR_ADV_ADJ_PRN,0)  ARREAR_PRINCIPLE, 
NVL(ARR_ADV_ADJ_VAT,0) ARREAR_GOVT_DUTY, 
0 LATE_PAYMENT_SURCHARGE, 
NVL(TOTAL_BILL,0) TOTAL_BILL_AMOUNT, 
LOCATION_CODE, 
BILL_CYCLE_CODE BILL_MONTH, 
TARIFF, CUST_STATUS CUSTOMER_TYPE, 
NVL(CURRENT_LPS,0) CURRENT_SURCHARGE, 
NVL(ARR_ADV_ADJ_LPS,0) ARREAR_SURCHARGE, 
NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0) ADJUSTED_PRINCIPLE, 
NVL(ADJUSTED_VAT,0) ADJUSTED_GOVT_DUTY, 
0  ADVANCE_AMOUNT,0 ADJ_ADV_GOVT_DUTY,'T' DATA_TRANS_LOG
               FROM  BC_BILL_IMAGE@BILLING_TANG
WHERE INVOICE_NUM IS NOT NULL
AND  LOCATION_CODE=upper(:p_loc_code)
and invoice_num in (
SELECT dfn_ab(BILL_NUMBER) FROM VW_EPAY_RECON_UNSUC_OPT_ERR
WHERE ERROR_TXT LIKE '%This bill no does not exist on BPDB%' 
AND  LOCATION_CODE=upper(:p_loc_code)
and bank_code=:p_bank_code)


COMMIT;


====================================INSERT STATEMENT=====================================


INSERT INTO EPAY_CUSTOMER_MASTER_DATA 
(COMPANY_CODE,ACCOUNT_NO,NAME,LOCATION_CODE,AREAR_CODE,ACTIVATION_DATE,STATUS,CREATED_ON ,DUMPING_FOR, CREATED_BY)
SELECT 'BPDB', CUSTOMER_NUM||CHECK_DIGIT,CUSTOMER_NAME,LOCATION_CODE,AREA_CODE,  TO_DATE(START_BILL_CYCLE,'rrrrmm'),
DECODE (CUSTOMER_STATUS_CODE,'C','A','S','A','I') STATUS,  SYSDATE,    'U',USER 
FROM BC_CUSTOMERS@BILLING_syl
WHERE CUSTOMER_NUM=ACCOUNT_NO

*/
======================================This bill does not exist ===================================================

SELECT CENTER_NAME,COUNT(1) FROM VW_EPAY_RECON_UNSUC_OPT_ERR
WHERE ERROR_TYPE='PAYMVALD'
AND ERROR_TXT LIKE '%This bill no does not exist on BPDB%'
--AND CENTER_NAME<>'TANGAIL' 
GROUP BY CENTER_NAME



select * from EPAY_UTILITY_BILL_INT

DELETE EPAY_UTILITY_BILL_INT;

COMMIT;

INSERT INTO EPAY_UTILITY_BILL_INT
SELECT 'BPDB' AS COMPANY_CODE, 
CUSTOMER_NUM||CONS_CHK_DIGIT AS ACCOUNT_NUMBER, 
INVOICE_NUM||INVOICE_CHK_DGT BILL_NUMBER, 
INVOICE_DATE GENERATED_DATE, 
'N' BILL_STATUS, 
 INVOICE_DUE_DATE BILL_DUE_DATE, 
  NULL BILLAMT_AFTERDUEDATE, 
  INVOICE_DUE_DATE BILLENDDATE_FORPAYMENT, 
  SYSDATE CREATED_ON, 
  'SYSADMIN' CREATED_BY, 
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
 0 /*NVL(UNADJUSTED_PRN,0)+NVL(UNADJUSTED_VAT,0)*/ ADVANCE_AMOUNT,0,'T' AS DATA_TRANS_LOG ,'T' AS DATA_TRANS_LOG1,
 'T' AS DATA_TRANS_LOG2,'T' AS DATA_TRANS_LOG3,'T' AS DATA_TRANS_LOG4,'T' AS DATA_TRANS_LOG5
 FROM BC_BILL_IMAGE@BILLING_JAM
 WHERE --BILL_CYCLE_CODE=:P_BILL_MONTH AND 
--TARIFF IN ('A','C','B','D','E','J')
--AND 
INVOICE_NUM IN (
SELECT SUBSTR(BILL_NUMBER,1,8) FROM VW_EPAY_RECON_UNSUC_OPT_ERR
WHERE ERROR_TYPE='PAYMVALD'
AND ERROR_TXT LIKE '%This bill no does not exist on BPDB%'
AND CENTER_NAME='JAMALPUR'
)


COMMIT;

INSERT INTO EPAY_UTILITY_BILL
SELECT * FROM EPAY_UTILITY_BILL_INT

COMMIT;

------------------------------------------------
ERROR THEN BELOW SQL EXEXUTE

DELETE FROM EPAY_UTILITY_BILL
WHERE (ACCOUNT_NUMBER) IN (
SELECT ACCOUNT_NUMBER FROM EPAY_UTILITY_BILL_INT)

COMMIT;


DELETE FROM EPAY_CUSTOMER_MASTER_DATA
WHERE (ACCOUNT_NO) IN (
SELECT ACCOUNT_NUMBER FROM EPAY_UTILITY_BILL_INT)

INSERT INTO EPAY_CUSTOMER_MASTER_DATA
(COMPANY_CODE,ACCOUNT_NO,NAME,LOCATION_CODE,AREAR_CODE,ACTIVATION_DATE,STATUS,CREATED_ON ,DUMPING_FOR, CREATED_BY)
SELECT 'BPDB', CUSTOMER_NUM||CHECK_DIGIT,CUSTOMER_NAME,LOCATION_CODE,AREA_CODE,  TO_DATE(START_BILL_CYCLE,'rrrrmm'),
DECODE (CUSTOMER_STATUS_CODE,'C','A','S','A','I') STATUS,  SYSDATE,    'U','ROBIBPDB' 
FROM BC_CUSTOMERS@BILLING_JAM
WHERE CUSTOMER_NUM IN (SELECT SUBSTR(ACCOUNT_NUMBER,1,7) FROM EPAY_UTILITY_BILL_INT);


COMMIT;
