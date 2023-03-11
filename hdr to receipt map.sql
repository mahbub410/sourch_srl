

select a.invoice_num, a.PRINCIPAL_APPL-b.PRINCIPAL_AMT_LPS PRINCIPAL_APP_DIFF,A.VAT_APPL-B.VAT_AMT VAT_AMT_DIFF,
A.LPS_APPL-B.LPS_AMT LPS_AMT_DIFF
from (
select invoice_num,PRINCIPAL_APPL,LPS_APPL,VAT_APPL  from bc_invoice_hdr
where cust_id=cid(91130401) )
 a,
(select invoice_num,sum(PRINCIPAL_AMT_LPS) PRINCIPAL_AMT_LPS,sum(VAT_AMT) VAT_AMT,sum(LPS_AMT) LPS_AMT from  bc_invoice_receipt_map group by invoice_num) b
where a.invoice_num=b.invoice_num




select * from bc_invoice_receipt_map
where invoice_num='222913888'



select * from bc_invoice_dtl
where invoice_num in (
select invoice_Num from bc_invoice_hdr where cust_id=cid(91130401) and bill_cycle_code>='201712')
and TARIFF_TYPE_CODE='14'


select * from bc_invoice_dtl
where invoice_num in (
select invoice_Num from bc_invoice_hdr where cust_id=cid(91130401) and bill_cycle_code>='201712')
and TARIFF_TYPE_CODE='14'
--and INVOICE_AMOUNT<>APPLIED_AMOUNT
order by invoice_num desc

select sum(INVOICE_AMOUNT),sum(APPLIED_AMOUNT),sum(INVOICE_AMOUNT-APPLIED_AMOUNT) from bc_invoice_dtl
where invoice_num in (
select invoice_Num from bc_invoice_hdr where cust_id=cid(91130401) and bill_cycle_code<='201711')
and TARIFF_TYPE_CODE='14'
--and INVOICE_AMOUNT<>APPLIED_AMOUNT
--order by invoice_num desc


select * from bc_invoice_dtl
where invoice_num in (
select invoice_Num from bc_invoice_hdr where cust_id=cid(91130401) and bill_cycle_code<='201711')
and TARIFF_TYPE_CODE='14'
--and INVOICE_AMOUNT<>APPLIED_AMOUNT
--order by invoice_num desc

select * from bc_invoice_hdr
where invoice_num='61729355'