
select * from bc_customer_meter
WHERE CUST_ID IN ( CID(52461637))


SELECT *  FROM BC_METER_READING_CARD_DTL
WHERE CUST_ID IN ( CID(52461637)
)
and bill_cycle_code ='202008'


SELECT *  from bc_customer_event_log
WHERE CUST_ID IN ( CID(52461637)
)
and bill_cycle_code ='202008'




SELECT * FROM BC_METER_READING_CARD_DTL
WHERE CUST_ID IN (
SELECT CUST_ID FROM BC_CUSTOMERS where location_code='L3' and SUBSTR(AREA_CODE,4)='15'
)
and bill_cycle_code ='202001'


SELECT *  from bc_customer_event_log
WHERE CUST_ID IN (
SELECT CUST_ID FROM BC_CUSTOMERS where location_code='L3' and SUBSTR(AREA_CODE,4)='15'
)
and bill_cycle_code ='202001'




SELECT *  FROM BC_METER_READING_CARD_DTL
WHERE CUST_ID IN (
SELECT CUST_ID FROM BC_CUSTOMERS where location_code='L1' and AREA_CODE='F4303'
)
and bill_cycle_code ='202001'


SELECT *  from bc_customer_event_log
WHERE CUST_ID IN (
SELECT CUST_ID FROM BC_CUSTOMERS where location_code='L1' and AREA_CODE='FF115'
)
and bill_cycle_code ='201910'





select * from bc_customer_event_log
WHERE CUST_ID IN (
SELECT CUST_ID FROM BC_CUSTOMERS where location_code='L1' and SUBSTR(AREA_CODE,4)='01'
)
and bill_cycle_code ='201908'