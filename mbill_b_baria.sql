	

select 20+19 from dual

select bill_cycle_code,location_code,area_code,WALKING_SEQUENCE,PREV_READING_DATE,CURR_READING_DATE,OPN_KWH_SR_RDNG,
CLS_KWH_SR_RDNG,CONS_KWH_SR,(nvl(CLS_KWH_SR_RDNG,0)-nvl(OPN_KWH_SR_RDNG,0)) cons,decode(mrs_status,'M','Mbill','N','Not Mbill','','Not Mbill') mrs_status
from bc_bill_image
where cust_id=cid(37098446)
--and mrs_status ='M'
order by bill_cycle_code desc