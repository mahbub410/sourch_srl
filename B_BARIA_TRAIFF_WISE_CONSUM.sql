
SELECT * FROM BC_BILL_IMAGE
WHERE LOCATION_CODE='C3'
AND BILL_CYCLE_CODE='201905'
AND BILL_GROUP='15'
--and cust_id='300171129'
 
     

SELECT BILL_CYCLE_CODE,BILL_GROUP,TARIFF,COUNT(*),SUM(NVL(CONS_KWH_SR,0)+NVL(CONS_KWH_OFPK,0)+NVL(CONS_KWH_PK,0)+NVL(OLD_KWH_SR_CONS,0)+NVL(OLD_KWH_OFPK_CONS,0)+
NVL(OLD_KWH_PK_CONS,0)+NVL(CONS_KVARH_SR,0)+NVL(OLD_KVARH_SR_CONS,0)+NVL(CONS_KVARH_OFPK,0)+NVL(OLD_KVARH_OFPK_CONS,0)+NVL(CONS_KVARH_PK,0)+NVL(OLD_KVARH_PK_CONS,0)) TOT_CONSUMPTION
FROM BC_BILL_IMAGE
WHERE LOCATION_CODE='C3'
AND BILL_CYCLE_CODE='201801'
AND BILL_GROUP='16'
--and cust_id='300171129'
GROUP BY BILL_CYCLE_CODE,BILL_GROUP,TARIFF
ORDER BY 3





