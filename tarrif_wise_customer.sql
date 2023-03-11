select * from BC_CUSTOMERS

select * from bc_bill_image

20409
20408
20411

select * from BC_CUSTOMER_CATEGORY
where CREATE_BY='SYSADMIN'

EXP_DATE is null

select * from BC_CATEGORY_MASTER
where CATEGORY_ID='20017'

select * from BC_CUSTOMER_CATEGORY
where cat_id='20407'

6,211
,substr(C.AREA_CODE,4) bill_group

select substr(C.AREA_CODE,1,3) book,count(*) no_of_cons,B.TARIFF,decode(CUSTOMER_STATUS_CODE,'C','Connected','D','Disconnected') con_ststus 
from bc_bill_image b,BC_CUSTOMERS c
where B.CUST_ID=C.CUST_ID
and B.LOCATION_CODE=C.LOCATION_CODE
and B.BILL_CYCLE_CODE='201902'
group by substr(C.AREA_CODE,1,3),B.TARIFF,decode(CUSTOMER_STATUS_CODE,'C','Connected','D','Disconnected') 
order by 1 


5,703