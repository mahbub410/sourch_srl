
CREATE DATABASE LINK BILLING_MYMEN
 CONNECT TO EBC
 IDENTIFIED BY <PWD>
 USING '192.168.15.2:1521/MYMEN';
 
SELECT 
'CREATE DATABASE LINK '||DBLINK_NAME||' CONNECT TO '||DBUSER_NAME||' IDENTIFIED BY '||'"'||FNGETPASS(DBUSER_PASS)||'"'||' USING '||''''||IP_ADDR||':1521/'||DB_NAME ||''''||';'||CHR(10) 
FROM MAIL_DBLINK_MST
WHERE SERVER_NAME = 'ePayment Local'


SELECT 
'CREATE DATABASE LINK '||DBLINK_NAME||' CONNECT TO '||DBUSER_NAME||' IDENTIFIED BY '||'"'||FNGETPASS(DBUSER_PASS)||'"'||' USING '||''''||IP_ADDR||':1521/'||DB_NAME ||''''||';'||CHR(10) 
FROM MAIL_DBLINK_MST
WHERE SERVER_NAME = 'Billing'

SELECT 
'CREATE DATABASE LINK '||DBLINK_NAME||' CONNECT TO '||DBUSER_NAME||' IDENTIFIED BY '||'"'||FNGETPASS(DBUSER_PASS)||'"'||' USING '||''''||IP_ADDR||':1521/'||DB_NAME ||''''||';'||CHR(10) 
FROM MAIL_DBLINK_MST
WHERE SERVER_NAME 
 NOT IN ('ePayment Local','Billing')
