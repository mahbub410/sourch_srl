38992603
38992602

select * from bc_customer_meter
where meter_num like '%16402670%'
--and meter_status='2'

50499895

select CUST_ID,CUSTOMER_NAME, CUSTOMER_NUM, LOCATION_CODE, AREA_CODE, WALKING_SEQUENCE from bc_customers
where CUSTOMER_NAME like '%Dha%'

9113040	GM	G0624	1010






select * from bc_customers
where cust_id=cid(9113040)




select *  from bc_meter_reading_card_dtl
where cust_id=cid(9113040)
and bill_cycle_code='202206'

select * from bc_customer_event_log
where cust_id=cid(9113040)
and bill_cycle_code='202206'


select c.METER_NUM,a.* from bc_meter_reading_card_dtl a,bc_customer_meter c
where a.CUST_ID=c.CUST_ID
and a.bill_cycle_code='202008'
and a.cust_id=cid(9113202)

and a.METER_ID=82103
and c.meter_num like '%37225241%'

select * from bc_customers
where CUSTOMER_NAME like '%Sha%'