
  SELECT b.*,c.*
        FROM epay_utility_bill b,EPAY_CUSTOMER_MASTER_DATA c
          WHERE b.account_number=c.account_no
          AND b.COMPANY_CODE=c.COMPANY_CODE
          AND b.location_code=c.location_code
--          and b.account_number = vnm_account_number
            AND b.bill_month = :vnm_bill_month
            AND b.location_code = :vnm_location_code
            AND b.COMPANY_CODE=UPPER(:vnm_ORG_CODE);
            
            SELECT c.*  FROM EPAY_BANKS@EPAY_SRL_DCC B,
                                      EPAY_BANKS_MAP@EPAY_SRL_DCC BM,
                                      EPAY_BANK_BRANCHES@EPAY_SRL_DCC BR,
                                      EPAY_CUSTOMER_BANK@EPAY_SRL_DCC C,
                                      EPAY_ACCOUNTID_GLCODE_MAP@EPAY_SRL_DCC L
        WHERE B.BANK_CODE='14'
        AND B.BANK_CODE=BM.BANK_CODE
        AND B.BANK_CODE=BR.BANK_CODE
        AND C.BANK_CODE=BR.BILLING_BANK_CODE
        AND C.BRANCH_CODE=BR.BILLING_BRANCH_CODE
        AND C.EXP_DATE IS NULL
        AND C.BANK_CODE=L.BANK_CODE
        AND C.BRANCH_CODE=L.BRANCH_CODE
        AND L.LOCATION_CODE=:vnm_location_code
        AND C.COMPANY_CODE=UPPER(:vnm_ORG_CODE)
        and  c.ACCOUNT_NO in (
         SELECT b.account_number
        FROM epay_utility_bill b,EPAY_CUSTOMER_MASTER_DATA c
          WHERE b.account_number=c.account_no
          AND b.COMPANY_CODE=c.COMPANY_CODE
          AND b.location_code=c.location_code
--          and b.account_number = vnm_account_number
            AND b.bill_month = :vnm_bill_month
            AND b.location_code = :vnm_location_code
            AND b.COMPANY_CODE=UPPER(:vnm_ORG_CODE));
        
         select * from EPAY_CUSTOMER_BANK@EPAY_SRL_DCC C
         where bank_code='14'
         
         select * from EPAY_ACCOUNTID_GLCODE_MAP@EPAY_SRL_DCC L
         where bank_code='14'
         
          select * from EPAY_CUSTOMER_BANK@EPAY_SRL_DCC C where C.ACCOUNT_NO=:vnm_account_number
         
         SELECT b.location_code, account_number,c.NAME as customer_name, bill_number, bill_due_date,
         
         delete from EPAY_CUSTOMER_BANK@EPAY_SRL_DCC C
         where (BANK_CODE, BRANCH_CODE, ACCOUNT_NO) in (
          select BANK_CODE, BRANCH_CODE, ACCOUNT_NO from EPAY_CUSTOMER_BANK@EPAY_SRL_DCC C --where C.ACCOUNT_NO=:vnm_account_number
          group by BANK_CODE, BRANCH_CODE, ACCOUNT_NO
          having count(1)>1)
         
         
         DELETE FROM EPAY_CUSTOMER_BANK@EPAY_SRL_DCC 
WHERE ROWID IN (
SELECT ROWID FROM EPAY_CUSTOMER_BANK@EPAY_SRL_DCC 
MINUS
SELECT MAX(ROWID) FROM EPAY_CUSTOMER_BANK@EPAY_SRL_DCC 
GROUP BY BANK_CODE, BRANCH_CODE, ACCOUNT_NO);


                bill_status,
                
        --nvl(nvl(CURRENT_PRINCIPLE,0)+nvl(ARREAR_PRINCIPLE,0)+nvl(LATE_PAYMENT_SURCHARGE,0)+nvl(CURRENT_SURCHARGE,0)+nvl(ARREAR_SURCHARGE,0)+nvl(ADJUSTED_PRINCIPLE,0),0) TOTAL_DPDC_AMOUNT,
                NVL (  NVL (total_bill_amount, 0)
                     - NVL (  NVL (current_govt_duty, 0)
                            + NVL (arrear_govt_duty, 0)
                            + NVL (adjusted_govt_duty, 0),
                            0
                           ),
                     0
                    ) total_dpdc_amount,
                NVL (  NVL (current_govt_duty, 0)
                     + NVL (arrear_govt_duty, 0)
                     + NVL (adjusted_govt_duty, 0),
                     0
                    ) vat_amount,
                total_bill_amount, billamt_afterduedate
           FROM epay_utility_bill b,EPAY_CUSTOMER_MASTER_DATA c
          WHERE b.account_number=c.account_no
          AND b.COMPANY_CODE=c.COMPANY_CODE
          AND b.location_code=c.location_code
          and b.account_number = vnm_account_number
            AND b.bill_month = vnm_bill_month
            AND b.location_code = vnm_location_code
            AND b.COMPANY_CODE=UPPER(vnm_ORG_CODE);