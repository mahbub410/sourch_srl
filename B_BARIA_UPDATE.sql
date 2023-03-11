


select a.bill_cycle,a.tariff,a.CODE_DESCR,NVL(A.no_of_cust_under_snapshot,0) no_of_cust_under_snapshot,nvl(b.billed_consumer,0) billed_consumer_snafshot,nvl(b.billed_unit,0) billed_unit_snapshot,
DECODE(SUBSTR(a.tariff,1,2),'LT',(nvl(a.billed_unit,0)-nvl(b.billed_unit,0)),nvl(a.billed_unit,0)) billed_unit_without_snapshot,
DECODE(SUBSTR(a.tariff,1,2),'LT',(nvl(a.billed_unit,0)),0) billed_unit_under_snapshot,
DECODE(SUBSTR(a.tariff,1,2),'LT',0,(nvl(a.billed_consumer,0))) cust_not_under_snapshot,
DECODE(SUBSTR(a.tariff,1,2),'LT',0,nvl(a.billed_unit,0)) billed_unit_not_under_snapshot,
nvl(a.billed_unit,0) billed_unit_total,nvl(a.total_adj_unit,0) total_adj_unit,nvl(a.billed_unit,0)+nvl(b.total_adj_unit,0) billed_unit_total_final
from
(select :bc bill_cycle,tariff,T.CODE_DESCR,sum(decode(substr(tariff,1,2),'LT',1,0)) no_of_cust_under_snapshot,COUNT(bi.CUST_ID) billed_consumer,SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) billed_unit,SUM(NVL(bi.adjusted_cons,0)) total_adj_unit
    from bc_bill_image bi,BC_USAGE_CATEGORY_CODE t
    where bill_cycle_code=:bc
    and BI.INVOICE_NUM is not null
    and location_code='C8'
    and bi.tariff=t.USAGE_CATEGORY_CODE
group by tariff,T.CODE_DESCR) a,
(
select :bc bill_cycle,tariff,T.CODE_DESCR,sum(decode(substr(tariff,1,2),'LT',1,0)) no_of_cust_under_snapshot,COUNT(bi.CUST_ID) billed_consumer,SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) billed_unit,SUM(NVL(bi.adjusted_cons,0)) total_adj_unit
    from bc_bill_image bi,BC_USAGE_CATEGORY_CODE t
    where bill_cycle_code=:bc
    and location_code='C8'
    --and MRS_STATUS='M'
    and substr(AREA_CODE,4) not in('15','16','22')
    and BI.INVOICE_NUM is not null
    and bi.tariff=t.USAGE_CATEGORY_CODE
group by tariff,T.CODE_DESCR
union
select :bc bill_cycle,tariff,T.CODE_DESCR,0 no_of_cust_under_snapshot,0 billed_consumer,0 billed_unit,0 total_adj_unit
    from bc_bill_image bi,BC_USAGE_CATEGORY_CODE t
    where bill_cycle_code=:bc
    and BI.INVOICE_NUM is not null
    and location_code='C8'
    and tariff not in(select tariff
    from bc_bill_image bi
    where bill_cycle_code=:bc
    and location_code='C8'
    --and MRS_STATUS='M'
    and substr(AREA_CODE,4) not in('15','16','22')
    and BI.INVOICE_NUM is not null)
    and bi.tariff=t.USAGE_CATEGORY_CODE
group by tariff,T.CODE_DESCR) b
where a.tariff=b.tariff(+)
















/*
select a.bill_cycle,a.tariff,a.CODE_DESCR,NVL(A.no_of_cust_under_snapshot,0) no_of_cust_under_snapshot,nvl(b.billed_consumer,0) billed_consumer_snafshot,nvl(b.billed_unit,0) billed_unit_snapshot,
DECODE(SUBSTR(a.tariff,1,2),'LT',(nvl(a.billed_unit,0)-nvl(b.billed_unit,0)),nvl(a.billed_unit,0)) billed_unit_without_snapshot,
DECODE(SUBSTR(a.tariff,1,2),'LT',(nvl(a.billed_unit,0)),0) billed_unit_under_snapshot,
DECODE(SUBSTR(a.tariff,1,2),'LT',0,(nvl(a.billed_consumer,0))) cust_not_under_snapshot,
DECODE(SUBSTR(a.tariff,1,2),'LT',0,nvl(a.billed_unit,0)) billed_unit_not_under_snapshot,
nvl(a.billed_unit,0) billed_unit_total,nvl(a.total_adj_unit,0) total_adj_unit,nvl(a.billed_unit,0)+nvl(b.total_adj_unit,0) billed_unit_total_final
from
(select :bc bill_cycle,tariff,T.CODE_DESCR,sum(decode(substr(tariff,1,2),'LT',1,0)) no_of_cust_under_snapshot,COUNT(bi.CUST_ID) billed_consumer,SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) billed_unit,SUM(NVL(bi.adjusted_cons,0)) total_adj_unit
    from bc_bill_image bi,BC_USAGE_CATEGORY_CODE t
    where bill_cycle_code=:bc
    and BI.INVOICE_NUM is not null
    and location_code='C3'
    and bi.tariff=t.USAGE_CATEGORY_CODE
group by tariff,T.CODE_DESCR) a,
(
select :bc bill_cycle,tariff,T.CODE_DESCR,sum(decode(substr(tariff,1,2),'LT',1,0)) no_of_cust_under_snapshot,COUNT(bi.CUST_ID) billed_consumer,SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) billed_unit,SUM(NVL(bi.adjusted_cons,0)) total_adj_unit
    from bc_bill_image bi,BC_USAGE_CATEGORY_CODE t
    where bill_cycle_code=:bc
    and location_code='C3'
    and MRS_STATUS='M'
    and BI.INVOICE_NUM is not null
    and bi.tariff=t.USAGE_CATEGORY_CODE
group by tariff,T.CODE_DESCR
union
select :bc bill_cycle,tariff,T.CODE_DESCR,0 no_of_cust_under_snapshot,0 billed_consumer,0 billed_unit,0 total_adj_unit
    from bc_bill_image bi,BC_USAGE_CATEGORY_CODE t
    where bill_cycle_code=:bc
    and BI.INVOICE_NUM is not null
    and location_code='C3'
    and tariff not in(select tariff
    from bc_bill_image bi
    where bill_cycle_code=:bc
    and location_code='C3'
    and MRS_STATUS='M'
    and BI.INVOICE_NUM is not null)
    and bi.tariff=t.USAGE_CATEGORY_CODE
group by tariff,T.CODE_DESCR) b
where a.tariff=b.tariff(+)
*/