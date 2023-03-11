
select EPAY.DFN_SEBL_CONS_DCLINT (:P_Cons_Num ) from dual


--insert into EPAY_PAYMENT_DTL_ONLINE_INT_BK
select *  from EPAY_PAYMENT_DTL_ONLINE_INT
where account_number in (
'20664292'
)




select * from EPAY_PAYMENT_DTL_ONLINE_HSTR
where account_number='25046325'
order by pay_date desc


select * from EPAY_PAYMENT_DTL_ONLINE_INT
where pay_date='26-jan-2020'
and location_code='W3'
and account_number='81850866'


insert into EPAY_PAYMENT_DTL_ONLINE_REV
select * from EPAY_PAYMENT_DTL_ONLINE_INT
where pay_date='26-jan-2020'
and location_code='W3'
and account_number='81850866'

commit;


delete from EPAY_PAYMENT_DTL_ONLINE_INT
where pay_date='26-jan-2020'
and location_code='W3'
and account_number='81850866'

commit;


select * from epay_utility_bill
where bill_month='202107'
and account_number in (
'20664292')
and COMPANY_CODE='BPDB'


update epay_utility_bill
set BILL_STATUS='N'
where bill_month='202006'
and account_number in (
'80205443')
and COMPANY_CODE='BPDB'
and BILL_STATUS='P'

commit;


select *  from EPAY_PAYMENT_DTL_ONLINE_HSTR
where pay_date='23-jan-2020'
and location_code='W3'
--and account_number='81897006'