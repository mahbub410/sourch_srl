
select * from epay_payment_mst
where status='E'

select * from epay_payment_mst
where batch_no='MBP66515'


select * from epay_payment_dtl
where batch_no='MBP66515'


select * from epay_payment_dtl
where batch_no='MBP66515'
and account_number in (
select account_number from epay_utility_Bill where location_code='Y1')


select account_number from epay_payment_dtl
where batch_no='MBP43111'
minus
select account_number from epay_utility_Bill 
where bill_month='201903' 
and location_code='Q7'
and account_number in (
select account_number from epay_payment_dtl
where batch_no='MBP43111')

select * from epay_payment_dtl
where batch_no='MBP43111'
and bill_number in ('295644326','295696130')

-----------------------------------------------------------



select BILL_NUMBER,COUNT(*) from epay_payment_dtl
where batch_no='MBP66515'
GROUP BY BILL_NUMBER
HAVING COUNT(BILL_NUMBER)>1


select * from epay_payment_dtl
where BILL_NUMBER='584795871'