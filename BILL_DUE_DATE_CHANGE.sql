
SELECT * FROM EPAY_LOCATION_MASTER
WHERE LOCATION_CODE=UPPER(:P_LOC_CODE)

SELECT TOTAL_BILL,A.* FROM BC_BILL_IMAGE@BILLING_kishor A
WHERE BILL_CYCLE_CODE='201905'
AND CUSTOMER_NUM='7130522'

---------------------BILLING DATE CHEEK------------

SELECT INVOICE_DUE_DATE,COUNT(1) FROM BC_BILL_IMAGE@BILLING_kishor
WHERE LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_CYCLE_CODE=:P_BILL_MONTH
AND BILL_GROUP =:P_BILL_GROUP
GROUP BY INVOICE_DUE_DATE

---pdb check

SELECT LOCATION_CODE,BILL_DUE_DATE,COUNT(*) bill_count 
FROM EPAY_UTILITY_BILL--@EPAY_SRL
            WHERE BILL_MONTH=:v_billMonth
            AND LOCATION_CODE=:LOCATION_CODE
--            AND LOCATION_CODE IN ('K1','K2','K3','K4','K5')
            --AND BILL_DUE_DATE='''||v_blng_due_date||'''
            AND ACCOUNT_NUMBER IN (
            SELECT ACCOUNT_NO FROM EPAY_CUSTOMER_MASTER_DATA
            WHERE   LOCATION_CODE=:LOCATION_CODE
            --LOCATION_CODE IN ('K1','K2','K3','K4','K5')
            AND SUBSTR(AREAR_CODE,4)=:v_billGrpou
            )GROUP BY LOCATION_CODE,BILL_DUE_DATE
            ORDER BY 1 DESC
            
----24

SELECT LOCATION_CODE,BILL_DUE_DATE,COUNT(*) bill_count 
FROM EPAY_UTILITY_BILL@EPAY_SRL
            WHERE BILL_MONTH=:v_billMonth
            AND LOCATION_CODE=:LOCATION_CODE
--            AND LOCATION_CODE IN ('K1','K2','K3','K4','K5')
            --AND BILL_DUE_DATE='''||v_blng_due_date||'''
            AND ACCOUNT_NUMBER IN (
            SELECT ACCOUNT_NO FROM EPAY_CUSTOMER_MASTER_DATA@EPAY_SRL
            WHERE   LOCATION_CODE=:LOCATION_CODE
            --LOCATION_CODE IN ('K1','K2','K3','K4','K5')
            AND SUBSTR(AREAR_CODE,4)=:v_billGrpou
            )GROUP BY LOCATION_CODE,BILL_DUE_DATE
            ORDER BY 1 DESC

---

SELECT EPAY.DFN_BILL_DUE_DATE_EXTAND(:P_LOCATION,:P_BILL_GROUP) FROM DUAL


------
update EPAY_UTILITY_BILL--@EPAY_SRL
set  BILL_DUE_DATE='23-JUN-2021',
       BILLENDDATE_FORPAYMENT='23-JUN-2021'
            WHERE BILL_MONTH=:v_billMonth
            AND LOCATION_CODE=:v_locCode
            --AND BILL_DUE_DATE='''||v_blng_due_date||'''
            AND ACCOUNT_NUMBER IN (
            SELECT ACCOUNT_NO FROM EPAY_CUSTOMER_MASTER_DATA
            WHERE  LOCATION_CODE=:v_locCode
            AND SUBSTR(AREAR_CODE,4)in ('07')--=:v_billGrpou
            )

-----------------------UPDATE---PDB------------------------------------

UPDATE EPAY_UTILITY_BILL
SET BILL_DUE_DATE='27-SEP-2020',
       BILLENDDATE_FORPAYMENT='27-SEP-2020',
       CREATED_ON=SYSDATE
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND ACCOUNT_NUMBER IN (
SELECT CUSTOMER_NUM||CONS_CHK_DIGIT FROM BC_BILL_IMAGE@BILLING_CTG
WHERE BILL_CYCLE_CODE =:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_GROUP=:P_BILL_GROUP
AND INVOICE_DUE_DATE='27-SEP-2020'
)

COMMIT;

