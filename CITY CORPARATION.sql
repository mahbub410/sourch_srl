select a.ministry_code,a.Ministry,a.Department,a.cust_status, a.LOCATION_CODE,  a.loc_desc,a.Customer_name,a.Address,sum(NVL(a.Current_prin ,0)+nvl(a.Current_vat,0)+NVL(a.Energy_arr,0)+nvl(a.Vat_arr,0)) Receiveable,sum(NVL(a.Surcharge_arr,0)+NVL(a.Current_lps,0)) surcharge_arr,
sum(NVL(a.Current_prin,0))+sum(NVL(a.Energy_arr,0))+sum(NVL(a.Surcharge_arr,0)+NVL(a.Current_lps,0)+nvl(a.Current_vat,0)+nvl(a.Vat_arr,0)) total_Receiveable
from
(select :p_bill_cycle_code run_bill_cycle,b.bill_cycle_code,b.LOCATION_CODE, l.descr loc_desc,
   f.ministry_code, 
   f.code_descr Ministry, 
   ctm.code_descr Department, 
   ctm.CUSTOMER_TYPE_CODE cust_status, 
   SUBSTR(b.area_code,1,3) book_no, 
   b.tariff, 
   b.customer_num||c.check_digit customer_num, 
   b.cons_extg_num, 
   SUBSTR(c.customer_name,1,34) Customer_name, 
   SUBSTR(d.addr_descr1,0,22) Address, 
   b.INVOICE_NUM,
    /*NVL(c.principal_amt,0) +*/  NVL(b.arr_adv_adj_prn,0) + NVL(b.adjusted_prn,0) Energy_arr, 
   --NVL(b.current_vat,0) + 
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)  Current_prin,
   NVL(b.arr_adv_adj_vat,0) + NVL(b.adjusted_vat,0) Vat_arr, 
   NVL(b.current_vat,0)  Current_vat,
   NVL(b.arr_adv_adj_lps,0) + NVL(b.adjusted_lps,0) Surcharge_arr,
    nvl(Current_lps,0) Current_lps
FROM  ebc.BC_BILL_IMAGE b, bc_location_master l,
(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=:p_bill_cycle_code and invoice_num is not null group by cust_id) bi,
     BC_CUSTOMERS c, 
    BC_CUSTOMER_ADDR d, 
    BC_CUSTOMER_TYPE_CODE e,
    BC_MINISTRY_CODE f,
    BC_CUSTOMER_TYPE_MST ctm,
    BC_CUSTOMER_OWNER_TYPE o,
    BC_CUSTOMER_CATEGORY cc,
    BC_CATEGORY_MASTER cm
WHERE b.cust_id = c.cust_id 
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
and c.customer_status_code='C'
AND e.MINISTRY_CODE not in '98'
and NVL(e.MINISTRY_CODE,'98') LIKE :p_ministry_code
and ctm.CUSTOMER_TYPE_CODE in ('10','11')
--AND NVL(e.CUSTOMER_TYPE_CODE_DUMMY,'71') LIKE :p_cust_type_code
--AND NVL(e.CUSTOMER_OWNER_CODE,'1') LIKE :p_owner_code
--AND DECODE(e.CUSTOMER_OWNER_CODE,'5','Y','N') LIKE DECODE(:p_inc_private,'Y','%','N')
ORDER BY e.ministry_code, e.CUSTOMER_TYPE_CODE_DUMMY, e.CUSTOMER_OWNER_CODE) a
group by a.ministry_code,a.Ministry,a.Department,a.cust_status, a.LOCATION_CODE,  a.loc_desc,a.Customer_name,a.Address



-------------------------------ctg----------------------------------------------

select a.ministry_code,a.Ministry,a.Department,a.cust_status, a.LOCATION_CODE,  a.loc_desc,a.Customer_name,a.Address,sum(NVL(a.Current_prin ,0)+nvl(a.Current_vat,0)+NVL(a.Energy_arr,0)+nvl(a.Vat_arr,0)) Receiveable,sum(NVL(a.Surcharge_arr,0)+NVL(a.Current_lps,0)) surcharge_arr,
sum(NVL(a.Current_prin,0))+sum(NVL(a.Energy_arr,0))+sum(NVL(a.Surcharge_arr,0)+NVL(a.Current_lps,0)+nvl(a.Current_vat,0)+nvl(a.Vat_arr,0)) total_Receiveable
from
(select :p_bill_cycle_code run_bill_cycle,b.bill_cycle_code,b.LOCATION_CODE, l.descr loc_desc,
   f.ministry_code, 
   f.code_descr Ministry, 
   ctm.code_descr Department, 
   ctm.CUSTOMER_TYPE_CODE cust_status, 
   SUBSTR(b.area_code,1,3) book_no, 
   b.tariff, 
   b.customer_num||c.check_digit customer_num, 
   b.cons_extg_num, 
   SUBSTR(c.customer_name,1,34) Customer_name, 
   SUBSTR(d.addr_descr1,0,22) Address, 
   b.INVOICE_NUM,
    NVL(c.principal_amt,0) +  NVL(b.arr_adv_adj_prn,0) + NVL(b.adjusted_prn,0) Energy_arr, 
   --NVL(b.current_vat,0) + 
    NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0)  Current_prin,
   NVL(b.arr_adv_adj_vat,0) + NVL(b.adjusted_vat,0) Vat_arr, 
   NVL(b.current_vat,0)  Current_vat,
   NVL(b.arr_adv_adj_lps,0) + NVL(b.adjusted_lps,0) Surcharge_arr,
    nvl(Current_lps,0) Current_lps
