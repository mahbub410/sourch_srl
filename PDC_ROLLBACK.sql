DELETE BC_AMEND_CONTROL
WHERE cust_id =cid(:P_customer_num)

update BC_CUSTOMERS
set CUSTOMER_STATUS_CODE='C'
WHERE cust_id =cid(:P_customer_num) 

update bc_customer_meter
set METER_STATUS='2',PERM_DISCON_DATE =  null
WHERE cust_id =cid(:P_customer_num) 

update BC_EQUIP_MAST
set STATUS='2'
where EQUIP_ID in (select EQUIP_ID from bc_customer_meter  where CUST_ID=CID(:P_customer_num))

delete BC_METER_DISCRECON
WHERE cust_id =cid(:P_customer_num) 

/*delete bc_customer_event_log
where CUST_ID =cid(:P_customer_num) 
and bill_cycle_code=:P_bill_cycle


update bc_customer_event_log
set BILL_GEN_DATE=CARD_GEN_DATE
where CUST_ID =cid(:P_customer_num) 
and bill_cycle_code=:P_bill_cycle


delete BC_meter_reading_card_dtl
WHERE cust_id =cid(:P_customer_num)
and bill_cycle_code=:P_bill_cycle
*/

update bc_invoice_hdr
set REC_STATUS='M'
WHERE cust_id =cid(:P_customer_num) 
and bill_cycle_code=:P_bill_cycle