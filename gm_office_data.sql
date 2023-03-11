

-----------tdc above 3 months

select a.location_code,B.DESCR loc_name,c.start_date,f.area_code book_no,f.CONS_EXTG_NUM acc_no,A.TARIFF,f.WALKING_SEQUENCE walking_order,
f.customer_name,D.ADDR_DESCR1||' '||D.ADDR_DESCR2 address, f.customer_num||CHECK_DIGIT consumer_num,A.METER_NUM_KWH meter_num,
NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)  arr_prin,
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)  vat_arr,
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) lps_arr,
   NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0) +
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)+
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) total_arr
 from bc_bill_image a,bc_location_master b,
(select cust_id,min(METER_CONNECT_DATE) start_date from bc_customer_meter group by cust_id) c,bc_customer_addr d,
(select a.cust_id,months_between(to_date(max(a.bill_cycle_code),'RRRRMM'),to_date(min(a.bill_cycle_code),'RRRRMM'))+1 no_of_td_month from bc_bill_image a,
(select cust_id,max(bill_cycle_code) bill_cycle_code  from bc_bill_image
where meter_status='2'
group by cust_id) b
where  a.meter_status=1
and a.bill_cycle_code<='201907'
and a.cust_id=b.cust_id
and a.bill_cycle_code>b.bill_cycle_code
group by a.cust_id
order by a.cust_id ) e,bc_customers f
where A.LOCATION_CODE=B.LOCATION_CODE
and a.cust_id=c.cust_id
and a.cust_id=d.cust_id
and D.ADDR_TYPE='B'
and a.cust_id=e.cust_id
and e.no_of_td_month>=3
and a.cust_id=f.cust_id
and A.BILL_CYCLE_CODE='201907'
and B.LOCATION_CODE=f.location_code


----double account


select a.location_code,B.DESCR loc_name,c.start_date,f.area_code book_no,f.CONS_EXTG_NUM acc_no,A.TARIFF,f.WALKING_SEQUENCE walking_order,
f.customer_name,D.ADDR_DESCR1||' '||D.ADDR_DESCR2 address, f.customer_num||f.CHECK_DIGIT consumer_num,A.METER_NUM_KWH meter_num,
NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)  arr_prin,
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)  vat_arr,
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) lps_arr,
   NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0) +
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)+
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) total_arr
 from bc_bill_image a,bc_location_master b,
(select cust_id,min(METER_CONNECT_DATE) start_date from bc_customer_meter group by cust_id) c,bc_customer_addr d,
(select a.cust_id,b.meter_num,a.location_code,a.CONS_EXTG_NUM from bc_customers a,bc_customer_meter b
where (a.CONS_EXTG_NUM,a.location_code,a.customer_name,b.meter_num) in(
select CONS_EXTG_NUM,location_code,customer_name,meter_num
from (
select a.CONS_EXTG_NUM,a.location_code,a.customer_name,b.meter_num,count(1) from bc_customers a,bc_customer_meter b
where a.cust_id=b.cust_id
and a.CUSTOMER_STATUS_CODE='C'
group by a.CONS_EXTG_NUM,a.location_code,a.customer_name,b.meter_num
having count(1)>1))
and a.cust_id=b.cust_id ) e,bc_customers f
where A.LOCATION_CODE=B.LOCATION_CODE
and a.cust_id=c.cust_id
and a.cust_id=d.cust_id
and D.ADDR_TYPE='B'
and a.cust_id=e.cust_id
and a.meter_num_kwh=e.meter_num
and a.location_code=e.location_code
and a.CONS_EXTG_NUM=e.CONS_EXTG_NUM
and a.cust_id=f.cust_id
and A.LOCATION_CODE=:loc
and A.BILL_CYCLE_CODE='201907'
and B.LOCATION_CODE=f.location_code
order by location_code



--Lt-D1 customer arrear

select a.location_code,B.DESCR loc_name,c.start_date,f.area_code book_no,f.CONS_EXTG_NUM acc_no,A.TARIFF,f.WALKING_SEQUENCE walking_order,
f.customer_name,D.ADDR_DESCR1||' '||D.ADDR_DESCR2 address, f.customer_num||f.CHECK_DIGIT consumer_num,A.METER_NUM_KWH meter_num,
NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)  arr_prin,
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)  vat_arr,
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) lps_arr,
   NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0) +
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)+
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) total_arr
 from bc_bill_image a,bc_location_master b,
(select cust_id,min(METER_CONNECT_DATE) start_date from bc_customer_meter group by cust_id) c,bc_customer_addr d,
(select cust_id
from (
 select cust_id,bill_cycle_code,
sum(invoice_amount-applied_amount+adjusted_amount) arr from bc_invoice_dtl a, bc_invoice_hdr b
where a.invoice_num=b.invoice_num 
and  bill_cycle_code<'201907'
and invoice_amount-applied_amount+adjusted_amount>0
group by cust_id,bill_cycle_code)
where arr>1
group by cust_id
having count(1)>2) e,bc_customers f
where A.LOCATION_CODE=B.LOCATION_CODE
and a.cust_id=c.cust_id
and a.cust_id=d.cust_id
and D.ADDR_TYPE='B'
and a.cust_id=e.cust_id
and a.cust_id=f.cust_id
and  A.BILL_CYCLE_CODE='201907'
and a.tariff='LT-D1'
and B.LOCATION_CODE=f.location_code
ORDER BY LOCATION_CODE 






















