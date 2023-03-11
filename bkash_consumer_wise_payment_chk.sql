

select b.BANK_NAME,m.pay_date,m.org_br_code,d.account_number,d.bill_number,d.transaction_id,d.org_prn_amount,d.vat_amount,m.status,m.batch_no
from epay_payment_mst m,epay_payment_dtl d,epay_banks b
where m.batch_no=d.batch_no
and m.org_bank_code=b.bank_code
and d.account_number='83837342'
order by m.pay_date desc

----24--
select b.BANK_NAME,m.pay_date,m.org_br_code,d.account_number,d.bill_number,d.transaction_id,d.org_prn_amount,d.vat_amount,m.status,m.batch_no
from epay_payment_mst@epay_srl m,epay_payment_dtl@epay_srl d,epay_banks@epay_srl b
where m.batch_no=d.batch_no
and m.org_bank_code=b.bank_code
and d.account_number='83837342'
order by m.pay_date desc


select b.BANK_NAME,a.LOCATION_CODE,a.CUST_NUM,a.INVOICE_NUM,a.RECEIPT_DATE,a.DCS_RECEIPT_DATE,a.POST_DATE,a.RECEIPT_AMT,a.VAT_AMT,a.RECEIPT_OFFSET,a.VAT_OFFSET 
from bc_receipt_hdr@billing_rong a,bc_banks@billing_rong b
where a.BANK_CODE = b.BANK_CODE
and a.cust_num='5804615'
and a.BANK_CODE='94'
order by receipt_date desc


select * from epay_payment_dtl
where account_number='56540168'
order by bill_month desc

select * FROM MBP_CUST_PMNT_hist@MBP_23
where acc_num='58046151'

select * from MBP_PAYMENT_DTL_OVC@MBP_23
where account_number='41436123'

select * from epay_utility_bill
where bill_month='202006'
and account_number='41436123'