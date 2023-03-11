
select * from epay_banks


select sum(ROUND(NVL(ORG_PRN_AMOUNT,0))) PRN_AMOUNT,sum(ROUND(NVL(VAT_AMOUNT,0))) VAT_AMOUNT,sum(ROUND(NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0))) TOTAL_AMOUNT,
sum(ROUND(NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)))-sum(CASE  WHEN NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)>=500 THEN 10  ELSE 0  END) net_pay 
from epay_payment_dtl
WHERE BATCH_NO IN (
select BATCH_NO from epay_payment_mst
where to_char(pay_date,'rrrrmm')='201901'--<='201905'
and org_bank_code='01'
)



select * from epay_payment_mst
where to_char(pay_date,'rrrrmm')<='201905'
and org_bank_code='01'





select to_char(pay_date,'rrrrmm') pay_month,sum(ROUND(NVL(ORG_PRN_AMOUNT,0))) PRN_AMOUNT,sum(ROUND(NVL(VAT_AMOUNT,0))) VAT_AMOUNT,sum(ROUND(NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0))) TOTAL_AMOUNT,
sum(ROUND(NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)))-sum(CASE  WHEN NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)>=500 THEN 10  ELSE 0  END) net_pay 
from epay_payment_dtl d, epay_payment_mst m
where m.BATCH_NO=d.BATCH_NO
and to_char(pay_date,'rrrrmm')='201712'--<='201905'
and org_bank_code='01'
group by to_char(pay_date,'rrrrmm')





select to_char(pay_date,'rrrrmm') pay_month,sum(ROUND(NVL(ORG_PRN_AMOUNT,0))) PRN_AMOUNT,sum(ROUND(NVL(VAT_AMOUNT,0))) VAT_AMOUNT,sum(ROUND(NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0))) TOTAL_AMOUNT,
SUM(CASE  WHEN NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)>=500 THEN 10  ELSE 0  END) rev_stamp,
sum(ROUND(NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)))-sum(CASE  WHEN NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)>=500 THEN 10  ELSE 0  END) net_pay 
from epay_payment_dtl d, epay_payment_mst m
where m.BATCH_NO=d.BATCH_NO
and pay_date between '01-jul-2017' and '15-jul-2017'
and org_bank_code='01'
group by to_char(pay_date,'rrrrmm')

---location wise

select m.ORG_BR_CODE ,sum(ROUND(NVL(ORG_PRN_AMOUNT,0))) PRN_AMOUNT,sum(ROUND(NVL(VAT_AMOUNT,0))) VAT_AMOUNT,sum(ROUND(NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0))) TOTAL_AMOUNT,
SUM(CASE  WHEN NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)>=500 THEN 10  ELSE 0  END) rev_stamp,
sum(ROUND(NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)))-sum(CASE  WHEN NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)>=500 THEN 10  ELSE 0  END) net_pay 
from epay_payment_dtl d, epay_payment_mst m
where m.BATCH_NO=d.BATCH_NO
and pay_date between '01-feb-2019' and '28-feb-2019' 
--and org_bank_code='01'
group by m.ORG_BR_CODE
order by 1




select sum(ROUND(NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0))) TOTAL_AMOUNT
from epay_payment_dtl d, epay_payment_mst m
where m.BATCH_NO=d.BATCH_NO
and pay_date between '01-jan-2019' and '31-jan-2019'
--and org_bank_code='01'
--group by m.ORG_BR_CODE
--order by 1

24588288

select LOCATION_CODE,sum(TOTAL_BILL) TOTAL_BILL from payment_dtl@wz
where TRANSACTION_DATE between '01-feb-2019' and '28-feb-2019'
GROUP BY LOCATION_CODE
ORDER BY 1



select TRANSACTION_DATE,sum(TOTAL_BILL) TOTAL_BILL from payment_dtl@wz
where TRANSACTION_DATE between '01-JAN-2019' and '31-JAN-2019'
GROUP BY TRANSACTION_DATE
ORDER BY 1



select * from payment_dtl@wz
where TRANSACTION_DATE between '01-feb-2019' and '28-feb-2019'






select SUM(CASE  WHEN NVL(ORG_PRN_AMOUNT,0)+NVL(VAT_AMOUNT,0)>=500 THEN 10  ELSE 0  END)
from epay_payment_dtl
WHERE BATCH_NO IN (
select BATCH_NO from epay_payment_mst
where to_char(pay_date,'rrrrmm')='201712'
and org_bank_code='01'
)




