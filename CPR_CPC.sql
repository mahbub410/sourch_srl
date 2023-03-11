

SELECT DISTINCT 'CPC' typ,a.customer_num CUSTNO,B.bill_cycle_code bcycl,B.opn_reading opn,B.cls_reading cls,B.advance adv,
B.defective_code mcon,B.overall_mf omf,B.batch_process_flag bf,B.purpose_of_rdng rf,B.loss_consumption loss,
B.billed_value+B.loss_consumption billed,0 CPCSUM FROM ebc.bc_customer_meter a,ebc.bc_meter_reading_card_dtl B 
WHERE a.cust_id=B.cust_id AND a.check_pt_meter_id IN(SELECT equip_id FROM ebc.bc_customer_meter 
WHERE cust_id IN(SELECT cust_id FROM ebc.bc_customers 
WHERE customer_num=SUBSTR(:cons,1,7)) AND meter_status=2) AND B.bill_cycle_code=:bcycle
and meter_type_code<>'12'
UNION ALL
SELECT TTT.*,TTTT.CPCSUM FROM
(SELECT p.spl_type typ,p.customer_num||p.check_digit custno,q.bill_cycle_code bcycl,q.OPN_READING opn,q.CLS_READING cls,q.advance adv,
q.DEFECTIVE_CODE mcon,q.overall_mf omf,q.BATCH_PROCESS_FLAG bf,q.purpose_of_rdng rf,q.LOSS_CONSUMPTION loss,q.billed_value billed
FROM ebc.bc_customers p,ebc.bc_meter_reading_card_dtl q WHERE p.cust_id=q.cust_id
AND p.customer_num=SUBSTR(:cons,1,7) AND q.bill_cycle_code=:bcycle
and meter_type_code<>'12') TTT,
(SELECT 'CPR' TYP,SUM(DECODE(BILLED_VALUE,NULL,advance*overall_mf,billed_value)) CPCSUM FROM ebc.bc_meter_READING_CARD_DTL
WHERE cust_id IN(SELECT cust_id FROM ebc.bc_customer_meter
WHERE Check_pt_meter_id IN(SELECT equip_id FROM ebc.bc_customer_meter WHERE cust_id IN(SELECT cust_id
FROM ebc.BC_CUSTOMERS WHERE customer_num=SUBSTR(:cons,1,7))))
AND bill_cycle_code=:bcycle) TTTT WHERE TTT.TYP=TTTT.TYP
