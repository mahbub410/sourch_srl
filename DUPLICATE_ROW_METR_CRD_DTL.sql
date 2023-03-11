


select * from bc_customer_meter
where cust_id=cid('5831885')

select * from bc_customer_category
where cust_id=cid('5831885')

select * from BC_METER_READING_CARD_DTL
where cust_id in (select cust_id from bc_customers where CUST_ID=CID('76967677')) 
--and bill_cycle_code='201806'
ORDER BY bill_cycle_code DESC
 
select * from BC_METER_READING_CARD_DTL
where cust_id ='680244052'
and bill_cycle_code='201803'

SELECT * from bc_customers where CUSTOMER_NUM='5831885'

SELECT * FROM BC_BILL_IMAGE
where CUSTOMER_NUM='5831885'
ORDER BY BILL_CYCLE_CODE DESC

select * from BC_METER_READING_CARD_hdr
where READING_ID='130858'


select * from bc_customer_event_log
where cust_id in (select cust_id from bc_customers where CUSTOMER_NUM='5311159')
and bill_cycle_code='201806'




select * from bc_bill_image
where bill_cycle_code='201804'
and CUSTOMER_NUM='6893590'


select * from bc_customer_meter
where CUSTOMER_NUM='5699549'