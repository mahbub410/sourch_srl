

execute EMP.Dpd_off_remove(:p_customer_num  , :p_receipt_num)

9113142,2218275

select * from bc_receipt_hdr
where BATCH_NUM='55551768'

receipt_date='10-may-2020'
and cust_id=cid(9113128)

select * from BC_INVOICE_RECEIPT_MAP
where RECEIPT_NUM in (
select RECEIPT_NUM from bc_receipt_hdr
where receipt_date='09-feb-2020'
and cust_id=cid(9113142)
)



select * from BC_INVOICE_DTL
where invoice_num='61733859'