-----------------------UPDATE-------------SERVER--24--------------------------


UPDATE EPAY_UTILITY_BILL@EPAY_SRL
SET DATA_TRANS_LOG='N'
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND ACCOUNT_NUMBER IN (
SELECT CUSTOMER_NUM||CONS_CHK_DIGIT FROM BC_BILL_IMAGE@BILLING_CTG
WHERE BILL_CYCLE_CODE =:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_GROUP=:P_BILL_GROUP
--AND INVOICE_DUE_DATE='27-SEP-2020'
)

COMMIT;


------------------EPAYMENT-----------

UPDATE EPAY_UTILITY_BILL@EPAYMENT
SET BILL_DUE_DATE='27-SEP-2020',
       BILLENDDATE_FORPAYMENT='27-SEP-2020',
       CREATED_ON=SYSDATE
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND ACCOUNT_NUMBER IN (
SELECT CUSTOMER_NUM||CONS_CHK_DIGIT FROM BC_BILL_IMAGE@BILLING_CTG
WHERE BILL_CYCLE_CODE =:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_GROUP=:P_BILL_GROUP
AND INVOICE_DUE_DATE='27-SEP-2020'
)


COMMIT;

---------------------------------UPDATE-------------ROBI---------------------------------

UPDATE UTILITY_BILL_PDB@EPAY_ROBI
SET BILL_DUE_DATE='27-SEP-2020',
       BILLENDDATE_FORPAYMENT='27-SEP-2020',
       CREATED_ON=SYSDATE
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_DUE_DATE='23-SEP-2020'


COMMIT;

---------------------------------UPDATE------GP-----------CTG,-SYL-,-MOU-,-RONG-,-DIN---------------

UPDATE UTILITY_BILL_PDB@EPAY_GP
SET BILL_DUE_DATE='27-SEP-2020',
       BILLENDDATE_FORPAYMENT='27-SEP-2020',
       CREATED_ON=SYSDATE
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_DUE_DATE='23-SEP-2020'


COMMIT;


-----------------------UPDATE-------------SERVER-169---------CTG-,COM-,SYL-,MOU-,MYMEN-,TANG-,KISHOR-,JAM-----------


UPDATE UTILITY_BILL_PDB@EPAY_GP
SET  BILL_DUE_DATE='27-SEP-2020',
BILLENDDATE_FORPAYMENT='27-SEP-2020',
CREATED_ON=SYSDATE
WHERE BILL_MONTH='202008'
AND LOCATION_CODE=:LOCATION_CODE
--AND BILL_DUE_DATE='27-AUG-2020'
AND ACCOUNT_NUMBER IN (
SELECT ACCOUNT_NO FROM CUSTOMER_MASTER_DATA_PDB@EPAY_GP
WHERE  LOCATION_CODE=:LOCATION_CODE
AND SUBSTR(AREAR_CODE,4)='08')

COMMIT;


---------------nesco--------------

UPDATE EPAY_UTILITY_BILL@NESCO_RAJ
SET BILL_DUE_DATE='21-MAR-2019',
       BILLENDDATE_FORPAYMENT='21-MAR-2019',
       CREATED_ON=SYSDATE
WHERE BILL_MONTH=:P_BILL_MONTH
--AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND ACCOUNT_NUMBER IN (
SELECT CUSTOMER_NUM||CONS_CHK_DIGIT FROM BC_BILL_IMAGE@BILLING_bog
WHERE BILL_CYCLE_CODE =:P_BILL_MONTH
--AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_GROUP=:P_BILL_GROUP
)

COMMIT;

------


select * from epay_utility_Bill@epay_srl
where bill_month='202005'
and company_code='BPDB'
AND TARIFF='LT-A'
AND BILL_DUE_DATE <>'30-JUN-2020'


UPDATE epay_utility_Bill@epay_srl
SET BILL_DUE_DATE='30-JUN-2020',BILLENDDATE_FORPAYMENT='30-JUN-2020'
where bill_month='202005'
and company_code='BPDB'
AND TARIFF='LT-A'
AND BILL_DUE_DATE <>'30-JUN-2020'

COMMIT;





-------

