

SELECT M.BATCH_NO,TO_CHAR (M.PAY_DATE, 'DD-MON-RRRR') PAY_DATE,B.EPAY_BANK_CODE||'-'||B.BANK_NAME BANK_NAME,
B.EPAY_BRANCH_CODE||'-'||B.BRANCH_NAME  BRANCH_NAME,B.LOCATION_CODE LOC_CODE,B.LOCATION_NAME  LOC_NAME,
DECODE (M.STATUS,'M', 'Error In Mst Int','N', 'Not Validation Mst Int','T', 'Transfer In BPDB',M.STATUS)AS status,
M.USER_NAME,SUM (NVL (d.PDB_AMOUNT, 0))AMT,SUM (NVL (D.GOVT_DUTY, 0)) VAT,COUNT (1)                         TOT_CONS
FROM EPAY_PAYMENT_DTL_INT      D,
EPAY_PAYMENT_MST_INT      M,
VW_1EPAY_BANK_BRANCHES_LIST b
WHERE     D.BATCH_NO = M.BATCH_NO
AND M.PAY_BANK_CODE = B.EPAY_BANK_CODE
AND M.PAY_BRANCH_CODE = B.EPAY_BRANCH_CODE
AND m.location_code = b.location_code
and m.location_code=upper('e1')
and M.PAY_DATE='09-MAY-2021'
GROUP BY M.BATCH_NO,M.PAY_DATE,B.EPAY_BANK_CODE,B.BANK_NAME,B.EPAY_BRANCH_CODE,
B.BRANCH_NAME,B.LOCATION_CODE,B.LOCATION_NAME,M.USER_NAME,
DECODE (M.STATUS,'M', 'Error In Mst Int','N', 'Not Validation Mst Int','T', 'Transfer To BPDB',M.STATUS)
ORDER BY M.PAY_DATE DESC

SELECT M.BATCH_NO,TO_CHAR (M.PAY_DATE, 'DD-MON-RRRR') PAY_DATE,B.EPAY_BANK_CODE||'-'||B.BANK_NAME BANK_NAME,
B.EPAY_BRANCH_CODE||'-'||B.BRANCH_NAME  BRANCH_NAME,B.LOCATION_CODE LOC_CODE,B.LOCATION_NAME  LOC_NAME,
DECODE (M.STATUS,'M', 'Error In Mst','N', 'Not Validation In Mst','T', 'Transfer To Billing',M.STATUS)AS status,
M.USER_NAME,SUM (NVL (d.PDB_AMOUNT, 0))AMT,SUM (NVL (D.GOVT_DUTY, 0)) VAT,COUNT (1)TOT_CONS
FROM EPAY_PAYMENT_DTL      D,
EPAY_PAYMENT_MST     M,
VW_1EPAY_BANK_BRANCHES_LIST b
WHERE     D.BATCH_NO = M.BATCH_NO
AND M.PAY_BANK_CODE = B.EPAY_BANK_CODE
AND M.PAY_BRANCH_CODE = B.EPAY_BRANCH_CODE
AND m.location_code = b.location_code
and m.location_code=upper('e1')
and M.PAY_DATE='09-MAY-2021'
GROUP BY M.BATCH_NO,M.PAY_DATE,B.EPAY_BANK_CODE||'-'||B.BANK_NAME ,
B.EPAY_BRANCH_CODE||'-'||B.BRANCH_NAME  ,B.LOCATION_CODE ,B.LOCATION_NAME  ,
DECODE (M.STATUS,'M','Error In Mst','N', 'Not Validation In Mst','T', 'Transfer To Billing',M.STATUS),
M.USER_NAME
ORDER BY M.PAY_DATE DESC







SELECT * FROM VW_1EPAY_BANK_PYMT_VALED_ALL


SELECT * FROM VW_1EPAY_BANK_PYMT_UNVALED

SELECT * FROM VW_1EPAY_BANK_PYMT_VALED_ALL
WHERE LOC='E1'
AND PAY_DATE='09-MAY-2021'