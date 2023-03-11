

 /* SELECT ''''||location_code||''''||','--,BILL_MONTH
 from v_utility_bill_pdb a
where CURRENT_SURCHARGE>0
and (account_number,to_char(add_months(to_date(bill_month,'RRRRMM'),-1),'RRRRMM')) in (select account_number,bill_month from v_utility_bill_pdb
where (location_code,bill_number) in (select location_code,bill_number from v_payment_mst a, v_payment_dtl b where a.batch_no=b.batch_no ) 
)
GROUP BY location_code

SELECT * FROM EPAY_UTILITY_BILL
where location_code in  ('Q6','T1','U7')
and bill_month in ('201503','201505','201508')
and bill_number in (
'181201045',
'181201092',
'181201129',
'181194311',
'181206588',

'536516910')
UNION

INSERT INTO EPAY_UTILITY_BILL_GPR
SELECT * FROM UTILITY_BILL_PDB@epay_robi
where location_code in ('Q6','T1','U7')
and bill_month in ('201503','201505','201508')
and bill_number in ('181201045',
'181201092',
'181201129',
'181194311',
'181206588',
'181206745',

)*/

DELETE FROM EPAY_UTILITY_BILL_GPR_X;

COMMIT;

INSERT INTO EPAY_UTILITY_BILL_GPR_X
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
 0 /*NVL(UNADJUSTED_PRN,0)+NVL(UNADJUSTED_VAT,0)*/ ADVANCE_AMOUNT,0 
 FROM BC_BILL_IMAGE@BILLING_MYMEN
 WHERE BILL_CYCLE_CODE=:P_BILL_MONTH
--AND TARIFF IN ('A','C','B','D','E','J')
and customer_num ='7872777'
--AND DATA_TRANS_LOG='N'
AND TO_CHAR(INVOICE_DUE_DATE,'yyyymmdd')>=(SELECT  TO_CHAR(SYSDATE,'yyyymmdd') FROM DUAL)
AND INVOICE_NUM IS NOT NULL
AND  LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER
                                       WHERE CENTER_NAME LIKE '%MYMENSING%');


COMMIT;

update EPAY_UTILITY_BILL_GPR_X
set ARREAR_PRINCIPLE=0, ARREAR_GOVT_DUTY=0, CURRENT_SURCHARGE=0, ARREAR_SURCHARGE=0


COMMIT;


/*
UPDATE UTILITY_BILL_PDB_DMP_X
SET total_bill_amount=ROUND(NVL(CURRENT_PRINCIPLE,0)+NVL(CURRENT_GOVT_DUTY,0)
+NVL(ARREAR_PRINCIPLE,0)+NVL(ARREAR_GOVT_DUTY,0)+NVL(CURRENT_SURCHARGE,0)
+NVL(ARREAR_SURCHARGE,0)+NVL(ADJUSTED_PRINCIPLE,0)+NVL(ADJUSTED_GOVT_DUTY,0)
-NVL(ADVANCE_AMOUNT,0)+NVL(ADJ_ADV_GOVT_DUTY,0))
*/

UPDATE EPAY_UTILITY_BILL_GPR_X
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



DELETE UTILITY_BILL_PDB@EPAY_ROBI
WHERE (ACCOUNT_NUMBER,BILL_MONTH) IN (SELECT ACCOUNT_NUMBER,BILL_MONTH FROM EPAY_UTILITY_BILL_GPR_X);


COMMIT;

DELETE EPAY_UTILITY_BILL
WHERE (ACCOUNT_NUMBER,BILL_MONTH) IN (SELECT ACCOUNT_NUMBER,BILL_MONTH FROM EPAY_UTILITY_BILL_GPR_X);

DELETE DBERSICE.UTILITY_BILL_PDB@EPAY_GP
WHERE (ACCOUNT_NUMBER,BILL_MONTH) IN (SELECT ACCOUNT_NUMBER,BILL_MONTH FROM EPAY_UTILITY_BILL_GPR_X);


COMMIT;


INSERT INTO UTILITY_BILL_PDB@EPAY_ROBI
SELECT * FROM EPAY_UTILITY_BILL_GPR_X


COMMIT;

INSERT INTO DBERSICE.UTILITY_BILL_PDB@EPAY_GP
SELECT * FROM EPAY_UTILITY_BILL_GPR_X


INSERT INTO EPAY_UTILITY_BILL
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
ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY,'T' DATA_TRNS_LOG
 FROM EPAY_UTILITY_BILL_GPR_X


COMMIT;