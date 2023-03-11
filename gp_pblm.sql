
select * from epay_payment_dtl
where batch_no in (
select batch_no from epay_payment_mst where pay_date between '08-aug-2019' and '13-aug-2019' and pay_bank_code='96' and location_code='N3')


select * from epay_utility_bill
where bill_number in (
select bill_number from epay_payment_dtl
where batch_no in (
select batch_no from epay_payment_mst where pay_date between '08-aug-2019' and '13-aug-2019' and pay_bank_code='96' and location_code='N3')
)
and ARREAR_PRINCIPLE='0'

select * from epay_utility_bill
where account_number in (
select account_number from epay_utility_bill
where bill_number in (
select bill_number from epay_payment_dtl
where batch_no in (
select batch_no from epay_payment_mst where pay_date between '08-aug-2019' and '13-aug-2019' and pay_bank_code='96' and location_code='N3')
)
--and ARREAR_PRINCIPLE='0'
)
and bill_month='201908'



select * from utility_bill_pdb@epay_gp
where account_number in (
select account_number from utility_bill_pdb@epay_gp
where bill_number in (
select bill_number from epay_payment_dtl
where batch_no in (
select batch_no from epay_payment_mst where pay_date between '08-aug-2019' and '13-aug-2019' and pay_bank_code='96' and location_code='N3')
)
--and ARREAR_PRINCIPLE='0'
)
and bill_month='201908'