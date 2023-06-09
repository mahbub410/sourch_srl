
SELECT * FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='201603'
AND BILL_NUMBER=:ACC
AND LOCATION_CODE=:LOC


INSERT INTO  EPAY_UTILITY_BILL_CR_BILL
SELECT * FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='201603'
AND LOCATION_CODE=:LOC
AND BILL_NUMBER=:ACC

COMMIT;                    
                    
                    UPDATE EPAY_UTILITY_BILL
                    SET BILL_DUE_DATE=TRUNC(SYSDATE),
                    BILLENDDATE_FORPAYMENT=TRUNC(SYSDATE)
                    WHERE BILL_MONTH='201603'
                    AND BILL_NUMBER=:ACC
                    AND LOCATION_CODE=UPPER(:LOC);
                    
                    
                    COMMIT;