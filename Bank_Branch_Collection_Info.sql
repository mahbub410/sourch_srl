
BILL BANK CODE:94,COMP CNTR:01:Bill Bank Code and Computer Center wise Bank Code not found 

--PROCEDURE DPD_BANK_BR_DATA_TRANS(p_run_id NUMBER) IS

CUR_BANK_BRANCH  RefCurTyp;
V_REC_BANK_CODE VARCHAR2(5);
V_REC_BRANCH_CODE VARCHAR2(10);
V_REC_BRANCH_NAME VARCHAR2(30);
V_REC_STATUS VARCHAR2(1);
V_REC_ADDRESS_LINE1 VARCHAR2(40);
V_REC_ADDRESS_LINE2 VARCHAR2(40);
V_REC_ADDRESS_LINE3 VARCHAR2(40);
V_REC_LOCATION_CODE VARCHAR2(5); 
v_SQL VARCHAR2(32000);

vchCompID       VARCHAR2(20):='BPDB';
vnmErrNo           NUMBER;
vchErrDesc         VARCHAR2(500);
v_Bank_Br_Data_Ins_Count NUMBER:=0;
v_Bank_Br_Data_Updt_Count NUMBER:=0;
v_Comp_Cntr_Code VARCHAR2(2);
v_Comp_Cntr_Code_Count NUMBER:=0;
v_Bank_Code VARCHAR2(5);
v_Bank_Code_Count NUMBER:=0;
v_Bank_Branch_Code VARCHAR2(10);
v_Bank_Branch_ID NUMBER;
v_Bank_Br_Count NUMBER:=0;
    
BEGIN

FOR LOC_LIST IN(SELECT LOCATION_CODE,BILLING_DBLINK,EPAY_DBLINK 
                          FROM EPAY_LOCATION_MASTER 
                          WHERE STATUS='A' 
                          AND BILLING_DBLINK IS NOT NULL
                          AND EPAY_DBLINK IS NOT NULL
                          ORDER BY LOCATION_SEQ_NO)
