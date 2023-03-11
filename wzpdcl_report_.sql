
========================================= location Wise Summary Report========================

SELECT 
            L.LOCATION_CODE,
            L.LOCATION_NAME,
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
            L.LOCATION_CODE,
                L.LOCATION_NAME
     order by L.LOCATION_CODE


============================================== Bank Wise Summary Report =========================================

SELECT 
            B.BANK_NAME,
            BR.BRANCH_NAME,
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
                BR.BRANCH_NAME


===================================================Location Bank & Date wise summary Report ============================

SELECT
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
         M.PAY_DATE
         ORDER BY M.PAY_DATE ASC;


============================================================Location Date wise summary Report ===========================


            SELECT 
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
         M.PAY_DATE
         ORDER BY M.PAY_DATE ASC;


==================================================== Location & Bank wise summary report ====================================


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
         M.PAY_DATE;


======================================================== Location wise summary report =======================================

SELECT 
            L.LOCATION_CODE,
            L.LOCATION_NAME,
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
            L.LOCATION_CODE,
                L.LOCATION_NAME
     order by L.LOCATION_CODE


======================================================== Bank Date & Location wise summary report =================================


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
         M.PAY_DATE;


====================================================== Bank Date & Location wise summary report  20.24 NBL ====================================

SELECT  A.PAY_DATE,C.BANK_NAME,B.BRANCH_NAME,  D.LOCATION_CODE, D.LOCATION_NAME, COUNT(A.PAY_DATE) TOT_TRANS,SUM(PRN_AMOUNT) PRINCIPAL_AMT,
SUM(VAT_AMOUNT) VAT_AMT,SUM(TOTAL_AMOUNT) TOTAL_AMT,SUM(REV_STAMP_AMOUNT) REV_STAMP_AMT,
 SUM(TOTAL_AMOUNT)-SUM(REV_STAMP_AMOUNT) NET_AMT
 FROM EPAYONLINE.EPAY_PAYMENT_DTL_ONLINE_HIST A,EPAYONLINE.EPAY_BANK_BRANCH B,EPAYONLINE.EPAY_BANK_MST C, EPAY_LOCATION_MASTER D
 WHERE A.PAY_BANK_CODE=B.BANK_CODE
 AND A.PAY_BANK_BR_CODE=B.BRANCH_CODE
 AND A.ORG_BR_CODE = D.LOCATION_CODE
 AND A.PAY_BANK_CODE=C.BANK_CODE
 AND A.PAY_DATE BETWEEN :P_START_DATE AND :P_END_DATE
 AND A.PAY_BANK_CODE=:P_PAY_BANK_CODE
 AND A.ORG_CODE='WZPDCL'
 GROUP BY A.PAY_DATE,C.BANK_NAME,B.BRANCH_NAME, D.LOCATION_CODE, D.LOCATION_NAME
 ORDER BY TO_DATE(A.PAY_DATE), D.LOCATION_CODE