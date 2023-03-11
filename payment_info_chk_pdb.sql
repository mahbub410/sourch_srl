
select u.bill_month,u.bill_due_date,p.pay_date,u.account_number,p.bill_number,u.TOTAL_BILL_AMOUNT,
sum(nvl(PDB_AMOUNT,0)+nvl(GOVT_DUTY,0)) total_payment,PAY_BANK_CODE||'-'||b.bank_name bank_name
 from epay_utility_bill u,VW_EPAY_PAYMENT_MST_DTL p,epay_banks b
where u.bill_number=p.bill_number
and u.location_code=p.location_code
and p.pay_bank_code=b.bank_code
and u.account_Number='27897660'
and p.location_code=upper('r2')
group by u.bill_month,u.bill_due_date,p.pay_date,u.account_number,p.bill_number,u.TOTAL_BILL_AMOUNT,PAY_BANK_CODE||'-'||b.bank_name
order by 3 desc