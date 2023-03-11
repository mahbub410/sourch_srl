execute EMP.DPD_OMF_UPDATE_cust(:P_cust_num ,:p_omf ,:P_BILL_CYCLE_CODE)



select OVERALL_MF from BC_meter_reading_card_dtl
WHERE cust_id =cid(:P_cust_num)
and bill_cycle_code='201601'
