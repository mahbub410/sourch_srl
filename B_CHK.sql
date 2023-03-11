
select * from epay_payment_mst
where pay_date='30-nov-2016'
and location_code='R7'

select * from epay_payment_dtl
where batch_no='215882'


select * from EPAY_RECEIPT_BATCH_HDR_PDB
where BATCH_NUM_EPAY='219136'

0251032328

select * from bc_receipt_batch_hdr@billing_ctg
where batch_num='0251032328'


select COUNT(*) COUNT from bc_receipt_hdr@billing_ctg
where batch_num='0251032299'


SELECT * FROM BC_RECEIPT1_INT_DTL@BILLING_CTG
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT1_INT_HDR@BILLING_CTG
                     WHERE batch_num=:P_BATCH_NUM);

SELECT * FROM BC_RECEIPT1_INT_HDR@BILLING_CTG
WHERE batch_num=:P_BATCH_NUM;

SELECT * FROM BC_RECEIPT2_INT_DTL@BILLING_CTG
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT2_INT_HDR@BILLING_CTG
                     WHERE batch_num=:P_BATCH_NUM);

SELECT * FROM BC_RECEIPT2_INT_HDR@BILLING_CTG
WHERE batch_num=:P_BATCH_NUM;

SELECT * FROM BC_RECEIPT_BATCH_CONTROL@BILLING_CTG
WHERE batch_num=:P_BATCH_NUM;

SELECT * FROM BC_RECEIPT_HDR@BILLING_CTG
WHERE batch_num=:P_BATCH_NUM;


SELECT * FROM BC_RECEIPT_BATCH_HDR@BILLING_CTG
WHERE batch_num=:P_BATCH_NUM;

COMMIT;

02001801301116

 SELECT *  FROM  epay_payment_MST_INT
 WHERE BATCH_NO IN (
select REF_BATCH_NO from epay_payment_mst
where pay_date='30-nov-2016'
and location_code='R7'
)

select * from 


SELECT * FROM epay_payment_MST
where batch_no IN (
select BATCH_NUM_EPAY from EPAY_RECEIPT_BATCH_HDR_PDB
where BATCH_NUM_PDB=:P_BATCH_NUM)


 SELECT * from EPAY_RECEIPT_BATCH_HDR_PDB
where BATCH_NUM_PDB=:P_BATCH_NUM
