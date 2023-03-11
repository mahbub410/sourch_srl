

SELECT  round(sum(PDB_AMOUNT)) as amount, round(sum(GOVT_DUTY)) as vat,round(sum(PDB_AMOUNT+GOVT_DUTY)) as total,count(*) FROM EPAY_PAYMENT_MST M,EPAY_PAYMENT_DTL D
where M.batch_no=D.batch_no
and m.location_code in ( select location_code from epay_location_master where center_name in ('SYLHET','MOULAVIBAZAR'))
AND M.PAY_DATE BETWEEN '01-JUN-2015' AND '30-JUN-2015'
AND M.PAY_BANK_CODE='96'


MINUS



SELECT sum(PDB_AMOUNT) as amount, sum(GOVT_DUTY) as vat,(sum(PDB_AMOUNT+GOVT_DUTY)) as total,count(*) FROM DBERSICE.PAYMENT_MST@EPAY_GP M,DBERSICE.PAYMENT_DTL@EPAY_GP D
where M.batch_no=D.batch_no
and m.location_code in ( select location_code from epay_location_master where center_name in ('SYLHET','MOULAVIBAZAR'))
AND M.PAY_DATE BETWEEN '01-JUN-2015' AND '30-JUN-2015'


GROUP BY D.BILL_NUMBER






SELECT * FROM EPAY_UTILITY_BILL
WHERE ACCOUNT_NUMBER='46250867'


select --max (receipt_date),
sum (r.ENTERED_BATCH_COLL_AMT) Total_payment, sum(r.ENTERED_BATCH_VAT_AMT) vat,SUM(R.POSTED_SCROLL) Total_customer,SUM(R.DERIVED_SCROLL) Total_payment 
from BC_LOCATION_MASTER l,bc_receipt_batch_hdr r
where l.LOCATION_CODE=r.LOCATION_CODE
and r.BANK_CODE='97'
and r.RECEIPT_DATE between '01-jan-2016' and '31-jan-2016'
