select 'Average Consumtion Comp. ' rep_name, ADDR_1 Comp_center, L.LOCATION_CODE,L.DESCR,C.AREA_CODE,C.CUSTOMER_NUM||C.CHECK_DIGIT CUSTOMER_NUM,C.CUSTOMER_NAME,i.tariff,
ad.ADDR_DESCR1||','||ad.ADDR_DESCR2||','||ad.ADDR_DESCR3 as ADDRess,
a.cust_id,AVG_CONS_2014,AVG_CONS_2015,AVG_CONS_2015-AVG_CONS_2014 dif
from EMPOWER_HOME,bc_customers c,bc_location_master l,bc_customer_addr ad
, (select cust_id, round(AVG(nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)+ nvl(CONS_KWH_OFPK,0)+nvl(OLD_KWH_OFPK_CONS,0)
+nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(adjusted_cons,0)))  AVG_CONS_2014
from bc_bill_image
where  invoice_num is not null
and substr(bill_cycle_code,1,4) in ('2014')
group by cust_id ) a,(select cust_id, round( AVG(nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)+ nvl(CONS_KWH_OFPK,0)+nvl(OLD_KWH_OFPK_CONS,0)
+nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(adjusted_cons,0)))  AVG_CONS_2015
from bc_bill_image
where  invoice_num is not null
and substr(bill_cycle_code,1,4) in ('2015')
group by cust_id ) b, bc_bill_image i
where i.cust_id=c.cust_id
and i.invoice_num is not null
and i.bill_cycle_code='201512'
and i.meter_status=2 and 
a.cust_id=b.cust_id
and AVG_CONS_2015<=AVG_CONS_2014
and C.LOCATION_CODE=L.LOCATION_CODE
and a.cust_id=c.cust_id
and ad.cust_id=c.cust_id
and ad.ADDR_TYPE='M'
and ad.ADDR_EXP_DATE is null
order by AVG_CONS_2015-AVG_CONS_2014 asc