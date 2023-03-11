update bc_receipt_hdr
set coll_centre_code=EMP.Dpd_Bc_Inv_Update(batch_num,seq_num,receipt_amt+vat_amt,receipt_type_code)
where  coll_centre_code is null
and post_date is null