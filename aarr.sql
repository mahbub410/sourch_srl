
select CUSTOMER_NUM||CONS_CHK_DIGIT ACCOUNT_NUMBER,INVOICE_NUM||INVOICE_CHK_DGT BILL_NUMBER,REC_STATUS,'arrear' as status from bc_bill_image@billing_jam
WHERE BILL_CYCLE_CODE=:P_BILL_MONTH
AND (ARR_ADV_ADJ_PRN<> 0 OR ARR_ADV_ADJ_VAT<>0)
and INVOICE_DUE_DATE>=trunc(sysdate)
AND CUSTOMER_NUM IN (
select substr(account_number,1,7) from epay_utility_bill
where bill_month=:P_BILL_MONTH
and (nvl(ARREAR_PRINCIPLE,0)<>0 or  nvl(ARREAR_GOVT_DUTY,0)<>0)
and account_number in (
select account_number from epay_utility_bill
where bill_month=:old_BILL_MONTH
and (bill_number,location_code) in (
select bill_number,location_code from VW_EPAY_PAYMENT_MST_DTL
where status='T'
and location_code in (select location_code from epay_location_master where center_name='JAMALPUR'
))))
group by CUSTOMER_NUM||CONS_CHK_DIGIT,INVOICE_NUM||INVOICE_CHK_DGT,REC_STATUS,'arrear'



select LOCATION_CODE,BILL_GROUP,REC_STATUS,'arrear' as status,count(1) no_of_arr_cons from bc_bill_image@billing_jam
WHERE BILL_CYCLE_CODE=:P_BILL_MONTH
AND (ARR_ADV_ADJ_PRN<> 0 OR ARR_ADV_ADJ_VAT<>0)
and INVOICE_DUE_DATE>=trunc(sysdate)
AND CUSTOMER_NUM IN (
select substr(account_number,1,7) from epay_utility_bill
where bill_month=:P_BILL_MONTH
and (nvl(ARREAR_PRINCIPLE,0)<>0 or  nvl(ARREAR_GOVT_DUTY,0)<>0)
and account_number in (
select account_number from epay_utility_bill
where bill_month=:old_BILL_MONTH
and (bill_number,location_code) in (
select bill_number,location_code from VW_EPAY_PAYMENT_MST_DTL
where status='T'
and location_code in (select location_code from epay_location_master where center_name='JAMALPUR'
))))
group by LOCATION_CODE,BILL_GROUP,REC_STATUS,'arrear'

select * from bc_bill_image@billing_jam
WHERE BILL_CYCLE_CODE=:P_BILL_MONTH
AND (ARR_ADV_ADJ_PRN<> 0 OR ARR_ADV_ADJ_VAT<>0)
AND CUSTOMER_NUM IN (
select substr(account_number,1,7) from epay_utility_bill
where bill_month=:old_BILL_MONTH
and (bill_number,location_code) in (
select bill_number,location_code from VW_EPAY_PAYMENT_MST_DTL
where status='T'
and location_code in (select location_code from epay_location_master where center_name='JAMALPUR'
)))


select  from epay_utility_bill@epay_dcc


select REC_STATUS,INVOICE_DUE_DATE,count(1)--,bill_group,CUSTOMER_NUM||CONS_CHK_DIGIT account_number
from bc_bill_image@ROBICOM
WHERE BILL_CYCLE_CODE='201504'
AND (ARR_ADV_ADJ_PRN<> 0 OR ARR_ADV_ADJ_VAT<>0)
AND CUSTOMER_NUM IN (
SELECT SUBSTR(ACCOUNT_NUMBER,1,7) FROM UTILITY_BILL_PDB
WHERE BILL_MONTH='201503'
AND BILL_NUMBER IN (
SELECT BILL_NUMBER FROM PAYMENT_DTL
WHERE BATCH_NO IN (
SELECT BATCH_NO FROM PAYMENT_MST M,EP_RECEIPT_BATCH_HDR_PDB R
WHERE M.BATCH_NO=R.BATCH_NUM_AKTEL
AND M.PAY_DATE BETWEEN '20-MAR-2015' AND '30-MAR-2015'
AND M.STATUS='P' 
)))
GROUP BY REC_STATUS,INVOICE_DUE_DATE
ORDER BY INVOICE_DUE_DATE