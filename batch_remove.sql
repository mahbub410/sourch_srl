
select min(batch_no)  from epay_payment_mst
where ( pay_Date,LOCATION_CODE,ref_batch_no) in (
select pay_Date,LOCATION_CODE,ref_batch_no  from epay_payment_mst
where to_char(pay_date,'rrrrmm')='201601'
and pay_bank_code='97'
group by pay_Date,LOCATION_CODE,ref_batch_no
having count(1)>1
)
group by pay_Date,LOCATION_CODE,ref_batch_no
)

commit;





delete from  epay_payment_mst
where batch_no in (
select min(batch_no)  from epay_payment_mst
where ( pay_Date,LOCATION_CODE,ref_batch_no) in (
select pay_Date,LOCATION_CODE,ref_batch_no  from epay_payment_mst
where to_char(pay_date,'rrrrmm')='201601'
and pay_bank_code='97'
group by pay_Date,LOCATION_CODE,ref_batch_no
having count(1)>1
)
group by pay_Date,LOCATION_CODE,ref_batch_no
)

commit;


select receipt_Date,LOCATION_CODE  from epay_receipt_batch_hdr_pdb
where to_char(receipt_Date,'rrrrmm')='201601'
and bank_code='97'
group by receipt_Date,LOCATION_CODE
having count(1)>1