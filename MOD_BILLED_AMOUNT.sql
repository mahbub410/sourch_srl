select b.BILL_CYCLE_CODE,b.LOCATION_CODE,b.FEEDER_NO,b.USAGE_CATEGORY_CODE,b.BUS_TYPE_CODE,b.CUSTOMER_STATUS_CODE,b.area_code,
a.billed_amount,b.PRINCIPAL_BILLED_AMT,(a.billed_amount-b.PRINCIPAL_BILLED_AMT) dif
from
(
select BILL_CYCLE_CODE,LOCATION_CODE,FEEDER_NO,tariff,BUS_TYPE_CODE,CUST_STATUS,area_code,SUM(NVL(bi.eng_chrg_sr,0)+NVL(bi.eng_chrg_ofpk,0) + NVL(bi.eng_chrg_pk,0) + NVL(bi.minimum_chrg,0)
        + NVL(bi.service_chrg,0)+ NVL(bi.demand_chrg,0)+ NVL(bi.pfc_charge,0)
        + NVL(bi.xf_loss_chrg,0)+ NVL(bi.xf_rent,0)
        + NVL(eng_chrg_mr1,0)+NVL(eng_chrg_mr2,0)+NVL(eng_chrg_mr3,0)+NVL(eng_chrg_mr4,0)
    ) billed_amount from bc_bill_image bi
where bill_cycle_code='201906'
and location_code='W4'
group by BILL_CYCLE_CODE,LOCATION_CODE,FEEDER_NO,tariff,BUS_TYPE_CODE,CUST_STATUS,area_code
) a,
(select BILL_CYCLE_CODE,LOCATION_CODE,FEEDER_NO,USAGE_CATEGORY_CODE,BUS_TYPE_CODE,CUSTOMER_STATUS_CODE,area_code,PRINCIPAL_BILLED_AMT from BC_MONTH_MOD_REPORT
where location_code='W4'
and bill_cycle_code='201906' ) b
where a.BILL_CYCLE_CODE=b.BILL_CYCLE_CODE
and a.LOCATION_CODE=b.LOCATION_CODe
and a.FEEDER_NO=b.FEEDER_NO
and a.tariff=b.USAGE_CATEGORY_CODE
and a.BUS_TYPE_CODE=b.BUS_TYPE_CODE
and a.CUST_STATUS=b.CUSTOMER_STATUS_CODE
and a.area_code=b.area_code