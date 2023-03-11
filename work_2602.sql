
select * from NEPAY.SRL_BILL_COLLECTION@BILLING_DESCO
where COLLECTION_DATE='25-feb-2021'
and bank_code='BK'


select M2.ACCOUNT_NUMBER,M2.BILL_NUMBER,'BK'||TO_CHAR(M1.PAY_DATE,'DDMMRR'),'BK',null,M1.PAY_DATE,NVL(M2.ORG_PRN_AMOUNT,0)+NVL(M2.VAT_AMOUNT,0),
1,'SRL_API',SYSDATE,NVL(M2.VAT_AMOUNT,0),
M1.BATCH_NO,M2.TRANSACTION_ID,M1.ORG_BR_CODE,NVL(M2.REV_STAMP_AMOUNT,0) 
from EPAY_PAYMENT_DTL@DESCO_NESCO m2,EPAY_PAYMENT_mst@DESCO_NESCO m1
where m1.BATCH_NO=m2.BATCH_NO
and pay_date ='25-feb-2021'
and org_code ='NESCO'
and org_bank_code='94'
and (to_number(ACCOUNT_NUMBER),BILL_NUMBER,TRANSACTION_ID) in (
select to_number(ACCOUNT_NUMBER),BILL_NUMBER,TRANSACTION_ID
from EPAY_PAYMENT_DTL@DESCO_NESCO m2,EPAY_PAYMENT_mst@DESCO_NESCO m1
where m1.BATCH_NO=m2.BATCH_NO
and pay_date ='25-feb-2021'
and org_code ='NESCO'
and org_bank_code='94'
minus
select ACCOUNT_NO,BILL_NO,REF_TXN_ID from NEPAY.SRL_BILL_COLLECTION@BILLING_DESCO
where COLLECTION_DATE='25-feb-2021'
and bank_code='BK'
)