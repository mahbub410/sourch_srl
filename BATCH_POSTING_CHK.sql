

SELECT * FROM EPAY_PAYMENT_MST
WHERE PAY_DATE BETWEEN '01-MAR-2019' AND '18-MAR-2019'
AND PAY_BANK_CODE='97'
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER WHERE CENTER_NAME='MOULAVIBAZAR')



SELECT * FROM EPAY_RECEIPT_BATCH_HDR_PDB
WHERE BATCH_NUM_EPAY IN (
SELECT BATCH_NO FROM EPAY_PAYMENT_MST
WHERE PAY_DATE BETWEEN '01-MAR-2019' AND '18-MAR-2019'
AND PAY_BANK_CODE='97'
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER WHERE CENTER_NAME='MOULAVIBAZAR')
)


SELECT * FROM BC_RECEIPT_HDR@BILLING_MOU
WHERE BATCH_NUM IN (
SELECT BATCH_NUM_PDB FROM EPAY_RECEIPT_BATCH_HDR_PDB
WHERE BATCH_NUM_EPAY IN (
SELECT BATCH_NO FROM EPAY_PAYMENT_MST
WHERE PAY_DATE BETWEEN '01-MAR-2019' AND '18-MAR-2019'
AND PAY_BANK_CODE='97'
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER WHERE CENTER_NAME='MOULAVIBAZAR')
))


SELECT * FROM BC_RECEIPT_BATCH_HDR@BILLING_MOU
WHERE RECEIPT_DATE BETWEEN '01-MAR-2019' AND '18-MAR-2019'
AND BANK_CODE='97'


SELECT * FROM BC_RECEIPT_HDR@BILLING_MOU
WHERE RECEIPT_DATE BETWEEN '01-MAR-2019' AND '18-MAR-2019'
AND BANK_CODE='97'