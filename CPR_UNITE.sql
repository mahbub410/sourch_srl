
select bill_cycle_code,sum(net_value)
from bc_meter_reading_card_dtl
where cust_id in (select cust_id from bc_customer_meter where CHECK_PT_METER_ID in (select equip_id from bc_customer_meter where cust_id=cid(50823728)))
group by bill_cycle_code