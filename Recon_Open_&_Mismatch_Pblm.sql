
select * from VW_EPAY_RECON_UNSUC_PDB_BNK@EPAY_SRL_DCC
WHERE PAY_DATE='20-MAY-2021'
AND LOC='B1'

SELECT EPAY.FN_EPAY_API_BNK_BTCH_REMOVE(:P_Batch_Num,:P_PAY_DATE) FROM DUAL

select * from VW_MBP_API_BATCH_NOT_GET 
where loc_code='B1'

select * FROM MBP_PAYMENT_DTL_OVC@MBP_23 
where pay_date='20-MAY-2021'
and org_br_code='B1'
and PAY_PC_CODE='10'
and PAY_PC_BR_CODE='004'
AND ACCOUNT_nUMBER='32958080'


SELECT EPAY.DFN_RECON_MISM 
(:P_API_BNK_CODE,:P_API_BRNC_CODE,:P_PAY_DATE,:P_LOC_CODE,:P_Cons_Num,:P_STATUS) 
FROM DUAL