
CUST_ID = cid(55869371)

select * from BC_BILL_CYCLE_CODE
where location_code='Q7'
AND AREA_CODE='D5705'
AND BILL_CYCLE_CODE='201812'



SELECT * FROM BC_METER_READING_CARD_HDR
WHERE BILL_CYCLE_CODE='201812'
AND   LOCATION_CODE='Q7' 
AND AREA_CODE ='D5705'

F7409

SELECT *  FROM

UPDATE BC_METER_READING_CARD_DTL
SET DEFECTIVE_CODE=00
WHERE BILL_CYCLE_CODE='201907'
AND CUST_ID IN (SELECT CUST_ID FROM BC_CUSTOMERS WHERE LOCATION_CODE='L1' AND AREA_CODE ='F7409')
AND DEFECTIVE_CODE IS NULL

where cust_id=cid(76990531))


SELECT * FROM BC_CUSTOMER_EVENT_LOG
WHERE BILL_CYCLE_CODE='201902'
AND CUST_ID IN (SELECT CUST_ID FROM BC_CUSTOMERS --WHERE LOCATION_CODE='V5' AND AREA_CODE ='A0322')
where cust_id=cid(76990531))


SELECT * FROM BC_INVOICE_HDR
WHERE BILL_CYCLE_CODE='201812'
AND CUST_ID IN (SELECT CUST_ID FROM BC_CUSTOMERS --WHERE LOCATION_CODE='L1' AND AREA_CODE ='J0103')
where cust_id=cid(76990531))



COMMIT;

SELECT * FROM BC_CUSTOMERS

-------

DELETE FROM BC_METER_READING_CARD_DTL
WHERE BILL_CYCLE_CODE='201902'
AND CUST_ID IN (SELECT CUST_ID FROM BC_CUSTOMERS WHERE LOCATION_CODE='L1' AND AREA_CODE ='C0315')



DELETE FROM BC_CUSTOMER_EVENT_LOG
WHERE BILL_CYCLE_CODE='201902'
AND CUST_ID IN (SELECT CUST_ID FROM BC_CUSTOMERS WHERE LOCATION_CODE='L1' AND AREA_CODE ='C0315')


DELETE FROM BC_METER_READING_CARD_HDR
WHERE BILL_CYCLE_CODE='201812'
AND   LOCATION_CODE='Q7' 
AND AREA_CODE ='D5705'


COMMIT;
