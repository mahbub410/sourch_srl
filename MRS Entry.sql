

select c.CUSTOMER_NUM,CUSTOMER_NAME, cm.meter_num,tc.TOD_DESC,TCD.DESCR TIM_CYCLE, OPN_KWH_SR_RDNG prev_reading,CLS_KWH_OFPK_RDNG pre_reading ,CLS_KWH_OFPK_RDNG ADV
from MBILL_METER_READING_CARD_DTL cd,MBILL_CUSTOMER_METER cm,MBILL_CUSTOMERS c,MBILL_TOD_CODE tc,MBILL_TIME_CYCLE_CODE tcd
where cd.cust_id=cm.cust_id
and cd.cust_id=c.cust_id
and cd.TOD_CODE=tc.TOD_CODE
and cd.TIME_CYCLE_CODE=tcd.TIME_CYCLE_CODE
--and cd.READING_TYPE_CODE=rtc.READING_TYPE_CODE
and bill_cycle_code='202109'
and c.location_code='H1'
and substr(c.AREA_CODE,4)='08'
and substr(c.AREA_CODE,1,3)='C24'
--and cd.cust_id=28001
and cm.METER_STATUS='2'











------------------OLD---
select * from bc_meter_reading_card_dtl
where bill_cycle_code='202204'
and cust_Id in (
select cust_id from bc_customers where location_code='M2'
and substr(AREA_CODE,4)='15'
and substr(AREA_CODE,1,3)='V09'
)

select c.CUSTOMER_NUM,CUSTOMER_NAME, cm.meter_num,tc.TOD_DESC,tcd.DESCR,READING_DESCR,OPN_READING prev_reading,CLS_READING pre_reading,ADVANCE adv 
from bc_meter_reading_card_dtl cd,bc_customer_meter cm,bc_customers c,BC_TOD_CODE tc,BC_TIME_CYCLE_CODE tcd,BC_READING_TYPE_CODE rtc
where cd.cust_id=cm.cust_id
and cd.cust_id=c.cust_id
and cd.TOD_CODE=tc.TOD_CODE
and cd.TIME_CYCLE_CODE=tcd.TIME_CYCLE_CODE
and cd.READING_TYPE_CODE=rtc.READING_TYPE_CODE
and bill_cycle_code='202204'
and c.location_code='M2'
and substr(c.AREA_CODE,4)='15'
and substr(c.AREA_CODE,1,3)='V09'
and cd.cust_id=28001
and cm.METER_STATUS='2'

and cd.cust_Id in (
select cust_id from bc_customers where location_code='M2'
and substr(AREA_CODE,4)='15'
and substr(AREA_CODE,1,3)='V09'
)and cd.cust_id=28001
and cm.METER_STATUS='2'


select * from bc_customers 
WHERE cust_id=28001

select FNGETPASS(USER_PASSWORD) from emp.emp_user_mst
where user_name='SYSADMIN'

ITBL71