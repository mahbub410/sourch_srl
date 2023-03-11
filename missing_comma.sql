



SELECT
 'SELECT  C.LOCATION_CODE,C.CUSTOMER_NAME,RTRIM(CA.ADDR_DESCR1||'',''||CA.ADDR_DESCR2||'',''||CA.ADDR_DESCR3,'',,'') ADDRESS,
                        C.CUSTOMER_NUM||C.CHECK_DIGIT CONSUMER_NUM,SUBSTR(C.AREA_CODE,1,3) BOOK_NO,BI.TARIFF,Y.AMENDMENT_DATE,
                        ''BILL CORRECTION'' TYPE_OF_MODY,X.ADJ_PRINC NET_AMT,X.ADJ_VAT VAT_AMT,
                        X.ADJ_LPS LPS_AMT,NVL(X.ADJ_PRINC ,0)+ NVL(X.ADJ_VAT ,0)+ NVL( X.ADJ_LPS ,0) TOTAL                  
                           FROM BC_AMEND_CONTROL_TEMP@'||LOC_LIST.BILLING_DBLINK||' Y ,
                                     BC_CUSTOMERS@'||LOC_LIST.BILLING_DBLINK||' C,     
                                     BC_CUSTOMER_ADDR@'||LOC_LIST.BILLING_DBLINK||' CA,    
                                     BC_BILL_IMAGE@'||LOC_LIST.BILLING_DBLINK||' BI,    
                        (SELECT CUST_ID,ORIGINAL_BILL_CYCLE,
                                     SUM(DECODE(TARIFF_TYPE_CODE,''01'',ADJ_AMNT,0)) ADJ_VAT,
                                     SUM(DECODE(TARIFF_TYPE_CODE,''02'',ADJ_AMNT,0)) ADJ_LPS,
                                     SUM(DECODE(TARIFF_TYPE_CODE,''01'',0,''02'',0,ADJ_AMNT)) ADJ_PRINC
                                            FROM BC_INVOICE_ADJUSTMENTS@'||LOC_LIST.BILLING_DBLINK||'
                        WHERE ADJUSTMENT_TYPE=''EST''
                        AND BILL_CYCLE_CODE>='''||v_ST_BILL_CYCLE_CODE||'''
                        AND BILL_CYCLE_CODE<='''||v_END_BILL_CYCLE_CODE||'''
                        GROUP BY CUST_ID,ORIGINAL_BILL_CYCLE) X
                        WHERE PROCESSING_BILL_CYCLE>='''||v_ST_BILL_CYCLE_CODE||'''
                        AND     PROCESSING_BILL_CYCLE<='''||v_END_BILL_CYCLE_CODE||''' 
                        AND X.CUST_ID=Y.CUST_ID
                        AND C.CUST_ID=Y.CUST_ID
                        AND C.CUST_ID=BI.CUST_ID
                        AND X.ORIGINAL_BILL_CYCLE=BI.BILL_CYCLE_CODE
                        AND BI.INVOICE_NUM IS NOT NULL
                        AND Y.CUST_ID=CA.CUST_ID
                        AND CA.ADDR_TYPE=''M''
                        AND X.ORIGINAL_BILL_CYCLE=Y.BILL_CYCLE_CODE
                        AND BI.LOCATION_CODE='''||LOC_LIST.LOCATION_CODE||'''
                        AND Y.SOURCE_FLAG=''BC_BILCORR'''  
                        from (
SELECT LOCATION_CODE,BILLING_DBLINK,MBILL_DBLINK ,'201507' v_ST_BILL_CYCLE_CODE,'201606' v_END_BILL_CYCLE_CODE
                                   FROM MIS_LOCATION_MASTER 
                               WHERE STATUS='A' 
                               AND LOCATION_CODE='E2'
                               AND BILLING_DBLINK IS NOT NULL
                               AND MBILL_DBLINK IS NOT NULL) LOC_LIST
                               
                               
                               
SELECT ST_BILL_CYCLE_CODE ,
                 END_BILL_CYCLE_CODE
                      FROM MIS_AUDIT_SYSTEM_SETTING@BILLING_KISHOR





-----------------------------------------------------------------------------------------


SELECT  C.LOCATION_CODE,C.CUSTOMER_NAME,RTRIM(CA.ADDR_DESCR1||','||CA.ADDR_DESCR2||','||CA.ADDR_DESCR3,',,') ADDRESS,
                        C.CUSTOMER_NUM||C.CHECK_DIGIT CONSUMER_NUM,SUBSTR(C.AREA_CODE,1,3) BOOK_NO,BI.TARIFF,Y.AMENDMENT_DATE,
                        'BILL CORRECTION' TYPE_OF_MODY,X.ADJ_PRINC NET_AMT,X.ADJ_VAT VAT_AMT,
                        X.ADJ_LPS LPS_AMT,NVL(X.ADJ_PRINC ,0)+ NVL(X.ADJ_VAT ,0)+ NVL( X.ADJ_LPS ,0) TOTAL                  
                           FROM BC_AMEND_CONTROL_TEMP@BILLING_KISHOR Y ,
                                     BC_CUSTOMERS@BILLING_KISHOR C,     
                                     BC_CUSTOMER_ADDR@BILLING_KISHOR CA,    
                                     BC_BILL_IMAGE@BILLING_KISHOR BI,    
                        (SELECT CUST_ID,ORIGINAL_BILL_CYCLE,
                                     SUM(DECODE(TARIFF_TYPE_CODE,'01',ADJ_AMNT,0)) ADJ_VAT,
                                     SUM(DECODE(TARIFF_TYPE_CODE,'02',ADJ_AMNT,0)) ADJ_LPS,
                                     SUM(DECODE(TARIFF_TYPE_CODE,'01',0,'02',0,ADJ_AMNT)) ADJ_PRINC
                                            FROM BC_INVOICE_ADJUSTMENTS@BILLING_KISHOR
                        WHERE ADJUSTMENT_TYPE='EST'
                        AND BILL_CYCLE_CODE>='201607'
                        AND BILL_CYCLE_CODE<='201706'
                        GROUP BY CUST_ID,ORIGINAL_BILL_CYCLE) X
                        WHERE PROCESSING_BILL_CYCLE>='201607'
                        AND     PROCESSING_BILL_CYCLE<='201706' 
                        AND X.CUST_ID=Y.CUST_ID
                        AND C.CUST_ID=Y.CUST_ID
                        AND C.CUST_ID=BI.CUST_ID
                        AND C.CUSTomer_num='7073978'
                        AND X.ORIGINAL_BILL_CYCLE=BI.BILL_CYCLE_CODE
                        AND BI.INVOICE_NUM IS NOT NULL
                        AND Y.CUST_ID=CA.CUST_ID
                        AND CA.ADDR_TYPE='M'
                        AND X.ORIGINAL_BILL_CYCLE=Y.BILL_CYCLE_CODE
                        AND BI.LOCATION_CODE='K3'
                        AND Y.SOURCE_FLAG='BC_BILCORR'
                        
                        
                        Bill Mon:-201607-201706,ConNo:70739784, ORA-00917: missing comma
                        
    
---------------------------billing update--------------------




UPDATE BC_CUSTOMERS--@BILLING_KISHOR
SET CUSTOMER_NAME=REPLACE(REPLACE(CUSTOMER_NAME,',',''),CHR(39),'') 
WHERE  (INSTR(CUSTOMER_NAME,',')>1 OR INSTR(CUSTOMER_NAME,CHR(39))>1)
--AND LOCATION_NAME=:P_LOC 

UPDATE BC_CUSTOMER_ADDR@BILLING_KISHOR
SET (ADDR_DESCR1,ADDR_DESCR2,ADDR_DESCR3)=(REPLACE(REPLACE(ADDR_DESCR1,',',''),CHR(39),''),REPLACE(REPLACE(ADDR_DESCR1,',',''),CHR(39),''),REPLACE(REPLACE(ADDR_DESCR1,',',''),CHR(39),'')) 




UPDATE BC_CUSTOMER_ADDR--@BILLING_KISHOR
SET ADDR_DESCR1=REPLACE(ADDR_DESCR1,CHR(39),'')
,ADDR_DESCR2=REPLACE(ADDR_DESCR2,CHR(39),'')
,ADDR_DESCR3=REPLACE(ADDR_DESCR3,CHR(39),'')
WHERE  (( INSTR(ADDR_DESCR1,CHR(39))>1) or
(INSTR(ADDR_DESCR2,CHR(39))>1) or
(INSTR(ADDR_DESCR3,CHR(39))>1))


commit;

UPDATE BC_CUSTOMER_ADDR--@BILLING_KISHOR
SET (ADDR_DESCR3)=
(
REPLACE(ADDR_DESCR3,CHR(39),'')
)
WHERE  (( INSTR(ADDR_DESCR1,CHR(39))>1) or
(INSTR(ADDR_DESCR2,CHR(39))>1) or
(INSTR(ADDR_DESCR3,CHR(39))>1))
