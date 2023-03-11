update bc_invoice_hdr
set rec_status='M'
WHERE cust_id =cid(:p_cust_id)
AND BILL_CYCLE_CODE=201902

update bc_invoice_hdr
set rec_status='M'
where cust_id in (select cust_id from bc_customers where LOCATION_CODE='GM')
AND BILL_CYCLE_CODE=201806