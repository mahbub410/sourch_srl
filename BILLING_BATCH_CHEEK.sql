
SELECT *  FROM BC_RECEIPT1_INT_DTL
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT1_INT_HDR
WHERE BATCH_NUM='9797070836')

SELECT *  FROM BC_RECEIPT1_INT_HDR
WHERE BATCH_NUM='9797070836'

SELECT *  FROM BC_RECEIPT2_INT_DTL
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT2_INT_HDR
WHERE BATCH_NUM='9797070836')

SELECT *  FROM BC_RECEIPT2_INT_HDR
WHERE BATCH_NUM='9797070836'


SELECT *  FROM BC_RECEIPT_BATCH_CONTROL
WHERE BATCH_NUM='9797070836'

SELECT *  FROM BC_RECEIPT_BATCH_HDR
WHERE BATCH_NUM='9797070836'


SELECT *  FROM BC_RECEIPT_HDR
WHERE BATCH_NUM='9797070836'


SELECT *  FROM EPAY_RECEIPT_BATCH_HDR_PDB
WHERE --BATCH_NUM_EPAY='330514'
BATCH_NUM_PDB='9797070836'

COMMIT;

SELECT *  FROM BC_RECEIPT1_INT_DTL_TEMP
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT1_INT_HDR_TEMP
WHERE BATCH_NUM='9797070836')


SELECT *  FROM BC_RECEIPT1_INT_HDR_TEMP
WHERE BATCH_NUM='9797070836'


SELECT *  FROM BC_RECEIPT2_INT_DTL_TEMP
WHERE REC_INT_ID IN (SELECT REC_INT_ID FROM BC_RECEIPT2_INT_HDR_TEMP
WHERE BATCH_NUM='9797070836')


SELECT *  FROM BC_RECEIPT2_INT_HDR_TEMP
WHERE BATCH_NUM='9797070836'