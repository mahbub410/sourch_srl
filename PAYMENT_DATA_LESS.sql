Payment data is less than bill data
--------------------error find-----------

select * from VW_EPAY_RECON_UNSUC_OPT_ERR
where bank_code='97'
and location_code IN ('T3','T4')
--and ERROR_TXT like '%Payment data is less than bill data%'


-----------------------

SELECT EPAY.DFN_PAYMENT_DATA_LESS (:P_BILL_MONTH ,:P_BILL_NO ,:P_LOC_CODE ,:P_BANK_CODE ) FROM DUAL

---------------GP-------------

SELECT 'SELECT EPAY.DFN_PAYMENT_DATA_LESS ('''||BILL_MONTH||''','''||BILL_NUMBER||''','''||LOCATION_CODE||''','''||bank_code||''' )'||' FROM DUAL'||CHR(10)||CHR(10)||'COMMIT;'||CHR(10) AS "RETURN_QUERY"  
FROM (
select '201912' BILL_MONTH, BILL_NUMBER,LOCATION_CODE,bank_code from VW_EPAY_RECON_UNSUC_OPT_ERR
where bank_code='96' 
and location_code='H7'
and ERROR_TXT like '%Payment data is less than bill data%'
group by bill_number,LOCATION_CODE,bank_code
)


------------------------------


SELECT 'SELECT EPAY.DFN_PAYMENT_DATA_LESS ('''||BILL_MONTH||''','''||BILL_NUMBER||''','''||LOCATION_CODE||''','''||'96'||''' )'||' FROM DUAL'||CHR(10)||CHR(10)||'COMMIT;'||CHR(10)  
FROM EPAY_UTILITY_BILL
WHERE BILL_NUMBER IN (
'555644328',
'555644375',
'555645164',
'555644911',
'555646105',
'555646807',
'555625325',
'555626491',
'555638104',
'555639637',
'555639710',
'555643518',
'555639422',
'555639291',
'555638193',
'555627118',
'555625325',
'555626491',
'555638104',
'555639637',
'555639710'
)
AND LOCATION_CODE='V8'



EXECUTE EPAY.DPG_EPAY_ONL_OPT_PYMT_VALID_GP.DPD_PAY_BILL_VALD_PASS_CONT

------------------ROBI--------

EXECUTE EPAY.DPG_EPAY_ONL_OPT_PYMT_VALID_RB.DPD_PAY_BILL_VALD_PASS_CONT

201706	17828675	15957313

SELECT * FROM PAYMENT_DTL@EPAY_GP
WHERE BILL_NUMBER='179266802'

SELECT * FROM DBERSICE.UTILITY_BILL_PDB@EPAY_GP
WHERE BILL_NUMBER='179266802'

INSERT INTO EPAY_UTILITY_BILL_INT

SELECT * FROM EPAY_UTILITY_BILL
WHERE BILL_NUMBER='179266802'



-----------------------------------------------GP----------------------------------------------

UPDATE EPAY_UTILITY_BILL X
SET (X.CURRENT_PRINCIPLE,X.CURRENT_GOVT_DUTY,  X.TOTAL_BILL_AMOUNT)=(SELECT NVL(D.PDB_AMOUNT,0),NVL(D.GOVT_DUTY,0),NVL(D.PDB_AMOUNT,0)+NVL(D.GOVT_DUTY,0) 
                                                                                                                            FROM PAYMENT_DTL@EPAY_GP D,PAYMENT_MST@EPAY_GP M
                                                                                                                        WHERE M.BATCH_NO=D.BATCH_NO
                                                                                                                        AND D.BILL_NUMBER=:BILL_NO
                                                                                                                        AND M.LOCATION_CODE=UPPER(:LOC_CODE))
WHERE X.BILL_MONTH=:BILL_MONTH
AND X.BILL_NUMBER=:BILL_NO
AND X.LOCATION_CODE=UPPER(:LOC_CODE)
 

COMMIT;

-----------------------------------------------ROBI-----------------------------------------

UPDATE EPAY_UTILITY_BILL X
SET (X.CURRENT_PRINCIPLE,X.CURRENT_GOVT_DUTY,  X.TOTAL_BILL_AMOUNT)=(SELECT NVL(D.PDB_AMOUNT,0),NVL(D.GOVT_DUTY,0),NVL(D.PDB_AMOUNT,0)+NVL(D.GOVT_DUTY,0) 
                                                                                                                            FROM PAYMENT_DTL@EPAY_robi D,PAYMENT_MST@EPAY_robi M
                                                                                                                        WHERE M.BATCH_NO=D.BATCH_NO
                                                                                                                        AND D.BILL_NUMBER=:BILL_NO
                                                                                                                        AND M.LOCATION_CODE=UPPER(:LOC_CODE))
WHERE X.BILL_MONTH=:BILL_MONTH
AND X.BILL_NUMBER=:BILL_NO
AND X.LOCATION_CODE=UPPER(:LOC_CODE)



COMMIT;




------------------------------------------------------------------------

UPDATE EPAY_UTILITY_BILL X
SET (CURRENT_PRINCIPLE,CURRENT_GOVT_DUTY,TOTAL_BILL_AMOUNT)=(SELECT PDB_AMOUNT,GOVT_DUTY,PDB_AMOUNT+GOVT_DUTY 
                                                                                                                        FROM DBERSICE.PAYMENT_MST@EPAY_GP M,DBERSICE.PAYMENT_DTL@EPAY_GP D
                                                                                                            WHERE M.BATCH_NO=D.BATCH_NO
                                                                                                            AND X.BILL_NUMBER=D.BILL_NUMBER
                                                                                                            AND M.LOCATION_CODE=X.LOCATION_CODE
                                                                                                            AND (D.BILL_NUMBER,M.LOCATION_CODE) IN (
                                                                                                            SELECT DISTINCT BILL_NUMBER,LOCATION_CODE FROM VW_EPAY_RECON_UNSUC_OPT_ERR
                                                                                                            WHERE ERROR_TXT LIKE '%Payment data is less than bill data%'
                                                                                                            AND BANK_CODE=:P_BANK_CODE      ))
WHERE (BILL_NUMBER,LOCATION_CODE) IN (
SELECT DISTINCT BILL_NUMBER,LOCATION_CODE FROM VW_EPAY_RECON_UNSUC_OPT_ERR
WHERE ERROR_TXT LIKE '%Payment data is less than bill data%'
AND BANK_CODE=:P_BANK_CODE  )
AND BILL_MONTH=:P_BILL_MONTH
--AND LOCATION_CODE=:P_LOCATION_CODE


COMMIT;


INSERT INTO epay_utility_bill
select COMPANY_CODE, ACCOUNT_NUMBER, BILL_NUMBER, GENERATED_DATE, BILL_STATUS, BILL_DUE_DATE, BILLAMT_AFTERDUEDATE, 
BILLENDDATE_FORPAYMENT, CREATED_ON, CREATED_BY, MODIFIED_ON, MODIFIED_BY, NOTIFICATION_SENT_STATUS, CURRENT_PRINCIPLE, 
CURRENT_GOVT_DUTY, ARREAR_PRINCIPLE, ARREAR_GOVT_DUTY, LATE_PAYMENT_SURCHARGE, TOTAL_BILL_AMOUNT, LOCATION_CODE, 
BILL_MONTH, TARIFF, CUSTOMER_TYPE, CURRENT_SURCHARGE, ARREAR_SURCHARGE, ADJUSTED_PRINCIPLE, ADJUSTED_GOVT_DUTY, ADVANCE_AMOUNT, 
ADJ_ADV_GOVT_DUTY,'N' DATA_TRANS_LOG,'T' DATA_TRANS_LOG1,'T' DATA_TRANS_LOG2,'T' DATA_TRANS_LOG3,'T' DATA_TRANS_LOG4,'N' DATA_TRANS_LOG5
from utility_bill_pdb@epay_gp
where bill_month='201812'
and bill_number in (
select bill_number from payment_dtl@epay_gp
where batch_no='172413'
)


COMMIT;


SELECT * FROM 

UPDATE EPAY_ERR_LOG
SET STATUS='C'
WHERE LOCATION_CODE ='W2'
AND ONLINE_OPT='GP'
AND DATA_TYPE='PAYMVALD'

COMMIT;