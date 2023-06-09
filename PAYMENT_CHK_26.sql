--------50.2--------

SELECT COUNT(*) FROM EPAY_UTILITY_BILL@EPAY_WZPDCL
WHERE BILL_MONTH='201908'

--------20.26--------

SELECT COUNT(*) FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='201908'

--------20.24--------

SELECT COUNT(*) FROM EPAY_UTILITY_BILL@EPAY_SRL_24
WHERE BILL_MONTH='201908'
AND COMPANY_CODE='WZPDCL'








----------------------------------------

SELECT PAY_DATE PAY_DATE_24,COUNT(*) TOTAL_CONS_24 FROM EPAY_PAYMENT_MST@EPAY_SRL_24 M,EPAY_PAYMENT_DTL@EPAY_SRL_24 D
WHERE M.BATCH_NO=D.BATCH_NO
AND TO_CHAR(PAY_DATE,'RRRRMM')='201907'
AND ORG_CODE='WZPDCL'
GROUP BY PAY_DATE
ORDER by 1 desc


SELECT PAY_DATE PAY_DATE_26,COUNT(*) TOTAL_CONS_26 FROM EPAY_PAYMENT_MST M,EPAY_PAYMENT_DTL D
WHERE M.BATCH_NO=D.BATCH_NO
AND TO_CHAR(PAY_DATE,'RRRRMM')='201907'
GROUP BY PAY_DATE
ORDER by 1 desc


SELECT PAY_DATE PAY_DATE_26,COUNT(*) TOTAL_CONS_26 FROM EPAY_PAYMENT_MST@EPAY_WZPDCL M,EPAY_PAYMENT_DTL@EPAY_WZPDCL D
WHERE M.BATCH_NO=D.BATCH_NO
AND TO_CHAR(PAY_DATE,'RRRRMM')='201907'
GROUP BY PAY_DATE
ORDER by 1 desc



SELECT * FROM EPAY_PAYMENT_MST@EPAY_SRL_24
where status<>'T'
and org_code='WZPDCL' 