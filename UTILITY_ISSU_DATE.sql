
select * from bc_location_master
order by DESCR

select * from bc_bill_cycle_code
where location_code='X5'
and bill_cycle_code='202001'

UPDATE  bc_bill_cycle_code
set BILL_DATE='10-FEB-2020'
where location_code='X9'
and bill_cycle_code='202001'

COMMIT;


SELECT * FROM BC_BILL_IMAGE
where location_code='X9'
and bill_cycle_code='202001'
AND INVOICE_NUM IS NOT NULL


UPDATE BC_BILL_IMAGE
set INVOICE_DATE='10-FEB-2020'
where location_code='X9'
and bill_cycle_code='202001'
AND INVOICE_NUM IS NOT NULL

COMMIT;


SELECT * FROM BC_INVOICE_HDR
where CUST_ID IN (SELECT CUST_ID FROM BC_CUSTOMERS WHERE location_code='X9')
AND  bill_cycle_code='202001'

UPDATE BC_INVOICE_HDR
set INVOICE_DATE='10-FEB-2020'
where CUST_ID IN (SELECT CUST_ID FROM BC_CUSTOMERS WHERE location_code='X9')
AND  bill_cycle_code='202001'

COMMIT;
