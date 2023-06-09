

SELECT * FROM EPAY_PAYMENT_DTL@EPAY_DCC
WHERE BATCH_NO='454759'
AND TO_NUMBER((SUBSTR(BILL_NUMBER,1,LENGTH(BILL_NUMBER)-1))) IN (
SELECT TO_NUMBER(SUBSTR(BILL_NUMBER,1,LENGTH(BILL_NUMBER)-1)) INVOICE_NUM FROM EPAY_PAYMENT_DTL@EPAY_DCC
WHERE BATCH_NO='454759'
MINUS
SELECT INVOICE_NUM FROM ebc.BC_INVOICE_HDR@BILLING_TANG
WHERE  INVOICE_NUM IN (
SELECT SUBSTR(BILL_NUMBER,1,LENGTH(BILL_NUMBER)-1) FROM EPAY_PAYMENT_DTL@EPAY_DCC
WHERE BATCH_NO='454759'
)
)




SELECT * FROM EPAY_PAYMENT_DTL@EPAY_DCC
WHERE BATCH_NO='455362'
AND TO_NUMBER((SUBSTR(BILL_NUMBER,1,LENGTH(BILL_NUMBER)-1))) IN (
SELECT TO_NUMBER(SUBSTR(BILL_NUMBER,1,LENGTH(BILL_NUMBER)-1)) INVOICE_NUM FROM EPAY_PAYMENT_DTL@EPAY_DCC
WHERE BATCH_NO='455362'
MINUS
SELECT INVOICE_NUM FROM ebc.BC_INVOICE_HDR@BILLING_TANG
WHERE  INVOICE_NUM IN (
SELECT SUBSTR(BILL_NUMBER,1,LENGTH(BILL_NUMBER)-1) FROM EPAY_PAYMENT_DTL@EPAY_DCC
WHERE BATCH_NO='455362'
)
)