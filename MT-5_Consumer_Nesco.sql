
SELECT A.CUSTOMER_NAME,B.SANC_LOAD,(SELECT SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') ENERRGY_SOLD,
  (SELECT SUM(NVL(bi.eng_chrg_sr,0)+NVL(bi.eng_chrg_ofpk,0) + NVL(bi.eng_chrg_pk,0) + NVL(bi.minimum_chrg,0)
        + NVL(bi.service_chrg,0)+ NVL(bi.demand_chrg,0)+ NVL(bi.pfc_charge,0)
        + NVL(bi.xf_loss_chrg,0)+ NVL(bi.xf_rent,0)
        + NVL(eng_chrg_mr1,0)+NVL(eng_chrg_mr2,0)+NVL(eng_chrg_mr3,0)+NVL(eng_chrg_mr4,0)
    )  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') ENERRGY_AMOUNT,
    (SELECT SUM(NVL(bi.demand_chrg,0)
    )  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') DEMAND_CHARGE ,
        (SELECT SUM(NVL(bi.PFC_CHARGE,0))
  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') PFC_CHARGE ,
   (SELECT SUM( NVL(bi.current_vat,0)+ NVL(bi.adjusted_vat,0)-(NVL(bi.installment_vat_1,0)+NVL(bi.installment_vat_2,0)) )
  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') VAT_AMOUNT ,
   (SELECT SUM( NVL(bi.current_lps,0)+ NVL(bi.adjusted_lps,0) - (NVL(bi.installment_lps_1,0)+NVL(bi.installment_lps_2,0)) )
  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') LPS_AMOUNT ,
 (SELECT SUM(NVL(bi.eng_chrg_sr,0)+NVL(bi.eng_chrg_ofpk,0) + NVL(bi.eng_chrg_pk,0) + NVL(bi.minimum_chrg,0)
        + NVL(bi.service_chrg,0)+ NVL(bi.demand_chrg,0)+ NVL(bi.pfc_charge,0)
        + NVL(bi.xf_loss_chrg,0)+ NVL(bi.xf_rent,0)
        + NVL(eng_chrg_mr1,0)+NVL(eng_chrg_mr2,0)+NVL(eng_chrg_mr3,0)+NVL(eng_chrg_mr4,0)+NVL(bi.demand_chrg,0)+NVL(bi.PFC_CHARGE,0)+
        NVL(bi.current_vat,0)+ NVL(bi.adjusted_vat,0)-(NVL(bi.installment_vat_1,0)+NVL(bi.installment_vat_2,0))+
        NVL(bi.current_lps,0)+ NVL(bi.adjusted_lps,0) - (NVL(bi.installment_lps_1,0)+NVL(bi.installment_lps_2,0))
    )  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') TOTAL_AMOUNT,   
    C.BUS_TYPE_DESC 
FROM BC_CUSTOMERS A,
(SELECT CUST_ID,BUS_TYPE_CODE,SANC_LOAD FROM BC_BILL_IMAGE WHERE TARIFF='MT-5' AND BILL_CYCLE_CODE='201906') B,BC_BUS_TYPE_CODE C
WHERE A.CUST_ID=B.CUST_ID
AND B.BUS_TYPE_CODE=C.BUS_TYPE_CODE

----------------------------------------------------------------------



SELECT A.LOCATION_CODE,A.CUSTOMER_NUM||A.CHECK_DIGIT CUSTOMER_NUMBER, A.CUSTOMER_NAME,B.SANC_LOAD,(SELECT SUM(NVL(bi.cons_kwh_sr,0) + NVL(bi.cons_kwh_pk,0) + NVL(bi.cons_kwh_ofpk,0)
           + NVL(bi.old_kwh_sr_cons,0) + NVL(bi.old_kwh_pk_cons,0)
           + NVL(bi.old_kwh_ofpk_cons,0) + NVL(bi.xf_loss_sr_cons,0) + NVL(bi.xf_loss_ofpk_cons,0)
              + NVL(bi.xf_loss_pk_cons,0)+ NVL(bi.pfc_sr_cons,0) + NVL(bi.pfc_ofpk_cons,0) + NVL(bi.pfc_pk_cons,0)
              + NVL(cons_kwh_mr1,0)+NVL(old_kwh_mr1_cons,0)+NVL(CONS_KWH_MR2,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(CONS_KWH_MR3,0)+NVL(OLD_KWH_MR3_CONS,0)
              + NVL(cons_kwh_mr4,0)+NVL(old_kwh_mr4_cons,0)+NVL(pfc_mr1_cons,0)+NVL(pfc_mr2_cons,0)+NVL(pfc_mr3_cons,0)
              + NVL(pfc_mr4_cons,0)+NVL(xf_loss_mr1_cons,0)+NVL(xf_loss_mr2_cons,0)+NVL(xf_loss_mr3_cons,0)+NVL(xf_loss_mr4_cons,0)
    ) FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') ENERRGY_SOLD,
  (SELECT SUM(NVL(bi.eng_chrg_sr,0)+NVL(bi.eng_chrg_ofpk,0) + NVL(bi.eng_chrg_pk,0) + NVL(bi.minimum_chrg,0)
        + NVL(bi.service_chrg,0)+ NVL(bi.demand_chrg,0)+ NVL(bi.pfc_charge,0)
        + NVL(bi.xf_loss_chrg,0)+ NVL(bi.xf_rent,0)
        + NVL(eng_chrg_mr1,0)+NVL(eng_chrg_mr2,0)+NVL(eng_chrg_mr3,0)+NVL(eng_chrg_mr4,0)
    )  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') ENERRGY_AMOUNT,
    (SELECT SUM(NVL(bi.demand_chrg,0)
    )  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') DEMAND_CHARGE ,
        (SELECT SUM(NVL(bi.PFC_CHARGE,0))
  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') PFC_CHARGE ,
   (SELECT SUM( NVL(bi.current_vat,0)+ NVL(bi.adjusted_vat,0)-(NVL(bi.installment_vat_1,0)+NVL(bi.installment_vat_2,0)) )
  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') VAT_AMOUNT ,
   (SELECT SUM( NVL(bi.current_lps,0)+ NVL(bi.adjusted_lps,0) - (NVL(bi.installment_lps_1,0)+NVL(bi.installment_lps_2,0)) )
  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') LPS_AMOUNT ,
 (SELECT SUM(NVL(bi.eng_chrg_sr,0)+NVL(bi.eng_chrg_ofpk,0) + NVL(bi.eng_chrg_pk,0) + NVL(bi.minimum_chrg,0)
        + NVL(bi.service_chrg,0)+ NVL(bi.demand_chrg,0)+ NVL(bi.pfc_charge,0)
        + NVL(bi.xf_loss_chrg,0)+ NVL(bi.xf_rent,0)
        + NVL(eng_chrg_mr1,0)+NVL(eng_chrg_mr2,0)+NVL(eng_chrg_mr3,0)+NVL(eng_chrg_mr4,0)+NVL(bi.demand_chrg,0)+NVL(bi.PFC_CHARGE,0)+
        NVL(bi.current_vat,0)+ NVL(bi.adjusted_vat,0)-(NVL(bi.installment_vat_1,0)+NVL(bi.installment_vat_2,0))+
        NVL(bi.current_lps,0)+ NVL(bi.adjusted_lps,0) - (NVL(bi.installment_lps_1,0)+NVL(bi.installment_lps_2,0))
    )  FROM BC_BILL_IMAGE BI WHERE CUST_ID=A.CUST_ID AND BILL_CYCLE_CODE BETWEEN '201807' AND '201906') TOTAL_AMOUNT,   
    C.BUS_TYPE_DESC 
FROM BC_CUSTOMERS A,
(SELECT CUST_ID,BUS_TYPE_CODE,SANC_LOAD FROM BC_BILL_IMAGE WHERE TARIFF='MT-5' AND BILL_CYCLE_CODE='201906') B,BC_BUS_TYPE_CODE C
WHERE A.CUST_ID=B.CUST_ID
AND B.BUS_TYPE_CODE=C.BUS_TYPE_CODE