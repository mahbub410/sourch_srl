
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
ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY,'T' DATA_TRANS_LOG FROM EPAY_UTILITY_BILL_GPR_X
WHERE (ACCOUNT_NUMBER,BILL_NUMBER,BILL_MONTH,LOCATION_CODE) IN (
SELECT ACCOUNT_NUMBER,BILL_NUMBER,BILL_MONTH,LOCATION_CODE FROM EPAY_UTILITY_BILL_GPR_X
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER)
and account_number in (
SELECT ACCOUNT_NO FROM EPAY_CUSTOMER_MASTER_DATA 
WHERE LOCATION_CODE IN (
SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER WHERE CENTER_NAME='COMILLA'))
MINUS
SELECT ACCOUNT_NUMBER,BILL_NUMBER,BILL_MONTH,LOCATION_CODE FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER));




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
ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY,'T' DATA_TRANS_LOG FROM EPAY_UTILITY_BILL_GPR_X
WHERE (ACCOUNT_NUMBER,BILL_MONTH) IN (
SELECT ACCOUNT_NUMBER,BILL_MONTH FROM EPAY_UTILITY_BILL_GPR_X
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER)
and account_number in (
SELECT ACCOUNT_NO FROM EPAY_CUSTOMER_MASTER_DATA 
WHERE LOCATION_CODE IN (
SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER WHERE CENTER_NAME='COMILLA'))
MINUS
SELECT ACCOUNT_NUMBER,BILL_MONTH FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER));