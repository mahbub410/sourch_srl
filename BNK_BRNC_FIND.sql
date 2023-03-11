

SELECT * FROM EPAY_LOCATION_MASTER
WHERE CENTER_NAME='COMILLA'

SELECT B.BANK_NAME,BR.BANK_CODE,BR.BRANCH_NAME,BR.BRANCH_CODE,BR.LOCATION_CODE,L.LOCATION_NAME FROM EPAY_BANKS B,EPAY_BANK_BRANCHES BR,EPAY_LOCATION_MASTER L
WHERE B.BANK_CODE=BR.BANK_CODE
AND BR.LOCATION_CODE=L.LOCATION_CODE
AND BR.LOCATION_CODE IN ('C3','D6','D7')
AND BR.BANK_CODE NOT IN ('97','96')
ORDER BY 1




SELECT USER_NAME,BANK_NAME,BRANCH_NAME,LOC_CODE,LOCATION_NAME FROM VW_1EPAY_OFLINE_BANK_USER_LIST
WHERE LOC_CODE IN ('C3','D6','D7')
GROUP BY USER_NAME,BANK_NAME,BRANCH_NAME,LOC_CODE,LOCATION_NAME