SELECT  LOCATION_CODE,    
                         ,SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0))) BILLED_AMOUNT,
                         SUM(NVL(I.CURRENT_VAT,0)) vat_amt  FROM BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    group by LOCATION_CODE
    
    
    
    SELECT LOCATION_CODE,   sum(RECEIPT_AMT) RECEIPT_AMT,sum(VAT_AMT) VAT_AMT from bc_receipt_hdr
    where RECEIPT_TYPE_CODE='REC'
    and RECEIPT_DATE between '01-oct-2016' and '30-jun-2018' 
    group by LOCATION_CODE
    
    
    

SELECT  LOCATION_CODE,    
                         ,SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0))) BILLED_AMOUNT,
                         SUM(NVL(I.CURRENT_VAT,0)) vat_amt  FROM BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUSTOMER_NUM NOT IN (SELECT GOVT_CUST_NUM FROM BC_REBATE_CUSTOMERS)
    group by LOCATION_CODE
    
    
    
    SELECT LOCATION_CODE,   sum(RECEIPT_AMT) RECEIPT_AMT,sum(VAT_AMT) VAT_AMT from bc_receipt_hdr
    where RECEIPT_TYPE_CODE='REC'
    and RECEIPT_DATE between '01-oct-2016' and '30-jun-2018' 
     AND CUST_NUM NOT IN (SELECT GOVT_CUST_NUM FROM BC_REBATE_CUSTOMERS)
    group by LOCATION_CODE
    
    
    SELECT A.BILLED_AMOUNT,A.BILL_vat_amt,B.RECEIPT_AMT,B.REC_VAT_AMT FROM(
SELECT      
                         SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0))) BILLED_AMOUNT,
                         SUM(NVL(CURRENT_VAT,0)) BILL_vat_amt  FROM BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806')A,(
    SELECT    sum(RECEIPT_AMT+VAT_AMT) RECEIPT_AMT,sum(VAT_AMT) REC_VAT_AMT from bc_receipt_hdr
    where RECEIPT_TYPE_CODE='REC'
    and RECEIPT_DATE between '01-oct-2016' and '30-jun-2018')B