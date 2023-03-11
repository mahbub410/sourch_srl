



select * from epay_payment_dtl
where batch_no in (
select batch_no from epay_payment_mst
where pay_date between '01-jun-2019' and '10-jun-2019')


select * from payment_dtl@wz
where TRANSACTION_DATE between '01-jun-2019' and '10-jun-2019'





select a.BANK_NAME,a.ORG_BR_CODE,a.PAY_DATE,a.TOTAL_AMOUNT,a.NO_OF_CON,a.CREATED_DATE,b.TOTAL_BILL TOTAL_BILL_blng,b.no_of_cons tot_cons_blng,b.CREATE_DATE billing_post_date from (
select M.BATCH_NO BATCH_NO, decode(ORG_BANK_CODE,'01','National Bank','03','Mercantile Bank','04','NRB Bank','05','Trust Bank','400','Dutch Bangla Bank Limited') bank_name,
ORG_BR_CODE,M.PAY_DATE,sum(ORG_PRN_AMOUNT+VAT_AMOUNT) total_amount,count(*) no_of_con,M.CREATED_DATE ,M.CREATED_BY 
from epay_payment_mst m,epay_payment_dtl d
where m.batch_no=d.batch_no
and  to_char(pay_date,'rrrrmm') in (SELECT TO_CHAR(ADD_MONTHS(SYSDATE,0),'rrrrmm') BILL_MONTH FROM DUAL)
group by M.BATCH_NO,decode(ORG_BANK_CODE,'01','National Bank','03','Mercantile Bank','04','NRB Bank','05','Trust Bank','400','Dutch Bangla Bank Limited'),ORG_BR_CODE,M.PAY_DATE,M.CREATED_DATE ,M.CREATED_BY 
)a,(
select BATCH_ID,LOCATION_CODE,TRANSACTION_DATE,sum(TOTAL_VAT+NET_AMOUNT) total_bill,count(*) no_of_cons,CREATE_DATE,CREATE_BY 
from payment_dtl@wz
where to_char(TRANSACTION_DATE,'rrrrmm') in (SELECT TO_CHAR(ADD_MONTHS(SYSDATE,0),'rrrrmm') BILL_MONTH FROM DUAL)
and BATCH_ID in (
select m.BATCH_NO
from epay_payment_mst m,epay_payment_dtl d
where m.batch_no=d.batch_no
and  to_char(pay_date,'rrrrmm') in (SELECT TO_CHAR(ADD_MONTHS(SYSDATE,0),'rrrrmm') BILL_MONTH FROM DUAL)
)
group by BATCH_ID,LOCATION_CODE,TRANSACTION_DATE,CREATE_DATE,CREATE_BY 
)b
where a.BATCH_NO=b.BATCH_ID
group by a.BANK_NAME,a.ORG_BR_CODE,a.PAY_DATE,a.TOTAL_AMOUNT,a.NO_OF_CON,a.CREATED_DATE,b.TOTAL_BILL ,b.no_of_cons ,b.CREATE_DATE 
order by a.PAY_DATE desc


select * from payment_dtl@wz