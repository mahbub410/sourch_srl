------------old meter-----

SELECT X.CUSTOMER_NUM,X.OLD_METER_NUM,X.OLD_METER_CONN_DATE,x.CUSTOMER_NAME,X.cons_unit_1607_1706,X.billed_amt_1607_1706,
Y.NEW_METER_NUM,Y.NEW_METER_CONN_DATE,Y.cons_unit_1807_1906,Y.billed_amt_1807_1906,x.TARIFF
 FROM (
select a.cust_id,a.CUSTOMER_NUM,a.OLD_METER_NUM,a.OLD_METER_CONN_DATE,a.CUSTOMER_NAME,b.cons_unit_1607_1706,b.billed_amt_1607_1706,b.TARIFF from (
SELECT CM.cust_id,CM.CUSTOMER_NUM,METER_NUM OLD_METER_NUM,METER_CONNECT_DATE OLD_METER_CONN_DATE,C.CUSTOMER_NAME 
FROM BC_CUSTOMER_METER CM,BC_CUSTOMERS C
WHERE  CM.CUST_ID = C.CUST_ID
AND CM.EQUIP_ID IN (
SELECT REPLACED_METER_ID FROM BC_CUSTOMER_METER
WHERE  METER_STATUS=2
and to_char(METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
AND REPLACED_METER_ID IS NOT NULL
))a,(
select cust_id,bi.TARIFF ,SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) cons_unit_1607_1706,SUM(NVL(bi.eng_chrg_sr,0)+NVL(bi.eng_chrg_ofpk,0) + NVL(bi.eng_chrg_pk,0) + NVL(bi.minimum_chrg,0)
        + NVL(bi.service_chrg,0)+ NVL(bi.demand_chrg,0)+ NVL(bi.pfc_charge,0)
        + NVL(bi.xf_loss_chrg,0)+ NVL(bi.xf_rent,0)
        + NVL(eng_chrg_mr1,0)+NVL(eng_chrg_mr2,0)+NVL(eng_chrg_mr3,0)+NVL(eng_chrg_mr4,0)
    )   billed_amt_1607_1706 
    FROM BC_BILL_IMAGE bi
    where bill_cycle_code between '201607' and '201706'
    and bi.location_code=:p_loc
    AND BI.METER_COND_KWH='00'
    group by cust_id,bi.TARIFF)b
    where a.CUST_ID = b.CUST_ID
    )X,(
 select a.cust_id,a.CUSTOMER_NUM,a.NEW_METER_NUM,a.NEW_METER_CONN_DATE,a.CUSTOMER_NAME,b.cons_unit_1807_1906,b.billed_amt_1807_1906,b.TARIFF from (
SELECT CM.cust_id,CM.CUSTOMER_NUM,METER_NUM NEW_METER_NUM,METER_CONNECT_DATE NEW_METER_CONN_DATE,C.CUSTOMER_NAME 
FROM BC_CUSTOMER_METER CM,BC_CUSTOMERS C
WHERE  CM.CUST_ID = C.CUST_ID
and  CM.METER_STATUS=2
and to_char(CM.METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
AND REPLACED_METER_ID IS NOT NULL
)a,(
select cust_id,bi.TARIFF ,SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) cons_unit_1807_1906,SUM(NVL(bi.eng_chrg_sr,0)+NVL(bi.eng_chrg_ofpk,0) + NVL(bi.eng_chrg_pk,0) + NVL(bi.minimum_chrg,0)
        + NVL(bi.service_chrg,0)+ NVL(bi.demand_chrg,0)+ NVL(bi.pfc_charge,0)
        + NVL(bi.xf_loss_chrg,0)+ NVL(bi.xf_rent,0)
        + NVL(eng_chrg_mr1,0)+NVL(eng_chrg_mr2,0)+NVL(eng_chrg_mr3,0)+NVL(eng_chrg_mr4,0)
    )   billed_amt_1807_1906
    FROM BC_BILL_IMAGE bi
    where bill_cycle_code between '201807' and '201906'
    and bi.location_code=:p_loc
    AND BI.METER_COND_KWH='00'
    group by cust_id,bi.TARIFF)b
    where a.CUST_ID = b.CUST_ID)Y
    WHERE X.CUST_ID = Y.CUST_ID
    
    
--------Faulty meter--------
    
    
    SELECT X.CUSTOMER_NUM,X.OLD_METER_NUM,X.OLD_METER_CONN_DATE,x.CUSTOMER_NAME,X.cons_unit_1607_1706,X.billed_amt_1607_1706,