FROM  ebc.BC_BILL_IMAGE b, bc_location_master l,
(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=:p_bill_cycle_code and invoice_num is not null group by cust_id) bi,
     BC_CUSTOMERS c, 
    BC_CUSTOMER_ADDR d, 
    BC_CUSTOMER_TYPE_CODE e,
    BC_MINISTRY_CODE f,
    BC_CUSTOMER_TYPE_MST ctm,
    BC_CUSTOMER_OWNER_TYPE o,
    BC_CUSTOMER_CATEGORY cc,
    BC_CATEGORY_MASTER cm
WHERE b.cust_id = c.cust_id 
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
and ctm.customer_type_code  in ('C1','C2','C3','C4','C5','C6','90','56')
AND e.CUSTOMER_OWNER_CODE = o.CUSTOMER_OWNER_CODE 
AND e.ministry_code = f.ministry_code
AND d.addr_type = 'B'
AND d.addr_exp_date IS NULL 
AND e.ministry_code IS NOT NULL
and c.customer_status_code='C'
AND e.MINISTRY_CODE not in '98'
and NVL(e.MINISTRY_CODE,'98') LIKE :p_ministry_code
--AND NVL(e.CUSTOMER_TYPE_CODE_DUMMY,'71') LIKE :p_cust_type_code
--AND NVL(e.CUSTOMER_OWNER_CODE,'1') LIKE :p_owner_code
--AND DECODE(e.CUSTOMER_OWNER_CODE,'5','Y','N') LIKE DECODE(:p_inc_private,'Y','%','N')
ORDER BY e.ministry_code, e.CUSTOMER_TYPE_CODE_DUMMY, e.CUSTOMER_OWNER_CODE) a
group by a.ministry_code,a.Ministry,a.Department,a.cust_status, a.LOCATION_CODE,  a.loc_desc,a.Customer_name,a.Address








------------------------------------final----------------------------------


