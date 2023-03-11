
select * from bc_bill_image

select * from bc_receipt_hdr

    SELECT A.TOT_BILLED_AMOUNT,B.TOT_RECEIPT_AMT FROM(
SELECT      
                         SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)))+SUM(NVL(CURRENT_VAT,0)) TOT_BILLED_AMOUNT  FROM BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='05')A,(
    SELECT    SUM(RECEIPT_AMT+VAT_AMT) +SUM(VAT_AMT) TOT_RECEIPT_AMT FROM BC_RECEIPT_HDR
    WHERE RECEIPT_TYPE_CODE='REC'
    AND RECEIPT_DATE BETWEEN '01-oct-2016' AND '30-jun-2018'
    AND CUST_ID IN (SELECT CUST_ID FROM BC_BILL_IMAGE  WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='05'))B
    
    
    
    
     SELECT A.BILL_MONTH,A.TOT_BILLED_AMOUNT,B.TOT_RECEIPT_AMT FROM(
SELECT              BILL_CYCLE_CODE BILL_MONTH,
                         SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)))+SUM(NVL(CURRENT_VAT,0)) TOT_BILLED_AMOUNT  FROM BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='05'
    GROUP BY BILL_CYCLE_CODE)A,(
    SELECT   TO_CHAR(RECEIPT_DATE,'RRRRMM') REC_MONTH, SUM(RECEIPT_AMT+VAT_AMT) +SUM(VAT_AMT) TOT_RECEIPT_AMT FROM BC_RECEIPT_HDR
    WHERE RECEIPT_TYPE_CODE='REC'
    AND RECEIPT_DATE BETWEEN '01-oct-2016' AND '30-jun-2018'
    AND CUST_ID IN (SELECT CUST_ID FROM BC_BILL_IMAGE  WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='05')
    GROUP BY TO_CHAR(RECEIPT_DATE,'RRRRMM'))B
    WHERE A.BILL_MONTH=B.REC_MONTH
    ORDER BY 1
    
    ----------------------------------------------------------
    
    
    
--1-----PRIVATE--------

     SELECT A.TOT_BILLED_AMOUNT,B.TOT_RECEIPT_AMT FROM(
SELECT      
                         SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)))+SUM(NVL(CURRENT_VAT,0)) TOT_BILLED_AMOUNT  FROM EBC.BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='05')A,(
    SELECT    SUM(NVL(RECEIPT_AMT,0)+NVL(VAT_AMT,0)) TOT_RECEIPT_AMT FROM EBC.BC_RECEIPT_HDR
    WHERE RECEIPT_TYPE_CODE='REC'
    AND RECEIPT_DATE BETWEEN '01-OCT-2016' AND '30-JUN-2018'
    AND CUST_ID IN (SELECT CUST_ID FROM EBC.BC_BILL_IMAGE  WHERE  BILL_CYCLE_CODE BETWEEN '201610' AND '201806' AND CUST_STATUS='05')
    )B
    
    
--2----- PRIVATE-----month--wise-------   
    
     SELECT A.BILL_MONTH,A.TOT_BILLED_AMOUNT,B.TOT_RECEIPT_AMT FROM(
SELECT              BILL_CYCLE_CODE BILL_MONTH,
                         SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)))+SUM(NVL(CURRENT_VAT,0)) TOT_BILLED_AMOUNT  FROM EBC.BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='05'
    GROUP BY BILL_CYCLE_CODE)A,(
    SELECT   TO_CHAR(RECEIPT_DATE,'RRRRMM') REC_MONTH, SUM(NVL(RECEIPT_AMT,0)+NVL(VAT_AMT,0)) TOT_RECEIPT_AMT FROM EBC.BC_RECEIPT_HDR
    WHERE RECEIPT_TYPE_CODE='REC'
    AND RECEIPT_DATE BETWEEN '01-OCT-2016' AND '30-JUN-2018'
     AND CUST_ID IN (SELECT CUST_ID FROM EBC.BC_BILL_IMAGE  WHERE  BILL_CYCLE_CODE BETWEEN '201610' AND '201806' AND CUST_STATUS='05')
    GROUP BY TO_CHAR(RECEIPT_DATE,'RRRRMM'))B
    WHERE A.BILL_MONTH=B.REC_MONTH
    ORDER BY 1
    
    
