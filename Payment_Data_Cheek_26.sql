SELECT 
            B.BANK_NAME,
            BR.BRANCH_NAME,
            M.PAY_DATE,
            SUM (D.PRINCIPLE_AMOUNT) PRINCIPLE_AMOUNT,
            SUM (VAT_AMOUNT) VAT_AMOUNT,
            SUM (TOTAL_COLL_AMOUNT) TOTAL_COLL_AMOUNT,
            SUM (d.REV_STAMP_AMOUNT) REV_STAMP_AMOUNT,
            SUM (TOTAL_COLL_AMOUNT) - SUM (d.REV_STAMP_AMOUNT) net_amount,
            SUM (NO_OF_TRNS) NO_OF_TRNS
       FROM EPAY_PAYMENT_MST M,
            V_Z_C_C_L L,
            EPAY_BANKS B,
            EPAY_BANK_BRANCHES BR,
            (  SELECT BATCH_NO,
                      SUM (NVL (ORG_PRN_AMOUNT, 0)) PRINCIPLE_AMOUNT,
                      SUM (NVL (VAT_AMOUNT, 0)) VAT_AMOUNT,
                      SUM (NVL (ORG_PRN_AMOUNT, 0)) + SUM (NVL (VAT_AMOUNT, 0))
                         TOTAL_COLL_AMOUNT,
                      SUM (NVL (REV_STAMP_AMOUNT, 0)) REV_STAMP_AMOUNT,
                      COUNT (1) NO_OF_TRNS
                 FROM EPAY_PAYMENT_DTL
             GROUP BY BATCH_NO) D
      WHERE     M.ORG_BR_CODE = L.LOCATION_CODE
            AND M.ORG_BANK_CODE = B.BANK_CODE
            AND B.STATUS = 'A'
            AND B.BANK_CODE = BR.BANK_CODE
            AND M.ORG_BANK_CODE = BR.BANK_CODE
            AND M.ORG_BANK_BRANCH_CODE = BR.BRANCH_CODE
            AND M.BATCH_NO = D.BATCH_NO
  AND M.ORG_BR_CODE LIKE NVL(:P_ORG_BR_CODE,'%')
  AND M.PAY_DATE>=:P_START_DATE
  AND M.PAY_DATE<=:P_END_DATE
  AND M.ORG_BANK_CODE LIKE NVL(:P_BANK_CODE,'%')
   GROUP BY 
            B.BANK_NAME,
                BR.BRANCH_NAME,
         M.PAY_DATE
         order by    M.PAY_DATE;