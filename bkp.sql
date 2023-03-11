Directory Path	F:\Mahbub

expdp EBPS/EBPS@EBPS full=Y schema=EPAY directory=MY_DIR dumpfile=MYMEN_BKP_%DATE%.dmp logfile=MYMEN_BKP_%DATE%.log

expdp EBPS/EBPS@EBPS schemas=EPAY directory=DBA_BACKUP_ROBI dumpfile=JAMALPUR_BKP.dmp logfile=JAMALPUR_BKP.log;

impdp EBPS/EBPS@orcl directory=DATA_PUMP_DIR dumpfile=DB10G_210419.dmp logfile=expdpDB10G_210419.log

impdp LEAA/LEAA@ORCL schemas=LEAA directory=DATA_PUMP_DIR dumpfile=leaa.dmp logfile=leaa.log;

ALTER USER scott IDENTIFIED BY tiger ACCOUNT UNLOCK;

CREATE OR REPLACE DIRECTORY BACKUP_DIR AS 'F:\Mahbub\Backup_Dump_File\SDAGG';

GRANT READ, WRITE ON DIRECTORY BACKUP_DIR TO PMIS;

grant exp_full_database to PMIS;



----bdlink

-------DIRECTORY----->DATA_PUMP_DIR
-----USER---->PMIS


expdp PMIS/PMIS directory=BACKUP_DIR DUMPFILE=%DATE:~7,2%%DATE:~4,2%%DATE:~-4%_SDA_FULL_BKP.dmp LOGFILE=%DATE:~7,2%%DATE:~4,2%%DATE:~-4%_SDA_FULL_BKP.log  network_link=SDAGG  schemas=SDA,EPAY,EPAYMENT full=no compress=y

--expdp PMIS/PMIS directory=BACKUP_DIR DUMPFILE=SDA_FULL_BKP_`date +%b_%d_%y_%H_%M_%S.`dmp LOGFILE=SDA_FULL_BKP_`date +%b_%d_%y_%H_%M_%S.`log  network_link=SDAGG  schemas=SDA,EPAY,EPAYMENT full=no compress=y

logfile=%DATE:~7,2%%DATE:~4,2%%DATE:~-4%_UBILL_BACKUP.log


exp scott/tiger file= scott_bk_`date +%b_%d_%y_%H_%M_%S.`dmp log= scott_bk_`date +%b_%d_%y_%H_%M_%S.`log statistics=none compress=y



schemas=MMW

expdp dumpfile=test.dmp logfile=test.log directory=EXPDIR full=y version=11.2


expdp hr/hr DIRECTORY=dpump_dir1 NETWORK_LINK=source_database_link DUMPFILE=network_export.dmp

expdp EPAY/EPAYLDAP78666 DIRECTORY=MY_DIR NETWORK_LINK=EPAY_MYMEN DUMPFILE=EPAY_BKP.dmp



expdp sms/sms full=y directory=LOG_FILE_DIR include=EPAY_MYMEN dumpfile=orcl_DBlink.dmp logfile=orcl_DBlink.log

expdp hr/hr DIRECTORY=dpump_dir1 NETWORK_LINK=source_database_link DUMPFILE=network_export.dmp

expdp EPAY/EPAYLDAP78666 DIRECTORY=MY_DIR NETWORK_LINK=EPAY_MYMEN DUMPFILE=EPAY_BKP.dmp

expdp system directory=MY_DIR LOGFILE=EPAY_BKP.log DUMPFILE=EPAY_BKP.dmp network_link=EPAY_MYMEN schemas=EPAY

expdp sms/sms full=y directory=LOG_FILE_DIR include=EPAY_MYMEN dumpfile=orcl_DBlink.dmp logfile=orcl_DBlink.log