LOOP

     INSERT INTO EPAY_DATA_TRANS_BATCH_CONTROL
    (RUN_ID,RUN_BY,RUN_DATE,DATA_TYPE, RUN_STATUS_CODE,LOCATION_CODE)
    VALUES(p_run_id,USER,SYSDATE,'BBRINFO','04',LOC_LIST.LOCATION_CODE);

    COMMIT;
  
   v_Bank_Br_Data_Ins_Count:=0;
    v_Bank_Br_Data_Updt_Count:=0;
    
 BEGIN
 
      OPEN CUR_BANK_BRANCH FOR
      'SELECT A.BANK_CODE,A.BRANCH_CODE,A.BRANCH_NAME, A.STATUS,A.ADDRESS_LINE1,A.ADDRESS_LINE2,A.ADDRESS_LINE3,B.LOCATION_CODE 
        FROM EBC.BC_BANK_BRANCHES@'||LOC_LIST.BILLING_DBLINK||' A,BC_ACCOUNTID_GLCODE_MAP@'||LOC_LIST.BILLING_DBLINK||' B
        WHERE A.BANK_CODE=B.BANK_CODE
        AND A.BRANCH_CODE=B.BRANCH_CODE
        AND B.LOCATION_CODE='''||LOC_LIST.LOCATION_CODE||'''';
        
        LOOP
        
           BEGIN
           
            FETCH CUR_BANK_BRANCH INTO V_REC_BANK_CODE,V_REC_BRANCH_CODE,V_REC_BRANCH_NAME,V_REC_STATUS,
            V_REC_ADDRESS_LINE1,V_REC_ADDRESS_LINE2,V_REC_ADDRESS_LINE3,V_REC_LOCATION_CODE; 
            
            EXIT WHEN CUR_BANK_BRANCH%NOTFOUND;
            
            EXECUTE IMMEDIATE 'SELECT COUNT(1)
                          FROM EPAY_BANK_BRANCHES@'||LOC_LIST.EPAY_DBLINK||'  
                           WHERE BILLING_BANK_CODE='''||V_REC_BANK_CODE||''' 
                           AND BILLING_BRANCH_CODE='''||V_REC_BRANCH_CODE||'''
                           AND LOCATION_CODE='''||V_REC_LOCATION_CODE||''''  INTO v_Bank_Br_Count;
                           
                           
               IF v_Bank_Br_Count=0 THEN
            
                        EXECUTE IMMEDIATE 'SELECT COUNT(1) 
                              FROM EPAY_ZONE_COMP_CNTR_LOC@'||LOC_LIST.EPAY_DBLINK||'  
                              WHERE LOCATION_CODE='''||V_REC_LOCATION_CODE||''''  INTO v_Comp_Cntr_Code_Count;
                              
                         IF v_Comp_Cntr_Code_Count=0 THEN
                         
                                  INSERT INTO EPAY_DATA_TRANS_ERR_LOG
                                 (RUN_ID, ERROR_NO, ERROR_TXT, DATA_TYPE, RUN_DATE,LOCATION_CODE)
                                 VALUES(p_run_id,NULL,'LOC CODE:'||V_REC_LOCATION_CODE||':Computer Center Code Not Found for Location Code','BBRINFO',SYSDATE,LOC_LIST.LOCATION_CODE);
                                 COMMIT;

                         ELSE
                         
                              EXECUTE IMMEDIATE 'SELECT COMP_CNTR_CODE
                              FROM EPAY_ZONE_COMP_CNTR_LOC@'||LOC_LIST.EPAY_DBLINK||'  
                              WHERE LOCATION_CODE='''||V_REC_LOCATION_CODE||''''  INTO v_Comp_Cntr_Code;
                              
                              
                               EXECUTE IMMEDIATE 'SELECT COUNT(1) 
                               FROM EPAY_BANKS_MAP@'||LOC_LIST.EPAY_DBLINK||'  
                               WHERE BILLING_BANK_CODE='''||V_REC_BANK_CODE||''' 
                               AND COMP_CNTR_CODE='''||v_Comp_Cntr_Code||''''  INTO v_Bank_Code_Count;
             
                              
                              
                                 IF v_Bank_Code_Count=0 THEN
                                 
                                          INSERT INTO EPAY_DATA_TRANS_ERR_LOG
                                         (RUN_ID, ERROR_NO, ERROR_TXT, DATA_TYPE, RUN_DATE,LOCATION_CODE)
                                         VALUES(p_run_id,v_Bank_Code_Count,'BILL BANK CODE:'||V_REC_BANK_CODE||',COMP CNTR:'||v_Comp_Cntr_Code||':Bill Bank Code and Computer Center wise Bank Code not found ','BBRINFO',SYSDATE,LOC_LIST.LOCATION_CODE);
                                         COMMIT;
                                 
                                 ELSE
                                 
                                      EXECUTE IMMEDIATE 'SELECT BANK_CODE
                                      FROM EPAY_BANKS_MAP@'||LOC_LIST.EPAY_DBLINK||'  
                                       WHERE BILLING_BANK_CODE='''||V_REC_BANK_CODE||''' 
                                       AND COMP_CNTR_CODE='''||v_Comp_Cntr_Code||''''  INTO v_Bank_Code;
                                       
                                       
                                       EXECUTE IMMEDIATE
                                       'SELECT LPAD(NVL(MAX(BRANCH_CODE),0)+1,4,''0'') FROM EPAY_BANK_BRANCHES@'||LOC_LIST.EPAY_DBLINK||' 
                                       WHERE BANK_CODE='''||v_Bank_Code||'''' INTO v_Bank_Branch_Code;
                                       
                                       EXECUTE IMMEDIATE
                                       'SELECT NVL(MAX(BANK_BRANCH_ID),0)+1 FROM EPAY_BANK_BRANCHES@'||LOC_LIST.EPAY_DBLINK INTO v_Bank_Branch_ID;
                                        
                                       /*EXECUTE IMMEDIATE
                                       'SELECT EPAY_BANK_BRANCH_ID_SEQ@'||LOC_LIST.EPAY_DBLINK||' FROM DUAL' INTO v_Bank_Branch_ID;*/
                                       
                                       v_Bank_Br_Data_Ins_Count:=v_Bank_Br_Data_Ins_Count+1;
                                       
                                         EXECUTE IMMEDIATE 'INSERT INTO EPAY_BANK_BRANCHES@'||LOC_LIST.EPAY_DBLINK||'(
                                                  BANK_BRANCH_ID,BANK_CODE,BRANCH_CODE,BRANCH_NAME,STATUS,ADDRESS_LINE1,ADDRESS_LINE2,ADDRESS_LINE3,CREATE_DATE,CREATE_BY,LOCATION_CODE,BILLING_BANK_CODE,BILLING_BRANCH_CODE)
                                                  VALUES('||v_Bank_Branch_ID||','''||v_Bank_Code||''','''||v_Bank_Branch_Code||''','''||V_REC_BRANCH_NAME||''','''||
                                                  V_REC_STATUS||''','''||V_REC_ADDRESS_LINE1||''','''||V_REC_ADDRESS_LINE2||''','''||V_REC_ADDRESS_LINE3||''','''||SYSDATE||''','''||USER||''','''||V_REC_LOCATION_CODE||''','''||V_REC_BANK_CODE||''','''||V_REC_BRANCH_CODE||''')';
                                                  
                                                  COMMIT;
                                 
                                 END IF;
                         
                         END IF;
                         
               END IF;
           
           EXCEPTION
           
                 WHEN OTHERS THEN
                    ROLLBACK;
                    
                 vnmErrNo   := SQLCODE;
                 vchErrDesc := SUBSTR(SQLCODE||' - '||SQLERRM,1,500);
                 INSERT INTO EPAY_DATA_TRANS_ERR_LOG
                 (RUN_ID, ERROR_NO, ERROR_TXT, DATA_TYPE, RUN_DATE,LOCATION_CODE)
                 VALUES(p_run_id,vnmErrNo,vchErrDesc,'BBRINFO',SYSDATE,LOC_LIST.LOCATION_CODE);
                 
                 
                 COMMIT;
                 
            END;
        
        END LOOP;
        
        CLOSE CUR_BANK_BRANCH;

 
  IF v_Bank_Br_Data_Ins_Count>0 THEN
       
           INSERT INTO EPAY_DATA_TRANS_LOG
           (RUN_ID,DATA_TYPE,REC_TYPE,REC_COUNT,TOT_BILL_AMT,TRANS_DATE,LOCATION_CODE,RUN_BY,RUN_DATE,STATUS)
           VALUES(p_run_id,'BBRINFO','I',v_Bank_Br_Data_Ins_Count,NULL,SYSDATE,LOC_LIST.LOCATION_CODE,USER,SYSDATE,'N');
           COMMIT;
           
       END IF;
       
       
        IF v_Bank_Br_Data_Updt_Count>0 THEN
       
           INSERT INTO EPAY_DATA_TRANS_LOG
           (RUN_ID,DATA_TYPE,REC_TYPE,REC_COUNT,TOT_BILL_AMT,TRANS_DATE,LOCATION_CODE,RUN_BY,RUN_DATE,STATUS)
           VALUES(p_run_id,'BBRINFO','U',v_Bank_Br_Data_Updt_Count,NULL,SYSDATE,LOC_LIST.LOCATION_CODE,USER,SYSDATE,'N');
           COMMIT;
           
       END IF;
    
    UPDATE EPAY_DATA_TRANS_BATCH_CONTROL
         SET RUN_STATUS_CODE='01'
         WHERE RUN_ID=p_run_id
         AND DATA_TYPE='BBRINFO'
         AND  LOCATION_CODE=LOC_LIST.LOCATION_CODE;
         
         COMMIT;
 
 EXCEPTION
   
         WHEN OTHERS THEN
            ROLLBACK;
            
         vnmErrNo   := SQLCODE;
         vchErrDesc := SUBSTR(SQLCODE||' - '||SQLERRM,1,500);
         INSERT INTO EPAY_DATA_TRANS_ERR_LOG
         (RUN_ID, ERROR_NO, ERROR_TXT, DATA_TYPE, RUN_DATE,LOCATION_CODE)
         VALUES(p_run_id,vnmErrNo,vchErrDesc,'BBRINFO',SYSDATE,LOC_LIST.LOCATION_CODE);
         
         UPDATE EPAY_DATA_TRANS_BATCH_CONTROL
         SET RUN_STATUS_CODE='02'
         WHERE RUN_ID=p_run_id
         AND DATA_TYPE='BBRINFO'
         AND  LOCATION_CODE=LOC_LIST.LOCATION_CODE;
         
         COMMIT;
         
    END;
    
    
END LOOP;

END DPD_BANK_BR_DATA_TRANS;