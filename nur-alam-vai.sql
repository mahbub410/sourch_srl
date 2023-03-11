
--01	Government
--03	Autonomous

select LOCATION_CODE,CUSTOMER_NUM||CONS_CHK_DIGIT CUSTOMER_NUM from BC_bill_image
where CUST_STATUS='03'
group by LOCATION_CODE,CUSTOMER_NUM||CONS_CHK_DIGIT

and cust_id in (

select * from bc_customer_meter 
where cust_id=cid(66076566)

------Government

select bi.LOCATION_CODE,bi.CUSTOMER_NUM||bi.CONS_CHK_DIGIT CUSTOMER_NUM,decode(cm.METER_STATUS,'2','Connected','1','TDC','3','PDC') METER_STATUS from BC_bill_image bi,bc_customer_meter cm
where bi.CUST_ID = cm.CUST_ID
and bi.CUST_STATUS='01'
and cm.METER_STATUS<>'5'
group by bi.LOCATION_CODE,bi.CUSTOMER_NUM||bi.CONS_CHK_DIGIT,cm.METER_STATUS
order by 1


--------Autonomous

select bi.LOCATION_CODE,bi.CUSTOMER_NUM||bi.CONS_CHK_DIGIT CUSTOMER_NUM,decode(cm.METER_STATUS,'2','Connected','1','TDC','3','PDC') METER_STATUS from BC_bill_image bi,bc_customer_meter cm
where bi.CUST_ID = cm.CUST_ID
and bi.CUST_STATUS='03'
and cm.METER_STATUS<>'5'
group by bi.LOCATION_CODE,bi.CUSTOMER_NUM||bi.CONS_CHK_DIGIT,cm.METER_STATUS
order by 1


----------Religious

select LOCATION_CODE,CUSTOMER_NUM||CONS_CHK_DIGIT CUSTOMER_NUM from BC_bill_image
where BUS_TYPE_CODE='42'
group by LOCATION_CODE,CUSTOMER_NUM||CONS_CHK_DIGIT

select * from BC_bill_image