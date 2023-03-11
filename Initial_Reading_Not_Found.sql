

select * from BC_CUSTOMER_CATEGORY
where cust_id=cid(51649298)

select * from  BC_meter_reading_card_dtl
WHERE cust_id  =cid(51649298)
order by bill_cycle_code desc

select * from bc_customer_event_log
where CUST_ID in (select cust_id from bc_customers where
cust_id  =cid(51649298))