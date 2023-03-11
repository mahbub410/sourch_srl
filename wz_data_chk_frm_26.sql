


SELECT COUNT(*) FROM EPAY_UTILITY_BILL@EPAY_WZPDCL
where  BILL_MONTH='201905'

SELECT COUNT(*) FROM EPAY_UTILITY_BILL
where  BILL_MONTH='201905'

SELECT COUNT(*) FROM EPAY_UTILITY_BILL@EPAY_SRL_24
where  BILL_MONTH='201905'
and COMPANY_CODE='WZPDCL'


-------------payment chk-----------

16562

select count(*) from epay_payment_dtl@EPAY_SRL_24
where batch_no in (
select batch_no from epay_payment_mst@EPAY_SRL_24
where TO_CHAR(PAY_DATE,'RRRRMM')='201906'
and org_code='WZPDCL'
)

16562

select count(*) from epay_payment_dtl
where batch_no in (
select batch_no from epay_payment_mst
where  TO_CHAR(PAY_DATE,'RRRRMM')='201906'
and org_code='WZPDCL'
)

16562

select count(*) from epay_payment_dtl@EPAY_WZPDCL
where batch_no in (
select batch_no from epay_payment_mst@EPAY_WZPDCL
where  TO_CHAR(PAY_DATE,'RRRRMM')='201906'
and org_code='WZPDCL'
)

select STATUS,COUNT(*) from epay_payment_mst@EPAY_SRL_24
where org_code='WZPDCL'
AND STATUS<>'T'
GROUP BY STATUS