-------------------------------------------------OLD--------------------------------------

-----------tdc above 3 months

select a.location_code,B.DESCR loc_name,c.start_date,f.area_code book_no,f.CONS_EXTG_NUM acc_no,A.TARIFF,f.WALKING_SEQUENCE walking_order,
f.customer_name,D.ADDR_DESCR1||' '||D.ADDR_DESCR2 address, f.customer_num||CHECK_DIGIT consumer_num,A.METER_NUM_KWH meter_num,
NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)  arr_prin,
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)  vat_arr,
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) lps_arr,
   NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0) +
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)+
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) total_arr
 from bc_bill_image a,bc_location_master b,
(select cust_id,min(METER_CONNECT_DATE) start_date from bc_customer_meter group by cust_id) c,bc_customer_addr d,
(select a.cust_id,months_between(to_date(max(a.bill_cycle_code),'RRRRMM'),to_date(min(a.bill_cycle_code),'RRRRMM'))+1 no_of_td_month from bc_bill_image a,
(select cust_id,max(bill_cycle_code) bill_cycle_code  from bc_bill_image
where location_code=:loc
and meter_status='2'
group by cust_id) b
where  a.meter_status=1
and a.bill_cycle_code<='201907'
and a.cust_id=b.cust_id
and a.bill_cycle_code>b.bill_cycle_code
group by a.cust_id
order by a.cust_id ) e,bc_customers f
where A.LOCATION_CODE=B.LOCATION_CODE
and a.cust_id=c.cust_id
and a.cust_id=d.cust_id
and D.ADDR_TYPE='B'
and a.cust_id=e.cust_id
and e.no_of_td_month>=3
and a.cust_id=f.cust_id
and A.BILL_CYCLE_CODE='201907'
and B.LOCATION_CODE=f.location_code


----double account


select a.location_code,B.DESCR loc_name,c.start_date,f.area_code book_no,f.CONS_EXTG_NUM acc_no,A.TARIFF,f.WALKING_SEQUENCE walking_order,
f.customer_name,D.ADDR_DESCR1||' '||D.ADDR_DESCR2 address, f.customer_num||f.CHECK_DIGIT consumer_num,A.METER_NUM_KWH meter_num,
NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)  arr_prin,
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)  vat_arr,
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) lps_arr,
   NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0) +
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)+
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) total_arr
 from bc_bill_image a,bc_location_master b,
(select cust_id,min(METER_CONNECT_DATE) start_date from bc_customer_meter group by cust_id) c,bc_customer_addr d,
(select * from bc_customers
where (CONS_EXTG_NUM,location_code,customer_name) in(
select CONS_EXTG_NUM,location_code,customer_name
from (
select CONS_EXTG_NUM,location_code,customer_name,count(1) from bc_customers
group by CONS_EXTG_NUM,location_code,customer_name
having count(1)>1)) ) e,bc_customers f
where A.LOCATION_CODE=B.LOCATION_CODE
and a.cust_id=c.cust_id
and a.cust_id=d.cust_id
and D.ADDR_TYPE='B'
and a.cust_id=e.cust_id
and a.cust_id=f.cust_id
and A.LOCATION_CODE=:loc
and A.BILL_CYCLE_CODE='201907'
and B.LOCATION_CODE=f.location_code




--Lt-D1 customer arrear

select a.location_code,B.DESCR loc_name,c.start_date,f.area_code book_no,f.CONS_EXTG_NUM acc_no,A.TARIFF,f.WALKING_SEQUENCE walking_order,
f.customer_name,D.ADDR_DESCR1||' '||D.ADDR_DESCR2 address, f.customer_num||f.CHECK_DIGIT consumer_num,A.METER_NUM_KWH meter_num,
NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)  arr_prin,
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)  vat_arr,
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) lps_arr,
   NVL(a.arr_adv_adj_prn,0) + NVL(a.adjusted_prn,0)+
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0) +
   NVL(a.arr_adv_adj_vat,0) + NVL(a.adjusted_vat,0) +NVL(a.current_vat,0)+
   NVL(a.arr_adv_adj_lps,0) + NVL(a.adjusted_lps,0)+nvl(Current_lps,0) total_arr
 from bc_bill_image a,bc_location_master b,
(select cust_id,min(METER_CONNECT_DATE) start_date from bc_customer_meter group by cust_id) c,bc_customer_addr d,
(select cust_id
from (
 select cust_id,bill_cycle_code,
sum(invoice_amount-applied_amount+adjusted_amount) arr from bc_invoice_dtl a, bc_invoice_hdr b
where a.invoice_num=b.invoice_num 
and  bill_cycle_code<'201907'
and invoice_amount-applied_amount+adjusted_amount>0
group by cust_id,bill_cycle_code)
where arr>1
group by cust_id
having count(1)>2) e,bc_customers f
where A.LOCATION_CODE=B.LOCATION_CODE
and a.cust_id=c.cust_id
and a.cust_id=d.cust_id
and D.ADDR_TYPE='B'
and a.cust_id=e.cust_id
and a.cust_id=f.cust_id
and A.LOCATION_CODE=:loc
and A.BILL_CYCLE_CODE='201907'
and a.tariff='LT-D1'
and B.LOCATION_CODE=f.location_code