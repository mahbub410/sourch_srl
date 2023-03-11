CREATE OR REPLACE FUNCTION EPAY.MYM_TAN_ERROR_SLV(P_BATCH_NO VARCHAR2,P_LOCATION_CODE VARCHAR2) RETURN VARCHAR2 AS

v_Msg VARCHAR2(500);
v_DbLink VARCHAR2(30);
v_ExisData NUMBER;
v_Dtl_Bill_No VARCHAR2(20);
v_Uti_Bill_No VARCHAR2(20);
----v_Pdb_Link VARCHAR2(20):='EPAY_DCC';
v_Bill_Month VARCHAR2(8);
v_Bill_Count NUMBER;
v_Dtl_Count NUMBER;
v_ip VARCHAR2(20);
v_Host VARCHAR2(100);
v_user VARCHAR2(100);

    PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN

    select SYS_CONTEXT('USERENV', 'IP_ADDRESS', 20) into v_ip from dual;
    
    select SYS_CONTEXT('USERENV', 'HOST', 20) into v_Host from dual;
        
    select sys_context( 'userenv', 'os_user' ) into v_user from dual;
    
    SELECT TO_CHAR (ADD_MONTHS (PAY_DATE, -1), 'RRRRMM') INTO V_BILL_MONTH FROM EPAY_PAYMENT_MST
    WHERE BATCH_NO=P_BATCH_NO
    AND ORG_BR_CODE=P_LOCATION_CODE;

    SELECT TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'RRRRMM') INTO v_Bill_Month FROM DUAL ;
    
    SELECT BILLING_DBLINK into v_DbLink FROM EPAY_LOCATION_MASTER WHERE LOCATION_CODE=P_LOCATION_CODE;
    

    ---payment data count----
    
    SELECT COUNT(*) into v_Dtl_Count FROM EPAY_PAYMENT_DTL
    WHERE BATCH_NO IN (
    SELECT BATCH_NO FROM EPAY_PAYMENT_MST
    WHERE BATCH_NO=P_BATCH_NO 
    AND ORG_BR_CODE=P_LOCATION_CODE
    AND ORG_CODE='BPDB'
    AND STATUS='M');
    
    ---bill data count----
    
    SELECT COUNT(*) INTO v_Bill_Count FROM EPAY_UTILITY_bILL
    WHERE BILL_MONTH=v_Bill_Month
    AND (ACCOUNT_NUMBER,BILL_NUMBER) IN (
    SELECT ACCOUNT_NUMBER,BILL_NUMBER FROM EPAY_PAYMENT_DTL
    WHERE BATCH_NO IN (
    SELECT BATCH_NO FROM EPAY_PAYMENT_MST
    WHERE BATCH_NO=P_BATCH_NO 
    AND ORG_BR_CODE=P_LOCATION_CODE
    AND ORG_CODE='BPDB'
    AND STATUS='M')
    )
    AND LOCATION_CODE=P_LOCATION_CODE;
    
    IF v_Dtl_Count<>v_Bill_Count THEN
    
        INSERT INTO EPAY_PAYMENT_DTL_250419  /* EPAY_PAYMENT_DTL_250419 backup table*/
        SELECT * FROM EPAY_PAYMENT_DTL
        WHERE BATCH_NO IN (
        SELECT BATCH_NO FROM EPAY_PAYMENT_MST
        WHERE BATCH_NO=P_BATCH_NO 
        AND ORG_BR_CODE=P_LOCATION_CODE
        AND ORG_CODE='BPDB');

        INSERT INTO EPAY_PAYMENT_MST_250419  /* EPAY_PAYMENT_MST_250419 backup table*/
        SELECT * FROM EPAY_PAYMENT_MST
        WHERE BATCH_NO=P_BATCH_NO
        AND ORG_BR_CODE=P_LOCATION_CODE
        AND ORG_CODE='BPDB';
    
    
        DELETE FROM EPAY_UTILITY_BILL_SUP;
    
        COMMIT;

        /* Missing Account & Billnumer List*/

    FOR L1 IN (
        SELECT ACCOUNT_NUMBER,BILL_NUMBER  FROM EPAY_PAYMENT_DTL
        WHERE BATCH_NO IN (
        SELECT BATCH_NO FROM EPAY_PAYMENT_MST
        WHERE BATCH_NO=P_BATCH_NO
        AND ORG_BR_CODE=P_LOCATION_CODE
        AND ORG_CODE='BPDB'
        AND STATUS='M')
        MINUS
        SELECT ACCOUNT_NUMBER,BILL_NUMBER  FROM EPAY_UTILITY_bILL
        WHERE BILL_MONTH=v_Bill_Month
        AND (ACCOUNT_NUMBER,BILL_NUMBER) IN (
        SELECT ACCOUNT_NUMBER,BILL_NUMBER FROM EPAY_PAYMENT_DTL
        WHERE BATCH_NO IN (
        SELECT BATCH_NO FROM EPAY_PAYMENT_MST
        WHERE BATCH_NO=P_BATCH_NO  
        AND ORG_BR_CODE=P_LOCATION_CODE
        AND ORG_CODE='BPDB'
        AND STATUS='M')
        )
        AND LOCATION_CODE=P_LOCATION_CODE
    )
    
    LOOP
    
        /* Missing Data Upload From Billing Server */
    
        EXECUTE IMMEDIATE
        'INSERT INTO EPAY_UTILITY_BILL_SUP
        SELECT ''BPDB'' AS COMPANY_CODE, 
        CUSTOMER_NUM||CONS_CHK_DIGIT AS ACCOUNT_NUMBER, 
        INVOICE_NUM||INVOICE_CHK_DGT BILL_NUMBER, 
        INVOICE_DATE GENERATED_DATE, 
        ''N'' BILL_STATUS, 
        INVOICE_DUE_DATE BILL_DUE_DATE, 
        0 BILLAMT_AFTERDUEDATE, 
        INVOICE_DUE_DATE BILLENDDATE_FORPAYMENT, 
        SYSDATE CREATED_ON    , 
        ''SYSADMIN'' CREATED_BY   , 
        NULL  MODIFIED_ON , 
        NULL MODIFIED_BY, 
        ''N'' NOTIFICATION_SENT_STATUS, 
        (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0) 
        +NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+ 
        NVL(DEMAND_CHRG,0) 
        +NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)+ 
        NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)) CURRENT_PRINCIPLE, 
        CURRENT_VAT CURRENT_GOVT_DUTY, 
        ARR_ADV_ADJ_PRN  ARREAR_PRINCIPLE, 
        ARR_ADV_ADJ_VAT ARREAR_GOVT_DUTY, 
        0 LATE_PAYMENT_SURCHARGE, 
        TOTAL_BILL TOTAL_BILL_AMOUNT, 
        LOCATION_CODE, 
        BILL_CYCLE_CODE BILL_MONTH, 
        TARIFF, 
        CUST_STATUS CUSTOMER_TYPE, 
        CURRENT_LPS CURRENT_SURCHARGE, 
        ARR_ADV_ADJ_LPS ARREAR_SURCHARGE, 
        NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0) ADJUSTED_PRINCIPLE, 
        ADJUSTED_VAT ADJUSTED_GOVT_DUTY, 
        0 /*NVL(UNADJUSTED_PRN,0)+NVL(UNADJUSTED_VAT,0)*/ ADVANCE_AMOUNT,0 ,''T'' DATA_TRANS_LOG
        FROM BC_BILL_IMAGE@'||v_DbLink||'
        WHERE BILL_CYCLE_CODE='''||v_Bill_Month||'''
        AND CUSTOMER_NUM||CONS_CHK_DIGIT='''||L1.ACCOUNT_NUMBER||'''
        AND LOCATION_CODE='''||P_LOCATION_CODE||'''';
        
        /*SELECT A.*,'T' FROM EPAY_DUPLICATE_CONS_TM@EPAY_SRL_DCC A
        WHERE BILL_MONTH=v_Bill_Month
        AND ACCOUNT_NUMBER=L1.ACCOUNT_NUMBER
        AND LOCATION_CODE=P_LOCATION_CODE;*/
        
        COMMIT;
        
    END LOOP;   
        
        /* New Upload Data List */
    
        FOR L2 IN (SELECT * FROM EPAY_UTILITY_BILL_SUP)
        
        LOOP
        
            /* Bill_Data Chake BillMonth,AccountNum & BillNum wise */
        
            SELECT COUNT(*) INTO v_ExisData FROM EPAY_UTILITY_BILL
            WHERE BILL_MONTH=L2.BILL_MONTH
            AND ACCOUNT_NUMBER=L2.ACCOUNT_NUMBER
            AND BILL_NUMBER=L2.BILL_NUMBER;
            
            IF v_ExisData=0 THEN
            
                DELETE FROM EPAY_UTILITY_BILL
                WHERE BILL_MONTH=L2.BILL_MONTH
                AND ACCOUNT_NUMBER=L2.ACCOUNT_NUMBER;
                
                INSERT INTO EPAY_UTILITY_BILL
                SELECT * FROM EPAY_UTILITY_BILL_SUP
                WHERE BILL_MONTH=L2.BILL_MONTH
                AND ACCOUNT_NUMBER=L2.ACCOUNT_NUMBER
                AND BILL_NUMBER=L2.BILL_NUMBER;
                
                COMMIT;
                
                SELECT BILL_NUMBER INTO v_Dtl_Bill_No FROM EPAY_PAYMENT_DTL
                 WHERE BATCH_NO=P_BATCH_NO
                 AND ACCOUNT_NUMBER=L2.ACCOUNT_NUMBER;
                     
                 SELECT BILL_NUMBER INTO v_Uti_Bill_No FROM EPAY_UTILITY_BILL
                 WHERE BILL_MONTH=L2.BILL_MONTH
                 AND ACCOUNT_NUMBER=L2.ACCOUNT_NUMBER;
                 
                IF v_Dtl_Bill_No<>v_Uti_Bill_No THEN
                 
                 UPDATE EPAY_PAYMENT_DTL
                 SET BILL_NUMBER=v_Uti_Bill_No
                 WHERE BATCH_NO=P_BATCH_NO
                 AND BILL_NUMBER=v_Dtl_Bill_No
                 AND ACCOUNT_NUMBER=L2.ACCOUNT_NUMBER;
                 
                 COMMIT;
                 
                 v_Msg:='Sucessfully Complite';
                 
                ELSE
                
                    v_Msg:='Sucessfully Complite';
                
                END IF;

                v_Msg:='Sucessfully Complite';
            
            ELSE
            
             SELECT BILL_NUMBER INTO v_Dtl_Bill_No FROM EPAY_PAYMENT_DTL
             WHERE BATCH_NO=P_BATCH_NO
             AND ACCOUNT_NUMBER=L2.ACCOUNT_NUMBER;
         
             SELECT BILL_NUMBER INTO v_Uti_Bill_No FROM EPAY_UTILITY_BILL
             WHERE BILL_MONTH=L2.BILL_MONTH
             AND ACCOUNT_NUMBER=L2.ACCOUNT_NUMBER;
             
             /* BillNumber Cheack payment and bill table*/
             
                IF v_Dtl_Bill_No<>v_Uti_Bill_No THEN
                 
                 UPDATE EPAY_PAYMENT_DTL
                 SET BILL_NUMBER=v_Uti_Bill_No
                 WHERE BATCH_NO=P_BATCH_NO
                 AND BILL_NUMBER=v_Dtl_Bill_No
                 AND ACCOUNT_NUMBER=L2.ACCOUNT_NUMBER;
                 
                 COMMIT;
                 
                 v_Msg:='Sucessfully Complete';
                 
                ELSE
                
                 v_Msg:='Sucessfully Complete'; 
                
                END IF;

            END IF;
         
        
        END LOOP;

    
    END IF;

    INSERT INTO epay.PROG_LOG@EPAY_SRL_DCC
    (BILL_MONTH,LOCATION_CODE,BILL_GROUP,DESCIP,TOT_CONS,PROG_TYPE,IP_ADD,CREATE_BY,CREATE_DATE)
    VALUES
    (null,P_LOCATION_CODE,null,v_Msg|| 'BatchNo: '||P_BATCH_NO,
    null,'MYM_TAN_ERROR_24',v_ip,'User: '||v_user||' - Machine: '||v_Host,sysdate);
        
        COMMIT; 

     RETURN (v_Msg);
     
EXCEPTION WHEN OTHERS THEN ROLLBACK;

    v_Msg:=SUBSTR(SQLERRM,1,500);
    
    RETURN (v_Msg);

END MYM_TAN_ERROR_SLV;
/