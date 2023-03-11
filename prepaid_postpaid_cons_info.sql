
select a.LOC,a.MONTH,a.NO_CON pre_con,a.MNL_UNT pre_MNL_UNT,a.MNL_PRN pre_MNL_PRN,a.MNL_VAT pre_MNL_VAT,a.T_PRN_COLL pre_T_PRN_COLL,a.T_VAT_COLL pre_T_VAT_COLL,
b.NCON,b.BLD_UNIT,b.BLD_AMT,b.OUT_PRIN,b.OUT_SUR,b.COLL_BPDB from (
select b.LOCATION_CODE loc,b.BILL_CYCLE_CODE
month,sum(b.LIVE_CONSUMER_MONTH_END_MNL) no_con,
sum(b.TOTAL_ENERGY_SOLD_MNL) mnl_unt,sum(b.TOTAL_PRINCIPAL_BILLED_MNL)
mnl_prn,
sum(b.TOTAL_VAT_BILLED_MNL) mnl_vat,sum(b.TOTAL_COLLECTION_MNL) t_prn_coll,
sum(B.TOTAL_VAT_COLLECTION_MNL) t_vat_coll
from ebc.bc_feedermod_manual_input b
where b.BILL_CYCLE_CODE=:bil_cy
group by b.LOCATION_CODE ,b.BILL_CYCLE_CODE
order by loc,month )a,(
select a.loc loc,c.descr loc_name,bill_cycle_code month,a.ncon,
a.t_unit bld_unit,a.t_chrg bld_amt,
a.arr_prn out_prin,a.arr_lps out_sur,a.coll_bpdb
from
(select location_code loc,bill_cycle_code,count(*) ncon,sum(nvl(CONS_KWH_SR,0)+
nvl(CONS_KWH_OFPK,0)+ nvl(CONS_KWH_PK,0)+nvl(old_kwh_sr_cons,0)+
nvl(old_kwh_ofpk_cons,0)+nvl(old_kwh_pk_cons,0)+nvl(adjusted_cons,0)
+nvl(pfc_sr_cons,0)+nvl(pfc_ofpk_cons,0)+nvl(pfc_pk_cons,0)+
nvl(xf_loss_sr_cons,0)+nvl(xf_loss_ofpk_cons,0)+
nvl(xf_loss_pk_cons,0)+nvl(cons_kwh_mr1,0)+nvl(cons_kwh_mr2,0)+nvl(cons_kwh_mr3,0)+
nvl(cons_kwh_mr4,0)+nvl(pfc_mr1_cons,0)+nvl(pfc_mr2_cons,0)+nvl(pfc_mr3_cons,0)+
nvl(pfc_mr4_cons,0)+nvl(xf_loss_mr1_cons,0)+nvl(xf_loss_mr2_cons,0)+nvl(xf_loss_mr3_cons,0)+
nvl(xf_loss_mr4_cons,0)) t_unit,sum(nvl(ENG_CHRG_SR,0)+ 
nvl(ENG_CHRG_OFPK,0)+ nvl(ENG_CHRG_PK,0)+
nvl(minimum_CHRG,0)+nvl(service_CHRG,0)+nvl(demand_CHRG,0)+
nvl(adjusted_prn,0)+nvl(pfc_charge,0)+nvl(xf_loss_chrg,0)+nvl(xf_rent,0)
+nvl(eng_chrg_mr1,0)+nvl(eng_chrg_mr2,0)+nvl(eng_chrg_mr3,0)+nvl(eng_chrg_mr4,0) ) t_chrg,
sum(nvl(current_vat,0)+nvl(adjusted_vat,0)) t_vat,
sum(nvl(ENG_CHRG_SR,0)+ 
nvl(ENG_CHRG_OFPK,0)+ nvl(ENG_CHRG_PK,0)+
nvl(minimum_CHRG,0)+nvl(service_CHRG,0)+nvl(demand_CHRG,0)+
nvl(adjusted_prn,0)+nvl(pfc_charge,0)+nvl(xf_loss_chrg,0) )+
sum(nvl(current_vat,0)+nvl(adjusted_vat,0)) t_bill,sum(nvl(ADJUSTED_PRN,0)+nvl(ARR_ADV_ADJ_PRN,0)) arr_prn,sum(nvl(ADJUSTED_LPS,0)+nvl(ARR_ADV_ADJ_LPS,0)) arr_lps,
sum(nvl(ADJUSTED_PRN,0)+nvl(ADJUSTED_VAT,0)+nvl(ADJUSTED_LPS,0)+nvl(ARR_ADV_ADJ_PRN,0)+
nvl(ARR_ADV_ADJ_VAT,0)+nvl(ARR_ADV_ADJ_LPS,0)) total_arr,
sum(nvl(rcpt_prn_1,0)+nvl(rcpt_prn_2,0)+nvl(rcpt_prn_3,0)) coll_bpdb
from ebc.bc_bill_image where   
bill_cycle_code=:bil_cy and invoice_num is not null group by location_code,bill_cycle_code)
 a, 
ebc.bc_location_master c
where  a.loc=c.location_code 
order by loc)b
where a.LOC = b.LOC
and a.MONTH=b.MONTH