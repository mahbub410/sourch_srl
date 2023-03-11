CREATE OR REPLACE PROCEDURE DPD_DUE_DATE_CHNG IS

    TYPE RefCursor IS REF CURSOR;
    Cur_Data RefCursor;
 
    v_DataType  CONSTANT   VARCHAR2(50):='DATE_CHNG';
    v_Bill_Month   VARCHAR2(6);
    v_Rec_BILL_GROUP        
    v_Rec_INVOICE_DUE_DATE;
    v_ExisRecCnt   NUMBER;

    v_ErrNo          NUMBER;
    v_ErrDesc       VARCHAR2(2000);

BEGIN

    SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-1),'RRRRMM') INTO v_Bill_Month FROM DUAL;
    
    FOR Con_Chk IN (SELECT DISTINCT CENTER_NAME,BILLING_DBLINK FROM EPAY_LOCATION_MASTER
                              ORDER BY CENTER_NAME)
    LOOP
     
        BEGIN
            
          EXECUTE IMMEDIATE
          'SELECT COUNT(1) FROM DUAL@'||BILLING_DBLINK INTO v_ExisRecCnt;
         
        EXCEPTION WHEN OTHERS THEN
         
         v_ExisRecCnt:=0;
            
        END;
     
        IF v_ExisRecCnt>0 THEN 
         
            FOR LocList IN (SELECT LOCATION_CODE,BILLING_DBLINK FROM EPAY_LOCATION_MASTER
                                   WHERE CNETER_NAME=Con_Chk.CENTER_NAME
                                   ORDER BY 1 ASC)
                                    LOOP
                                        
                                       BEGIN
                                        
                                           OPEN Cur_Data FOR 
                                           'SELECT BILL_GROUP,INVOICE_DUE_DATE FROM BC_BILL_IMAGE@'||LocList.BILLING_DBLINK||'
                                            WHERE BILL_CYCLE_CODE='''||v_Bill_Month||'''
                                            AND LOCATION_CODE='''||LocList.LOCATION_CODE||'''
                                            AND INVOICE_DUE_DATE>=TRUNC(SYSDATE)
                                            GROUP BY BILL_CYCLE_CODE,LOCATION_CODE,BILL_GROUP,INVOICE_DUE_DATE
                                            ORDER BY 4 ASC';
                                            LOOP
                                                
                                                EXIT WHEN Cur_Data%NOTFOUND;
                                                
                                                FETCH Cur_Data INTO v_Rec_BILL_GROUP,v_Rec_INVOICE_DUE_DATE;
                                                
                                                SELECT COUNT(1) INTO v_ExisRecCnt FROM EPAY_UTILITY_BILL UB,EPAY_CUSTOMER_MASTER_DATA CM
                                                WHERE UB.ACCOUNT_NUMBER=CM.ACCOUNT_NO
                                                AND UB.LOCATION_CODE=CM.LOCATION_CODE
                                                AND UB.BILL_MONTH=v_Bill_Month
                                                AND UB.LOCATION_CODE=LocList.LOCATION_CODE
                                                AND SUBSTR(CM.AREAR_CODE,4,5)=v_Rec_BILL_GROUP
                                                AND BILL_DUE_DATE <>v_Rec_INVOICE_DUE_DATE
                                                GROUP BY BILL_DUE_DATE;
                                                
                                                IF v_ExisRecCnt>0 THEN
                                                 
                                                    UPDATE EPAY_UTILITY_BILL SET 
                                                    BILL_DUE_DATE=v_Rec_INVOICE_DUE_DATE,
                                                    BILLENDDATE_FORPAYMENT=v_Rec_INVOICE_DUE_DATE,
                                                    DATA_TRANS_LOG  ='N',
                                                    DATA_TRANS_LOG1='N',
                                                    DATA_TRANS_LOG2='N',
                                                    DATA_TRANS_LOG3='N',
                                                    DATA_TRANS_LOG4='N',
                                                    DATA_TRANS_LOG5='N',
                                                    MODIFIED_ON=SYSDATE,
                                                    MODIFIED_BY=USER
                                                    WHERE BILL_MONTH=v_Bill_Month
                                                    AND LOCATION_CODE=LocList.LOCATION_CODE
                                                    AND ACCOUNT_NUMBER IN (
                                                    SELECT ACCOUNT_NO FROM EPAY_CUSTOMER_MASTER_DATA
                                                        WHERE LOCATION_CODE=LocList.LOCATION_CODE
                                                        AND SUBSTR(CM.AREAR_CODE,4,5)=v_Rec_BILL_GROUP)                                       
                                                    AND BILL_DUE_DATE <>v_Rec_INVOICE_DUE_DATE;
                                                    
                                                    COMMIT;
                                                 
                                                END IF;
                                             
                                            END LOOP;
                                            
                                            CLOSE Cur_Data;
                                        
                                       EXCEPTION WHEN OTHERS THEN 
                                            ROLLBACK;
                                          
                                       END;
                                     
                                    END LOOP ;
                                    
        END IF;
                            
    END LOOP;

EXCEPTION 
    WHEN OTHERS THEN ROLLBACK;
    
    v_ErrNo         :=SQLCODE;
    v_ErrDesc      :=SQLERRM;
    
   INSERT INTO EPAY_ERR_LOG
   (ERROR_NO,ERROR_TXT,DATA_TYPE,LOCATION_CODE,RUN_DATE,RUN_BY,STATUS)
 VALUES
   (v_ErrNo,v_ErrDesc,v_DataType,NULL,SYSDATE,USER,'N');
     
   COMMIT;

END DPD_DUE_DATE_CHNG;