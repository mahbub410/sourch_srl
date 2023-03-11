


select C.CUSTOMER_NAME,cv.* from bc_customers c,bc_customer_event_log cv
where C.CUST_ID=CV.CUST_ID
and cv.bill_cycle_code='202206'
and cv.BILL_DESPATCH_DATE is null

ALL Despatch CALL

SELECT  ' EXECUTE emp.Dpg_Bc_Despatch.dpd_call_Despatch ('''||BILL_CYCLE_CODE||''','''||CUST_NUM||''','''||:p_app_user||''');'||chr(10) from bc_INVOICE_hdr
WHERE BILL_CYCLE_CODE='202206'


select * from bc_invoice_hdr
where bill_cycle_code='202206'
and REC_STATUS<>'F'


update bc_invoice_hdr
 set  REC_STATUS='F'
where bill_cycle_code='202203'
and REC_STATUS='M'

commit;

select * from bc_customer_event_log
where bill_cycle_code='202101'
and BILL_DESPATCH_DATE is not null