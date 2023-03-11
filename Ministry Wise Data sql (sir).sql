select sum(decode(TARIFF_TYPE_CODE,'01',0,'02',0,(nvl(INVOICE_AMOUNT,0)+nvl(ADJUSTED_AMOUNT,0))-nvl(APPLIED_AMOUNT,0))) prin_arrear,
sum(decode(TARIFF_TYPE_CODE,'02',(nvl(INVOICE_AMOUNT,0)+nvl(ADJUSTED_AMOUNT,0))-nvl(APPLIED_AMOUNT,0),0)) lps_arrear,
sum(decode(TARIFF_TYPE_CODE,'01',(nvl(INVOICE_AMOUNT,0)+nvl(ADJUSTED_AMOUNT,0))-nvl(APPLIED_AMOUNT,0),0)) vat_arrear
 from bc_invoice_dtl a,bc_invoice_hdr b,bc_customer_category c,bc_category_master d
where a.INVOICE_NUM = b.INVOICE_NUM
and b.CUST_ID = c.CUST_ID
and c.EXP_DATE is null
and c.CAT_ID=d.CATEGORY_ID
--and d.CUSTOMER_TYPE_CODE='05'
and b.BILL_CYCLE_CODE<='202201'
having sum((nvl(INVOICE_AMOUNT,0)+nvl(ADJUSTED_AMOUNT,0))-nvl(APPLIED_AMOUNT,0))>0

-----

SELECT 
   f.code_descr Ministry, 
   ctm.code_descr Department,
   l.location_code,
   l.DESCR location_name,
       substr(a.AREA_CODE,1,3) book,
    substr(a.AREA_CODE,4) bill_group,
    a.CUSTOMER_NUM||CHECK_DIGIT CUSTOMER_NUM,
    a.CUSTOMER_NAME,
    d.ADDR_DESCR1||'-'||ADDR_DESCR2||'-'||ADDR_DESCR3 address
FROM  ebc.BC_BILL_IMAGE b, bc_location_master l,
(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=202202 and invoice_num is not null group by cust_id) bi,
     BC_CUSTOMERS a, 
    BC_CUSTOMER_ADDR d, 
    BC_CUSTOMER_TYPE_CODE e,
    BC_MINISTRY_CODE f,
    BC_CUSTOMER_TYPE_MST ctm,
    BC_CUSTOMER_OWNER_TYPE o,
    BC_CUSTOMER_CATEGORY cc,
    BC_CATEGORY_MASTER cm
WHERE b.cust_id = a.cust_id 
AND b.cust_id = d.cust_id
AND b.cust_id = cc.cust_id
AND cc.CAT_ID = cm.CATEGORY_ID
AND cc.EXP_DATE IS NULL 
AND cm.CUSTOMER_TYPE_CODE = e.CUSTOMER_TYPE_CODE
and b.bill_cycle_code=bi.bill_cycle_code
and b.cust_id=bi.cust_id
and l.location_code=b.location_code
and b.invoice_num is not null
--AND b.LOCATION_CODE = :p_location_code 
AND NVL(e.customer_type_code_dummy,'71') = ctm.customer_type_code 
AND e.CUSTOMER_OWNER_CODE = o.CUSTOMER_OWNER_CODE 
AND e.ministry_code = f.ministry_code
AND d.addr_type = 'B'
AND d.addr_exp_date IS NULL 
AND e.ministry_code IS NOT NULL
and a.customer_status_code='C'
AND e.MINISTRY_CODE is not null-- ('98')

-----2nd

SELECT
  :p_bill_cycle_code run_bill_cycle,b.LOCATION_CODE, l.LOCATION_NAME loc_desc,
   f.ministry_code, 
   f.code_descr Ministry, 
   --V.REFERENCE_CODE DEPT_CODE,V.REFERENCE_DESC DEPT_DESC,
    'AA' DEPT_CODE,'AA' DEPT_DESC,
   --v.CUSTOMER_TYPE_CODE SUB_DEPT_CODE,V.CODE_DESCR SUB_DEPT_DESC,
   e.CUSTOMER_TYPE_CODE SUB_DEPT_CODE,e.CODE_DESCR SUB_DEPT_DESC,
   SUBSTR(b.area_code,1,3) book_no, 
   b.tariff, 
   b.customer_num||a.check_digit customer_num, 
   b.cons_extg_num, 
   SUBSTR(a.customer_name,1,34) Customer_name, 
  sum(NVL(b.arr_adv_adj_prn,0) + NVL(b.adjusted_prn,0)) Energy_arr, 
    sum(NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0))  Current_prin,
   sum(NVL(b.arr_adv_adj_vat,0) + NVL(b.adjusted_vat,0)) Vat_arr, 
   sum(NVL(b.current_vat,0))  Current_vat,
   sum(NVL(b.arr_adv_adj_lps,0) + NVL(b.adjusted_lps,0)) Surcharge_arr,
   sum(nvl(Current_lps,0)) Current_lps
FROM BC_BILL_IMAGE b, mis_location_master l,
(select customer_num,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=:p_bill_cycle_code and invoice_num is not null group by customer_num) bi,
    BC_CUSTOMERS a, 
    BC_CUSTOMER_TYPE_CODE_map e,
    BC_MINISTRY_CODE f,
    BC_CUSTOMER_OWNER_TYPE o ,
   -- VW_MIN_CUST_TYPE V
    V_Z_C_C_L V1
WHERE b.customer_num = a.customer_num 
and b.customer_num=bi.customer_num
and b.bill_cycle_code=bi.bill_cycle_code
and l.location_code=b.location_code
and b.invoice_num is not null
--AND DFN_NEW_CUST_TYPE_CODE(b.location_code,b.CUST_STATUS) = e.CUSTOMER_TYPE_CODEb.CUST_STATUS) = e.CUSTOMER_TYPE_CODE
and b.CUST_STATUS = e.CUSTOMER_TYPE_CODE
--AND v.MINISTRY_CODE||v.CUSTOMER_TYPE_CODE=SUBSTR(E.CUSTOMER_TYPE_CODE,1,4) 
AND e.CUSTOMER_OWNER_CODE = o.CUSTOMER_OWNER_CODE 
AND e.ministry_code = decode(v1.comp_cntr_code,'01',f.ministry_code_ctg,f.ministry_code)
and e.comp_cntr_code=v1.comp_cntr_code
AND e.ministry_code IS NOT NULL
--AND e.ministry_code ='50'
and a.customer_status_code='C'
and L.LOCATION_CODE=v1.location_code
--and L.LOCATION_CODE=p_LOCATION_CODE
--AND V1.ZONE_CODE=2
group by b.LOCATION_CODE, l.LOCATION_NAME,
   f.ministry_code, 
   f.code_descr, 
   'All','All',--e.REFERENCE_CODE,e.REFERENCE_DESC,
   e.CUSTOMER_TYPE_CODE ,e.CODE_DESCR,
   SUBSTR(b.area_code,1,3), 
   b.tariff, 
   b.customer_num||a.check_digit, 
   b.cons_extg_num, 
   SUBSTR(a.customer_name,1,34);