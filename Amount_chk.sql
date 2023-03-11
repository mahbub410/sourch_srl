
select * from BC_CUSTOMER_CATEGORY
where cust_id=cid(41448038)

select * from bc_category_master
where CATEGORY_ID in (select CAT_ID from BC_CUSTOMER_CATEGORY
where cust_id=cid(41448038) and EXP_DATE is null)

select * from bc_customer_meter
WHERE cust_id  =cid(41448038)


select * from bc_equip_mast
where equip_id in (
1594882,
1594883
)


select * from bc_loc_area_change
WHERE cust_id =cid(:p_cust_id)

---------

select * from  BC_meter_reading_card_dtl
WHERE cust_id  =cid(41448038)
order by bill_cycle_code desc


select A.METER_ID,A.PREV_READING_DATE,A.READING_DATE,A.BILL_CYCLE_CODE,A.OPN_READING,A.CLS_READING,A.ADVANCE,A.BILLED_VALUE,A.NET_VALUE,A.DEFECTIVE_CODE 
from  BC_meter_reading_card_dtl a
WHERE cust_id  =cid(21885594)
order by bill_cycle_code desc


select * from bc_customer_event_log
where CUST_ID in (select cust_id from bc_customers where
cust_id  =cid(41448038))


AND BILL_CYCLE_CODE='201810'


select * from BC_meter_reading_card_dtl
WHERE cust_id =cid(55869371)
AND BILLED_VALUE IS NOT NULL
AND NET_VALUE IS NULL
order by bill_cycle_code desc


select * from BC_meter_reading_card_hdr
WHERE area_code='D8405'
order by bill_cycle_code desc


select * from BC_EQUIP_MAST
--WHERE cust_id =cid(55869371)


select * from BC_CUSTOMERS
WHERE cust_id =cid(41448038)



 
select * from BC_CUSTOMER_CATEGORY
where cust_id in 
(select cust_id from BC_CUSTOMERS
WHERE cust_id not in (select cust_id from bc_customer_event_log where bill_cycle_code='201801')
and substr (AREA_CODE,4,2)='01'
and locAtion_code='L6'
AND CUSTOMER_STATUS_CODE='C')
and EXP_DATE ='07-NOV-2017'
AND EFF_DATE='08-NOV-2017'

select * from bc_customer_event_log
where CUST_ID in (select cust_id from bc_customers where
customer_num ='6755895')


select RECEIPT_NUM,RECEIPT_DATE,RECEIPT_AMT,RECEIPT_OFFSET,VAT_AMT,VAT_OFFSET,PAID_INVOICE_NUM,REC_STATUS from bc_receipt_hdr
where cust_id=cid(:p_cust_id)
order by RECEIPT_DATE desc

select * from bc_receipt_hdr
where cust_id=cid(:p_cust_id)
order by RECEIPT_DATE desc

select * from bc_invoice_hdr
where cust_id=cid(:p_cust_id)
order by bill_cycle_code desc

select * from bc_invoice_receipt_map
where receipt_num=:p_receipt_num
  
select * from bc_invoice_dtl
where INVOICE_NUM ='69140125'

IN (SELECT INVOICE_NUM FROM bc_invoice_hdr where cust_id =cid(50551086) and bill_cycle_code='201807')
AND  UPDATE_DATE IS NOT NULL
ORDER BY  UPDATE_DATE DESC



select * from BC_INVOICE_ADJUSTMENTS
where invoice_num=:p_invoice_num

select * from bc_invoice_receipt_map
where invoice_num=:p_invoice_num

select * from BC_meter_reading_card_dtl
WHERE cust_id =cid(:p_cust_id)
order by bill_cycle_code desc


select * from bc_invoice_hdr
where cust_id =cid(:p_cust_id)
--and BILL_CYCLE_CODE =:p_BILL_CYCLE_CODE
order by bill_cycle_code desc


select * from bc_invoice_dtl
where invoice_num=:p_invoice_num


select * from bc_receipt_hdr
where cust_id=cid(:p_cust_id)
order by RECEIPT_DATE desc


select * from bc_invoice_receipt_map
where receipt_num=:p_receipt_num
  

select rec_status,a.* from bc_invoice_hdr a
where cust_id =cid(:p_cust_id)
--and BILL_CYCLE_CODE =:p_BILL_CYCLE_CODE
order by bill_cycle_code desc


SELECT BILL_CYCLE_CODE bill_cycle,location_code,area_code,CUSTOMER_NUM||CONS_CHK_DIGIT CUST_NUM,INVOICE_NUM INV_NUM,INVOICE_DATE INV_DT,INVOICE_DUE_DATE INV_DUE_DT,RCPT_DATE_1,RCPT_DATE_2,RCPT_DATE_3,
    CONS_KWH_SR UNIT, (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)) CURR_BILL,RCPT_PRN_1, CURRENT_VAT CURR_VAT,CURRENT_LPS,UNADJUSTED_PRN,ARR_ADV_ADJ_PRN,ARR_ADV_ADJ_LPS, ARR_ADV_ADJ_VAT,NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0) ADJ_PRN, ADJUSTED_VAT ADJ_VAT,ADJUSTED_LPS,TOTAL_BILL,
       nvl(RCPT_PRN_1,0)+nvl(RCPT_PRN_2,0)+nvl(RCPT_PRN_3,0)+nvl(RCPT_VAT_1,0)+nvl(RCPT_VAT_2,0)+nvl(RCPT_VAT_3,0) total_receipt,RCPT_PRN_1,RCPT_PRN_2,RCPT_VAT_1,RCPT_VAT_2,RCPT_VAT_3,                
       TARIFF,CUST_STATUS,ARR_PRN_N_SRCHG1,
       ARR_PRN_N_SRCHG2,ARR_PRN_N_SRCHG3,ARR_PRN_N_SRCHG4,ARR_PRN_N_SRCHG5,ARR_PRN_N_SRCHG6,ARR_PRN_N_SRCHG7,ARR_PRN_N_SRCHG8,ARR_PRN_N_SRCHG9,ARR_PRN_N_SRCHG10,
       ARR_PRN_N_SRCHG11,ARR_PRN_N_SRCHG12,ARR_VAT_1,ARR_VAT_2,ARR_VAT_3,ARR_VAT_4,ARR_VAT_5,ARR_VAT_6,ARR_VAT_7,ARR_VAT_8,ARR_VAT_9,ARR_VAT_10,ARR_VAT_11,ARR_VAT_12