SELECT BILL_DUE_DATE,count(*) FROM EPAY_UTILITY_BILL--@EPAY_SRL
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND ACCOUNT_NUMBER IN (
SELECT CUSTOMER_NUM||CONS_CHK_DIGIT FROM BC_BILL_IMAGE@BILLING_ctg
WHERE BILL_CYCLE_CODE =:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_GROUP in ('08')
)--GROUP BY BILL_DUE_DATE
group by BILL_DUE_DATE



SELECT BILL_DUE_DATE,count(*) FROM UTILITY_BILL_PDB@EPAY_ROBI--@EPAY_SRL
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND ACCOUNT_NUMBER IN (
SELECT CUSTOMER_NUM||CONS_CHK_DIGIT FROM BC_BILL_IMAGE@BILLING_ctg
WHERE BILL_CYCLE_CODE =:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_GROUP in ('09','10')
)--GROUP BY BILL_DUE_DATE
group by BILL_DUE_DATE

SELECT * FROM UTILITY_BILL_PDB@EPAY_ROBI
WHERE BILL_MONTH='201907'
AND ACCOUNT_NUMBER='55946044'

SELECT BILL_DUE_DATE,count(*) FROM EPAY_UTILITY_BILL@EPAY_SRL
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND ACCOUNT_NUMBER IN (
SELECT CUSTOMER_NUM||CONS_CHK_DIGIT FROM BC_BILL_IMAGE@BILLING_RAJ
WHERE BILL_CYCLE_CODE =:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
AND BILL_GROUP=:P_BILL_GROUP
)GROUP BY BILL_DUE_DATE



select bill_due_date,count(*) FROM UTILITY_BILL_PDB@EPAY_ROBI
WHERE BILL_MONTH=:P_BILL_MONTH
AND LOCATION_CODE=UPPER(:P_LOC_CODE)
--AND BILL_DUE_DATE='24-JUN-2018'
GROUP BY bill_due_date

--------BILL GROUP WISE CHK EPAY--

SELECT SUBSTR(C.AREAR_CODE,4) BILL_GROUP,U.BILL_DUE_DATE,COUNT(*) FROM EPAY_UTILITY_bILL@EPAY_SRL U,EPAY_CUSTOMER_MASTER_DATA@EPAY_SRL C
WHERE U.ACCOUNT_NUMBER=C.ACCOUNT_NO
AND U.LOCATION_CODE=C.LOCATION_CODE
AND U.LOCATION_CODE='S7'
AND U.BILL_MONTH='202006'
AND SUBSTR(C.AREAR_CODE,4)='09'
--and U.location_code in (select location_code from epay_location_master where center_name='RANGPUR')
GROUP BY SUBSTR(C.AREAR_CODE,4) ,U.BILL_DUE_DATE
ORDER BY SUBSTR(C.AREAR_CODE,4)

--------BILL GROUP WISE CHK BILLING---

SELECT BILL_GROUP,INVOICE_DUE_DATE,COUNT(*)  FROM BC_BILL_IMAGE@billing_syl
WHERE BILL_CYCLE_CODE='202007'
--AND LOCATION_CODE='S7'
--AND BILL_GROUP='09'
and INVOICE_DUE_DATE>'23-AUG-2020'
GROUP BY BILL_GROUP,INVOICE_DUE_DATE
ORDER BY BILL_GROUP

----------------ROBI-----

SELECT SUBSTR(C.AREAR_CODE,4) BILL_GROUP,U.BILL_DUE_DATE,COUNT(*) FROM UTILITY_bILL_PDB@EPAY_ROBI U,CUSTOMER_MASTER_DATA_PDB@EPAY_ROBI C
WHERE U.ACCOUNT_NUMBER=C.ACCOUNT_NO
AND U.LOCATION_CODE=C.LOCATION_CODE
AND U.LOCATION_CODE='S7'
AND U.BILL_MONTH='202006'
AND SUBSTR(C.AREAR_CODE,4)='09'
--and U.location_code in (select location_code from epay_location_master where center_name='RANGPUR')
GROUP BY SUBSTR(C.AREAR_CODE,4) ,U.BILL_DUE_DATE
ORDER BY SUBSTR(C.AREAR_CODE,4)