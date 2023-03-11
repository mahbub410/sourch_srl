
select NVL(B.CONS_KWH_SR,0) , NVL(B.CONS_KWH_PK,0),NVL(B.CONS_KWH_OFPK,0) , NVL(B.ADJUSTED_CONS,0)
, NVL(B.OLD_KWH_SR_CONS,0) , NVL(B.OLD_KWH_PK_CONS,0) 
        , NVL(B.OLD_KWH_OFPK_CONS,0)
        , NVL(B.XF_LOSS_SR_CONS,0) 
        , NVL(B.XF_LOSS_OFPK_CONS,0) 
        , NVL(B.XF_LOSS_PK_CONS,0) 
        , NVL(B.PFC_SR_CONS,0) 
        , NVL(B.PFC_OFPK_CONS,0) 
        , NVL(B.PFC_PK_CONS,0)
                   tc from bc_bill_image b
where b.bill_cycle_code='202008'
and b.location_code='U3' 
--group by b.CUST_ID
--group by b.area_code

select USAGE_CATEGORY_CODE,TOTAL_ENERGY_SOLD,TOTAL_ADJ_UNIT from BC_MONTH_MOD_REPORT_SUMMERY
where bill_cycle_code='202008'
and location_code='U3'
group by USAGE_CATEGORY_CODE,TOTAL_ENERGY_SOLD,TOTAL_ADJ_UNIT