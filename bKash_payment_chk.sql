

----------DESCO-------

select SP_MSG,A.* from MBP.MBP_CUST_PMNT@MBP_23 A
where BANK_TRAN_ID='6FQ4W47QF0'


-------desco post--------

select REMOTE_POSTED,A.* from DESCOPST.MBP_DESCO_POSTPAID_COLLECTION@MBP_09 A
WHERE OLD_ACCOUNT_NO = '23111341'


-------------NESCO---------

SELECT * FROM EPAY_PAYMENT_DTL
WHERE TRANSACTION_ID='6EG6H1PUQW'

SELECT ARREAR_PRINCIPLE,ARREAR_GOVT_DUTY,a.* FROM EPAY_UTILITY_BILL a
WHERE BILL_MONTH='201905'
AND ACCOUNT_NUMBER='65527827'












select * from bc_receipt_hdr@billing_rong
where receipt_date='28-may-2019'
and bank_code='94'
and location_code='V8'
and cust_num in ('5748139','5711990')

and RECEIPT_OFFSET=0


select * from epay_utility_Bill--@epay_srl
where bill_month='201905'
and account_number in ('57481395','57119901')


select total_bill,a.* from bc_bill_image@billing_rong a
where bill_cycle_code='201905'
and customer_num in ('5748139','5711990')

3601
2279

select REC_STATUS,a.* from bc_invoice_hdr@billing_rong a
where bill_cycle_code='201905'
and CUST_NUM in ('5748139','5711990')