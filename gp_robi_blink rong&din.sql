  SELECT (SELECT ADDR_1 FROM EMPOWER_HOME@BILLING_RONG) AS CENTER_NAME,DECODE (M.BANK_CODE,
                 '77', 'Banglalink Phone Ltd',
                 '96', 'Grameen Phone Ltd',
                 '97', 'Axiata Bangladesh Ltd')
            OPERATOR_NAME,
         TO_CHAR (M.RECEIPT_DATE, 'rrrrmm') PAY_MONTH,
         SUM (NVL (RECEIPT_AMT, 0)) RECEIPT_AMT,
         SUM (NVL (VAT_AMT, 0)) VAT_AMT,
         SUM (NVL (RECEIPT_AMT, 0)) + SUM (NVL (VAT_AMT, 0))
            TOTAL_RECEIPT_AMOUNT,
         COUNT (1) TOTAL_TRANS
    FROM BC_RECEIPT_BATCH_HDR@BILLING_RONG M,
         BC_RECEIPT_HDR@BILLING_RONG D,
         BC_LOCATION_MASTER@BILLING_RONG L
   WHERE     M.BATCH_NUM = D.BATCH_NUM
         AND M.LOCATION_CODE = L.LOCATION_CODE
         AND M.BANK_CODE IN ('77', '96', '97')
         AND TO_CHAR (M.RECEIPT_DATE, 'rrrrmm') = '201602'
GROUP BY DECODE (M.BANK_CODE,
                 '77', 'Banglalink Phone Ltd',
                 '96', 'Grameen Phone Ltd',
                 '97', 'Axiata Bangladesh Ltd'),
         TO_CHAR (M.RECEIPT_DATE, 'rrrrmm')
         UNION
SELECT (SELECT ADDR_1 FROM EMPOWER_HOME@BILLING_DIN) AS CENTER_NAME,DECODE (M.BANK_CODE,
                 '77', 'Banglalink Phone Ltd',
                 '96', 'Grameen Phone Ltd',
                 '97', 'Axiata Bangladesh Ltd')
            OPERATOR_NAME,
         TO_CHAR (M.RECEIPT_DATE, 'rrrrmm') PAY_MONTH,
         SUM (NVL (RECEIPT_AMT, 0)) RECEIPT_AMT,
         SUM (NVL (VAT_AMT, 0)) VAT_AMT,
         SUM (NVL (RECEIPT_AMT, 0)) + SUM (NVL (VAT_AMT, 0))
            TOTAL_RECEIPT_AMOUNT,
         COUNT (1) TOTAL_TRANS
    FROM BC_RECEIPT_BATCH_HDR@BILLING_DIN M,
         BC_RECEIPT_HDR@BILLING_DIN D,
         BC_LOCATION_MASTER@BILLING_DIN L
   WHERE     M.BATCH_NUM = D.BATCH_NUM
         AND M.LOCATION_CODE = L.LOCATION_CODE
         AND M.BANK_CODE IN ('77', '96', '97')
         AND TO_CHAR (M.RECEIPT_DATE, 'rrrrmm') = '201602'
GROUP BY DECODE (M.BANK_CODE,
                 '77', 'Banglalink Phone Ltd',
                 '96', 'Grameen Phone Ltd',
                 '97', 'Axiata Bangladesh Ltd'),
         TO_CHAR (M.RECEIPT_DATE, 'rrrrmm')
                
ORDER BY 1