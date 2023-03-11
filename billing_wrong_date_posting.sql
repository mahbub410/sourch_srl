
select * from bc_receipt_batch_hdr
where batch_num='0101102150'

select * from bc_receipt_hdr
where batch_num='0101102150'

select * from bc_invoice_receipt_map
where (invoice_num,RECEIPT_NUM) in (
select invoice_num,RECEIPT_NUM from bc_receipt_hdr
where batch_num='0101102150'
)


update bc_receipt_batch_hdr
set RECEIPT_DATE='10-feb-2020'
where batch_num='0101102150'

update bc_receipt_hdr
set RECEIPT_DATE='10-feb-2020'
where batch_num='0101102150'

update bc_invoice_receipt_map
set RECEIPT_DATE='10-feb-2020'
where (invoice_num,RECEIPT_NUM) in (
select invoice_num,RECEIPT_NUM from bc_receipt_hdr
where batch_num='0101102150'
)

commit;

------------------------------

select * from bc_invoice_hdr
where bill_cycle_code='202002'
and cust_id in (
select cust_id from bc_customers where location_code='M5' and substr(area_code,4)='03')


update bc_invoice_hdr
set REC_STATUS='M'
where bill_cycle_code='202002'
and cust_id in (
select cust_id from bc_customers where location_code='M5' and substr(area_code,4)='03')


commit;