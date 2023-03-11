
SELECT
  :p_bill_cycle run_bill_cycle,b.bill_cycle_code,b.LOCATION_CODE, l.descr loc_desc,
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
   /*NVL(c.principal_amt,0) +*/  NVL(b.arr_adv_adj_prn,0) + NVL(b.adjusted_prn,0) Energy_arr,
   --NVL(b.current_vat,0) +
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)  Current_prin,
   NVL(b.arr_adv_adj_vat,0) + NVL(b.adjusted_vat,0) Vat_arr,
   NVL(b.current_vat,0)  Current_vat,
   NVL(b.arr_adv_adj_lps,0) + NVL(b.adjusted_lps,0) Surcharge_arr,
   Current_lps
  -- nvl(B.total_bill,0) total_bill
FROM ebc.BC_BILL_IMAGE b, bc_location_master l,
(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=:p_bill_cycle and invoice_num is not null group by cust_id) bi,
     BC_CUSTOMERS a,
    BC_CUSTOMER_ADDR d,
    BC_CUSTOMER_TYPE_CODE e,
    BC_MINISTRY_CODE f,
    --BC_CUSTOMER_TYPE_MST ctm,
    BC_CUSTOMER_OWNER_TYPE o,
    BC_CUSTOMER_CATEGORY cc,
    BC_CATEGORY_MASTER cm,
    VW_MIN_CUST_TYPE V
WHERE b.cust_id = a.cust_id
AND b.cust_id = d.cust_id
AND b.cust_id = cc.cust_id
and b.cust_id=bi.cust_id
and b.bill_cycle_code=bi.bill_cycle_code
and l.location_code=b.location_code
and b.invoice_num is not null
--and b.invoice_num=R.invoice_num(+)
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
and a.customer_status_code='C'
ORDER BY  1,2,4,6,8