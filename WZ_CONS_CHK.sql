
SELECT * FROM EPAY_UTILITY_BILL
where  BILL_MONTH='201809'
AND ACCOUNT_NUMBER='104110405'



UPDATE EPAY_UTILITY_BILL
SET BILL_DUE_DATE='31-OCT-2018',
BILLENDDATE_FORPAYMENT='31-OCT-2018',
CREATED_ON=SYSDATE
where  BILL_MONTH='201809'
AND ACCOUNT_NUMBER='104110405'


SELECT * FROM BC_INVOICE_HDR@WZ
WHERE SUBSTR(BILL_NUM,1,4)='1809'
AND ACCOUNT_NUM='104110405'





SELECT * FROM EPAY_UTILITY_BILL
where  BILL_MONTH='201809'
AND ACCOUNT_NUMBER='104110405'


UPDATE EPAY_UTILITY_BILL
SET BILL_DUE_DATE='31-OCT-2018',
BILLENDDATE_FORPAYMENT='31-OCT-2018',
CREATED_ON=SYSDATE
where  BILL_MONTH='201809'
AND ACCOUNT_NUMBER='104110405'



UPDATE EPAY_UTILITY_BILL@EPAY_SRL_24
SET BILL_DUE_DATE='31-OCT-2018',
BILLENDDATE_FORPAYMENT='31-OCT-2018',
CREATED_ON=SYSDATE
where  BILL_MONTH='201809'
AND ACCOUNT_NUMBER='104110405'


SELECT * FROM EPAY_UTILITY_BILL@EPAY_SRL_24
where  BILL_MONTH='201809'
AND ACCOUNT_NUMBER='104110405'