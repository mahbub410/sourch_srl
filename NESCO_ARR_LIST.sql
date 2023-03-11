select l.location_code,l.descr loc_name,area_code,c.WALKING_SEQUENCE, CUSTOMER_NUM||CHECK_DIGIT cust_num,CONS_EXTG_NUM,CUSTOMER_NAME,addr,USAGE_CATEGORY_CODE tariff, START_BILL_CYCLE,r.last_pay_date,h.arr_amt, last_bill_month 
from BC_CUSTOMERS c, 
(select cust_id ,max(receipt_date) last_pay_date from bc_receipt_hdr
where receipt_type_code='REC'
group by cust_id) r, (select cust_id, max(bill_cycle_code) last_bill_month,sum(INVOICE_AMT-INVOICE_APPLIED_AMT+INVOICE_ADJUSTED_AMT) arr_amt
 from bc_invoice_hdr
 where bill_cycle_code<'201805'
 group by cust_id) h, bc_location_master l, (select cust_id, USAGE_CATEGORY_CODE from bc_customer_category cc, bc_category_master cm
where cc.cat_id=cm.category_id
and cc.exp_date is null) cat, (select cust_id,ADDR_DESCR1||'  '||ADDR_DESCR2||'  '||ADDR_DESCR3 addr from bc_customer_addr
where addr_exP_date is null
and addr_type='M') ad
where c.cust_id in (
select cust_id from bc_customers
minus
select cust_id from bc_receipt_hdr 
where receipt_type_code='REC'
and receipt_date>='1-jan-2014')
and START_BILL_CYCLE<'201401'
and CUSTOMER_STATUS_CODE<>'D'
and c.cust_id=r.cust_id(+)
and c.cust_id=h.cust_id
and c.location_code=l.location_code
and c.cust_id=cat.cust_id
and c.cust_id=ad.cust_id
order by location_code,substr(area_code,4,2),area_code