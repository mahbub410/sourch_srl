
---------------------------------------------------

select * from bc_invoice_hdr where cust_id=cid(:P_Cust)
and bill_cycle_code=:P_bill_cycle

select * from bc_invoice_adjustments where invoice_num=:P_invoice_num

select * from bc_invoice_receipt_map
where invoice_num=(select invoice_num from bc_invoice_hdr where cust_id=cid(:P_Cust)and bill_cycle_code=:P_Bill_cycle )
and invoice_num=:P_invoice_num

-------------------Check Bill---------------------------------------------------      

select * from bc_invoice_receipt_map where INVOICE_NUM=:P_INVOICE_NUM


-------------------Start-------Despatch Rollback--------------------------------



delete bc_invoice_receipt_map
where invoice_num=(select invoice_num from bc_invoice_hdr where cust_id=cid(:P_Cust)and bill_cycle_code=:P_Bill_cycle )
and receipt_num=:P_receipt 


update bc_receipt_hdr a
set (receipt_offset,vat_offset)=( select nvl(sum(b.PRINCIPAL_AMT_LPS+b.LPS_AMT),0),nvl(sum(b.vat_amt),0) from bc_invoice_receipt_map b
      where   a.receipt_num=b.receipt_num),rec_status='C'
     where a.receipt_num=:p_receipt_num
     and a.rec_status='A'


--SELECT * FROM 
UPDATE
BC_METER_READING_CARD_DTL 
SET BATCH_PROCESS_FLAG = 'C'
WHERE cust_id = cid(:P_Cust)
AND bill_cycle_code=:p_bill_cycle


--select * from 
UPDATE 
BC_CUSTOMER_EVENT_LOG
SET BILL_DESPATCH_DATE = NULL 
WHERE cust_id = cid(:P_Cust)
AND bill_cycle_code = :p_bill_cycle


UPDATE 
--select distinct INVOICE_NUM from
BC_INVOICE_DTL
SET rec_status='C' 
WHERE INVOICE_NUM IN(SELECT invoice_num FROM BC_INVOICE_HDR WHERE cust_id = cid(:P_Cust)
                       AND bill_cycle_code=:p_bill_cycle)

UPDATE
--SELECT * FROM 
BC_INVOICE_HDR
sET rec_status='M' 
WHERE cust_id = cid(:P_Cust)
AND bill_cycle_code=:p_bill_cycle

--select * from
UPDATE BC_BILL_IMAGE
sET rec_status='C', despatch_date = NULL 
WHERE cust_id = cid(:P_Cust)
AND bill_cycle_code=:p_bill_cycle

DELETE
--SELECT * FROM 
 BC_INVOICE_ADJUSTMENTS --set rec_status='P'
WHERE invoice_num = (SELECT invoice_num FROM BC_INVOICE_HDR WHERE cust_id = cid(:P_Cust)
                       AND bill_cycle_code=:p_bill_cycle)
--AND  adj_process_flag = 'B';


DELETE 
--SELECT * 
FROM BC_INVOICE_ADJUSTMENTS
WHERE ORIGINAL_invoice_num IN(
SELECT invoice_num FROM BC_INVOICE_HDR WHERE cust_id = cid(:P_Cust)
AND bill_cycle_code=:p_bill_cycle)
-------

COMMIT;

-----------------------------------------End--------------

SELECT * FROM BC_CUSTOMER_EVENT_LOG
WHERE CUST_ID =CID(:P_CUST_ID)