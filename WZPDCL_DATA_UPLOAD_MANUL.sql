
 INSERT INTO EPAY.EPAY_UTILITY_BILL
                            (COMPANY_CODE,ACCOUNT_NUMBER,BILL_NUMBER,GENERATED_DATE,BILL_STATUS,BILL_DUE_DATE,BILLAMT_AFTERDUEDATE,BILLENDDATE_FORPAYMENT,
                            CREATED_ON,CREATED_BY,MODIFIED_ON,MODIFIED_BY,NOTIFICATION_SENT_STATUS,CURRENT_PRINCIPLE,CURRENT_GOVT_DUTY,ARREAR_PRINCIPLE,
                            ARREAR_GOVT_DUTY,LATE_PAYMENT_SURCHARGE,TOTAL_BILL_AMOUNT,LOCATION_CODE,BILL_MONTH,TARIFF,CUSTOMER_TYPE,CURRENT_SURCHARGE,
                            ARREAR_SURCHARGE,ADJUSTED_PRINCIPLE,ADJUSTED_GOVT_DUTY,ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY,DATA_TRANS_LOG) VALUES                          
                            (vchCompID,CUR_BILL.ACCOUNT_NUM,CUR_BILL.BILL_NUM,CUR_BILL.INVOICE_DATE,'N',CUR_BILL.LAST_PAY_DATE,NULL,CUR_BILL.LAST_PAY_DATE,
                            SYSDATE,USER ,NULL,NULL,'N',CUR_BILL.CURRENT_AMT,CUR_BILL.VAT_AMT,0,
                            0,0,CUR_BILL.TOTAL_BILL_AMOUNT,CUR_BILL.LOCATION_CODE,CUR_BILL.BILL_MONTH,NULL,NULL,0,
                            0,0,0,0,0,'N');

select * FROM BC_INVOICE_HDR@WZ CUR_BILL
                                WHERE SUBSTR(BILL_NUM,1,4)=SUBSTR(:P_BILL_MONTH,3,6)


 INSERT INTO EPAY.EPAY_UTILITY_BILL
                            (COMPANY_CODE,ACCOUNT_NUMBER,BILL_NUMBER,GENERATED_DATE,BILL_STATUS,BILL_DUE_DATE,BILLAMT_AFTERDUEDATE,BILLENDDATE_FORPAYMENT,
                            CREATED_ON,CREATED_BY,MODIFIED_ON,MODIFIED_BY,NOTIFICATION_SENT_STATUS,CURRENT_PRINCIPLE,CURRENT_GOVT_DUTY,ARREAR_PRINCIPLE,
                            ARREAR_GOVT_DUTY,LATE_PAYMENT_SURCHARGE,TOTAL_BILL_AMOUNT,LOCATION_CODE,BILL_MONTH,TARIFF,CUSTOMER_TYPE,CURRENT_SURCHARGE,
                            ARREAR_SURCHARGE,ADJUSTED_PRINCIPLE,ADJUSTED_GOVT_DUTY,ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY,DATA_TRANS_LOG)
SELECT 'WZPDCL',CUR_BILL.ACCOUNT_NUM,CUR_BILL.BILL_NUM,CUR_BILL.INVOICE_DATE,'N',CUR_BILL.LAST_PAY_DATE,NULL,CUR_BILL.LAST_PAY_DATE,
                            SYSDATE,USER ,NULL,NULL,'N',NVL(TOTAL_BILL_AMOUNT,0)-NVL(VAT_AMT,0),nvl(CUR_BILL.VAT_AMT,0),0,
                            0,0,NVL(CUR_BILL.TOTAL_BILL_AMOUNT,0),CUR_BILL.LOCATION_CODE,:P_BILL_MONTH,NULL,NULL,0,
                            0,0,0,0,0,'N'
                                     FROM BC_INVOICE_HDR@WZ CUR_BILL
                                WHERE SUBSTR(BILL_NUM,1,4)=SUBSTR(:P_BILL_MONTH,3,6)
                               and account_num in (
'502241745','501214335','501142252','502280102','501170184'
)
                                --WHERE TO_CHAR(TO_DATE(BILL_MONTH,'YYMM'),'YYYYMM')=p_bill_month
                                --AND LOCATION_CODE=:P_LOCATION_CODE
                                AND NVL(TOTAL_BILL_AMOUNT,0)>=0
                                AND (ACCOUNT_NUM,BILL_num) IN (
                                SELECT ACCOUNT_NUM,BILL_NUM FROM BC_INVOICE_HDR@WZ
                                WHERE SUBSTR(BILL_NUM,1,4)=SUBSTR(:P_BILL_MONTH,3,6)
                                --WHERE TO_CHAR(TO_DATE(BILL_MONTH,'YYMM'),'YYYYMM')=SUBSTR(p_bill_month,3,6)
                                --AND LOCATION_CODE=:P_LOCATION_CODE
                                AND NVL(TOTAL_BILL_AMOUNT,0)>=0
                                AND ACCOUNT_NUM IN (SELECT ACCOUNT_NO FROM EPAY_CUSTOMER_MASTER_DATA)
                                MINUS
                                SELECT ACCOUNT_NUMBER, BILL_NUMBER FROM EPAY_UTILITY_BILL
                                WHERE BILL_MONTH=:P_BILL_MONTH
                               -- AND LOCATION_CODE=:P_LOCATION_CODE
                                )
                                
                                 AND LOCATION_CODE=:P_LOCATION_CODE
                                ORDER BY LAST_PAY_DATE DESC
                                


