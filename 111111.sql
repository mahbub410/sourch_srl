
c+s+R+M

SELECT 2+28+1+25 FROM DUAL

select ''''||ACCOUNT_NUMBER||''''||',' from epay_utility_bill
where bill_month='201812'
and account_number in (
select account_number from GP_PAYMENT_CONS
)
and location_code in (select location_code from epay_location_master where center_name='MOULAVIBAZAR')


select ACCOUNT_NUMBER from epay_utility_bill
where bill_month='201812'
and account_number in (
select account_number from GP_PAYMENT_CONS
)
and location_code in (select location_code from epay_location_master where center_name='CHITTAGONG')



select * from bc_BILL_IMAGE@billing_MOU
where bill_cycle_code='201901'
and CUSTOMER_NUM||CONS_CHK_DIGIT in (
'47333483',
'47331114',
'47136659',
'46297511',
'46297505',
'46287194',
'46283562',
'46253128',
'46237408',
'46233636',
'46227877',
'46177580',
'46177576',
'46172518',
'46171670',
'46169999',
'46163082',
'46163063',
'46163031',
'46162949',
'46162915',
'46162807',
'46162756',
'45134045',
'45112472'
)


select account_number from GP_PAYMENT_CONS
)



select * from epay_utility_bill
where bill_number in (
select bill_number from GP_PAYMENT_CONS
)
and location_code in (
select location_code from EPAY_ZONE_COMP_CNTR_LOC
where ZONE_CODE in ('2','4','5')
)

SELECT * FROM EPAY_PAYMENT_MST
WHERE BATCH_NO IN (
SELECT BATCH_NO FROM EPAY_PAYMENT_DTL
WHERE BILL_NUMBER IN ( 
select bill_number from GP_PAYMENT_CONS
)AND CREATED_BY='GP'
)