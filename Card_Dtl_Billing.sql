



SELECT * FROM BC_METER_READING_CARD_DTL
WHERE CUST_ID =CID(65945591)
and bill_cycle_code ='202005'


select * from bc_customer_event_log
WHERE CUST_ID =CID(65945591)
and bill_cycle_code ='202005'



SELECT * FROM BC_METER_READING_CARD_DTL
WHERE CUST_ID IN (
SELECT CUST_ID FROM BC_CUSTOMERS where location_code='U7' and AREA_CODE='21715'
)
and bill_cycle_code ='202006'
and  CUST_ID='570076088'

SELECT *
FROM BC_METER_READING_CARD_DTL
WHERE CUST_ID IN (
SELECT CUST_ID FROM BC_CUSTOMERS where location_code='U3' and SUBSTR(AREA_CODE,1,3)='C31'
)
and bill_cycle_code ='202006'


SELECT *
FROM BC_METER_READING_CARD_DTL
WHERE CUST_ID IN (
SELECT CUST_ID FROM BC_CUSTOMERS where location_code='Q5' and SUBSTR(AREA_CODE,4)='22'
)
and bill_cycle_code ='202007'



SELECT *
FROM bc_customer_event_log
WHERE CUST_ID IN (
SELECT CUST_ID FROM BC_CUSTOMERS where location_code='Q5' and SUBSTR(AREA_CODE,4)='22'
)
and bill_cycle_code ='202007'


select
'update BC_METER_READING_CARD_DTL a
set a.OPN_READING='''||x.OPN_READING||''',a.CLS_READING='''||x.CLS_READING||'''
WHERE a.bill_cycle_code=''202007''
and  a.OPN_READING is null
and CLS_READING is null
and a.CUST_ID IN (SELECT CUST_ID FROM BC_CUSTOMERS where location_code=''U7'' and AREA_CODE=''21715'')
and a.CUST_ID='''||x.CUST_ID||''';'||chr(10)||'commit;'||chr(10)
from 
(select CUST_ID,OPN_READING,CLS_READING  from BC_METER_READING_CARD_DTL
                    WHERE bill_cycle_code='202006' 
                    and CUST_ID IN (
                    SELECT CUST_ID FROM BC_METER_READING_CARD_DTL
                    WHERE CUST_ID IN (
                    SELECT CUST_ID FROM BC_CUSTOMERS where location_code='U7' and AREA_CODE='21715'
                    )
                    and bill_cycle_code ='202007'
                    and OPN_READING is null
                    and CLS_READING is null))x