Y.NEW_METER_NUM,Y.NEW_METER_CONN_DATE,Y.cons_unit_1807_1906,Y.billed_amt_1807_1906,x.TARIFF
 FROM (
select a.cust_id,a.CUSTOMER_NUM,a.OLD_METER_NUM,a.OLD_METER_CONN_DATE,a.CUSTOMER_NAME,b.cons_unit_1607_1706,b.billed_amt_1607_1706,b.TARIFF from (
SELECT CM.cust_id,CM.CUSTOMER_NUM,METER_NUM OLD_METER_NUM,METER_CONNECT_DATE OLD_METER_CONN_DATE,C.CUSTOMER_NAME 
FROM BC_CUSTOMER_METER CM,BC_CUSTOMERS C
WHERE  CM.CUST_ID = C.CUST_ID
AND CM.EQUIP_ID IN (
SELECT REPLACED_METER_ID FROM BC_CUSTOMER_METER
WHERE  METER_STATUS=2
and to_char(METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
AND REPLACED_METER_ID IS NOT NULL
))a,(
select cust_id,bi.TARIFF ,SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) cons_unit_1607_1706,SUM(NVL(bi.eng_chrg_sr,0)+NVL(bi.eng_chrg_ofpk,0) + NVL(bi.eng_chrg_pk,0) + NVL(bi.minimum_chrg,0)
        + NVL(bi.service_chrg,0)+ NVL(bi.demand_chrg,0)+ NVL(bi.pfc_charge,0)
        + NVL(bi.xf_loss_chrg,0)+ NVL(bi.xf_rent,0)
        + NVL(eng_chrg_mr1,0)+NVL(eng_chrg_mr2,0)+NVL(eng_chrg_mr3,0)+NVL(eng_chrg_mr4,0)
    )   billed_amt_1607_1706 
    FROM BC_BILL_IMAGE bi
    where  bi.cust_id in (
            SELECT CUST_ID FROM BC_CUSTOMER_METER
            WHERE to_char(METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
            ) 
    and bi.bill_cycle_code between '201607' and '201706'
    and bi.location_code=:p_loc
    AND BI.METER_COND_KWH in ('11','13')
    group by cust_id,bi.TARIFF)b
    where a.CUST_ID = b.CUST_ID
    )X,(
 select a.cust_id,a.CUSTOMER_NUM,a.NEW_METER_NUM,a.NEW_METER_CONN_DATE,a.CUSTOMER_NAME,b.cons_unit_1807_1906,b.billed_amt_1807_1906,b.TARIFF from (
SELECT CM.cust_id,CM.CUSTOMER_NUM,METER_NUM NEW_METER_NUM,METER_CONNECT_DATE NEW_METER_CONN_DATE,C.CUSTOMER_NAME 
FROM BC_CUSTOMER_METER CM,BC_CUSTOMERS C
WHERE  CM.CUST_ID = C.CUST_ID
and  CM.METER_STATUS=2
and to_char(CM.METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
AND REPLACED_METER_ID IS NOT NULL
)a,(
select cust_id,bi.TARIFF ,SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) cons_unit_1807_1906,SUM(NVL(bi.eng_chrg_sr,0)+NVL(bi.eng_chrg_ofpk,0) + NVL(bi.eng_chrg_pk,0) + NVL(bi.minimum_chrg,0)
        + NVL(bi.service_chrg,0)+ NVL(bi.demand_chrg,0)+ NVL(bi.pfc_charge,0)
        + NVL(bi.xf_loss_chrg,0)+ NVL(bi.xf_rent,0)
        + NVL(eng_chrg_mr1,0)+NVL(eng_chrg_mr2,0)+NVL(eng_chrg_mr3,0)+NVL(eng_chrg_mr4,0)
    )   billed_amt_1807_1906
    FROM BC_BILL_IMAGE bi
    where  bi.cust_id in (
            SELECT CUST_ID FROM BC_CUSTOMER_METER
            WHERE to_char(METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
            and METER_STATUS=2
            AND REPLACED_METER_ID IS NOT NULL
            ) 
    and bi.bill_cycle_code between '201807' and '201906'
    and bi.location_code=:p_loc
    AND BI.METER_COND_KWH in ('11','13')
    group by cust_id,bi.TARIFF)b
    where a.CUST_ID = b.CUST_ID)Y
    WHERE X.CUST_ID = Y.CUST_ID
    
    ------------
    
    
select * from bc_customer_meter
where  METER_STATUS=2
and to_char(METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
AND REPLACED_METER_ID IS NOT NULL

SELECT *
FROM BC_CUSTOMER_METER CM,BC_CUSTOMERS C
WHERE  CM.CUST_ID = C.CUST_ID
AND CM.EQUIP_ID IN (
SELECT REPLACED_METER_ID FROM BC_CUSTOMER_METER
WHERE  METER_STATUS=2
and to_char(METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
AND REPLACED_METER_ID IS NOT NULL
)

---

select * from bc_bill_image
where bill_cycle_code between '201807' and '201906'
and location_code='L1'
and cust_id in (
select cust_id from bc_customer_meter
where  METER_STATUS=2
and to_char(METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
AND REPLACED_METER_ID IS NOT NULL
)

select * from bc_bill_image
where bill_cycle_code between '201607' and '201706'
and location_code='L1'
and cust_id in (
select cust_id from bc_customer_meter
where  METER_STATUS=2
and to_char(METER_CONNECT_DATE,'rrrrmm') between '201707' and '201806'
AND REPLACED_METER_ID IS NOT NULL
)