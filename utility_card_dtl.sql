
select * from bc_customer_meter
where METER_NUM like '%Dh%'

select * from bc_customers
where CUSTOMER_NAME like '%Dh%'

select * from bc_meter_reading_card_dtl
where cust_id=cid(9113041)
and bill_cycle_code='202103'


select * from bc_customer_event_log
where cust_id=cid(9113120)
and bill_cycle_code='202102'



delete from bc_meter_reading_card_dtl
where cust_id=cid(9113041)
and bill_cycle_code='202103'


delete from bc_customer_event_log
where cust_id=cid(9113041)
and bill_cycle_code='202103'


commit;