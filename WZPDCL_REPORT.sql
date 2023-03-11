01	National Bank Ltd
03	Mercantile Bank Ltd
04	NRB Bank Ltd
05	Trust Bank Ltd.
400	Dutch Bangla Bank Limited

SELECT PM.ORG_CODE,B.BANK_CODE,B.BANK_NAME,L.LOCATION_CODE,L.LOCATION_NAME,SUM(PD.ORG_PRN_AMOUNT) PRN_AMOUNT,SUM(PD.VAT_AMOUNT),
SUM(PD.ORG_PRN_AMOUNT+PD.VAT_AMOUNT) TOTAL_AMOUNT,COUNT(*) TOTAL_CON
FROM EPAY_PAYMENT_MST PM,EPAY_PAYMENT_DTL PD,EPAY_BANKS B,EPAY_LOCATION_MASTER L
WHERE PM.BATCH_NO=PD.BATCH_NO
AND PM.ORG_BR_CODE=L.LOCATION_CODE
AND PM.ORG_BANK_CODE=B.BANK_CODE
--AND PM.ORG_BANK_CODE='03'
AND PAY_DATE BETWEEN '01-MAY-2019' AND '31-MAY-2019'
AND ORG_CODE='WZPDCL'
GROUP BY PM.ORG_CODE,B.BANK_CODE,B.BANK_NAME,L.LOCATION_CODE,L.LOCATION_NAME




SELECT M.PAY_DATE,COUNT(*),SUM(D.ORG_PRN_AMOUNT+D.VAT_AMOUNT) TOTAL FROM EPAY_PAYMENT_MST M,EPAY_PAYMENT_DTL D
WHERE M.BATCH_NO=D.BATCH_NO
AND M.PAY_DATE BETWEEN '01-MAY-2019' AND '31-MAY-2019'
AND M.ORG_CODE='WZPDCL'
AND M.ORG_BANK_CODE='03'
GROUP BY M.PAY_DATE
ORDER BY 1


SELECT * FROM EPAY_PAYMENT_MST@EPAY_SRL_24
WHERE ORG_CODE='WZPDCL'
AND PAY_DATE BETWEEN '01-MAY-2019' AND '31-MAY-2019'
AND STATUS<>'T'
ORDER BY PAY_DATE DESC













SELECT PM.ORG_CODE,TO_CHAR(PM.PAY_DATE,'YYYYMM') PAY_MONTH,B.BANK_CODE,B.BANK_NAME,SUM(PD.ORG_PRN_AMOUNT) PRN_AMOUNT,SUM(PD.VAT_AMOUNT),
SUM(PD.ORG_PRN_AMOUNT+PD.VAT_AMOUNT) TOTAL_AMOUNT,COUNT(*) TOTAL_CON
FROM EPAY_PAYMENT_MST PM,EPAY_PAYMENT_DTL PD,EPAY_BANKS B,EPAY_LOCATION_MASTER L
WHERE PM.BATCH_NO=PD.BATCH_NO
AND PM.ORG_BR_CODE=L.LOCATION_CODE
AND PM.ORG_BANK_CODE=B.BANK_CODE
AND PAY_DATE BETWEEN '01-SEP-2017' AND '30-SEP-2017'
AND ORG_CODE='WZPDCL'
GROUP BY PM.ORG_CODE,TO_CHAR(PM.PAY_DATE,'YYYYMM'),B.BANK_CODE,B.BANK_NAME




SELECT * FROM EPAY_PAYMENT_MST
WHERE PAY_DATE BETWEEN '01-SEP-2017' AND '30-SEP-2017'
AND ORG_CODE='WZPDCL'



SELECT * FROM EPAY_PAYMENT_MST@EPAY_SRL_24
WHERE PAY_DATE BETWEEN '01-SEP-2017' AND '30-SEP-2017'
AND ORG_CODE='WZPDCL'


SELECT * FROM EPAY_PAYMENT_MST@EPAY_WZPDCL
WHERE PAY_DATE BETWEEN '01-SEP-2017' AND '30-SEP-2017'
AND ORG_CODE='WZPDCL'