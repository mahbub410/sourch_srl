
SELECT * FROM ROBI_BATCH_230318

SELECT * 
 FROM EPAY_PAYMENT_MST
WHERE PAY_DATE='23-MAR-2018'
AND PAY_BANK_CODE='97'
AND REF_BATCH_NO IN (
SELECT REF_BATCH_NO FROM ROBI_BATCH_230318)


SELECT *
 FROM EPAY_PAYMENT_DTL
WHERE  REF_BATCH_NO IN (
SELECT REF_BATCH_NO FROM ROBI_BATCH_230318)







AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER WHERE CENTER_NAME='SYLHET')

SELECT * FROM EPAY_RECEIPT_BATCH_HDR_PDB
WHERE BATCH_NUM_EPAY IN (
SELECT BATCH_NO FROM EPAY_PAYMENT_MST
WHERE PAY_DATE='23-MAR-2018'
AND PAY_BANK_CODE='97'
AND REF_BATCH_NO IN (
SELECT REF_BATCH_NO FROM ROBI_BATCH_230318))

SELECT * FROM BC_RECEIPT_BATCH_HDR@BILLING_RAJ
WHERE BATCH_NUM IN (
SELECT BATCH_NUM_PDB FROM EPAY_RECEIPT_BATCH_HDR_PDB
WHERE BATCH_NUM_EPAY IN (
SELECT BATCH_NO FROM EPAY_PAYMENT_MST
WHERE PAY_DATE='23-MAR-2018'
AND PAY_BANK_CODE='97'
AND REF_BATCH_NO IN (
SELECT REF_BATCH_NO FROM ROBI_BATCH_230318)))




SELECT * FROM BC_RECEIPT_HDR@BILLING_RAJ
WHERE BATCH_NUM IN ('9797011070','9797121133','9797021136','9797031121')




RAJ
9797011070
9797121133
9797021136
9797031121


COM

9731012176
9735012389
9734012304

CTG
9797180322

BOG
9797011146

KISH
9797031176

MYMEN
9797101161

NAO
9797011193

SYL
9703020840

JAM
9797011085


PAB
9797011174