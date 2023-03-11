
-- CUR_AREA_CODE 

          SELECT AREA_CODE FROM MBILL_AREA_ALLOCATION@MBILLSVR
          WHERE LOCATION_CODE=:LOCATION_CODE
    --    AND BILL_GRP IN (''09'',''10'')
    --    AND AREA_CODE=''71408''   
          ORDER BY BILL_GRP;
          
---CARD_HDR  DATA INSERT
   
INSERT INTO MBILL_METER_READING_CARD_HDR@MBILLSVR
SELECT READING_ID,LOCATION_CODE ,AREA_CODE ,READING_DATE, BILL_CYCLE_CODE, ENTRY_DATE, CARD_GEN_FLAG, EMP_ID,REMARKS, CREATE_DATE ,CREATE_BY,  UPDATE_DATE, UPDATE_BY,
REC_STATUS,PREV_READING_DATE,NULL,NULL,NULL FROM BC_METER_READING_CARD_HDR@BILLING_RONG
WHERE LOCATION_CODE=:LOCATION_CODE
--AND AREA_CODE='''||V_AREA||'''
AND BILL_CYCLE_CODE=:p_bill_cycle_code
AND (LOCATION_CODE,AREA_CODE,BILL_CYCLE_CODE)  IN (SELECT LOCATION_CODE,AREA_CODE,BILL_CYCLE_CODE
                                                                                                FROM BC_METER_READING_CARD_HDR@BILLING_RONG
                                                                                                WHERE LOCATION_CODE=:LOCATION_CODE
                                                                                                --AND AREA_CODE='''||V_AREA||'''
                                                                                                AND BILL_CYCLE_CODE=:p_bill_cycle_code
                                                                                                MINUS
                                                                                                SELECT LOCATION_CODE,AREA_CODE,BILL_CYCLE_CODE
                                                                                                FROM MBILL_METER_READING_CARD_HDR@MBILLSVR
                                                                                                WHERE LOCATION_CODE=:LOCATION_CODE
                                                                                                --AND AREA_CODE='''||V_AREA||'''
                                                                                                AND BILL_CYCLE_CODE=:p_bill_cycle_code);
                     
COMMIT;


================DATA_LOG===============


---CUR_DATA_LOG 
                                  
SELECT B.CUST_ID,B.BILL_CYCLE_CODE,B.CARD_GEN_DATE FROM MBILL_CUSTOMERS@MBILLSVR A ,BC_CUSTOMER_EVENT_LOG@BILLING_RONG b
WHERE A.CUST_ID IN (SELECT CUST_ID FROM  BC_CUSTOMER_EVENT_LOG@BILLING_RONG
                 WHERE BILL_CYCLE_CODE=:P_BILL_CYCLE_CODE
                 AND CUST_ID IN(SELECT CUST_ID FROM MBILL_CUSTOMERS@MBILLSVR WHERE LOCATION_CODE=:LOCATION_CODE 
                 --AND AREA_CODE='''||V_AREA||'''
                 )
                 MINUS
                 SELECT CUST_ID FROM  MBILL_DATA_LOG@MBILLSVR
                 WHERE BILL_CYCLE_CODE=:p_bill_cycle_code
                 AND CUST_ID IN(SELECT CUST_ID FROM MBILL_CUSTOMERS@MBILLSVR WHERE LOCATION_CODE=:LOCATION_CODE 
                 --AND AREA_CODE='''||V_AREA||'''
                 )
                 )    
AND  LOCATION_CODE=:LOCATION_CODE
--AND AREA_CODE='''||V_AREA||'''
AND A.CUST_ID=B.CUST_ID 
AND B.BILL_CYCLE_CODE=:P_Bill_Cycle_Code;

select * from mbill_data_log@MBILLSVR

INSERT INTO mbill_data_log@MBILLSVR
(CUST_ID,BILL_CYCLE_CODE,card_gen_date )
                      
                        
                        
                        
===========card dtl================

  OPEN CUR_DATA_LOG FOR
               SELECT CUST_ID,BILL_CYCLE_CODE,CARD_GEN_DATE 
                 FROM MBILL_DATA_LOG@'||LOC_LIST.MBILL_DBLINK||'
                 WHERE CUST_ID IN(SELECT CUST_ID FROM MBILL_CUSTOMERS@'||LOC_LIST.MBILL_DBLINK||'
                                                WHERE LOCATION_CODE='''||LOC_LIST.LOCATION_CODE||'''
                                                AND AREA_CODE='''||V_AREA||''')
                 AND CUST_ID NOT IN(SELECT CUST_ID FROM MBILL_METER_READING_CARD_DTL@'||LOC_LIST.MBILL_DBLINK||'
                                                WHERE  BILL_CYCLE_CODE='''||p_bill_cycle_code||''')
                 AND BILL_CYCLE_CODE='''||p_bill_cycle_code||;
                 
                 
                 
                 
                  'SELECT METER_READING_ID,READING_ID,METER_ID,CUST_ID,CAT_ID,POWER_FACTOR,NET_POWER_FACTOR,PREV_READING_DATE,READING_DATE,BILL_CYCLE_CODE,TIME_CYCLE_CODE,
                          TOD_CODE,READING_TYPE_CODE,PURPOSE_OF_RDNG,METER_TYPE_CODE,DEFECTIVE_CODE,ACTUAL_READING_FLAG,BATCH_PROCESS_FLAG,METER_STATUS,NO_OF_DAYS_TO_PRORATE,
                          METER_DIGIT,OPN_READING,CLS_READING,ADVANCE,OVERALL_MF,CREATE_DATE,CREATE_BY,UPDATE_DATE,UPDATE_BY,REC_STATUS,PREV_CUM_NUM,CUM_NUM,WALK_SEQ,RDG_SRL_NO,
                          CUM_DIGITS,RUN_ID,REPLACE_METER_ID,NO_OF_CONSUMERS,LOSS_CONSUMPTION,METER_SIDE,ASSESSED_CONSUMPTION,GROUP_EFFECT_FLAG,ACCEPT_CODE,CHECKPOINT_METER_ID,
                          PREVIOUS_METER_READING_ID,POWER_FACTOR_FLAG,BILLED_VALUE,NET_VALUE 
                          FROM BC_METER_READING_CARD_DTL@'||LOC_LIST.BILLING_DBLINK||'
                          WHERE CUST_ID='||V_CUST_ID||'
                          AND BILL_CYCLE_CODE='''||p_bill_cycle_code||'''
                          AND PURPOSE_OF_RDNG=''B'' ORDER BY TIME_CYCLE_CODE  DESC';
                                                                         