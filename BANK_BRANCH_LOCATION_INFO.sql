
SELECT * FROM EPAY_BANKS
WHERE BANK_CODE='15'

SELECT * FROM  EPAY_BANK_BRANCHES
WHERE BANK_CODE='13'

----------NESCO-----CHARA----

SELECT B.LOCATION_CODE,C.LOCATION_NAME,B.BILLING_BANK_CODE BANK_CODE,B.BILLING_BRANCH_CODE BRANCH_CODE,
B.BANK_CODE NEW_BANK_CODE,B.BRANCH_CODE NEW_BRANCH_CODE FROM EPAY_BANKS A,EPAY_BANK_BRANCHES B,EPAY_LOCATION_MASTER C
WHERE A.BANK_CODE=B.BANK_CODE
AND B.LOCATION_CODE=C.LOCATION_CODE
AND A.BANK_CODE='54'
AND B.LOCATION_CODE NOT IN (SELECT LOCATION_CODE FROM EPAY_LOC_ONLINE_OPT_NESCO)
ORDER BY 1 ASC


SELECT B.LOCATION_CODE,C.LOCATION_NAME,B.BANK_CODE,A.BANK_NAME,B.BRANCH_CODE,B.BRANCH_NAME 
FROM EPAY_BANKS A,EPAY_BANK_BRANCHES B,EPAY_LOCATION_MASTER C
WHERE A.BANK_CODE=B.BANK_CODE
AND B.LOCATION_CODE=C.LOCATION_CODE
AND A.BANK_CODE='54'
AND B.LOCATION_CODE NOT IN (SELECT LOCATION_CODE FROM EPAY_LOC_ONLINE_OPT_NESCO)
ORDER BY 1 ASC



SELECT B.LOCATION_CODE,C.LOCATION_NAME,B.BILLING_BANK_CODE BANK_CODE,B.BILLING_BRANCH_CODE BRANCH_CODE,
B.BANK_CODE NEW_BANK_CODE, B.BRANCH_CODE NEW_BRANCH_CODE,B.BRANCH_NAME FROM EPAY_BANKS A,EPAY_BANK_BRANCHES B,EPAY_LOCATION_MASTER C
WHERE A.BANK_CODE=B.BANK_CODE
AND B.LOCATION_CODE=C.LOCATION_CODE
AND A.BANK_CODE='16'
AND B.LOCATION_CODE NOT IN (SELECT LOCATION_CODE FROM EPAY_LOC_ONLINE_OPT_NESCO)
ORDER BY 1 ASC



