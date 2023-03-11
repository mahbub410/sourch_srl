
---------------------------receipt_map to receipt_hdr--------------------------

select m.*,r.cust_num,r.RECEIPT_AMT,r.VAT_AMT,r.RECEIPT_OFFSET,r.VAT_OFFSET
   from  (select  receipt_num,sum(PRINCIPAL_AMT_LPS+ LPS_AMT) prin_map ,sum(vat_amt) vat_map from bc_invoice_receipt_map group by receipt_num ) m, bc_receipt_hdr r
    where m.receipt_num=r.receipt_num
    and (R.RECEIPT_OFFSET <>prin_map or R.VAT_OFFSET <> vat_map)
    --and trunc(R.RECEIPT_DATE) >='01-NOV-2019'
    and r.CUST_ID=cid(78426876)


--------------------------------invoice_hdr to receipt_map---------------------

select a.invoice_num, a.PRINCIPAL_APPL-b.PRINCIPAL_AMT_LPS PRINCIPAL_APP_DIFF,A.VAT_APPL-B.VAT_AMT VAT_AMT_DIFF,
A.LPS_APPL-B.LPS_AMT LPS_AMT_DIFF
from (
select invoice_num,PRINCIPAL_APPL,LPS_APPL,VAT_APPL  from bc_invoice_hdr
where cust_id=cid(78426876) )
 a,
(select invoice_num,sum(PRINCIPAL_AMT_LPS) PRINCIPAL_AMT_LPS,sum(VAT_AMT) VAT_AMT,sum(LPS_AMT) LPS_AMT from  bc_invoice_receipt_map group by invoice_num) b
where a.invoice_num=b.invoice_num

--------------------------invoice_dtl to  invoice_hdr----------------------------------------

select bill_cycle_code,a.invoice_num,
sum(invoice_amount-applied_amount+adjusted_amount) from bc_invoice_dtl a, bc_invoice_hdr b
where a.invoice_num=b.invoice_num 
and  bill_cycle_code<='202012' and cust_id =cid(:p_cust_id)
and invoice_amount-applied_amount+adjusted_amount<>0
group by bill_cycle_code,a.invoice_num
--having sum(invoice_amount-applied_amount+adjusted_amount)<>0
order by Bill_cycle_code desc





--------------------------------------------------------------------

select * from bc_receipt_hdr
where RECEIPT_NUM=105670948



-----------------------------------

offsetting problem bill no-44476303 


select * from bc_invoice_hdr
--where INVOICE_NUM='44476303'
where cust_id=cid(57422582)
ORDER BY BILL_CYCLE_CODE DESC
--and INVOICE_NUM='44476303'

/*
update bc_invoice_hdr
set REC_STATUS='D'
where cust_id=cid(41072177)
and REC_STATUS='M'

commit;
*/

select RECEIPT_AMT-RECEIPT_OFFSET,VAT_AMT-VAT_OFFSET from bc_receipt_hdr
where cust_id=cid(57422582)

---------------------for bkp--------------------------------



create table emp.bc_invoice_hdr_x as
select * from bc_invoice_hdr
where cust_id=cid(2425493)

create table emp.bc_invoice_dtl as
select * from bc_invoice_dtl
where invoice_num in (
select invoice_num from bc_invoice_hdr
where cust_id=cid(2425493)
)

create table emp.bc_receipt_hdr as
select * from bc_receipt_hdr
where cust_id=cid(2425493)


create table emp.bc_invoice_receipt_map as
select * from bc_invoice_receipt_map
where invoice_num in (
select invoice_num from bc_invoice_hdr
where cust_id=cid(2425493)
)