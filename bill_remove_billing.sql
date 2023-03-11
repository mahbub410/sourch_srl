
---emp.BC_BILL_IMAGE_202005

select * from BC_BILL_IMAGE
where bill_cycle_code='202006'
and cust_id=cid(67619448)

--insert into BC_INVOICE_HDR_x

select * from BC_INVOICE_HDR
where bill_cycle_code='202006'
and cust_id=cid(67619448)

--BC_INVOICE_DTL_x

select * from BC_INVOICE_DTL
where invoice_num='31335956'


--BC_INVOICE_ARREARS_x

select * from BC_INVOICE_ARREARS
where invoice_num='31335956'


---BC_INVOICE_ADJUSTMENTS_x

select * from BC_INVOICE_ADJUSTMENTS
where invoice_num='31335956'