select  a.ministry_code,a.Ministry, SUB_DEPT_DESC Department, SUB_DEPT_CODE cust_status, a.LOCATION_CODE,  a.loc_desc,bill_gr,book_no,cons_extg_num,customer_num,a.Customer_name,a.Address,sum(NVL(a.Current_prin ,0)+nvl(a.Current_vat,0)+NVL(a.Energy_arr,0)+nvl(a.Vat_arr,0)) Receiveable,sum(NVL(a.Surcharge_arr,0)+NVL(a.Current_lps,0)) surcharge_arr,
sum(NVL(a.Current_prin,0))+sum(NVL(a.Energy_arr,0))+sum(NVL(a.Surcharge_arr,0)+NVL(a.Current_lps,0)+nvl(a.Current_vat,0)+nvl(a.Vat_arr,0)) total_Receiveable,a.curr_coll,a.prev_coll
from (
SELECT l.descr loc_desc,
   b.LOCATION_CODE,
   f.ministry_code,
   f.code_descr Ministry,
   V.REFERENCE_CODE DEPT_CODE,V.REFERENCE_DESC DEPT_DESC,
   V.CUSTOMER_TYPE_CODE SUB_DEPT_CODE,V.CODE_DESCR SUB_DEPT_DESC,
   SUBSTR(b.area_code,1,3) book_no,
   SUBSTR(b.area_code,4,2) bill_gr,
   b.tariff,
   b.customer_num||c.check_digit customer_num,
   b.cons_extg_num,
   SUBSTR(c.customer_name,1,34) Customer_name,
   SUBSTR(d.addr_descr1,0,22) Address,
   b.INVOICE_NUM,
   NVL(b.ENG_CHRG_SR,0)+ NVL(b.ENG_CHRG_OFPK,0)+NVL(b.ENG_CHRG_PK,0)+NVL(b.MINIMUM_CHRG,0) +NVL(b.SERVICE_CHRG,0)+NVL(b.DEMAND_CHRG,0)+
       NVL(b.XF_RENT,0)+NVL(b.XF_LOSS_CHRG,0)+NVL(b.PFC_CHARGE,0)  +  NVL(b.arr_adv_adj_prn,0) + NVL(b.adjusted_prn,0) Energy_arr, 
   --NVL(b.current_vat,0) + 
    NVL(b.ENG_CHRG_SR,0)+ NVL(b.ENG_CHRG_OFPK,0)+NVL(b.ENG_CHRG_PK,0)+NVL(b.MINIMUM_CHRG,0) +NVL(b.SERVICE_CHRG,0)+NVL(b.DEMAND_CHRG,0)+
       NVL(b.XF_RENT,0)+NVL(b.XF_LOSS_CHRG,0)+NVL(b.PFC_CHARGE,0)  Current_prin,
   NVL(b.arr_adv_adj_vat,0) + NVL(b.adjusted_vat,0) Vat_arr, 
   NVL(b.current_vat,0)  Current_vat,
   NVL(b.arr_adv_adj_lps,0) + NVL(b.adjusted_lps,0) Surcharge_arr,
    nvl(b.Current_lps,0) Current_lps,
     nvl(b.RCPT_PRN_1,0)+nvl(b.RCPT_PRN_2,0)+nvl(b.RCPT_PRN_3,0) curr_coll,
     nvl(x.RCPT_PRN_1,0)+nvl(x.RCPT_PRN_2,0)+nvl(x.RCPT_PRN_3,0) prev_coll
FROM bc_location_master l, BC_BILL_IMAGE b, BC_BILL_IMAGE x ,
     BC_CUSTOMERS c,
    BC_CUSTOMER_ADDR d,
    BC_CUSTOMER_TYPE_CODE e,
    BC_MINISTRY_CODE f,
    --BC_CUSTOMER_TYPE_MST ctm,
    BC_CUSTOMER_OWNER_TYPE o,
    BC_CUSTOMER_CATEGORY cc,
    BC_CATEGORY_MASTER cm,
    EMP.VW_MIN_CUST_TYPE V,(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=:p_bill_cycle_code and invoice_num is not null group by cust_id) bi
WHERE-- b.bill_cycle_code = :p_bill_cycle_code
 b.cust_id = c.cust_id
AND b.cust_id = d.cust_id
AND b.cust_id = cc.cust_id
and  c.location_code=l.location_code
and v.CUSTOMER_TYPE_CODE in ('10','11')
and b.bill_cycle_code=bi.bill_cycle_code
and  b.invoice_num is not null
and x.bill_cycle_code=to_char(add_months(to_date(bi.bill_cycle_code,'RRRRMM'),-1),'RRRRMM')
and x.cust_id=bi.cust_id
and x.invoice_num is not null
and b.cust_id=bi.cust_id
AND cc.CAT_ID = cm.CATEGORY_ID
AND cc.EXP_DATE IS NULL
AND cm.CUSTOMER_TYPE_CODE = e.CUSTOMER_TYPE_CODE
--AND b.LOCATION_CODE = :p_location_code
AND v.MINISTRY_CODE||v.CUSTOMER_TYPE_CODE=SUBSTR(E.CUSTOMER_TYPE_CODE,1,4)
AND e.CUSTOMER_OWNER_CODE = o.CUSTOMER_OWNER_CODE
AND e.ministry_code = f.ministry_code
AND d.addr_type = 'B'
AND d.addr_exp_date IS NULL
AND e.ministry_code IS NOT NULL
AND f.ministry_code=:p_ministry_code
--AND NVL(e.MINISTRY_CODE,'37') LIKE :p_ministry_code
--AND NVL(e.CUSTOMER_TYPE_CODE_DUMMY,'71') LIKE :p_cust_type_code
--AND NVL(e.CUSTOMER_OWNER_CODE,'1') LIKE :p_owner_code
--AND DECODE(e.CUSTOMER_OWNER_CODE,'5','Y','N') LIKE DECODE(:p_inc_private,'Y','%','N')
ORDER  BY b.LOCATION_CODE,e.ministry_code, e.CUSTOMER_TYPE_CODE_DUMMY, e.CUSTOMER_OWNER_CODE ) a
group by a.ministry_code,a.Ministry, SUB_DEPT_DESC , SUB_DEPT_CODE , a.LOCATION_CODE,  a.loc_desc,bill_gr,book_no,cons_extg_num,customer_num,a.Customer_name,a.Address,a.curr_coll,a.prev_coll