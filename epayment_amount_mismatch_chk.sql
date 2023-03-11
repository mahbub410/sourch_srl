

select * from epay_payment_mst
where pay_date='28-jan-2020'
and location_code='S2'
and pay_bank_code='15'


select * from epay_payment_dtl
where batch_no='501786'
and bill_number in ('2366284633','2366192758','2366192126')

select sum(PDB_AMOUNT),sum(GOVT_DUTY),sum(PDB_AMOUNT+GOVT_DUTY) tot,count(*) from epay_payment_dtl
where batch_no='501786'




select * from epay_payment_dtl
where batch_no='501786'
and bill_number='2365619211'


select a.BILL_NUMBER,d_tot,TOTAL_BILL_AMOUNT,sum(d_tot-TOTAL_BILL_AMOUNT) diff from (
select BILL_NUMBER,sum(PDB_AMOUNT) d_prin,sum(GOVT_DUTY) d_vat,sum(PDB_AMOUNT+GOVT_DUTY) d_tot  from epay_payment_dtl
where batch_no='501786'
group by BILL_NUMBER)a,(
select bill_number,sum(CURRENT_PRINCIPLE+ARREAR_PRINCIPLE) prin,sum(CURRENT_GOVT_DUTY+ARREAR_GOVT_DUTY) vat,TOTAL_BILL_AMOUNT from epay_utility_Bill
where location_code='S2'
and bill_number in (
select bill_number from epay_payment_dtl
where batch_no='501786'
)
group by bill_number,TOTAL_BILL_AMOUNT)b
where a.BILL_NUMBER = b.BILL_NUMBER
group by a.BILL_NUMBER,d_tot,TOTAL_BILL_AMOUNT