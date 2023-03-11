UPDATE UTILITY_BILL_PDB@EPAY_ROBI
SET COMPANY_CODE='BPDB',
GENERATED_DATE='31-MAR-18',
BILL_STATUS='N',
BILL_DUE_DATE='25-APR-18',
BILLAMT_AFTERDUEDATE=0,
BILLENDDATE_FORPAYMENT='25-APR-18',
MODIFIED_ON='18-APR-18',
MODIFIED_BY='EPAY',
NOTIFICATION_SENT_STATUS='N',
CURRENT_PRINCIPLE=0,
CURRENT_GOVT_DUTY=0,
ARREAR_PRINCIPLE=7881.01,
ARREAR_GOVT_DUTY=385,
LATE_PAYMENT_SURCHARGE=0,
TOTAL_BILL_AMOUNT=9227,
LOCATION_CODE='V3',
TARIFF='LT-E',
CUSTOMER_TYPE='05',
CURRENT_SURCHARGE=0,
ARREAR_SURCHARGE=960.99
ADJUSTED_PRINCIPLE=0,
ADJUSTED_GOVT_DUTY=0 
WHERE ACCOUNT_NUMBER='52368201'
AND BILL_NUMBER='227557469'
AND BILL_MONTH='201803'
                                                                 
                                                                 
                                                                 
                                                                 select * from tab@epay_robi
                                                                 
                                                                 
SELECT * FROM USER_PART_TABLES@epay_robi
 
SELECT * FROM ALL_PART_TABLES@epay_robi
WHERE OWNER='MMONEY_BPDB'
 
SELECT * FROM DBA_PART_TABLES@epay_robi
WHERE OWNER='MMONEY_BPDB'

select partition_name from user_tab_partitions@epay_robi
where table_name = 'UTILITY_BILL_PDB';

ALTER TABLE UTILITY_BILL_PDB@EPAY_ROBI DISABLE ROW MOVEMENT;  

PTN_UTILITY_BILL_PDB

UTILITY_BILL_PDB_H


