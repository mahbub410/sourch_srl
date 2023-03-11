
select * from bc_location_master
where DESCR like '%RAJ%'

SELECT BC.CUSTOMER_NAME,
TO_NUMBER(ROUND(SUM(NVL(CD.NET_VALUE,0))))+
ROUND(SUM(NVL(CD.BUS_LOSS,0)))+
ROUND(SUM(NVL(CD.LINE_LOSS,0)))+
ROUND(SUM(NVL(CD.LOSS_CONSUMPTION,0))) NET
FROM UBILL.BC_UTILITY_BILL_ENTRY_HDR A,
UBILL.BC_METER_GRID_CK_COMB_BILL_MST B,
UBILL.BC_METER_GRID_CK_COMB_BILL_DTL C,
UBILL.BC_UTILITY_BILL_ENTRY_DTL D,
EBC.BC_VOLTAGE_CATEGORY_CODE  VCM,
(SELECT CUST_ID,BILL_CYCLE_CODE,METER_ID,TIME_CYCLE_CODE,MAX(PFC) PFC,SUM(NET_VALUE) NET_VALUE,SUM(NVL(LINE_LOSS,0)+NVL(LINE_LOSS_ADJ,0)) LINE_LOSS,SUM(PFC_UNIT) PFC_UNIT,
SUM(NVL(BUS_LOSS,0)+NVL(BUS_LOSS_ADJ,0)) BUS_LOSS,SUM(LOSS_CONSUMPTION) LOSS_CONSUMPTION 
FROM BC_METER_READING_CARD_DTL 
 WHERE READING_TYPE_CODE=2
GROUP BY CUST_ID,BILL_CYCLE_CODE,METER_ID,TIME_CYCLE_CODE) CD,
BC_CUSTOMERS BC
WHERE A.GRID_ID=B.GRID_ID
AND A.BILL_CYCLE_CODE=:P_BILL_CYCLE
--and b.grid_id=113
--AND CD.CUST_ID=EBC.CID(:P_CUST_NUM)
AND bc.location_code=upper(:p_loc)
---AND C.CUST_NUM=:P_CUST_NUM
AND C.CUST_ID=BC.CUST_ID
AND VCM.VOLTAGE_CATEGORY_CODE=C.VOLTAGE_CATEGORY_CODE
AND A.ENTRY_ID=D.ENTRY_ID
AND C.EQUIP_ID=D.EQUIP_ID
AND CD.BILL_CYCLE_CODE=:P_BILL_CYCLE
AND CD.METER_ID=D.EQUIP_ID
AND CD.TIME_CYCLE_CODE=D.TIME_CYCLE_CODE
GROUP by BC.CUSTOMER_NAME
ORDER by 1