
select 'execute EMP.dpd_auto_reading_entry('''||location_code||''','''||bg||''',''202003'');'||chr(10)
from(
select distinct location_code,substr(area_code,4,2) bg from bc_customers
where substr(area_code,4,2)=:bg)


select 'execute EMP.dpd_auto_reading_entry('''||location_code||''','''||bg||''',''202003'');'||chr(10)
from(
select distinct location_code,substr(area_code,4,2) bg from bc_customers
where substr(area_code,4,2) in (
select substr(area_code,4,2) from bc_customers
where substr(area_code,4,2)>'05'
group by substr(area_code,4,2)
))

select A.BILL_CYCLE_CODE,B.LOCATION_CODE,SUBSTR(B.AREA_CODE,4) bill_group,COUNT(MRS_ENTRY_DATE) MRS
from bc_customer_event_log A,bc_customers B
where A.CUST_ID=B.CUST_ID
AND A.bill_cycle_code='202003'
--AND SUBSTR(B.AREA_CODE,4)='22'
GROUP BY A.BILL_CYCLE_CODE,B.LOCATION_CODE,SUBSTR(B.AREA_CODE,4)




select A.BILL_CYCLE_CODE,B.LOCATION_CODE,COUNT(MRS_ENTRY_DATE) MRS
from bc_customer_event_log A,bc_customers B
where A.CUST_ID=B.CUST_ID
AND A.bill_cycle_code='202003'
AND SUBSTR(B.AREA_CODE,4)='02'
GROUP BY A.BILL_CYCLE_CODE,B.LOCATION_CODE


select * from bc_customer_event_log
where bill_cycle_code='202003'
and cust_id in (
select cust_id from bc_customers where location_code='L1' AND SUBSTR(AREA_CODE,4)='02')





