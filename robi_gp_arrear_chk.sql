select * from payment_dtl@epay_robi
where bill_number='3756383347'

select * from VW_EPAY_PAYMENT_MST_DTL

-----------------robi-------------

select u.BILL_MONTH,d.BATCH_NO,m.PAY_DATE,u.ACCOUNT_NUMBER,d.BILL_NUMBER,d.PDB_AMOUNT,d.GOVT_DUTY from payment_dtl@epay_robi d,payment_mst@epay_robi m,utility_bill_pdb@epay_robi u
where d.BATCH_NO = m.BATCH_NO
and d.BILL_NUMBER = u.BILL_NUMBER(+)
and m.LOCATION_CODE=u.LOCATION_CODE
and m.LOCATION_CODE='B1'
and u.ACCOUNT_NUMBER='32549550'
order by pay_date desc

-----------------gp-------------

select u.BILL_MONTH,d.BATCH_NO,m.PAY_DATE,u.ACCOUNT_NUMBER,d.BILL_NUMBER,d.PDB_AMOUNT,d.GOVT_DUTY 
from payment_dtl@epay_gp d,payment_mst@epay_gp m,utility_bill_pdb@epay_gp u
where d.BATCH_NO = m.BATCH_NO
and d.BILL_NUMBER = u.BILL_NUMBER(+)
and m.LOCATION_CODE=u.LOCATION_CODE
and m.LOCATION_CODE='B1'
and u.ACCOUNT_NUMBER='32549550'
order by pay_date desc

