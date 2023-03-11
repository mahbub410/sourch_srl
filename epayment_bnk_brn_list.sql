

select * from epay_payment_mst_int

select b.BANK_NAME,c.BRANCH_NAME from epay_payment_mst_int a, EPAY_BANKS b,EPAY_BANK_BRANCHES c
where a.PAY_BANK_CODE=b.BANK_CODE
and a.PAY_BRANCH_CODE=c.BRANCH_CODE
and b.BANK_CODE = c.BANK_CODE
group by b.BANK_NAME,c.BRANCH_NAME
order by b.BANK_NAME

---------------api--23----------

SELECT A.ORG_CODE,
                       B.PC_NAME,
                       C.PC_BR_NAME
       FROM MBP_PAYMENT_DTL_OVC_HIST A,
            MBP_PAY_COLTR     B,
            MBP_PC_BRANCH     C
      WHERE     A.PAY_PC_CODE = B.PC_CODE
            AND A.PAY_PC_CODE = C.PC_CODE
            AND A.PAY_PC_BR_CODE = C.PC_BR_CODE
            AND B.PC_CODE = C.PC_CODE
            AND A.PAY_DATE IS NOT NULL
   GROUP BY A.ORG_CODE,
                       B.PC_NAME,
                       C.PC_BR_NAME
   ORDER BY 2 ASC
   
   
-----------------online--24-----------

select a.ORG_CODE,b.BANK_NAME,c.BRANCH_NAME from epayonline.EPAY_PAYMENT_DTL_ONLINE_HIST a,epayonline. EPAY_BANK_MST b,epayonline.EPAY_BANK_BRANCH c
where a.PAY_BANK_CODE=b.BANK_CODE
and a.PAY_BANK_BR_CODE=c.BRANCH_CODE
and b.BANK_CODE = c.BANK_CODE
group by a.ORG_CODE,b.BANK_NAME,c.BRANCH_NAME
order by b.BANK_NAME   
   
   