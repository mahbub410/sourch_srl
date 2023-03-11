
select * from bc_location_master
order by location_code

select BILL_DATE,BILL_DUE_DATE,count(*) from BC_BILL_CYCLE_CODE
where bill_cycle_code='201912'
and location_code='X9'
group by BILL_DATE,BILL_DUE_DATE


select INVOICE_DATE,INVOICE_DUE_DATE,count(*) from bc_bill_image
where bill_cycle_code='201912'
and location_code='X9'
and invoice_num is not null
group by INVOICE_DATE,INVOICE_DUE_DATE


select INVOICE_DATE,INVOICE_DUE_DATE,count(*) from bc_invoice_hdr
where bill_cycle_code='201912'
and cust_id in (select cust_id from bc_customers where location_code='X9')
group by INVOICE_DATE,INVOICE_DUE_DATE


UPDATE bc_invoice_hdr
SET INVOICE_DATE='12-JAN-2020'--,INVOICE_DUE_DATE='10-FEB-2020'
where bill_cycle_code='201912'
and cust_id in (select cust_id from bc_customers where location_code='X9')
AND INVOICE_DATE='09-JAN-2020'
--AND INVOICE_DUE_DATE='12-FEB-2020'


COMMIT;

*/

select REC_STATUS,a.* from bc_invoice_hdr a
where bill_cycle_code='201912'
and cust_id in (select cust_id from bc_customers where location_code='X9')


update bc_invoice_hdr 
set REC_STATUS='F'
where bill_cycle_code='201912'
and cust_id in (select cust_id from bc_customers where location_code='X9')
and REC_STATUS='M'

commit;
