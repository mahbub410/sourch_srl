select * from BC_AMEND_CONTROL
WHERE cust_id =cid(:p_cust_id)

select * from BC_AMEND_CONTROL_temp
WHERE cust_id =cid(:p_cust_id)


select rec_status,a.* from  bc_invoice_hdr a
where cust_id =cid(:p_cust_id)
order by bill_cycle_code desc
--and bill_cycle_code='202002'


select * from BC_meter_reading_card_dtl
WHERE cust_id =cid(:p_cust_id)
order by bill_cycle_code desc


select * from BC_BILL_CYCLE_CORR_MAP
WHERE cust_id =cid(:p_cust_id)
order by BILL_CYCLE desc


select * from  BC_INVOICE_ADJUSTMENTS
WHERE cust_id =cid(:p_cust_id)
--and original_bill_cycle='201903'
order by BILL_CYCLE_CODE desc
