
INSERT INTO EPAY_UTILITY_BILL
SELECT *  FROM EPAY_UTILITY_BILL@EPAY_SRL
WHERE (BILL_NUMBER,LOCATION_CODE) IN (
SELECT BILL_NUMBER,LOCATION_CODE FROM EPAY_PAYMENT_MST_INT@EPAY_SRL M,EPAY_PAYMENT_DTL_INT@EPAY_SRL D
WHERE M.BATCH_NO=D.BATCH_NO
AND M.BATCH_NO=:P_BATCH_NO
) 
AND (ACCOUNT_NUMBER,BILL_NUMBER) IN (
SELECT ACCOUNT_NUMBER,BILL_NUMBER  FROM EPAY_UTILITY_BILL@EPAY_SRL
WHERE (BILL_NUMBER,LOCATION_CODE) IN (
SELECT BILL_NUMBER,LOCATION_CODE FROM EPAY_PAYMENT_MST_INT@EPAY_SRL M,EPAY_PAYMENT_DTL_INT@EPAY_SRL D
WHERE M.BATCH_NO=D.BATCH_NO
AND M.BATCH_NO=:P_BATCH_NO
) MINUS
SELECT ACCOUNT_NUMBER,BILL_NUMBER FROM EPAY_UTILITY_BILL
WHERE (BILL_NUMBER,LOCATION_CODE ) IN (
SELECT BILL_NUMBER,LOCATION_CODE FROM EPAY_PAYMENT_MST_INT@EPAY_SRL M,EPAY_PAYMENT_DTL_INT@EPAY_SRL D
WHERE M.BATCH_NO=D.BATCH_NO
AND M.BATCH_NO=:P_BATCH_NO
));

COMMIT;