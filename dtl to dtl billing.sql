

select bill_cycle_code,a.invoice_num,
sum(invoice_amount-applied_amount+adjusted_amount) from bc_invoice_dtl a, bc_invoice_hdr b
where a.invoice_num=b.invoice_num 
and  bill_cycle_code<='202203' and cust_id =cid(:p_cust_id)
and invoice_amount-applied_amount+adjusted_amount<>0
and TARIFF_TYPE_CODE='03'
group by bill_cycle_code,a.invoice_num
--having sum(invoice_amount-applied_amount+adjusted_amount)<>0
--order by Bill_cycle_code desc




select * from bc_invoice_hdr
where cust_id=cid(67418150)
and INVOICE_NUM='28934480'


select * from bc_receipt_hdr
where INVOICE_NUM='61728835'


select * from bc_invoice_HDR
where INVOICE_NUM='61728835'

select * from bc_invoice_DTL
where INVOICE_NUM='61728835'


select * from bc_invoice_receipt_map
where INVOICE_NUM='28934480'


select * from BC_TARIFF_TYPE_CODE
order by TARIFF_TYPE_CODE