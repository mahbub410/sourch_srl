

SELECT  'EXECUTE EMP.dpd_despatch_rollback ('''||cust_id||''','''||BILL_CYCLE_CODE||''');'||chr(10)    from bc_INVOICE_hdr
WHERE cust_id  IN (select cust_id from bc_bill_image where location_code='H9' and bill_group in ('15','22')
)
AND BILL_CYCLE_CODE='202206'


SELECT * FROM BC_CUSTOMER_EVENT_LOG
WHERE cust_id  IN (select cust_id from bc_bill_image where location_code='H9' and bill_group in ('15','22'))
AND BILL_CYCLE_CODE='202206'

--CUSTOMER_NUM||CONS_CHK_DIGIT

EXECUTE EMP.DPD_DESPATCH_ROLLBACK('52647','202205')


SELECT  'EXECUTE EMP.dpd_despatch_rollback('''||cust_id||''','''||BILL_CYCLE_CODE||''');'||chr(10)    from bc_INVOICE_hdr
WHERE cust_id  IN (select cust_id from bc_bill_image where Location_code= 'V8' AND AREA_CODE=:area_code  and Bill_Cycle_Code='201911' )
AND BILL_CYCLE_CODE='201911'



SELECT * FROM BC_CUSTOMER_EVENT_LOG
WHERE cust_id  IN (select cust_id from bc_bill_image where Location_code= 'V8' AND AREA_CODE=:area_code  and Bill_Cycle_Code='201911' )
AND BILL_CYCLE_CODE='201911'



--EXECUTE EMP.DPD_DESPATCH_ROLLBACK(:P_CUST_ID,:P_BILL_CYCLE )

SELECT * FROM BC_CUSTOMER_EVENT_LOG
WHERE cust_id  IN (select cust_id from bc_bill_image where CUSTOMER_NUM||CONS_CHK_DIGIT IN (
SELECT ACC_NO FROM BC_TEMP) AND BILL_CYCLE_CODE='202006')
AND BILL_CYCLE_CODE='202006'



SELECT  'EXECUTE EMP.dpd_despatch_rollback('''||cust_id||''','''||BILL_CYCLE_CODE||''');'||chr(10)    from bc_INVOICE_hdr
WHERE cust_id  IN (select cust_id from bc_bill_image where CUSTOMER_NUM||CONS_CHK_DIGIT IN (
SELECT ACC_NO FROM BC_TEMP) AND BILL_CYCLE_CODE='202006')
AND BILL_CYCLE_CODE='202006'


--------------------------
EXECUTE EMP.DPD_DESPATCH_ROLLBACK('410030525','201912')

SELECT * FROM BC_CUSTOMER_EVENT_LOG
WHERE CUST_ID =CID(:P_CUST_ID)

SELECT * FROM BC_CUSTOMERS
WHERE  CUSTOMER_NUM='6685919'

------------------
---OFFSET REMOVE--
--execute EMP.Dpd_off_remove(:cust_num,:receipt_num)


select * from bc_receipt_hdr
where cust_id=cid(50596086)
--and RECEIPT_NUM='19848389'
order by RECEIPT_DATE desc

select * from bc_invoice_receipt_map
where RECEIPT_NUM='19848389'