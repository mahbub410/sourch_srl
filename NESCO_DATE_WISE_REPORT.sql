
SELECT PAY_DATE,SUM(ORG_PRN_AMOUNT) ORG_PRN_AMOUNT,SUM(VAT_AMOUNT) VAT_AMOUNT,SUM(ORG_PRN_AMOUNT+VAT_AMOUNT) TOTAL_AMOUNT,COUNT(*) TOT_CONS
FROM EPAY_PAYMENT_MST M,EPAY_PAYMENT_DTL D
WHERE M.BATCH_NO=D.BATCH_NO 
AND M.ORG_BANK_CODE='94'
AND M.ORG_CODE='NESCO'
AND M.PAY_DATE BETWEEN '01-AUG-2019' AND '31-AUG-2019'
GROUP BY PAY_DATE
ORDER BY 1

and M.ORG_BR_CODE in (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER
WHERE BILLING_DBLINK='BILLING_NAO')
GROUP BY PAY_DATE
ORDER BY 1

order by PAY_DATE

SELECT * FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='201808'
AND ACCOUNT_NUMBER in ('303152159','303152132','303152159','303120177')