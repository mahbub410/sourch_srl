

select *

UPDATE epay_utility_bill
SET data_trans_log='T'
where bill_month='201511'
and data_trans_log='N'
and location_code in (select location_code from epay_location_master where center_name='RANGPUR'
)


SELECT * FROM

update BC_BILL_IMAGE@BILLING_RONG
SET data_trans_log='T'
WHERE BILL_CYCLE_CODE='201511'
AND CUSTOMER_NUM in (
select substr(account_number,1,7) from
 epay_utility_bill
--SET data_trans_log='T'
where bill_month='201511'
--and data_trans_log='N'
and location_code in (select location_code from epay_location_master where center_name='RANGPUR'
)
)


                    UPDATE BC_BILL_IMAGE@BILLING_RONG
                    SET DATA_TRANS_LOG='N',
                           BILL_GEN_LOG='R'
                    WHERE (BILL_CYCLE_CODE,CUSTOMER_NUM) IN (
                    SELECT  C.BILL_CYCLE_CODE,C.CUSTOMER_NUM FROM EPAY_UTILITY_BILL B,BC_BILL_IMAGE@BILLING_RONG C
                    WHERE B.BILL_MONTH=C.BILL_CYCLE_CODE
                    AND B.LOCATION_CODE=C.LOCATION_CODE
                    AND SUBSTR(B.ACCOUNT_NUMBER,1,7)=C.CUSTOMER_NUM
                    AND C.INVOICE_DUE_DATE>=TRUNC(SYSDATE)
                    AND C.DATA_TRANS_LOG='T'
--                    AND B.LOCATION_CODE='''||LOC_LIST.LOCATION_CODE||'''
                    AND  (B.BILL_DUE_DATE<>C.INVOICE_DUE_DATE OR NVL(B.TOTAL_BILL_AMOUNT,0)<>NVL(C.TOTAL_BILL,0)))