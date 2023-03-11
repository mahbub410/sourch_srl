
select * from bc_location_master
order by 2

select * from 

update bc_bill_image
set INVOICE_DUE_DATE='08-SEP-2021',INVOICE_DATE='09-AUG-2021'
where bill_cycle_code='202107'
and location_code='X4'
and invoice_num is not null


select * from 

update bc_invoice_hdr
set INVOICE_DUE_DATE='08-SEP-2021',INVOICE_DATE='09-AUG-2021'
where bill_cycle_code='202107'
and cust_id in (select cust_id from bc_customers where location_code='X4'
)


select * from 

update BC_BILL_CYCLE_CODE
set BILL_DUE_DATE='08-SEP-2021',BILL_DATE='09-AUG-2021'
where bill_cycle_code='202107'
and location_code='X4'


select * from  BC_BILL_image
where bill_cycle_code='202107'
and location_code='X4'
and invoice_num is not null