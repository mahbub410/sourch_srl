
--------------------------No Master Data for Bill Data--------------------------------

SELECT ONLINE_OPT,COUNT(1)  AS NO_OF_CONS FROM VW_ONLINE_BILL_VALED_ERR
GROUP BY ONLINE_OPT

SELECT A.ACC_NO,A.LOCATION_CODE,A.ONLINE_OPT FROM (SELECT ACC_NO,LOCATION_CODE,ONLINE_OPT FROM VW_ONLINE_BILL_VALED_ERR
WHERE ONLINE_OPT='ROBI'
GROUP BY ACC_NO,LOCATION_CODE,ONLINE_OPT) A,CUSTOMER_MASTER_DATA_PDB@EPAY_ROBI X
WHERE A.ACC_NO=X.ACCOUNT_NO
AND A.LOCATION_CODE=X.LOCATION_CODE
AND (A.ACC_NO,A.LOCATION_CODE) NOT IN (SELECT ACC_NO,LOCATION_CODE FROM  VW_ONLINE_BILL_VALED_ERR WHERE ONLINE_OPT='ROBI')
UNION
SELECT A.ACC_NO,A.LOCATION_CODE,A.ONLINE_OPT FROM (SELECT ACC_NO,LOCATION_CODE,ONLINE_OPT FROM VW_ONLINE_BILL_VALED_ERR
WHERE ONLINE_OPT='GP'
GROUP BY ACC_NO,LOCATION_CODE,ONLINE_OPT) A,DBERSICE.CUSTOMER_MASTER_DATA_PDB@EPAY_GP X
WHERE A.ACC_NO=X.ACCOUNT_NO
AND A.LOCATION_CODE=X.LOCATION_CODE
AND (A.ACC_NO,A.LOCATION_CODE) NOT IN (SELECT ACC_NO,LOCATION_CODE FROM  VW_ONLINE_BILL_VALED_ERR WHERE ONLINE_OPT='GP')





INSERT INTO CUSTOMER_MASTER_DATA_PDB@EPAY_ROBI
SELECT * FROM EPAY_CUSTOMER_MASTER_DATA
WHERE (ACCOUNT_NO,LOCATION_CODE) IN (
SELECT ACC_NO,LOCATION_CODE FROM VW_ONLINE_BILL_VALED_ERR
WHERE ONLINE_OPT=UPPER(:ONLINE_OPT)
AND (ACC_NO,LOCATION_CODE) NOT IN (
SELECT A.ACC_NO,A.LOCATION_CODE FROM (SELECT ACC_NO,LOCATION_CODE FROM VW_ONLINE_BILL_VALED_ERR
WHERE ONLINE_OPT=UPPER(:ONLINE_OPT)
GROUP BY ACC_NO,LOCATION_CODE) A,CUSTOMER_MASTER_DATA_PDB@EPAY_ROBI X
WHERE A.ACC_NO=X.ACCOUNT_NO
AND A.LOCATION_CODE=X.LOCATION_CODE))


INSERT INTO DBERSICE.CUSTOMER_MASTER_DATA_PDB@EPAY_GP
SELECT * FROM EPAY_CUSTOMER_MASTER_DATA
WHERE (ACCOUNT_NO,LOCATION_CODE) IN (
SELECT ACC_NO,LOCATION_CODE FROM VW_ONLINE_BILL_VALED_ERR
WHERE ONLINE_OPT=UPPER(:ONLINE_OPT)
AND (ACC_NO,LOCATION_CODE) NOT IN (
SELECT A.ACC_NO,A.LOCATION_CODE FROM (SELECT ACC_NO,LOCATION_CODE FROM VW_ONLINE_BILL_VALED_ERR
WHERE ONLINE_OPT=UPPER(:ONLINE_OPT)
GROUP BY ACC_NO,LOCATION_CODE) A,DBERSICE.CUSTOMER_MASTER_DATA_PDB@EPAY_GP X
WHERE A.ACC_NO=X.ACCOUNT_NO
AND A.LOCATION_CODE=X.LOCATION_CODE))