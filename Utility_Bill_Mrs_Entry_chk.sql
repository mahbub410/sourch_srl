
-----mrs entry check----

select a.cur_divtion,a.cur_tot,b.pre_tot,nvl(a.cur_tot,0)-nvl(b.pre_tot,0) diff from (
select eh.BILL_CYCLE_CODE cur_bill_month,dm.DIV_CODE_DESC cur_divtion,count(mg.GRID_NAME) cur_tot
from ubill.BC_UTILITY_BILL_ENTRY_DTL ed,ubill.BC_UTILITY_BILL_ENTRY_hdr eh,ubill.BC_METER_GRID_CK_COMB_BILL_MST mg,ubill.BC_DIV_CODE_MST dm--,BC_CUSTOMERS C
where ed.ENTRY_ID=eh.ENTRY_ID
and eh.GRID_ID = mg.GRID_ID
and mg.DIV_CODE = dm.DIV_CODE
and eh.BILL_CYCLE_CODE='202206'
--and mg.DIV_CODE='311D99'
and ed.CLS_KWH_SR_RDNG is not null
--AND dm.LOCATION_CODE=C.LOCATION_CODE
group by eh.BILL_CYCLE_CODE,dm.DIV_CODE_DESC)a,(
--order by dm.DIV_CODE_DESC
select eh.BILL_CYCLE_CODE pre_bill_month,dm.DIV_CODE_DESC pre_divtion,count(mg.GRID_NAME) pre_tot
from ubill.BC_UTILITY_BILL_ENTRY_DTL ed,ubill.BC_UTILITY_BILL_ENTRY_hdr eh,ubill.BC_METER_GRID_CK_COMB_BILL_MST mg,ubill.BC_DIV_CODE_MST dm--,BC_CUSTOMERS C
where ed.ENTRY_ID=eh.ENTRY_ID
and eh.GRID_ID = mg.GRID_ID
and mg.DIV_CODE = dm.DIV_CODE
and eh.BILL_CYCLE_CODE='202205'  
--and mg.DIV_CODE='311D99'
and ed.CLS_KWH_SR_RDNG is not null
--AND dm.LOCATION_CODE=C.LOCATION_CODE
group by eh.BILL_CYCLE_CODE,dm.DIV_CODE_DESC
order by dm.DIV_CODE_DESC)b
where a.cur_divtion = b.pre_divtion


----last-mnth--1097

select count(*)from ubill.BC_UTILITY_BILL_ENTRY_DTL
where bill_cycle_code='202103'


----Meter not entry grid wise chk----

select dm.DIV_CODE_DESC cur_divtion,mg.GRID_NAME, count(mg.GRID_NAME) cur_tot
from ubill.BC_UTILITY_BILL_ENTRY_DTL ed,ubill.BC_UTILITY_BILL_ENTRY_hdr eh,
ubill.BC_METER_GRID_CK_COMB_BILL_MST mg,ubill.BC_DIV_CODE_MST dm
where ed.ENTRY_ID=eh.ENTRY_ID
and eh.GRID_ID = mg.GRID_ID
and mg.DIV_CODE = dm.DIV_CODE
and eh.BILL_CYCLE_CODE='202110'
and mg.DIV_CODE='311199'
and ed.CLS_KWH_SR_RDNG is  null
--AND dm.LOCATION_CODE=C.LOCATION_CODE
group by dm.DIV_CODE_DESC,mg.GRID_NAME

------------- 



select c.CUSTOMER_NAME,cv.CARD_GEN_DATE,cv.MRS_ENTRY_DATE,cv.OVERALL_PROC_DATE,cv.OVERALL_FINAL_DATE,cv.BILL_GEN_DATE,cv.BILL_FINAL_DATE,cv.BILL_DESPATCH_DATE 
from bc_customer_event_log cv,bc_customers c
where cv.CUST_ID = c.CUST_ID 
and cv.bill_cycle_code='202102'
--and cv.MRS_ENTRY_DATE is not null
order by 3 desc




