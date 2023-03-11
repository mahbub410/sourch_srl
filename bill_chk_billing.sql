
select * from bc_receipt_batch_hdr
where bank_code='94'

SELECT *  FROM BC_RECEIPT1_INT_DTL
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT1_INT_HDR
WHERE BATCH_NUM in (select BATCH_NUM from bc_receipt_batch_hdr
where bank_code='94')
)

select * from bc_bill_image
where bill_cycle_code='201805'
and CUSTOMER_NUM||CONS_CHK_DIGIT in (select CUSTOMER_NUM from BC_RECEIPT1_INT_DTL
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT1_INT_HDR
WHERE BATCH_NUM in (select BATCH_NUM from bc_receipt_batch_hdr
where bank_code='94')
))


SELECT * FROM BC_RECEIPT1_INT_HDR
WHERE BATCH_NUM='9494040003'