
select * from bc_customer_meter
where meter_num like '%44475252%'

select * from bc_customers
where CUSTOMER_NAME like '%Kis%'

select * from bc_meter_reading_card_dtl
where cust_id=cid(9113106)
and bill_cycle_code='202102'


select * from bc_customer_event_log
where cust_id=cid(9113106)
and bill_cycle_code='202102'



delete from bc_meter_reading_card_dtl
where cust_id=cid(9113111)
and bill_cycle_code='202006'


delete from bc_customer_event_log
where cust_id=cid(9113111)
and bill_cycle_code='202006'


commit;