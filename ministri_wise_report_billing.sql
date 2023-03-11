
SELECT 
   b.LOCATION_CODE, l.descr loc_desc,
   f.ministry_code, 
   f.code_descr Ministry, 
   V.REFERENCE_CODE DEPT_CODE,V.REFERENCE_DESC DEPT_DESC,
   V.CUSTOMER_TYPE_CODE SUB_DEPT_CODE,V.CODE_DESCR SUB_DEPT_DESC,
   SUBSTR(b.area_code,1,3) book_no, 
   b.tariff, 
   b.customer_num||a.check_digit customer_num, 
   b.cons_extg_num, 
   SUBSTR(a.customer_name,1,34) Customer_name, 
   SUBSTR(d.addr_descr1,0,22) Address, 
   b.INVOICE_NUM,
   NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
           + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)
           +NVL(MINIMUM_CHRG,0) + NVL(SERVICE_CHRG,0)
           + NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)
           + NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)+NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0)
           + NVL(CURRENT_LPS,0)+NVL(CURRENT_VAT,0)+NVL(ADJUSTED_VAT,0)-NVL(UNADJUSTED_PRN,0) - NVL(UNADJUSTED_vat,0)  Current_bill,
      NVL(ARR_ADV_ADJ_PRN,0) Energy_rec,
      NVL(ARR_ADV_ADJ_VAT,0) VAT_REC,
      NVL(ARR_ADV_ADJ_LPS,0) LPS_REC,
      NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
           + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)
           +NVL(MINIMUM_CHRG,0) + NVL(SERVICE_CHRG,0)
           + NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)
           + NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)+NVL(ADJUSTED_PRN,0)+NVL(ADJUSTED_LPS,0)
           + NVL(CURRENT_LPS,0)+NVL(CURRENT_VAT,0)+NVL(ADJUSTED_VAT,0)-NVL(UNADJUSTED_PRN,0) - NVL(UNADJUSTED_vat,0)  +
      NVL(ARR_ADV_ADJ_PRN,0)+
      NVL(ARR_ADV_ADJ_VAT,0) +
      NVL(ARR_ADV_ADJ_LPS,0) TotaL   
FROM BC_BILL_IMAGE b, bc_location_master l,
     BC_CUSTOMERS a, 
    BC_CUSTOMER_ADDR d, 
    BC_CUSTOMER_TYPE_CODE e,
    BC_MINISTRY_CODE f,
    --BC_CUSTOMER_TYPE_MST ctm,
    BC_CUSTOMER_OWNER_TYPE o,
    BC_CUSTOMER_CATEGORY cc,
    BC_CATEGORY_MASTER cm,
    VW_MIN_CUST_TYPE V
   WHERE b.bill_cycle_code = :p_month
AND b.cust_id = a.cust_id 
AND b.cust_id = d.cust_id
AND b.cust_id = cc.cust_id
and l.location_code=b.location_code
AND cc.CAT_ID = cm.CATEGORY_ID
AND cc.EXP_DATE IS NULL 
AND cm.CUSTOMER_TYPE_CODE = e.CUSTOMER_TYPE_CODE
AND b.LOCATION_CODE = :p_location_code 
AND v.MINISTRY_CODE||v.CUSTOMER_TYPE_CODE=SUBSTR(E.CUSTOMER_TYPE_CODE,1,4) 
AND e.CUSTOMER_OWNER_CODE = o.CUSTOMER_OWNER_CODE 
AND e.ministry_code = f.ministry_code
AND d.addr_type = 'B'
AND d.addr_exp_date IS NULL 
AND e.ministry_code IS NOT NULL
AND NVL(e.MINISTRY_CODE,'98') LIKE :p_ministry_code
AND NVL(e.CUSTOMER_TYPE_CODE_DUMMY,'71') LIKE :p_cust_type_code
AND NVL(e.CUSTOMER_OWNER_CODE,'1') LIKE :p_owner_code
AND DECODE(e.CUSTOMER_OWNER_CODE,'5','Y','N') LIKE DECODE(:p_inc_private,'Y','%','N')
ORDER BY  location_code,e.ministry_code, e.CUSTOMER_TYPE_CODE_DUMMY, e.CUSTOMER_OWNER_CODE