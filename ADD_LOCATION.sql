

select * from ep_location_master@epay_robi


where location_code='Y2'

insert into ep_location_master@epay_robi
--(LOCATION_CODE, EFF_DATE, EXP_DATE, STATUS, CREATE_ON, CREATE_BY, LOCATION_NAME, DBLINK, LOCATION_SEQ_NO, LOCATION_DESC)
select LOCATION_CODE,EFF_DATE,EXP_DATE,STATUS,sysdate,'SYSADMIN',null,null,LOCATION_NAME,'NIL',LOCATION_SEQ_NO,CENTER_NAME
from epay_location_master
where location_code='C8'

select * from epay_location_master
where location_code='Y2'