commit;

select DATA_TRANS_LOG,count(1) FROM EPAY_UTILITY_BILL
                                WHERE BILL_MONTH=:P_BILL_MONTH
                                group by DATA_TRANS_LOG                                
                                
                                
                                
                                
                                
                                 INSERT INTO EPAY.EPAY_UTILITY_BILL
                            (COMPANY_CODE,ACCOUNT_NUMBER,BILL_NUMBER,GENERATED_DATE,BILL_STATUS,BILL_DUE_DATE,BILLAMT_AFTERDUEDATE,BILLENDDATE_FORPAYMENT,
                            CREATED_ON,CREATED_BY,MODIFIED_ON,MODIFIED_BY,NOTIFICATION_SENT_STATUS,CURRENT_PRINCIPLE,CURRENT_GOVT_DUTY,ARREAR_PRINCIPLE,
                            ARREAR_GOVT_DUTY,LATE_PAYMENT_SURCHARGE,TOTAL_BILL_AMOUNT,LOCATION_CODE,BILL_MONTH,TARIFF,CUSTOMER_TYPE,CURRENT_SURCHARGE,
                            ARREAR_SURCHARGE,ADJUSTED_PRINCIPLE,ADJUSTED_GOVT_DUTY,ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY,DATA_TRANS_LOG) VALUES                          
                            (vchCompID,CUR_BILL.ACCOUNT_NUM,CUR_BILL.BILL_NUM,CUR_BILL.INVOICE_DATE,'N',CUR_BILL.LAST_PAY_DATE,NULL,CUR_BILL.LAST_PAY_DATE,
                            SYSDATE,USER ,NULL,NULL,'N',CUR_BILL.CURRENT_AMT,CUR_BILL.VAT_AMT,0,
                            0,0,CUR_BILL.TOTAL_BILL_AMOUNT,CUR_BILL.LOCATION_CODE,CUR_BILL.BILL_MONTH,NULL,NULL,0,
                            0,0,0,0,0,'N');
                            
                            ---customer data
                            
                            
                            SELECT *  FROM BC_CUSTOMERS@WZ
                                WHERE ACCOUNT_NUM IN (
                                SELECT ACCOUNT_NUM  FROM BC_CUSTOMERS@WZ
                                WHERE LOCATION_CODE=LOC_LIST.LOCATION_CODE
                                MINUS
                                select ACCOUNT_NO from EPAY_CUSTOMER_MASTER_DATA
                                WHERE LOCATION_CODE=LOC_LIST.LOCATION_CODE
                                ))

       
       
         INSERT INTO EPAY_CUSTOMER_MASTER_DATA
                        (COMPANY_CODE,ACCOUNT_NO,NAME,LOCATION_CODE,AREAR_CODE,ACTIVATION_DATE,STATUS,CREATED_ON,CREATED_BY,MODIFIED_ON,MODIFIED_BY,DUMPING_FOR,DATA_TRANS_LOG)
                        VALUES
                        (vchCompID,CUR_CUST.ACCOUNT_NUM,CUR_CUST.CUSTOMER_NAME,CUR_CUST.LOCATION_CODE,NULL,NULL,'A', SYSDATE,USER,NULL,NULL,'I','N');