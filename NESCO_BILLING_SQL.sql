Location, area code, customer number, customer name, address,tariff, walking sequence, pre.acc.num, OMF_KWH, CLS_KWH_SR_RDNG, 
Meter num, SANC_LOAD, CONNECT_LOAD, C_MONTH_UNIT, Current PRINCIPAL, Current VAT, Current LPS, TOTAL_BILL 

SELECT C.LOCATION_CODE LOCATION,C.AREA_CODE,C.CUSTOMER_NUM,C.CUSTOMER_NAME NAME,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2 ADDRES,MM.USAGE_CATEGORY_CODE TARIFF,
C.WALKING_SEQUENCE ,C.CONS_EXTG_NUM AC_NUM,BI.OMF_KWH,BI.CLS_KWH_SR_RDNG, CM.METER_NUM METER,SL.SANCTIONED_LOAD S_LOAD,CL.CONNECTED_LOAD C_LOAD
,BI.CONS_KWH_SR UNIT,(NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)) CURR_BILL,CURRENT_VAT CURR_VAT,BI.CURRENT_LPS, (NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0))+NVL(CURRENT_VAT,0)+NVL(CURRENT_LPS,0) AS TOTAL_BILL
FROM BC_CUSTOMER_METER CM,BC_METER_SUPPLY MS,BC_PHASE_INFO PI,BC_CUSTOMERS C,
BC_CUSTOMER_CATEGORY CC,BC_CATEGORY_MASTER MM,BC_CUSTOMER_ADDR A,BC_CONNECTED_LOAD CL,BC_SANCTIONED_LOAD SL,BC_BILL_IMAGE BI
WHERE C.CUST_ID=SL.CUST_ID
AND SL.CUST_ID=CL.CUST_ID
--and cl.EFF_DATE >='01-jan-2015'
AND C.CUST_ID=A.CUST_ID
AND A.ADDR_TYPE='M'
AND A.ADDR_EXP_DATE IS NULL
AND C.CUST_ID=CC.CUST_ID
AND CM.CUST_ID=BI.CUST_ID
AND C.CUST_ID=BI.CUST_ID
AND A.CUST_ID=BI.CUST_ID
AND CC.EXP_DATE IS NULL
AND CC.CAT_ID=MM.CATEGORY_ID
AND C.CUST_ID=CM.CUST_ID 
AND CM.CONNECTION_ID=MS.CONNECTION_ID 
AND MS.SUPPLY_ID=PI.SUPPLY_ID 
AND BI.BILL_CYCLE_CODE=:P_BILL_CYCLE_CODE
AND C.LOCATION_CODE=:P_LOCATION_CODE
GROUP BY C.LOCATION_CODE,C.AREA_CODE,C.CONS_EXTG_NUM,CM.METER_NUM,C.WALKING_SEQUENCE,C.CUSTOMER_NAME,SL.SANCTIONED_LOAD,CL.CONNECTED_LOAD
,MM.USAGE_CATEGORY_CODE,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2,C.CUSTOMER_NUM,C.START_BILL_CYCLE,BI.CONS_KWH_SR,(NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)),CURRENT_VAT,BI.CURRENT_LPS,BI.OMF_KWH,BI.CLS_KWH_SR_RDNG
ORDER BY C.AREA_CODE,C.CONS_EXTG_NUM,C.WALKING_SEQUENCE,C.CUSTOMER_NAME,SL.SANCTIONED_LOAD,CL.CONNECTED_LOAD
,MM.USAGE_CATEGORY_CODE,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2,C.CUSTOMER_NUM,C.START_BILL_CYCLE