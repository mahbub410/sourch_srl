

SELECT M.BATCH_NO,
            TO_CHAR (M.PAY_DATE, 'DD-MON-RRRR')                    PAY_DATE,
            B.EPAY_BANK_CODE || '-' || B.BANK_NAME                 BANK_NAME,
            B.EPAY_BRANCH_CODE || '-' || B.BRANCH_NAME             BRANCH_NAME,
            B.LOCATION_CODE                                        loc,
            B.LOCATION_NAME                                        LOC_NAME,
            --M.USER_NAME,
            DECODE (M.STATUS,  'M', 'Error',  'N', 'Not Validation','T', 'Transfer BPDB') AS status,
            SUM (NVL (d.PDB_AMOUNT, 0))                            AMT,
            SUM (NVL (D.GOVT_DUTY, 0))                             VAT,
            COUNT (1)                                              TOT_CONS
       FROM EPAY_PAYMENT_DTL_INT      D,
            EPAY_PAYMENT_MST_INT      M,
            VW_1EPAY_BANK_BRANCHES_LIST b
      WHERE     D.BATCH_NO = M.BATCH_NO
            --AND M.STATUS <> 'T'
            AND M.PAY_BANK_CODE = B.EPAY_BANK_CODE
            AND M.PAY_BRANCH_CODE = B.EPAY_BRANCH_CODE
            AND m.location_code = b.location_code
            and M.LOCATION_CODE=UPPER(:p_location_code)
            and M.PAY_DATE between '01-dec-2019' and '31-dec-2019' --=:p_paydate
            and M.PAY_BANK_CODE='30'
   GROUP BY M.BATCH_NO,
            TO_CHAR (M.PAY_DATE, 'DD-MON-RRRR'),
            B.EPAY_BANK_CODE,
            B.BANK_NAME,
            B.EPAY_BRANCH_CODE,
            B.BRANCH_NAME,
            B.LOCATION_CODE,
            B.LOCATION_NAME,
            --M.USER_NAME,
            DECODE (M.STATUS,  'M', 'Error',  'N', 'Not Validation','T', 'Transfer BPDB')
   ORDER BY TO_CHAR (M.PAY_DATE, 'DD-MON-RRRR') ASC;