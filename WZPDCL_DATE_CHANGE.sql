
---------50.2-------------

UPDATE EPAY_UTILITY_BILL@EPAY_WZPDCL
SET BILL_DUE_DATE='30-APR-2019',BILLENDDATE_FORPAYMENT='30-APR-2019',CREATED_ON=SYSDATE
WHERE BILL_MONTH='201903'
AND ACCOUNT_NUMBER IN (
SELECT ACCOUNT_NUMBER FROM WZ_501_502
)
---------26-----------

UPDATE EPAY_UTILITY_BILL
SET BILL_DUE_DATE='30-APR-2019',BILLENDDATE_FORPAYMENT='30-APR-2019',CREATED_ON=SYSDATE
WHERE BILL_MONTH='201903'
AND ACCOUNT_NUMBER IN (
SELECT ACCOUNT_NUMBER FROM WZ_501_502
)


----------24--------

UPDATE EPAY_UTILITY_BILL@EPAY_SRL_24
SET BILL_DUE_DATE='30-APR-2019',BILLENDDATE_FORPAYMENT='30-APR-2019',CREATED_ON=SYSDATE
WHERE BILL_MONTH='201903'
AND ACCOUNT_NUMBER IN (
SELECT ACCOUNT_NUMBER FROM WZ_501_502
)


COMMIT;


---------50.2-------------

SELECT * FROM  EPAY_UTILITY_BILL@EPAY_WZPDCL
WHERE BILL_MONTH='201811'
AND LOCATION_CODE='201'
AND BILL_DUE_DATE BETWEEN '18-DEC-2018' AND '19-DEC-2018'

---------26-----------

SELECT * FROM  EPAY_UTILITY_BILL
WHERE BILL_MONTH='201811'
AND LOCATION_CODE='201'
AND BILL_DUE_DATE BETWEEN '18-DEC-2018' AND '19-DEC-2018'


----------24--------

SELECT * FROM  EPAY_UTILITY_BILL@EPAY_SRL_24
WHERE BILL_MONTH='201811'
AND LOCATION_CODE='201'
AND BILL_DUE_DATE BETWEEN '18-DEC-2018' AND '19-DEC-2018'

