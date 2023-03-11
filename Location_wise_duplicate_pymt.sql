

select bill_number,count(*) from epay_payment_dtl_int
where batch_no='04000301250619'
group by bill_number
having count(bill_number)>1
order by bill_number desc



select * from epay_payment_dtl_int
where batch_no='56000101100619'
and  bill_number='706835551'


select * from epay_payment_dtl_int
where batch_no='04000301250619'
and bill_number in (
select bill_number from epay_payment_dtl_int
where batch_no='30000801250619'
)

04000301250619	2321328027	a	147	04000301250619147	1031	52

select * from epay_payment_dtl_int
where batch_no='23000401050219'
and bill_number='2214064905'