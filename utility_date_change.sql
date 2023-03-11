SELECT * FROM BC_LOCATION_MASTER
ORDER BY DESCR


select c.CUSTOMER_NAME,bi.INVOICE_NUM,bi.TOTAL_BILL,bi.INVOICE_DUE_DATE,INVOICE_DATE,PFC_CHARGE from bc_bill_image bi,bc_customers c
where bi.CUST_ID=c.CUST_ID
and bi.LOCATION_CODE = c.LOCATION_CODE
and  bi.bill_cycle_code='202106'
and c.LOCATION_CODE='X4'
and bi.invoice_num is not null
order by 1

-----DUE DATE CHECK-----
select c.DESCR ,a.LOCATION_CODE,a.BILL_DATE,a.BILL_DUE_DATE,TO_CHAR(a.BILL_DUE_DATE, 'DAY') Day_Name from BC_BILL_CYCLE_CODE a,bc_location_master c
where a.LOCATION_CODE=c.LOCATION_CODE
and a.bill_cycle_code='202107'
and c.STATUS='A'
group by c.DESCR,a.LOCATION_CODE,a.BILL_DATE,a.BILL_DATE,a.BILL_DUE_DATE
order by 1

X6
X7
Z1

update bc_bill_image
SET INVOICE_DUE_DATE='09-AUG-2021'
WHERE BILL_CYCLE_CODE='202106'
AND LOCATION_CODE='X4'
and invoice_num is not null


update bc_invoice_hdr
SET INVOICE_DUE_DATE='09-AUG-2021'
WHERE BILL_CYCLE_CODE='202106'
AND CUST_ID IN(SELECT CUST_ID FROM BC_CUSTOMERS WHERE LOCATION_CODE='X4'
)


update bc_bill_cycle_code
set  BILL_DUE_DATE='09-AUG-2021'
WHERE BILL_CYCLE_CODE='202106'
AND LOCATION_CODE='X4'



COMMIT;

select * from bc_bill_image
where invoice_num is not null

select * from bc_bill_cycle_code
where bill_cycle_code='202009'
and location_code='Z4'




update bc_bill_cycle_code
set  BILL_DATE='10-AUG-2021'--,BILL_DUE_DATE='10-JUN-2020'
WHERE BILL_CYCLE_CODE='202107'
AND LOCATION_CODE='X5'