select eh.BILL_CYCLE_CODE,dm.DIV_CODE_DESC,count(mg.GRID_NAME) tot
from ubill.BC_UTILITY_BILL_ENTRY_DTL ed,ubill.BC_UTILITY_BILL_ENTRY_hdr eh,ubill.BC_METER_GRID_CK_COMB_BILL_MST mg,ubill.BC_DIV_CODE_MST dm--,BC_CUSTOMERS C
where ed.ENTRY_ID=eh.ENTRY_ID
and eh.GRID_ID = mg.GRID_ID
and mg.DIV_CODE = dm.DIV_CODE
and eh.BILL_CYCLE_CODE='202009'  
--and mg.DIV_CODE='311D99'
and ed.CLS_KWH_SR_RDNG is not null
--AND dm.LOCATION_CODE=C.LOCATION_CODE
group by eh.BILL_CYCLE_CODE,dm.DIV_CODE_DESC
order by dm.DIV_CODE_DESC


------last month----

select eh.BILL_CYCLE_CODE,dm.DIV_CODE_DESC,count(mg.GRID_NAME) tot
from ubill.BC_UTILITY_BILL_ENTRY_DTL ed,ubill.BC_UTILITY_BILL_ENTRY_hdr eh,ubill.BC_METER_GRID_CK_COMB_BILL_MST mg,ubill.BC_DIV_CODE_MST dm--,BC_CUSTOMERS C
where ed.ENTRY_ID=eh.ENTRY_ID
and eh.GRID_ID = mg.GRID_ID
and mg.DIV_CODE = dm.DIV_CODE
and eh.BILL_CYCLE_CODE='202008'  
--and mg.DIV_CODE='311D99'
and ed.CLS_KWH_SR_RDNG is not null
--AND dm.LOCATION_CODE=C.LOCATION_CODE
group by eh.BILL_CYCLE_CODE,dm.DIV_CODE_DESC
order by dm.DIV_CODE_DESC







select dm.DIV_CODE_DESC,mg.GRID_NAME,dm.LOCATION_CODE,ed.METER_NUM,ed.OPN_KWH_RDNG,ed.CLS_KWH_SR_RDNG,ed.CONS_KWH_SR,ed.LINE_LOSS,ed.TOTAL_ENERGY_KWH 
from ubill.BC_UTILITY_BILL_ENTRY_DTL ed,ubill.BC_UTILITY_BILL_ENTRY_hdr eh,ubill.BC_METER_GRID_CK_COMB_BILL_MST mg,ubill.BC_DIV_CODE_MST dm--,BC_CUSTOMERS C
where ed.ENTRY_ID=eh.ENTRY_ID
and eh.GRID_ID = mg.GRID_ID
and mg.DIV_CODE = dm.DIV_CODE
and eh.BILL_CYCLE_CODE='201912'  
--and mg.DIV_CODE='311D99'
and ed.CLS_KWH_SR_RDNG is not null
--AND dm.LOCATION_CODE=C.LOCATION_CODE
order by dm.DIV_CODE_DESC



select * from bc_customer_event_log
where bill_cycle_code='202001'

select count(*) from ubill.BC_UTILITY_BILL_ENTRY_DTL
where bill_cycle_code='202001'



select div_code,div_code_desc from ubill.BC_DIV_CODE_MST 
order by DIV_CODE_DESC


select * from ubill.BC_UTILITY_BILL_ENTRY_DTL ed,ubill.BC_UTILITY_BILL_ENTRY_hdr eh,ubill.BC_METER_GRID_CK_COMB_BILL_MST mg,ubill.BC_DIV_CODE_MST dm
where ed.ENTRY_ID=eh.ENTRY_ID
and eh.GRID_ID = mg.GRID_ID
and mg.DIV_CODE = dm.DIV_CODE
and eh.BILL_CYCLE_CODE='201912'  
--and mg.DIV_CODE='311000'
and ed.CLS_KWH_SR_RDNG is not null




 





