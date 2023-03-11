
--SELECT EPAY_SEQ_PAY_BATCH_NO.NEXTVAL FROM DUAL


SELECT * FROM EPAY_PAYMENT_MST
WHERE PAY_DATE='27-MAR-2019'
AND PAY_BANK_CODE='97'
AND LOCATION_CODE='P2'

SELECT * FROM EPAY_PAYMENT_DTL
WHERE BATCH_NO='424146'
AND BILL_NUMBER='408339009'

710450275

select * from utility_bill_pdb@epay_robi
where bill_month='201902'
AND account_number='61232631'
AND LOCATION_CODE='P2'
--AND BILL_STATUS='P'


SELECT INVOICE_NUM||INVOICE_CHK_DGT FROM BC_BILL_IMAGE@BILLING_TANG
WHERE BILL_CYCLE_CODE='201812'
AND CUSTOMER_NUM||CONS_CHK_DIGIT='76251727'


select BATCH_NO from payment_dtl@epay_robi
where bill_number='710450275'

select * from EPAY_payment_dtl
where bill_number='710450275'

select BATCH_NO from EPAY_payment_dtl
where bill_number='614968374'
AND REF_BATCH_NO='255503'


select * from BC_RECEIPT_HDR@BILLING_COM
where CUST_NUM='3681491'

select * from BC_RECEIPT_HDR@BILLING_TANG
where CUST_NUM='7914164'
AND BANK_CODE='97'
ORDER BY RECEIPT_DATE DESC


select * from bc_receipt_hdr@billing_tang
where batch_num='9797011366'
AND RECEIPT_OFFSET='0'
--and cust_num=SUBSTR(1,7,'75288595')


select 1398+68 from dual

SELECT TOTAL_BILL FROM BC_BILL_IMAGE@BILLING_TANG
WHERE BILL_CYCLE_CODE='201812'
AND CUSTOMER_NUM||CONS_CHK_DIGIT='76251727'





select * from utility_bill_pdb@epay_robi
where  account_number='75288595'


select * from payment_dtl@epay_robi
where bill_number='614968374'

select * from epay_payment_mst
where ref_batch_no='255503'

select * from EPAY_RECEIPT_BATCH_HDR_PDB
where BATCH_NUM_EPAY ='397727'


select * from bc_receipt_hdr@billing_tang


where batch_num='9797041194'
and cust_num='7528859'

select * from bc_bill_image@billing_tang
where customer_num='7528859'
order by bill_cycle_code desc

SELECT *  FROM EPAY_UTILITY_BILL
WHERE BILL_NUMBER='710450275'

BILL_MONTH='201812'
AND ACCOUNT_NUMBER='76251727'

INSERT INTO EPAY_PAYMENT_MST
SELECT * FROM PAYMENT_MST_MYMEN

INSERT INTO EPAY_PAYMENT_DTL
SELECT * FROM PAYMENT_DTL_MYMEN

COMMIT;


SELECT 75288595 FROM DUAL

SELECT 75288595 FROM DUAL


select * from payment_dtl@epay_robi
where TRANSACTION_ID='20190124027346'

select * from payment_mst@epay_robi
where batch_no='260411'

    505739553
1398    68

SELECT * FROM BC_RECEIPT_BATCH_HDR@BILLING_TANG
WHERE BATCH_NUM='9797031372'