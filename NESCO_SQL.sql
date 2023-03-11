
SELECT 'EXECUTE EMP.dpd_despatch_rollback('||CUST_ID||','''||BILL_CYCLE_CODE||''');'||CHR(10) FROM BC_INVOICE_HDR
WHERE CUST_ID IN(
SELECT CUST_ID FROM BC_RECEIPT_HDR
WHERE BANK_CODE='94'
AND RECEIPT_DATE<='31-MAY-2018')
AND BILL_CYCLE_CODE='201805'
AND REC_STATUS='D'


SELECT * FROM BC_INVOICE_HDR
WHERE CUST_ID IN(
SELECT CUST_ID FROM BC_RECEIPT_HDR
WHERE BANK_CODE='94'
AND RECEIPT_DATE<='31-MAY-2018')
AND BILL_CYCLE_CODE='201805'

SELECT DISTINCT LOCATION_CODE,AREA_CODE FROM BC_CUSTOMERS
WHERE CUST_ID IN(
SELECT CUST_ID FROM BC_RECEIPT_HDR
WHERE BANK_CODE='94'
AND RECEIPT_DATE<='31-MAY-2018')


select distinct location_code,area_code FROM BC_bill_image
WHERE bill_cycle_code='201805'
and  CUST_ID IN(
SELECT CUST_ID FROM BC_RECEIPT_HDR
WHERE BANK_CODE='94'
AND RECEIPT_DATE<='31-MAY-2018')
AND BILL_CYCLE_CODE='201805'
--AND REC_STATUS='D'
and nvl(current_lps,0)>0

select * FROM BC_bill_image
WHERE bill_cycle_code='201805'
and  CUST_ID IN(
SELECT CUST_ID FROM BC_RECEIPT_HDR
WHERE BANK_CODE='94'
AND RECEIPT_DATE<='31-MAY-2018')
AND BILL_CYCLE_CODE='201805'
--AND REC_STATUS='D'
and nvl(current_lps,0)>0