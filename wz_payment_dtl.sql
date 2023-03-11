
SELECT DISTINCT LOCATION_CODE FROM EPAY_LOCATION_MASTER

select * from epay_utility_bill
where bill_month='201711'
and account_number in ('605120703','605121026','605120227')

1711604113113

1711605120227
1711605120703
1711605121026


select * from epay_payment_mst m,epay_payment_dtl d
where M.BATCH_NO=D.BATCH_NO
and M.PAY_DATE between '01-dec-2017' and '31-dec-2017'
and d.bill_number in ('1711605120227','1711605120703','1711605121026')

select * from payment_dtl@wz
where BATCH_ID='MBP4411'


MBP4411
MBP4371
MBP4371