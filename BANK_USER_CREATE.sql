INSERT INTO EPAY_USER_MST
SELECT NULL,BANK_CODE||BRANCH_CODE||'01','123456','67',BANK_CODE,BRANCH_CODE,SYSDATE,'ePayment Ofline',NULL,NULL,'N',LOCATION_CODE,NULL FROM EPAY_BANK_BRANCHES
WHERE  bank_code ='66'


SELECT NULL,BANK_CODE||BRANCH_CODE||'01','123456','67',BANK_CODE,BRANCH_CODE,SYSDATE,'ePayment Ofline',NULL,NULL,'N',LOCATION_CODE,NULL FROM EPAY_BANK_BRANCHES
WHERE  bank_code ='66'