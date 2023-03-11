
delete  FROM BC_RECEIPT1_INT_DTL@BILLING_ctg
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT1_INT_HDR@BILLING_ctg
WHERE BATCH_NUM='0411015208')

                                                                                                         
                                            
delete  FROM BC_RECEIPT1_INT_HDR@BILLING_ctg
WHERE BATCH_NUM='0411015208'
                                                                                    
                                             
delete  FROM BC_RECEIPT2_INT_DTL@BILLING_ctg
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT2_INT_HDR@BILLING_ctg
WHERE BATCH_NUM='0411015208')
                                                                                                         
                                             
delete  FROM BC_RECEIPT2_INT_HDR@BILLING_ctg
WHERE BATCH_NUM='0411015208'
                             
                                                       
                                             
delete  FROM BC_RECEIPT_BATCH_CONTROL@BILLING_ctg
WHERE BATCH_NUM='0411015208'
                                                                                    
                                             
delete  FROM BC_RECEIPT_BATCH_HDR@BILLING_ctg
WHERE BATCH_NUM='0411015208'

delete  FROM BC_RECEIPT_HDR@BILLING_ctg
WHERE BATCH_NUM='0411015208'
                                          
                                                                                    
delete  FROM EPAY_RECEIPT_BATCH_HDR_PDB
WHERE BATCH_NUM_PDB='0411015208'

COMMIT;
                                            
 
select *

delete from epay_payment_dtl
where batch_no='438961'


select *

delete from epay_payment_mst
where batch_no='438961'
                    

commit;
                       
441365,441654,438961
