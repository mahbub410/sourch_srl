
SELECT * FROM MBP_PAYMENT_DTL_OVC
WHERE PAY_DATE='25-FEB-2018'
AND ORG_BR_CODE='D2'
AND PC_BR_CODE='039'

UPDATE MBP_PAYMENT_DTL_OVC
SET STATUS='P'
WHERE PAY_DATE='25-FEB-2018'
AND ORG_BR_CODE='D2'
AND PC_BR_CODE='039'
AND STATUS='N'

COMMIT;