----------tot payment data trns chk srl to nesco billing

select a.STATUS,a.pay_date,a.TOT_CONS tot_srl,b.COLLECTION_DATE,b.TOT_CONS tot_billing,sum(a.TOT_CONS-b.TOT_CONS) tot_diff from (
select pay_date,count(*) TOT_CONS,decode(M.STATUS,'T','Transfer','N','UnTransfer') STATUS from epay_payment_mst@desco_nesco m,epay_payment_dtl@desco_nesco d
where m.batch_no=d.batch_no
and org_bank_code='94'
and org_code='NESCO'
AND TO_CHAR(PAY_DATE,'RRRRMM')='202108'
--(SELECT TO_CHAR (ADD_MONTHS (SYSDATE,0), 'RRRRMM')   FROM DUAL)
and org_br_code in (
select location_code from EPAY.EPAY_NESCO_LOC_MAP@DESCO_NESCO
)
group by pay_date,decode(M.STATUS,'T','Transfer','N','UnTransfer'))a,(
--order by 1 desc
select COLLECTION_DATE,COUNT(*) TOT_CONS from NEPAY.SRL_BILL_COLLECTION@BILLING_DESCO
WHERE TO_CHAR(COLLECTION_DATE,'RRRRMM')='202108'
AND BANK_CODE='BK'
GROUP BY COLLECTION_DATE)b
where a.pay_date=b.COLLECTION_DATE(+)
group by a.STATUS,a.pay_date,a.TOT_CONS,b.COLLECTION_DATE,b.TOT_CONS
ORDER BY 2 DESC



select COUNT(*) from epay.epay_utility_Bill@DESCO_NESCO
where bill_month='202103'
and company_code='NESCO'
and location_code in (
select location_code from EPAY.EPAY_NESCO_LOC_MAP@DESCO_NESCO
)

--1381438

--268834

SELECT COUNT(*)
FROM BILL_CALCULATION@BILLING_DESCO_NESCO_NEW B,
NEW_CONSUMER_INFORMATION@BILLING_DESCO_NESCO_NEW C,
BILL_COLLECTION@BILLING_DESCO_NESCO_NEW BC
WHERE B.ACCOUNT_NO=C.ACCOUNT_NO
AND B.BILL_NO=BC.BILL_NO
AND YEAR=SUBSTR(:P_Bill_Month,1,4)
AND MONTH=TO_NUMBER(SUBSTR(:P_Bill_Month,5,6))
AND B.IS_PDB='0'
AND BC.SRL_STATUS='0'
AND BC.IS_PDB='0'


select * from DESCOPST_RUN_LOG
where ORG_CODE='NESCO'
ORDER BY RUN_DATE DESC