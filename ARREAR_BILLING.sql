select * from 
(
select a.location_code loc,g.DESCR office,substr(a.AREA_CODE,4,2) bg,substr(a.AREA_CODE,1,3) b_k,
    a.CUSTOMER_NUM||a.CHECK_DIGIT con_no,a.WALKING_SEQUENCE wlk_or,
    a.CONS_EXTG_NUM pv_ac,substr(a.CUSTOMER_NAME,1,35) name,a.F_H_NAME "father/husband Name",
e.addr_descr1 || e.addr_descr2 || e.addr_descr3 AS addr,
            tariff tariff,f.MONTHLY_LIKELY_CONS likely,
b.METER_NUM_KWH mtr_no,
b.SANC_LOAD s_load,b.CONNECT_LOAD c_load, b.bill_cycle_code month,
nvl(ENG_CHRG_SR,0)+ 
nvl(ENG_CHRG_OFPK,0)+ nvl(ENG_CHRG_PK,0)+
nvl(minimum_CHRG,0)+nvl(service_CHRG,0)+nvl(demand_CHRG,0)+
nvl(adjusted_prn,0)+nvl(pfc_charge,0)+nvl(xf_loss_chrg,0)+nvl(xf_rent,0)
+nvl(eng_chrg_mr1,0)+nvl(eng_chrg_mr2,0)+nvl(eng_chrg_mr3,0)+nvl(eng_chrg_mr4,0)  cur_prin,
nvl(arr_adv_adj_prn,0) arr_prin, 
nvl(ENG_CHRG_SR,0)+ 
nvl(ENG_CHRG_OFPK,0)+ nvl(ENG_CHRG_PK,0)+
nvl(minimum_CHRG,0)+nvl(service_CHRG,0)+nvl(demand_CHRG,0)+
nvl(adjusted_prn,0)+nvl(pfc_charge,0)+nvl(xf_loss_chrg,0)+nvl(xf_rent,0)
+nvl(eng_chrg_mr1,0)+nvl(eng_chrg_mr2,0)+nvl(eng_chrg_mr3,0)+nvl(eng_chrg_mr4,0)+nvl(arr_adv_adj_prn,0) Total_prin_Due,
decode(b.METER_STATUS,'2','Regular','1','Temp_Discon','3','Perm_Discon') status
 from ebc.bc_customers a,ebc.bc_bill_image b,ebc.bc_customer_addr e,
ebc.bc_monthly_likely f,ebc.bc_location_master g
 where a.cust_id=b.cust_id and a.cust_id=e.cust_id and  a.cust_id=f.cust_id and
a.LOCATION_CODE=g.LOCATION_CODE 
--and a.location_code=:loc 
and b.bill_cycle_code='202202'
and e.addr_type='B'
and b.invoice_num is not null
and b.Tariff in ('LT-C1','LT-E','MT-2','MT-3','HT-2','HT-3')
and b.invoice_num is not null and f.EXP_DATE is null and e.ADDR_EXP_DATE is null
order by nvl(arr_adv_adj_prn,0) desc)
where rownum<=40