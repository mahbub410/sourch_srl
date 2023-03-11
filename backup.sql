
CONN / AS SYSDBA
ALTER USER scott IDENTIFIED BY tiger ACCOUNT UNLOCK;

CREATE OR REPLACE DIRECTORY test_dir AS '/u01/app/oracle/oradata/';
GRANT READ, WRITE ON DIRECTORY test_dir TO scott;

-----------------------table

expdp scott/tiger@db10g tables=EMP,DEPT directory=TEST_DIR dumpfile=EMP_DEPT.dmp logfile=expdpEMP_DEPT.log

impdp LEAA/LEAA@ORCL tables=EMP,DEPT directory=TEST_DIR dumpfile=EMP_DEPT.dmp logfile=impdpEMP_DEPT.log


---------------schema
expdp scott/tiger@db10g schemas=SCOTT directory=TEST_DIR dumpfile=SCOTT.dmp logfile=expdpSCOTT.log full=y

impdp scott/tiger@db10g schemas=SCOTT directory=TEST_DIR dumpfile=SCOTT.dmp logfile=impdpSCOTT.log

expdp LEAA/LEAA@ORCL schemas=LEAA directory=DATA_FILE_DIR dumpfile=LEAA.dmp logfile=LEAA.log 

impdp LEAA/LEAA@ORCL schemas=LEAA directory=DATA_PUMP_DIR dumpfile=leaa.dmp;

----bdlink

expdp hr/hr DIRECTORY=dpump_dir1 NETWORK_LINK=source_database_link DUMPFILE=network_export.dmp

expdp EPAY/EPAYLDAP78666 DIRECTORY=MY_DIR NETWORK_LINK=EPAY_MYMEN DUMPFILE=EPAY_BKP.dmp

expdp system directory=MY_DIR LOGFILE=EPAY_BKP.log DUMPFILE=EPAY_BKP.dmp network_link=EPAY_MYMEN schemas=EPAY

expdp sms/sms full=y directory=LOG_FILE_DIR include=EPAY_MYMEN dumpfile=orcl_DBlink.dmp logfile=orcl_DBlink.log