FROM   BC_BILL_IMAGE
WHERE cust_id =cid(:p_cust_id)
AND INVOICE_NUM IS NOT  NULL
--AND CONS_KWH_SR='100'
ORDER BY BILL_CYCLE_CODE DESC

select *FROM   BC_BILL_IMAGE
WHERE cust_id =cid(:p_cust_id)
--and  BILL_CYCLE_CODE =:p_BILL_CYCLE_CODE
ORDER BY BILL_CYCLE_CODE DESC


select BILL_CYCLE_CODE,PRINCIPAL_AMT+PRINCIPAL_ADJ-PRINCIPAL_APPL prn,LPS_AMT+LPS_ADJ-LPS_APPL lps,VAT_AMT+VAT_ADJ-VAT_APPL vat from bc_invoice_hdr
where cust_id =cid(:p_cust_id)

select * from  bc_invoice_hdr
where cust_id =cid(:p_cust_id)
--and bill_cycle_code='201807'
AND INVOICE_NUM IS NOT NULL
ORDER BY BILL_CYCLE_CODE DESC


select * from BC_customer_CATEGORY
WHERE cust_id =cid(:p_cust_id)


select * from BC_CATEGORY_MASTER
where CATEGORY_id=:p_CATEGORY_id

select * from BC_TARIFF_RATE_MASTER
where TARIFF_id=:p_TARIFF_id
and EFF_END_BILL_CYCLE is null

select * from BC_BILL_CYCLE_CORR_MAP
WHERE cust_id =cid(:p_cust_id)
order by BILL_CYCLE desc



select rec_status,a.* from bc_invoice_hdr a
where cust_id =cid(:p_cust_id)
--and BILL_CYCLE_CODE =:p_BILL_CYCLE_CODE
order by bill_cycle_code desc


select * from bc_invoice_dtl
where invoice_num=:p_invoice_num

select * from BC_TARIFF_TYPE_CODE
where TARIFF_TYPE_CODE in (select TARIFF_TYPE_CODE from bc_invoice_dtl where invoice_num=:p_invoice_num)
order by TARIFF_TYPE_CODE



55557315		30/May/19
55186108		05/May/19

select RECEIPT_NUM,RECEIPT_TYPE_CODE,BATCH_NUM,
RECEIPT_DATE,CUST_ID,RECEIPT_AMT,VAT_AMT,INVOICE_NUM,
REC_STATUS,RECEIPT_OFFSET,VAT_OFFSET,(RECEIPT_AMT-RECEIPT_OFFSET) DFF_AMT ,(VAT_AMT-VAT_OFFSET) DFF_VAT_AMT from bc_receipt_hdr
where cust_id=cid(:p_cust_id)
--where invoice_num='55557315'
order by RECEIPT_DATE desc 

select SUM(PRINCIPAL_AMT_LPS) PRINCIPAL_AMT, SUM(VAT_AMT) VAT_AMT, SUM(LPS_AMT) LPS_AMT, SUM(PRINCIPAL_AMT_LPS+VAT_AMT+LPS_AMT) TOTAL  
from  BC_INVOICE_RECEIPT_MAP
where receipt_num=:p_receipt_num

select *  from  BC_INVOICE_RECEIPT_MAP
where receipt_num=:p_receipt_num


SELECT * FROM BC_CUSTOMER_EVENT_LOG
WHERE cust_id =cid(:p_cust_id)

UPDATE  bc_invoice_hdr
SET  REC_STATUS ='D'
where cust_id =cid(:p_cust_id)
and BILL_CYCLE_CODE <:p_BILL_CYCLE_CODE
and REC_STATUS in ('M','C','F')
--order by bill_cycle_code desc


select * from BC_CONNECTED_LOAD
where cust_id=cid()


SELECT B.TARIFF,BILL_CYCLE_CODE bill_cycle,b.location_code,b.area_code,b.CUSTOMER_NUM||b.CONS_CHK_DIGIT CUST_NUM,c.CUSTOMER_NAME,ADDR_DESCR1||'-'||ADDR_DESCR2||'-'||ADDR_DESCR3 addres,
    (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)) CURR_BILL,CURRENT_VAT CURR_VAT,NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0)+nvl(ARR_ADV_ADJ_PRN,0) ADJ_PRN,ARR_ADV_ADJ_VAT,ARR_ADV_ADJ_LPS,TOTAL_BILL
FROM   BC_BILL_IMAGE b,bc_customers c,BC_CUSTOMER_ADDR ca
WHERE b.cust_id=c.cust_id 
and b.cust_id=ca.cust_id
and ca.ADDR_TYPE='B'
and b.CUSTOMER_NUM||b.CONS_CHK_DIGIT in ('78474467','78724116')
AND INVOICE_NUM IS NOT  NULL
--AND CONS_KWH_SR='100'
and bill_cycle_code='202203'