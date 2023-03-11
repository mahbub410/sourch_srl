

     IF (P_LOCATION_CODE IS NULL OR P_BILL_NUM IS NULL) THEN
      
        v_Msg :='LOCATION_CODE OR BILL_NUM IS NULL';
      
     ELSE
      
        BEGIN
         
            SELECT BILLING_DBLINK INTO v_DbLink  FROM EPAY_LOCATION_MASTER
            WHERE LOCATION_CODE=P_LOCATION_CODE;
                
        EXCEPTION WHEN NO_DATA_FOUND THEN   
              
           v_DbLink:=NULL;
               
           v_Msg :='Location_Code Not Found';
               
        END;
      
     END IF;
     
     IF v_DbLink IS NOT NULL THEN
      
        BEGIN
           
           SELECT LOCATION_CODE INTO v_Location FROM EPAY_UTILITY_BILL
           WHERE LOCATION_CODE=P_LOCATION_CODE
           AND BILL_NUMBER =P_BILL_NUM;  

           
        EXCEPTION WHEN NO_DATA_FOUND THEN   
              
          v_Location:=NULL;
          
           v_Msg :='Data Not Found in EPAY_UTILITY_BILL'; 
        
       --END IF;
       
       IF v_Location IS NULL  THEN
        
         BEGIN
          
               EXECUTE IMMEDIATE
               'SELECT COUNT(*) FROM EPAY_UTILITY_BILL@'||v_Pdb_Link||'
               WHERE LOCATION_CODE ='''||P_LOCATION_CODE||'''
               AND  BILL_NUMBER ='''||P_BILL_NUM||'''' INTO v_Cnt;
               
             IF v_Cnt>0 THEN
           
                BEGIN
                 
                     EXECUTE IMMEDIATE
                    'INSERT INTO EPAY_UTILITY_BILL
                    SELECT COMPANY_CODE,ACCOUNT_NUMBER,BILL_NUMBER,
                    GENERATED_DATE,BILL_STATUS,BILL_DUE_DATE,
                    BILLAMT_AFTERDUEDATE,BILLENDDATE_FORPAYMENT,
                    CREATED_ON,CREATED_BY,MODIFIED_ON,MODIFIED_BY,
                    NOTIFICATION_SENT_STATUS,CURRENT_PRINCIPLE,
                    CURRENT_GOVT_DUTY,ARREAR_PRINCIPLE,
                    ARREAR_GOVT_DUTY,LATE_PAYMENT_SURCHARGE,
                    TOTAL_BILL_AMOUNT,LOCATION_CODE,BILL_MONTH,
                    TARIFF,CUSTOMER_TYPE,CURRENT_SURCHARGE,
                    ARREAR_SURCHARGE,ADJUSTED_PRINCIPLE,ADJUSTED_GOVT_DUTY,
                    ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY,''N'' DATA_TRANS_LOG 
                    FROM EPAY_UTILITY_BILL@'||v_Pdb_Link||'
                    WHERE LOCATION_CODE ='''||P_LOCATION_CODE||'''
                    AND  BILL_NUMBER ='''||P_BILL_NUM||'''';
                    
                    
                    COMMIT;

                 
                END ;
                
            ELSE
            
              BEGIN
              
                EXECUTE IMMEDIATE
                'INSERT INTO EPAY_UTILITY_BILL
                SELECT ''BPDB'' AS COMPANY_CODE, 
                CUSTOMER_NUM||CONS_CHK_DIGIT AS ACCOUNT_NUMBER, 
                INVOICE_NUM||INVOICE_CHK_DGT BILL_NUMBER, 
                INVOICE_DATE GENERATED_DATE, 
                ''N'' BILL_STATUS, 
                INVOICE_DUE_DATE BILL_DUE_DATE, 
                NULL BILLAMT_AFTERDUEDATE, 
                INVOICE_DUE_DATE BILLENDDATE_FORPAYMENT, 
                SYSDATE CREATED_ON    , 
                USER CREATED_BY   , 
                NULL  MODIFIED_ON , 
                NULL MODIFIED_BY, 
                ''N'' NOTIFICATION_SENT_STATUS, 
                (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+ 
                NVL(DEMAND_CHRG,0)+NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)+NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+
                NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)) CURRENT_PRINCIPLE, 
                NVL(CURRENT_VAT,0) CURRENT_GOVT_DUTY, 
                NVL(ARR_ADV_ADJ_PRN,0)  ARREAR_PRINCIPLE, 
                NVL(ARR_ADV_ADJ_VAT,0) ARREAR_GOVT_DUTY, 
                0 LATE_PAYMENT_SURCHARGE, 
                NVL(TOTAL_BILL,0) TOTAL_BILL_AMOUNT, 
                LOCATION_CODE, 
                BILL_CYCLE_CODE BILL_MONTH, 
                TARIFF, CUST_STATUS CUSTOMER_TYPE, 
                NVL(CURRENT_LPS,0) CURRENT_SURCHARGE, 
                NVL(ARR_ADV_ADJ_LPS,0) ARREAR_SURCHARGE, 
                NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0) ADJUSTED_PRINCIPLE, 
                NVL(ADJUSTED_VAT,0) ADJUSTED_GOVT_DUTY, 
                0  ADVANCE_AMOUNT,0 ADJ_ADV_GOVT_DUTY,''T'' DATA_TRANS_LOG
                FROM  BC_BILL_IMAGE@'||v_DbLink||'
                WHERE LOCATION_CODE=UPPER('''||P_LOCATION_CODE||''')
                AND INVOICE_NUM='''||SUBSTR(P_BILL_NUM,1,9)||'''';
            
            
              COMMIT;
              
              
              END ;    
           
               
          
           v_Msg :='Successfully Completed1!';
        
         END IF;
            
     
     RETURN (v_Msg);
     
EXCEPTION WHEN OTHERS THEN ROLLBACK;

    v_Msg:=SUBSTR(SQLERRM,1,500);
    
    RETURN (v_Msg);     