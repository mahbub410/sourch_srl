
SELECT * FROM EPAY_PAYMENT_MST@EPAY_SRL D

SELECT M.PAY_DATE,
            L.CENTER_NAME,
            B.BANK_CODE,
            B.ONLINE_OPT_DESCR,
            M.BATCH_NO,
            M.ORG_BR_CODE LOCATION_CODE,
            INITCAP (
               DECODE (M.STATUS,
                       'A', 'Not Reconciled',
                       'M', 'Reconciled Error',
                       'N', 'Reconciled Process Runing',
                       'P', 'Not Import'))
               FLAG_DESC,
            SUM (NVL (D.ORG_PRN_AMOUNT, 0))                      AMT,
            SUM (NVL (D.VAT_AMOUNT, 0))                       VAT,
            SUM (NVL (D.ORG_PRN_AMOUNT, 0) + NVL (D.VAT_AMOUNT, 0)) TOT_AMT,
            COUNT (1)                                        TOT_TRNS
       FROM EPAY_PAYMENT_MST@EPAY_SRL M,
            EPAY_PAYMENT_DTL@EPAY_SRL D,
            EPAY_LOCATION_MASTER  L,
            EPAY_ONLINE_OPERATOR  B
      WHERE     M.BATCH_NO = D.BATCH_NO
            AND M.ORG_BR_CODE = L.LOCATION_CODE
            AND B.BANK_CODE = '94'
            AND M.ORG_CODE='BPDB'
            AND M.ORG_BR_CODE IN
                   (SELECT LOCATION_CODE
                      FROM EPAY_LOC_ONLINE_OPT_MAP
                     WHERE LOCATION_CODE IN (SELECT LOCATION_CODE
                                               FROM EPAY_ZONE_COMP_CNTR_LOC --WHERE ZONE_CODE IN ('4', '5', '3', '6', '7')
                                                                           ))
            AND M.STATUS NOT IN ('T')
   GROUP BY L.CENTER_NAME,
            B.BANK_CODE,
            B.ONLINE_OPT_DESCR,
            M.BATCH_NO,
            M.ORG_BR_CODE,
            M.PAY_DATE,
            M.STATUS
   ORDER BY M.PAY_DATE ASC, M.ORG_BR_CODE ASC, L.CENTER_NAME ASC;