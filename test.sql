
R00330		4BF6FE3643D18AFB85B4708B0C13317B


select * from MBILL_METER_READING_CARD_DTL
where bill_cycle_code='202103'
and cust_id in (
select cust_id from MBILL_CUSTOMERS where location_code='H7' and area_code='P2605'
)


SELECT * FROM MBILL_DATA_LOG
where bill_cycle_code='202103'
and cust_id in (
select cust_id from MBILL_CUSTOMERS where location_code='H7' and area_code='A1605'
)
