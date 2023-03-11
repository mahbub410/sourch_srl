--Set Oracle User password never expired

--Sometime the Oracle User account password need to set to never expire

--1. First, to check the user belong to which profile,normal the user belong to ‘default’ group:


SELECT username,PROFILE FROM dba_users;

--2 Check the password policy for the profile( for example ‘default’):

SELECT * FROM dba_profiles s WHERE s.profile='DEFAULT' AND resource_name='PASSWORD_LIFE_TIME';

--3. Change the password expire period from 180 days to unlimited:

ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

--4. After the password expire period change, reset the password again if user alerted by ORA-28002 warning message:


$sqlplus / as sysdba
alter user wapgw identified by passowrd;

--If you create a user using a profile like this:


CREATE PROFILE my_profile LIMIT PASSWORD_LIFE_TIME30; 
SQL> ALTERUSER scott PROFILE my_profile;

--Then you can change the password lifetime like this:


ALTER PROFILE my_profile LIMIT PASSWORD_LIFE_TIME UNLIMITED;




select username, account_status, EXPIRY_DATE from dba_users where username='EPAY';

SELECT * FROM DBA_USERS
