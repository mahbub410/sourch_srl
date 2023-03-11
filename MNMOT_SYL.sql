
update bc_invoice_hdr 
set REC_STATUS='M' 
where bill_cycle_code=:bill_cycle 
and CUST_ID in 
( 
select CUST_ID from BC_CUSTOMERS 
where location_code=:location 
and substr(area_code,4,2)=:bill_group 
) 
 and REC_STATUS='F'
