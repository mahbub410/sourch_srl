
SELECT *  FROM  BC_AMEND_CONTROL
WHERE cust_id =cid(:P_customer_num)

SELECT *  FROM  BC_AMEND_CONTROL_temp
WHERE cust_id =cid(:P_customer_num)


SELECT *  FROM  BC_CUSTOMERS
--set CUSTOMER_STATUS_CODE='C'
WHERE cust_id =cid(:P_customer_num) 

SELECT *  FROM  bc_customer_meter
--set METER_STATUS='2',PERM_DISCON_DATE is null
WHERE cust_id =cid(:P_customer_num) 

SELECT *  FROM  BC_EQUIP_MAST
--set METER_STATUS='2'
where EQUIP_ID in (select EQUIP_ID from bc_customer_meter  where cust_id=cid(:P_customer_num)
)

SELECT *  FROM  BC_METER_DISCRECON
WHERE cust_id =cid(:P_customer_num) 

SELECT *  FROM  bc_customer_event_log
where CUST_ID =cid(:P_customer_num) 
--and bill_cycle_code=:P_bill_cycle


SELECT *  FROM  bc_customer_event_log
--set BILL_GEN_DATE=CARD_GEN_DATE
where CUST_ID =cid(:P_customer_num) 
and bill_cycle_code=:P_bill_cycle

SELECT *  FROM  BC_meter_reading_card_dtl
WHERE cust_id =cid(:P_customer_num)
--and bill_cycle_code=:P_bill_cycle
ORDER BY BILL_CYCLE_CODE DESC


SELECT *  FROM  bc_invoice_hdr
--set REC_STATUS='M'
WHERE cust_id =cid(:P_customer_num) 
and bill_cycle_code=:P_bill_cycle