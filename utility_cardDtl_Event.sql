select * from bc_customers
where customer_name like '%Nat%'

select * from bc_customer_meter
where cust_id=cid(9113073)
and meter_num like '%50498758%'

select * from bc_customers
where cust_id=cid(9113073)


select * from bc_customer_meter
where meter_num like '%56445331%'

--320

select *  from bc_meter_reading_card_dtl
where cust_id=cid(9113116)
and bill_cycle_code='202201'

select * from bc_customer_event_log
where cust_id=cid(9113116)
and bill_cycle_code='202201'