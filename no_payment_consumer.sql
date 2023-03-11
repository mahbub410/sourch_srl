select C.LOCATION_CODE,SUBSTR(C.AREA_CODE,1,3) BOOK,SUBSTR(C.AREA_CODE,4) BG,C.CONS_EXTG_NUM AC,b.TARIFF,C.WALKING_SEQUENCE PAGE,C.CUSTOMER_NAME NAME
,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2 ADDRESS, C.CUSTOMER_NUM ||C.CHECK_DIGIT CUST_NUM,B.METER_NUM_KWH METER,B.METER_STATUS ST,SUM(NVL(b.TOTAL_BILL,0)) TOTAL_BILL,MAX(B.BILL_CYCLE_CODE) BILL_CYCLE_CODE
from bc_CUSTOMERS C,BC_BILL_IMAGE B,BC_CUSTOMER_ADDR A
where C.CUST_ID=A.CUST_ID
AND A.ADDR_TYPE='B'
AND A.ADDR_EXP_DATE IS NULL
AND C.CUST_ID=B.CUST_ID
--AND B.BILL_CYCLE_CODE='201812'
and (b.cust_id in(
select cust_id from bc_bill_image 
minus
select cust_id from bc_receipt_hdr
where RECEIPT_TYPE_CODE='REC'))
--and C.LOCATION_CODE='M2' 
group by C.LOCATION_CODE,SUBSTR(C.AREA_CODE,1,3) ,SUBSTR(C.AREA_CODE,4) ,C.CONS_EXTG_NUM ,b.TARIFF,C.WALKING_SEQUENCE ,C.CUSTOMER_NAME 
,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2 , C.CUSTOMER_NUM ||C.CHECK_DIGIT ,B.METER_NUM_KWH ,B.METER_STATUS,B.BILL_CYCLE_CODE
order by SUBSTR(C.AREA_CODE,1,3),SUBSTR(C.AREA_CODE,4),C.WALKING_SEQUENCE,B.BILL_CYCLE_CODE DESC




select C.LOCATION_CODE,SUBSTR(C.AREA_CODE,1,3) BOOK,SUBSTR(C.AREA_CODE,4) BG,C.CONS_EXTG_NUM AC,b.TARIFF,C.WALKING_SEQUENCE PAGE,C.CUSTOMER_NAME NAME
,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2 ADDRESS, C.CUSTOMER_NUM ||C.CHECK_DIGIT CUST_NUM,B.METER_NUM_KWH METER,B.METER_STATUS ST,SUM(NVL(b.TOTAL_BILL,0)) TOTAL_BILL
from bc_CUSTOMERS C,BC_BILL_IMAGE B,BC_CUSTOMER_ADDR A
where C.CUST_ID=A.CUST_ID
AND A.ADDR_TYPE='B'
AND A.ADDR_EXP_DATE IS NULL
AND C.CUST_ID=B.CUST_ID
--AND B.BILL_CYCLE_CODE='201812'
and (b.cust_id in(
select cust_id from bc_bill_image 
minus
select cust_id from bc_receipt_hdr
where RECEIPT_TYPE_CODE='REC'))
--and C.LOCATION_CODE='M2' 
group by C.LOCATION_CODE,SUBSTR(C.AREA_CODE,1,3) ,SUBSTR(C.AREA_CODE,4) ,C.CONS_EXTG_NUM ,b.TARIFF,C.WALKING_SEQUENCE ,C.CUSTOMER_NAME 
,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2 , C.CUSTOMER_NUM ||C.CHECK_DIGIT ,B.METER_NUM_KWH ,B.METER_STATUS
order by SUBSTR(C.AREA_CODE,1,3),SUBSTR(C.AREA_CODE,4),C.WALKING_SEQUENCE

--------

select C.LOCATION_CODE,SUBSTR(C.AREA_CODE,1,3) BOOK,SUBSTR(C.AREA_CODE,4) BG,C.CONS_EXTG_NUM AC,b.TARIFF,C.WALKING_SEQUENCE PAGE,C.CUSTOMER_NAME NAME
,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2 ADDRESS, C.CUSTOMER_NUM ||C.CHECK_DIGIT CUST_NUM,B.METER_NUM_KWH METER,B.METER_STATUS ST,MAX(b.TOTAL_BILL) TOTAL_BILL,MAX(B.BILL_CYCLE_CODE) LAST_BILL_CYCLE
from bc_CUSTOMERS C,BC_BILL_IMAGE B,BC_CUSTOMER_ADDR A
where C.CUST_ID=A.CUST_ID
AND A.ADDR_TYPE='B'
AND A.ADDR_EXP_DATE IS NULL
AND C.CUST_ID=B.CUST_ID
--AND B.CUST_ID=CID(66083094)
--AND B.BILL_CYCLE_CODE='201812'
and b.cust_id not in(
select cust_id from bc_receipt_hdr
where RECEIPT_TYPE_CODE='REC')
--and C.LOCATION_CODE='L3' 
group by C.LOCATION_CODE,SUBSTR(C.AREA_CODE,1,3) ,SUBSTR(C.AREA_CODE,4) ,C.CONS_EXTG_NUM ,b.TARIFF,C.WALKING_SEQUENCE ,C.CUSTOMER_NAME 
,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2 , C.CUSTOMER_NUM ||C.CHECK_DIGIT ,B.METER_NUM_KWH ,B.METER_STATUS
order by SUBSTR(C.AREA_CODE,1,3),SUBSTR(C.AREA_CODE,4),C.WALKING_SEQUENCE


















==========

select C.LOCATION_CODE,SUBSTR(C.AREA_CODE,1,3) BOOK,SUBSTR(C.AREA_CODE,4) BG,C.CONS_EXTG_NUM AC,b.TARIFF,C.WALKING_SEQUENCE PAGE,C.CUSTOMER_NAME NAME
,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2 ADDRESS, C.CUSTOMER_NUM ||C.CHECK_DIGIT CUST_NUM,B.METER_NUM_KWH METER,B.METER_STATUS ST,SUM(NVL(b.TOTAL_BILL,0)) TOTAL_BILL
from bc_CUSTOMERS C,BC_BILL_IMAGE B,BC_CUSTOMER_ADDR A
where C.CUST_ID=A.CUST_ID
AND A.ADDR_TYPE='B'
AND A.ADDR_EXP_DATE IS NULL
AND C.CUST_ID=B.CUST_ID
--AND B.BILL_CYCLE_CODE='201812'
and b.cust_id not in(
select cust_id from bc_receipt_hdr
where RECEIPT_TYPE_CODE='REC')
--and C.LOCATION_CODE='M2' 
group by C.LOCATION_CODE,SUBSTR(C.AREA_CODE,1,3) ,SUBSTR(C.AREA_CODE,4) ,C.CONS_EXTG_NUM ,b.TARIFF,C.WALKING_SEQUENCE ,C.CUSTOMER_NAME 
,A.ADDR_DESCR1||'-'||A.ADDR_DESCR2 , C.CUSTOMER_NUM ||C.CHECK_DIGIT ,B.METER_NUM_KWH ,B.METER_STATUS
order by SUBSTR(C.AREA_CODE,1,3),SUBSTR(C.AREA_CODE,4),C.WALKING_SEQUENCE