----3----- SORKARI--------

    SELECT A.TOT_BILLED_AMOUNT,B.TOT_RECEIPT_AMT FROM(
SELECT      
                         SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)))+SUM(NVL(CURRENT_VAT,0)) TOT_BILLED_AMOUNT  FROM EBC.BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='01')A,(
    SELECT    SUM(NVL(RECEIPT_AMT,0)+NVL(VAT_AMT,0)) TOT_RECEIPT_AMT FROM EBC.BC_RECEIPT_HDR
    WHERE RECEIPT_TYPE_CODE='REC'
    AND RECEIPT_DATE BETWEEN '01-OCT-2016' AND '30-JUN-2018'
    AND CUST_ID IN (SELECT CUST_ID FROM EBC.BC_BILL_IMAGE  WHERE  BILL_CYCLE_CODE BETWEEN '201610' AND '201806' AND CUST_STATUS='01')
    )B
    
    
--4----- SORKARI-----month--wise-------   
    
     SELECT A.BILL_MONTH,A.TOT_BILLED_AMOUNT,B.TOT_RECEIPT_AMT FROM(
SELECT              BILL_CYCLE_CODE BILL_MONTH,
                         SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)))+SUM(NVL(CURRENT_VAT,0)) TOT_BILLED_AMOUNT  FROM EBC.BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='01'
    GROUP BY BILL_CYCLE_CODE)A,(
    SELECT   TO_CHAR(RECEIPT_DATE,'RRRRMM') REC_MONTH, SUM(NVL(RECEIPT_AMT,0)+NVL(VAT_AMT,0)) TOT_RECEIPT_AMT FROM EBC.BC_RECEIPT_HDR
    WHERE RECEIPT_TYPE_CODE='REC'
    AND RECEIPT_DATE BETWEEN '01-OCT-2016' AND '30-JUN-2018'
    AND CUST_ID IN (SELECT CUST_ID FROM EBC.BC_BILL_IMAGE  WHERE  BILL_CYCLE_CODE BETWEEN '201610' AND '201806' AND CUST_STATUS='01')
    GROUP BY TO_CHAR(RECEIPT_DATE,'RRRRMM'))B
    WHERE A.BILL_MONTH=B.REC_MONTH
    ORDER BY 1
    
    
----5-----UADA SORKARI--------

    SELECT A.TOT_BILLED_AMOUNT,B.TOT_RECEIPT_AMT FROM(
SELECT      
                         SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)))+SUM(NVL(CURRENT_VAT,0)) TOT_BILLED_AMOUNT  FROM EBC.BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='02')A,(
    SELECT    SUM(NVL(RECEIPT_AMT,0)+NVL(VAT_AMT,0)) TOT_RECEIPT_AMT FROM EBC.BC_RECEIPT_HDR
    WHERE RECEIPT_TYPE_CODE='REC'
    AND RECEIPT_DATE BETWEEN '01-OCT-2016' AND '30-JUN-2018'
   AND CUST_ID IN (SELECT CUST_ID FROM EBC.BC_BILL_IMAGE  WHERE  BILL_CYCLE_CODE BETWEEN '201610' AND '201806' AND CUST_STATUS='02')
    )B
    
    
--6-----UADA SORKARI-----month--wise-------   
    
     SELECT A.BILL_MONTH,A.TOT_BILLED_AMOUNT,B.TOT_RECEIPT_AMT FROM(
SELECT              BILL_CYCLE_CODE BILL_MONTH,
                         SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
                         + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)+NVL(MINIMUM_CHRG,0) 
                         + NVL(SERVICE_CHRG,0)+ NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)+ NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)))+SUM(NVL(CURRENT_VAT,0)) TOT_BILLED_AMOUNT  FROM EBC.BC_BILL_IMAGE
    WHERE BILL_CYCLE_CODE BETWEEN '201610' AND '201806'
    AND CUST_STATUS='02'
    GROUP BY BILL_CYCLE_CODE)A,(
    SELECT   TO_CHAR(RECEIPT_DATE,'RRRRMM') REC_MONTH, SUM(NVL(RECEIPT_AMT,0)+NVL(VAT_AMT,0)) TOT_RECEIPT_AMT FROM EBC.BC_RECEIPT_HDR
    WHERE RECEIPT_TYPE_CODE='REC'
    AND RECEIPT_DATE BETWEEN '01-OCT-2016' AND '30-JUN-2018'
    AND CUST_ID IN (SELECT CUST_ID FROM EBC.BC_BILL_IMAGE  WHERE  BILL_CYCLE_CODE BETWEEN '201610' AND '201806' AND CUST_STATUS='02')
    GROUP BY TO_CHAR(RECEIPT_DATE,'RRRRMM'))B
    WHERE A.BILL_MONTH=B.REC_MONTH
    ORDER BY 1