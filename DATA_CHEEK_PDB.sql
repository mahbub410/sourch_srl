
SELECT 599437-584552 FROM DUAL

SELECT COUNT(*) FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='201802'
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER WHERE CENTER_NAME='CHITTAGONG')


SELECT COUNT(*) FROM UTILITY_BILL_PDB@EPAY_GP
WHERE BILL_MONTH='201802'
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER WHERE CENTER_NAME='CHITTAGONG')


SELECT DATA_TRANS_LOG,COUNT(*) FROM BC_BILL_IMAGE@BILLING_NAO
WHERE BILL_CYCLE_CODE='201711'
GROUP BY DATA_TRANS_LOG