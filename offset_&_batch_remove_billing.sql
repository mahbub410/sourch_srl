select 'execute EMP.Dpd_off_remove('''||cust_num||''','''||receipt_num||''');'||chr(10) from bc_receipt_hdr
where batch_num='0505013255'



execute EMP.Dpd_off_remove(:cust_num,:receipt_num)


execute EMP.Dpd_off_remove('','')





delete  BC_INVOICE_RECEIPT_MAP
where receipt_num in (select receipt_num 
from bc_receipt_hdr
where batch_num='0505013255')


delete  bc_receipt_hdr
where batch_num='0505013255'

delete  bc_receipt_batch_hdr
where batch_num='0505013255'


delete  FROM BC_RECEIPT1_INT_DTL
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT1_INT_HDR
WHERE BATCH_NUM='0505013255')
                                                                                                         
                                            
delete FROM BC_RECEIPT1_INT_HDR
WHERE BATCH_NUM='0505013255'
                                                                                    
                                             
delete  FROM BC_RECEIPT2_INT_DTL
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT2_INT_HDR
WHERE BATCH_NUM='0505013255')
                                                                                                         
                                             
delete  FROM BC_RECEIPT2_INT_HDR
WHERE BATCH_NUM='0505013255'
                                                                                    
                                             
delete  FROM BC_RECEIPT_BATCH_CONTROL
WHERE BATCH_NUM='0505013255'
                                 


SELECT  'EXECUTE EMP.dpd_despatch_rollback('''||cust_id||''','''||BILL_CYCLE_CODE||''');'||chr(10) 
 from bc_INVOICE_hdr
 where cust_id =cid(:p_cust_id)
AND BILL_CYCLE_CODE='201904'



SELECT * from bc_INVOICE_hdr
WHERE CUST_ID IN(SELECT CUST_ID FROM  BC_CUSTOMERS WHERE CUSTOMER_NUM IN ('6690896','6690902','6690901','6683317'))
AND BILL_CYCLE_CODE='201904'

                                                   
                                             
SELECT *  FROM BC_RECEIPT_BATCH_HDR
WHERE BATCH_NUM='0505013255'

SELECT *  FROM BC_RECEIPT_HDR
WHERE BATCH_NUM='9696010798'



select 'execute EMP.Dpd_off_remove('''||cust_num||''','''||receipt_num||''');'||chr(10) from bc_receipt_hdr
where receipt_num='38358777'
and cust_id=cid(4178787)


SELECT *from bc_INVOICE_hdr
WHERE cust_id  IN (select cust_id from bc_bill_image where Location_code= 'I2' AND SUBSTR(AREA_CODE,4)=:P_Group and TARIFF ='LT-B' and Bill_Cycle_Code='201901' )
AND BILL_CYCLE_CODE='201901'









SELECT  'EXECUTE EMP.dpd_despatch_rollback('''||cust_id||''','''||BILL_CYCLE_CODE||''');'||chr(10)    from bc_INVOICE_hdr
WHERE cust_id  IN (select cust_id from bc_bill_image where Location_code= 'I2' AND SUBSTR(AREA_CODE,4)=:P_Group and TARIFF ='LT-B' and Bill_Cycle_Code='201901' )
AND BILL_CYCLE_CODE='201901'


SELECT  'EXECUTE EMP.dpd_despatch_rollback('''||cust_id||''','''||BILL_CYCLE_CODE||''');'||chr(10) 
 from bc_INVOICE_hdr
WHERE CUST_ID IN(SELECT CUST_ID FROM  BC_CUSTOMERS WHERE CUSTOMER_NUM IN ('6690896','6690902','6690901','6683317'))
AND BILL_CYCLE_CODE='201904'
