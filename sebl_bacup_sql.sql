


insert into EPAY_UTILITY_BILL

SELECT * FROM EPAY_UTILITY_BILL_hstr@epay_srl_dcc A
WHERE bill_number ='146475916'
AND LOCATION_CODE=:P_LOC

ACCOUNT_NUMBER=:ACC
AND BILL_MONTH=:P_MONTH

-------------------------------------------------------------------------------------------------------------


SELECT bill_month, TOTAL_BILL_AMOUNT,LOCATION_CODE,A.* FROM EPAY_UTILITY_BILL A
WHERE bill_number='161238573'
AND LOCATION_CODE=:P_LOC
 


SELECT bill_month, TOTAL_BILL_AMOUNT,LOCATION_CODE,A.* FROM EPAY_UTILITY_BILL A
WHERE ACCOUNT_NUMBER=:ACC
AND BILL_MONTH=:P_MONTH
AND LOCATION_CODE=:P_LOC



INSERT INTO  EPAY_UTILITY_BILL_CR_BILL
SELECT * FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH=:P_MONTH
AND ACCOUNT_NUMBER=:ACC
AND LOCATION_CODE=:P_LOC

                    UPDATE EPAY_UTILITY_BILL
                    SET BILL_DUE_DATE=TRUNC(SYSDATE),
                    BILLENDDATE_FORPAYMENT=TRUNC(SYSDATE)
                    WHERE BILL_MONTH=:P_MONTH
                    AND ACCOUNT_NUMBER=:ACC
                    AND LOCATION_CODE=:P_LOC;
                    
                    
COMMIT;



                    UPDATE EPAY_UTILITY_BILL
                    SET CURRENT_PRINCIPLE=(SELECT 262818-2602 FROM DUAL),
                    CURRENT_GOVT_DUTY=2602
                    WHERE BILL_MONTH=:P_MONTH
                    AND ACCOUNT_NUMBER=:ACC
                    AND LOCATION_CODE=:P_LOC;
                    
                    COMMIT;
                    
                    
                    UPDATE EPAY_UTILITY_BILL
                    SET ARREAR_PRINCIPLE=0, ARREAR_GOVT_DUTY=0, CURRENT_SURCHARGE=0, ARREAR_SURCHARGE=0,ADJUSTED_PRINCIPLE=0,ADJUSTED_GOVT_DUTY=0,CREATED_ON=SYSDATE
                    WHERE BILL_MONTH=:P_MONTH
                    AND ACCOUNT_NUMBER=:ACC AND LOCATION_CODE=:P_LOC;

                COMMIT;
                

                    UPDATE EPAY_UTILITY_BILL
                    SET TOTAL_BILL_AMOUNT=NVL(CURRENT_PRINCIPLE,0)+NVL(CURRENT_GOVT_DUTY,0)
                    +NVL(ARREAR_PRINCIPLE,0)+NVL(ARREAR_GOVT_DUTY,0)+NVL(CURRENT_SURCHARGE,0)
                    +NVL(ARREAR_SURCHARGE,0)+NVL(ADJUSTED_PRINCIPLE,0)+NVL(ADJUSTED_GOVT_DUTY,0)
                    -NVL(ADVANCE_AMOUNT,0)+NVL(ADJ_ADV_GOVT_DUTY,0)
                    /*,                    adjusted_principle=NVL(adjusted_principle,0)
                    +NVL(CURRENT_PRINCIPLE,0)+NVL(CURRENT_GOVT_DUTY,0)
                    +NVL(ARREAR_PRINCIPLE,0)+NVL(ARREAR_GOVT_DUTY,0)+NVL(CURRENT_SURCHARGE,0)
                    +NVL(ARREAR_SURCHARGE,0)+NVL(ADJUSTED_PRINCIPLE,0)+NVL(ADJUSTED_GOVT_DUTY,0)
                    -NVL(ADVANCE_AMOUNT,0)+NVL(ADJ_ADV_GOVT_DUTY,0)-(NVL(CURRENT_PRINCIPLE,0)
                    +NVL(CURRENT_GOVT_DUTY,0)+NVL(ARREAR_PRINCIPLE,0)+NVL(ARREAR_GOVT_DUTY,0)
                    +NVL(CURRENT_SURCHARGE,0)+NVL(ARREAR_SURCHARGE,0)+NVL(ADJUSTED_PRINCIPLE,0)
                    +NVL(ADJUSTED_GOVT_DUTY,0)-NVL(ADVANCE_AMOUNT,0)+NVL(ADJ_ADV_GOVT_DUTY,0))*/
                    WHERE BILL_MONTH=:P_MONTH
                    AND ACCOUNT_NUMBER=:ACC AND LOCATION_CODE=:P_LOC;

                    COMMIT;
                    
                    
                    SELECT B.LOCATION_CODE, ACCOUNT_NUMBER,C.NAME AS CUSTOMER_NAME,SUBSTR(BILL_NUMBER,1,7) AS BILL_NO,SUBSTR(BILL_NUMBER,8,9) AS CD, BILL_NUMBER, BILL_DUE_DATE,
                            BILL_STATUS,
                            NVL (  NVL (TOTAL_BILL_AMOUNT, 0)
                                 - NVL (  NVL (CURRENT_GOVT_DUTY, 0)
                                        + NVL (ARREAR_GOVT_DUTY, 0)
                                        + NVL (ADJUSTED_GOVT_DUTY, 0),
                                        0
                                       ),
                                 0
                                ) TOTAL_BPDB_AMOUNT,
                            NVL (  NVL (CURRENT_GOVT_DUTY, 0)
                                 + NVL (ARREAR_GOVT_DUTY, 0)
                                 + NVL (ADJUSTED_GOVT_DUTY, 0),
                                 0
                                ) VAT_AMOUNT,
                            TOTAL_BILL_AMOUNT, BILLAMT_AFTERDUEDATE
                       FROM EPAY_UTILITY_BILL B,EPAY_CUSTOMER_MASTER_DATA C
                      WHERE B.ACCOUNT_NUMBER=C.ACCOUNT_NO
                      AND B.COMPANY_CODE=C.COMPANY_CODE
                      AND B.LOCATION_CODE=C.LOCATION_CODE
                      AND B.ACCOUNT_NUMBER =:ACC
                        AND B.BILL_MONTH =:P_MONTH
--                        AND B.LOCATION_CODE = 'E2'
AND B.LOCATION_CODE=:P_LOC
                        AND BILL_DUE_DATE>=TRUNC(SYSDATE)
                        AND B.COMPANY_CODE=UPPER('BPDB');