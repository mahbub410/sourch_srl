

select * from bc_customers
--where location_code='X5'
order by customer_num

select * from bc_invoice_hdr
where bill_cycle_code='201912'
and rec_status='D'

and cust_id=cid(9113089)


select CONS_KWH_SR,ENG_CHRG_SR,TOTAL_BILL,a.* from bc_bill_image a
where bill_cycle_code='201912'
and cust_id=cid(9113051)
and invoice_num is not null




select sum(BILLED_VALUE) from bc_meter_reading_card_dtl
where bill_cycle_code='201912'
and cust_id=cid(9113051)
and READING_TYPE_CODE=2



----------------------



select PRINCIPAL_AMT hdr_prin_amt,TOTAL_BILL_AMOUNT hdr_tot_amt from bc_invoice_hdr
where bill_cycle_code='201912'
and cust_id=cid(9113051)


select CONS_KWH_SR img_tot_cons,ENG_CHRG_SR,TOTAL_BILL,a.* from bc_bill_image a
where bill_cycle_code='201912'
and cust_id=cid(9113051)
and invoice_num is not null




select sum(BILLED_VALUE) from bc_meter_reading_card_dtl
where bill_cycle_code='201912'
and cust_id=cid(9113089)
and READING_TYPE_CODE=2