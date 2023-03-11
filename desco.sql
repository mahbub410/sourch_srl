

Select * from EPAY_UTILITY_BILL
where company_code = 'DESCOPST'
and BILL_MONTH='201109'


Select * from 

update EPAY_UTILITY_BILL
set BILL_MONTH='201807',
 BILL_DUE_DATE='23-AUG-2018'
where company_code = 'DESCOPST'
and BILL_MONTH='201109'
AND account_number<>'23033341'


update EPAY_UTILITY_BILL
set bill_due_date='31-OCT-2018'
where company_code = 'DESCOPST'
and BILL_MONTH='201809'

and account_number in (

select * from  EPAY_UTILITY_BILL
where company_code = 'DESCOPST'
and BILL_MONTH='201102'
and account_number='23033341'



SELECT * FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='201807'
AND ACCOUNT_NUMBER IN (
Select ACCOUNT_NUMBER from EPAY_UTILITY_BILL
where company_code = 'DESCOPST'
and BILL_MONTH='201109'
)