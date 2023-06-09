

SELECT * FROM EPAY_LOCATION_MASTER
WHERE LOCATION_CODE=UPPER(:P_LOC_CODE)


SELECT INVOICE_DUE_DATE,COUNT(1) FROM BC_BILL_IMAGE@BILLING_BOG
WHERE LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_CYCLE_CODE=:P_BILL_MONTH
AND BILL_GROUP =:P_BILL_GROUP
GROUP BY INVOICE_DUE_DATE



SELECT DFN_BILL_DUE_DATE_EXTEND(:P_BILL_MONTH,:P_LOCATION_CODE,:P_OLD_BILL_DUE_DATE ,:P_EXTEND_BILL_DUE_DATE ) FROM DUAL