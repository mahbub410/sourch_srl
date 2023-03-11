

19,601

 DELETE FROM EPAY_UTILITY_BILL_GPR

INSERT INTO EPAY_UTILITY_BILL_GPR
select * from utility_bill_pdb@epay_gp
where bill_month='202102'
and location_code='T3'
AND ACCOUNT_NUMBER IN (
SELECT CUSTOMER_NUM FROM DUPLICATE_CONS_MYM
WHERE  TAN_LOCATION_CODE='T3'
AND SUBSTR(TAN_AREA_CODE,4)='08'
)

DELETE EPAY_UTILITY_bILL
WHERE bill_month='202102'
AND ACCOUNT_NUMBER IN (
SELECT ACCOUNT_NUMBER FROM EPAY_UTILITY_BILL_GPR
)


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
ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY,'N' DATA_TRANS_LOG,'T' DATA_TRANS_LOG1,
'N' DATA_TRANS_LOG2,'T' DATA_TRANS_LOG3,'T' DATA_TRANS_LOG4,'N' DATA_TRANS_LOG5
FROM EPAY_UTILITY_BILL_GPR
WHERE bill_month='202102'

COMMIT;