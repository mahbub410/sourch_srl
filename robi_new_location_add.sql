

select * from ep_location_master@epay_robi
where location_code='H8'

select LOCATION_CODE,EFF_DATE, EXP_DATE,STATUS, CREATE_ON, CREATE_BY, UPDATE_ON, UPDATE_BY, LOCATION_NAME, 'NILL', null,LOCATION_NAME  
 from epay_location_master
where location_code='H8'