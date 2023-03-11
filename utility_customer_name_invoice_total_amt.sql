
select c.DESCR ,a.LOCATION_CODE, to_char(a.BILL_DATE,'dd-Mon-rrrr') BILL_DATE,to_char(a.BILL_DUE_DATE,'dd-Mon-rrrr')DUE_DATE,TO_CHAR(a.BILL_DUE_DATE, 'DAY') Day_Name 
from BC_BILL_CYCLE_CODE a,bc_location_master c
where a.LOCATION_CODE=c.LOCATION_CODE
and a.bill_cycle_code='202205'
and c.STATUS='A'
--and c.LOCATION_CODE='X3'
group by c.DESCR,a.LOCATION_CODE,a.BILL_DATE,a.BILL_DATE,a.BILL_DUE_DATE
order by 4


update bc_bill_image
SET INVOICE_due_DATE='12-JUl-2022'
WHERE BILL_CYCLE_CODE='202205'
AND location_code='Z3'
and invoice_num is not null


update bc_invoice_hdr
SET INVOICE_DUE_DATE='12-JUl-2022'
WHERE BILL_CYCLE_CODE='202205'
AND CUST_ID IN(SELECT CUST_ID FROM BC_CUSTOMERS WHERE LOCATION_CODE='Z3'
)


update bc_bill_cycle_code
set  BILL_DUE_DATE='12-JUL-2022'--,BILL_DUE_DATE='07-JUN-2022'
WHERE BILL_CYCLE_CODE='202205'
AND LOCATION_CODE='Z3'


---LOCATION LIST----

select * from bc_location_master
order by DESCR


---INVOICE NUM CHECK---- 
select c.CUSTOMER_NAME,bi.INVOICE_NUM,bi.ENG_CHRG_SR, bi.TOTAL_BILL,bi.INVOICE_DUE_DATE,bi.PFC_CHARGE,bi.invoice_date,bi.CUSTOMER_NUM,BI.CUST_ID  
from bc_bill_image bi,bc_customers c
where bi.CUST_ID=c.CUST_ID
and bi.LOCATION_CODE = c.LOCATION_CODE
and  bi.bill_cycle_code='202205'
and c.LOCATION_CODE='GM'
and bi.invoice_num is not null
order by 1



select * from bc_receipt_batch_hdr
where receipt_date='09-jan-2020'
and location_code='GM'

select sum(RECEIPT_AMT) from bc_receipt_hdr
where batch_num in (
555507126,555507124
)

select * from bc_receipt_hdr
where batch_num in (
select batch_num from bc_receipt_batch_hdr
where receipt_date BETWEEN '01-jan-2020' AND '12-JAN-2020'
and location_code='Z4'
)

SELECT * FROM BC_CUSTOMER_EVENT_LOG
WHERE BILL_CYCLE_CODE='201912'


select c.DESCR,bi.invoice_due_date  from bc_bill_image bi,BC_LOCATION_MASTER c
where  bi.LOCATION_CODE = c.LOCATION_CODE
and  bi.bill_cycle_code='202201'
--and c.LOCATION_CODE='X3'
and bi.invoice_num is not null
group by c.DESCR,bi.invoice_due_date
order by 1